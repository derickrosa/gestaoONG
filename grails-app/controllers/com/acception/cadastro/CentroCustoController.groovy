package com.acception.cadastro

import com.acception.cadastro.enums.Moeda
import com.acception.cadastro.enums.StatusLancamento
import com.acception.cadastro.enums.StatusProjeto
import com.acception.cadastro.enums.TipoContaBancaria
import com.acception.cadastro.enums.TipoCusto
import com.acception.cadastro.enums.TipoLancamento
import com.acception.util.Util
import grails.converters.JSON
import java.text.DecimalFormat
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CentroCustoController {
    def exportService
    private static final okcontents = ['image/png', 'image/jpeg', 'image/jpg', 'image/gif']
    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index() {
        params?.remove('max')
        Map<String, String> pesquisa = params.pesquisa ?: params.subMap(['nome', 'codigo', 'ano', 'financiador', 'status'])
        pesquisa = Util.trimMap(pesquisa)

        def criteria = {
            if (pesquisa.containsKey('nome')) ilike('nomeNormalizado', "%${Util.normalizar(pesquisa.nome)}%")
            if (pesquisa.containsKey('codigo')) eq('codigo', pesquisa.codigo)
            if (pesquisa.containsKey('ano')) eq('ano', pesquisa.ano as Integer)
            if (pesquisa.containsKey('financiador')) {
                financiador {
                    idEq(pesquisa.financiador as Long)
                }
            }
            if (pesquisa.containsKey('status')) eq('statusProjeto', StatusProjeto.valueOf(pesquisa.status))
        }

        if (params?.exportFormat && params.exportFormat != "html") {
            response.contentType = grailsApplication.config.grails.mime.types[params.exportFormat]
            response.setHeader("Content-disposition", "attachment; filename=Relatório de Centro de Custos.${params.extension}")

            def centroCustoInstanceList = CentroCusto.createCriteria().list(params, criteria)

            List fields = ['nome', 'codigo', 'ano', 'dataInicio', 'dataFinal', 'statusProjeto', 'descricao']
            Map labels = ['nome': 'Nome', codigo: 'Código', 'ano': 'Ano', 'dataInicio': 'Data Início', 'dataFinal': 'Data Final', 'statusProjeto': 'Status do Projeto', 'descricao': 'Descrição']
            Map parameters = ["column.widths": [0.5, 0.1, 0.1, 0.1, 0.1, 0.3, 0.9]]

            exportService.export(params.exportFormat, response.outputStream, centroCustoInstanceList, fields, labels, [:], parameters)
            return
        }

        params.max = Math.min(params.max ?: 10, 100)

        [centroCustoInstanceList : CentroCusto.createCriteria().list(params, criteria),
         centroCustoInstanceCount: CentroCusto.createCriteria().count(criteria),
         pesquisa                : pesquisa]
    }

    def show(CentroCusto centroCustoInstance) {
        respond centroCustoInstance
    }

    def create() {
        respond new CentroCusto(params)
    }

    @Transactional
    def save(CentroCusto centroCustoInstance) {
        log.debug(params)

        if (centroCustoInstance == null) {
            notFound()
            return
        }

        if (centroCustoInstance.hasErrors()) {
            respond centroCustoInstance.errors, view: 'create'
            return
        }

        _updateCentroCusto(centroCustoInstance, params)

        if (params.saldoInicialContaBancaria) {
            def lancamentoSaldoInicial = criarLancamentoSaldoInicial(params.saldoInicialContaBancaria)

            centroCustoInstance.addToLancamentos(lancamentoSaldoInicial)

            centroCustoInstance.save(flush: true)
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'centroCusto.label', default: 'CentroCusto'), centroCustoInstance.id])
                redirect centroCustoInstance
            }
            '*' { respond centroCustoInstance, [status: CREATED] }
        }
    }

    def criarLancamentoSaldoInicial(saldoInicial) {
        def creditoInicial = new Lancamento(tipoLancamento: TipoLancamento.CREDITO)

        creditoInicial.valor = Util.parse(saldoInicial)
        creditoInicial.dataEmissao = new Date()
        creditoInicial.dataPagamento = new Date()
        creditoInicial.statusLancamento = StatusLancamento.BAIXADO
        creditoInicial.numeroTitulo = ''
        creditoInicial.descricao = "Saldo Inicial"
        creditoInicial.save(flush: true, failOnError: true)

        return creditoInicial
    }

    def edit(CentroCusto centroCustoInstance) {
        respond centroCustoInstance
    }

    @Transactional
    def update(CentroCusto centroCustoInstance) {
        if (centroCustoInstance == null) {
            notFound()
            return
        }

        if (centroCustoInstance.hasErrors()) {
            respond centroCustoInstance.errors, view: 'edit'
            return
        }

        _updateCentroCusto(centroCustoInstance, params)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'CentroCusto.label', default: 'CentroCusto'), centroCustoInstance.id])
                redirect centroCustoInstance
            }
            '*' { respond centroCustoInstance, [status: OK] }
        }
    }

    @Transactional
    def _updateCentroCusto(CentroCusto centroCustoInstance, params) {
        atualizarPlanoDeTrabalho(centroCustoInstance, params.numFilesUploaded, params.planoDeTrabalho, params.previousPlanoDeTrabalho)

        def orcamento = centroCustoInstance.orcamentos ? centroCustoInstance.orcamentoAtual : new Orcamento()

        orcamento.ano = Integer.parseInt(params.orcamento?.ano)
        orcamento.valorTotal = Util.parse(params.valorTotalOrcamento)
        orcamento.moeda = Moeda.valueOf(params.orcamento?.moeda)
        orcamento.valorCambial = params.valorCambialOrcamento ? Util.parse(params.valorCambialOrcamento) : 1
        orcamento.save()

        atualizarItensOrcamentarios(orcamento, params.itensOrcamento)

        centroCustoInstance.contaBancaria.tipoConta = TipoContaBancaria.valueOf(params.contaBancaria?.tipoConta)
        centroCustoInstance.contaBancaria.dvAgencia = params.contaBancaria.dvAgencia ?: '0'
        centroCustoInstance.contaBancaria.dvConta = params.contaBancaria.dvConta ?: '0'

        if (orcamento != centroCustoInstance.orcamentoAtual) {
            centroCustoInstance.addToOrcamentos(orcamento)
        }

        centroCustoInstance.save(failOnError: true)
    }

    @Transactional
    def delete(CentroCusto centroCustoInstance) {

        if (centroCustoInstance == null) {
            notFound()
            return
        }

        centroCustoInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'CentroCusto.label', default: 'CentroCusto'), centroCustoInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'centroCusto.label', default: 'CentroCusto'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    @Transactional
    def atualizarPlanoDeTrabalho(centroCusto, numFilesUploaded, planoDeTrabalhoAtual, planoDeTrabalhoAnterior) {
        if (numFilesUploaded.toInteger() == 0) {
            centroCusto.planoDeTrabalho = null
        } else {
            if (planoDeTrabalhoAtual.isEmpty()) {
                centroCusto.planoDeTrabalho = Anexo.get(planoDeTrabalhoAnterior)
            }

            centroCusto.planoDeTrabalho.save flush: true
        }
    }

    def removerItensOrcamentarios(Orcamento orcamento) {
        orcamento?.itensOrcamentarios?.collect()?.each {
            orcamento.removeFromItensOrcamentarios(it)
        }
    }

    def atualizarItensOrcamentarios(Orcamento orcamento, itensOrcamento) {
        def itensOrcamentarios = orcamento?.itensOrcamentarios?.collect()

        removerItensOrcamentarios(orcamento)

        if (itensOrcamento?.codigo?.class?.array) {
            itensOrcamento.codigo.eachWithIndex { codigo, i ->
                createUpdateItemOrcamentario(itensOrcamentarios, codigo, itensOrcamento.nome[i], itensOrcamento.valor[i],
                        itensOrcamento.tipoCusto[i], orcamento, itensOrcamento.id[i], itensOrcamento)
            }
        } else {
            createUpdateItemOrcamentario(itensOrcamentarios, itensOrcamento.codigo, itensOrcamento.nome,
                    itensOrcamento.valor, itensOrcamento.tipoCusto, orcamento, itensOrcamento.id, itensOrcamento)
        }

        deletarItensOrcamentariosPassados(orcamento.itensOrcamentarios, itensOrcamentarios)
    }

    def deletarItensOrcamentariosPassados(itensOrcamentariosAtuais, itensOrcamentariosPassados) {
        for (pastItemOrcamentario in itensOrcamentariosPassados) {
            if (!itensOrcamentariosAtuais.contains(pastItemOrcamentario)) {
                pastItemOrcamentario.delete()
            }
        }
    }

    def getItensOrcamentarios() {
        def df = new DecimalFormat('###,##0.00')

        def orcamento

        if (params.idOrcamento) {
            orcamento = Orcamento.get(Long.parseLong(params.idOrcamento))
        }

        def json = orcamento?.itensOrcamentarios?.collect { ItemOrcamentario it ->
            [it.codigo, it.nome, it.valor, it.tipoCusto.name(),
             it.salariosFuncionarios?.collect { it.funcionario.id }?.join(','),
             it.salariosFuncionarios?.collect { df.format(it.valor) }?.join('-')]
        }

        render(json as JSON)
    }

    def atualizarSalariosFuncionarios(listaFuncionarios, listaSalarios, ItemOrcamentario item) {
        def funcionarios = listaFuncionarios.split(',')
        def salarioFuncionarios = listaSalarios.split('-')

        println "FUNCIONÁRIOS: ${funcionarios}"
        println "SALÁRIO FUNCIONÁRIOS: ${salarioFuncionarios}"

        def listaAntigaSalariosFuncionarios = item.salariosFuncionarios?.collect()

        item.salariosFuncionarios?.collect()?.each {
            item.removeFromSalariosFuncionarios(it)
        }

        if (item.tipoCusto == TipoCusto.PESSOAL) {
            if (funcionarios) {
                funcionarios.eachWithIndex { funcionarioId, i ->
                    if (funcionarioId && salarioFuncionarios[i]) {
                        def salarioFuncionario = listaAntigaSalariosFuncionarios.find {
                            it.funcionario.id == funcionarioId.toInteger()
                        }

                        if (!salarioFuncionario) {
                            salarioFuncionario = new SalarioFuncionario(itemOrcamentario: item,
                                    funcionario: Funcionario.get(funcionarioId))
                        }

                        salarioFuncionario.valor = salarioFuncionarios[i] ? Util.parse(salarioFuncionarios[i]) : 0

                        item.addToSalariosFuncionarios(salarioFuncionario)
                        salarioFuncionario.save()
                    }
                }
            }
        }

        for (salarioFuncionario in listaAntigaSalariosFuncionarios) {
            if (!item.salariosFuncionarios.contains(salarioFuncionario)) {
                log.debug("SF ${salarioFuncionario} deletado!")
                salarioFuncionario.delete()
            }
        }
    }

    def createUpdateItemOrcamentario(itensOrcamentarios, codigo, nome, valor, tipoCusto, orcamento, id, params) {
        if (codigo) {
            ItemOrcamentario item = itensOrcamentarios?.find { it.codigo == codigo }

            println "---------------"
            println "ITEM PASSADO: ${item}"
            println "ID: ${id}"
            println "CÓDIGO: ${codigo}"
            println "NOME: ${nome}"
            println "VALOR: ${valor}"
            println "TIPO: ${tipoCusto}"

            if (!item) {
                item = new ItemOrcamentario(codigo: codigo)
            }

            item.nome = nome ?: ''
            item.valor = valor ? Util.parse(valor) : 0
            item.tipoCusto = tipoCusto ? TipoCusto.valueOf(tipoCusto) : null
            item.orcamento = orcamento
            item.save()

            atualizarSalariosFuncionarios(params["listaFuncionarios_${id}"],
                    params["listaFuncionariosSalario_${id}"], item)

            orcamento.addToItensOrcamentarios(item)
        }
    }

    @Transactional
    def carregarArquivo(Long id) {
        def centroCustoInstance = CentroCusto.get(id)
        def fileName = []
        def f = request.getFile('file')
        if (f) {
            Arquivo arquivoInstance = new Arquivo()
            arquivoInstance.bytes = f.bytes
            arquivoInstance.contentType = f.contentType
            arquivoInstance.size = f.size
            arquivoInstance.fileName = f.originalFilename
            arquivoInstance.save(flush: true)
            centroCustoInstance.addToArquivos(arquivoInstance)
            centroCustoInstance.save(flush: true)
            fileName.add([id: arquivoInstance.id])
        }
        render(fileName as JSON)
    }

    @Transactional
    def deletarArquivo(Long id) {
        def centroCustoInstance = CentroCusto.get(id)
        Arquivo arquivoInstance = Arquivo.get(params.idArquivo as Long)
        centroCustoInstance.removeFromArquivos(arquivoInstance)
        centroCustoInstance.save(flush: true)
        arquivoInstance.delete(flush: true)
        render([success: 'ok'] as JSON)
    }

    def baixarArquivo() {
        Arquivo arquivoInstance = Arquivo.get(params.idArquivo as Long)
        if (arquivoInstance == null) {
            flash.message = "Document not found."
            redirect(action: 'show')
        } else {
            response.setContentType("APPLICATION/OCTET-STREAM")
            response.setHeader("Content-Disposition", "Attachment;Filename=\"${arquivoInstance.fileName}\"")
            def outputStream = response.getOutputStream()
            outputStream << arquivoInstance.bytes
            outputStream.flush()
            outputStream.close()
        }
    }

    def getFiles(Long id) {
        def centroCusto = CentroCusto.get(params.id as Long)
        def arquivos = []
        centroCusto?.arquivos?.sort { -it?.fileName?.size() }.each { arquivoInstance ->
            if (okcontents.contains(arquivoInstance.contentType)) {
                arquivos.add([name: arquivoInstance.fileName, path: createLink(action: 'imagem', id: arquivoInstance.id), size: arquivoInstance.size, id: arquivoInstance.id])
            } else {
                arquivos.add([name: arquivoInstance.fileName, path: resource(file: 'images/document.png'), size: arquivoInstance.size, id: arquivoInstance.id])
            }
        }
        render(arquivos as JSON)
    }

    def imagem(Long id) {
        def arquivoInstance = Arquivo.get(id)
        if (!arquivoInstance || !arquivoInstance.bytes || !arquivoInstance.contentType) {
            response.sendError(404)
            return
        }

        response.contentType = arquivoInstance.contentType
        response.contentLength = arquivoInstance.bytes.size()
        OutputStream out = response.outputStream
        out.write(arquivoInstance.bytes)
        out.close()
    }

    def getAtividadesFromCentroCusto(Long centroCustoId) {
        if (centroCustoId) {
            def centroCusto = CentroCusto.get(centroCustoId)

            if (centroCusto) {
                def listaAtividades = centroCusto.atividades.collect { ['id': it.id, 'label': it.toString()] }

                render(['success': true, objects: listaAtividades] as JSON)
            } else {
                render(['success': false] as JSON)
            }
        } else {
            render(['success': false] as JSON)
        }
    }

    def getFuncionariosAtuaisDeCentroCusto(Long centroCustoId) {
        def centroCusto = CentroCusto.get(centroCustoId)

        if (centroCusto) {
            def dadosFuncionarios = []
            Set listaFuncionarios = centroCusto.orcamentoAtual?.itensOrcamentarios?.salariosFuncionarios?.funcionario

            if (listaFuncionarios) {
                listaFuncionarios = listaFuncionarios.flatten()

                dadosFuncionarios = listaFuncionarios.collect { ['id': it.id, 'label': it.participante.nome] }
            }

            render(['success': true, objects: dadosFuncionarios] as JSON)
        } else {
            render(['success': false] as JSON)
        }
    }

    def getItensOrcamentariosDeCentroCusto(Long centroCustoId) {
        def centroCusto = CentroCusto.get(centroCustoId)

        if (centroCusto) {
            def itensOrcamentarios = centroCusto.orcamentoAtual?.itensOrcamentarios?.collect {
                ['id'   : it.id,
                 'label': it.toString()]
            }

            render(['success': true, objects: itensOrcamentarios] as JSON)
        } else {
            render(['success': false] as JSON)
        }
    }
}

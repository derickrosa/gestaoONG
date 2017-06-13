package com.acception.cadastro

import com.acception.cadastro.enums.Moeda
import com.acception.cadastro.enums.TipoCusto
import com.acception.util.Util
import grails.converters.JSON
import java.text.DecimalFormat
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CentroCustoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond CentroCusto.list(params), model: [centroCustoInstanceCount: CentroCusto.count()]
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

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'centroCusto.label', default: 'CentroCusto'), centroCustoInstance.id])
                redirect centroCustoInstance
            }
            '*' { respond centroCustoInstance, [status: CREATED] }
        }
    }

    def edit(CentroCusto centroCustoInstance) {
        respond centroCustoInstance
    }

    @Transactional
    def update(CentroCusto centroCustoInstance) {
        log.debug(params)

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

        if (centroCustoInstance.orcamento) {
            centroCustoInstance.orcamento.valorTotal = Util.parse(params.valorTotalOrcamento)

            centroCustoInstance.orcamento.moeda = Moeda.valueOf(params.orcamento?.moeda)

            atualizarItensOrcamentarios(centroCustoInstance, params.itensOrcamento)
        }

        centroCustoInstance.orcamento.save flush: true, failOnError: true
        centroCustoInstance.save flush: true, failOnError: true
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

    def removerItensOrcamentarios(CentroCusto centroCustoInstance) {
        centroCustoInstance.orcamento?.itensOrcamentarios?.collect()?.each {
            centroCustoInstance.orcamento.removeFromItensOrcamentarios(it)
        }
    }

    def atualizarItensOrcamentarios(CentroCusto centroCustoInstance, itensOrcamento) {
        def itensOrcamentarios = centroCustoInstance.orcamento?.itensOrcamentarios?.collect()

        removerItensOrcamentarios(centroCustoInstance)

        if (itensOrcamento?.codigo?.class?.array) {
            itensOrcamento.codigo.eachWithIndex { codigo, i ->
                createUpdateItemOrcamentario(itensOrcamentarios, codigo, itensOrcamento.nome[i], itensOrcamento.valor[i],
                        itensOrcamento.tipoCusto[i], centroCustoInstance, itensOrcamento.id[i], itensOrcamento)
            }
        } else {
            createUpdateItemOrcamentario(itensOrcamentarios, itensOrcamento.codigo, itensOrcamento.nome,
                    itensOrcamento.valor, itensOrcamento.tipoCusto, centroCustoInstance, itensOrcamento.id, itensOrcamento)
        }

        deletarItensOrcamentariosPassados(centroCustoInstance.orcamento.itensOrcamentarios, itensOrcamentarios)
    }

    def deletarItensOrcamentariosPassados(itensOrcamentariosAtuais, itensOrcamentariosPassados) {
        for (pastItemOrcamentario in itensOrcamentariosPassados) {
            if (! itensOrcamentariosAtuais.contains(pastItemOrcamentario)) {
                pastItemOrcamentario.delete()
            }
        }
    }

    def getItensOrcamentarios(){
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
                    if (funcionarioId) {
                        def salarioFuncionario = listaAntigaSalariosFuncionarios.find { it.funcionario.id == funcionarioId.toInteger()}

                        if (! salarioFuncionario) {
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
            if (! item.salariosFuncionarios.contains(salarioFuncionario)) {
                log.debug("SF ${salarioFuncionario} deletado!")
                salarioFuncionario.delete()
            }
        }
    }

    def createUpdateItemOrcamentario(itensOrcamentarios, codigo, nome, valor, tipoCusto, centroCustoInstance, id, params) {
        if (codigo) {
            ItemOrcamentario item = itensOrcamentarios?.find { it.codigo == codigo}

            println "---------------"
            println "ITEM PASSADO: ${item}"
            println "ID: ${id}"
            println "CÓDIGO: ${codigo}"
            println "NOME: ${nome}"
            println "VALOR: ${valor}"
            println "TIPO: ${tipoCusto}"

            if (! item) {
                item = new ItemOrcamentario(codigo: codigo)
            }

            item.nome = nome ?: ''
            item.valor = valor ? Util.parse(valor) : 0
            item.tipoCusto = tipoCusto ? TipoCusto.valueOf(tipoCusto) : null
            item.orcamento = centroCustoInstance.orcamento
            item.save()

            atualizarSalariosFuncionarios(params["listaFuncionarios_${id}"],
                    params["listaFuncionariosSalario_${id}"], item)

            centroCustoInstance.orcamento.addToItensOrcamentarios(item)
        }
    }

}

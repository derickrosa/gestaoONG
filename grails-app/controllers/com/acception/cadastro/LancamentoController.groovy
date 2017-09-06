package com.acception.cadastro

import com.acception.cadastro.enums.TipoLancamento
import com.acception.util.Util
import grails.converters.JSON

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class LancamentoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def exportService

    def index() {
        params?.remove('max')
        Map<String, String> pesquisa = params.pesquisa ?: params.subMap(['dataEmissaoInicio', 'dataEmissaoFinal', 'dataPagamentoInicio', 'dataPagamentoFinal', 'tipo', 'classe', 'codigo'])
        pesquisa = Util.trimMap(pesquisa)

        def criteria = {
            if (pesquisa.containsKey('dataEmissaoInicio')) {
                Date inicio = Date.parse("dd/MM/yyyy", pesquisa.dataEmissaoInicio).clearTime()
                ge('dataEmissao', inicio)
            }
            if (pesquisa.containsKey('dataEmissaoFinal')) {
                Date fim = Date.parse("dd/MM/yyyy", pesquisa.dataEmissaoFinal).clearTime() + 1
                le('dataEmissao', fim)
            }
            if (pesquisa.containsKey('dataPagamentoInicio')) {
                Date inicio = Date.parse("dd/MM/yyyy", pesquisa.dataPagamentoInicio).clearTime()
                ge('dataPagamento', inicio)
            }
            if (pesquisa.containsKey('dataPagamentoFinal')) {
                Date fim = Date.parse("dd/MM/yyyy", pesquisa.dataPagamentoFinal).clearTime() + 1
                le('dataPagamento', fim)
            }
            if (pesquisa.containsKey('tipo')) eq('tipoLancamento', TipoLancamento.valueOf(pesquisa.tipo))
            if (pesquisa.containsKey('codigo')) eq('codigoLancamento', pesquisa.codigo)
        }

        if (params?.exportFormat && params.exportFormat != "html") {
            response.contentType = grailsApplication.config.grails.mime.types[params.exportFormat]
            response.setHeader("Content-disposition", "attachment; filename=Relatório de Lançamentos.${params.extension}")

            def lancamentoInstanceList = Lancamento.createCriteria().list(params, criteria)

            List fields = ['id', 'dateEmissao', 'dataPagamento', 'dataCancelamento', 'parcela', 'tipoLancamento', 'descricao']
            Map labels = ['id'     : 'Identificador', 'dateEmissao': 'Data Emissão', 'dataPagamento': 'Data Pagamento', 'dataCancelamento': 'Data Cancelamento',
                          'parcela': 'Parcelas', 'tipoLancamento': 'Tipo', 'descricao': 'Descrição']
            Map parameters = ["column.widths": [0.1, 0.2, 0.2, 0.2, 0.1, 0.2, 0.6]]

            exportService.export(params.exportFormat, response.outputStream, lancamentoInstanceList, fields, labels, null, parameters)
            return
        }


        params.max = Math.min(params.max ?: 10, 100)

        [lancamentoInstanceList : Lancamento.createCriteria().list(params, criteria),
         lancamentoInstanceCount: Lancamento.createCriteria().count(criteria),
         pesquisa               : pesquisa]
    }

    def show(Lancamento lancamentoInstance) {
        respond lancamentoInstance
    }

    def create() {
        respond new Lancamento(params)
    }


    @Transactional
    def criarLancamentoAjax() {
        def lancamento = new Lancamento(params)

        lancamento.valor = Util.parse(params.valorCredito)
        lancamento.tipoLancamento = TipoLancamento.CREDITO
        lancamento.numeroTitulo = 0
        lancamento.dataEmissao = Date.parse('dd/MM/yyyy', params.dataCredito)
        lancamento.descricao = params.descricaoCredito
        lancamento.centroCusto = CentroCusto.get(params.centroCustoCredito as Long)
        lancamento.papel = Papel.get(params.papelCredito as Long)
        lancamento.save(flush: true, failOnError: true)

        render(['success': true, 'credito': ['id'         : lancamento.id,
                                             'tipo'       : lancamento.tipoLancamento,
                                             'descricao'  : lancamento.descricao,
                                             'valor'      : lancamento.valor,
                                             'data'       : lancamento.dataEmissao.format('dd/MM/yyyy'),
                                             'centroCusto': ['nome': lancamento.centroCusto.toString(), 'id': lancamento.centroCusto.id],
                                             'papel'      : lancamento.papel ? lancamento.papel.toString() : '']] as JSON)
    }

    @Transactional
    def save(Lancamento lancamentoInstance) {
        if (lancamentoInstance == null) {
            notFound()
            return
        }

        if (lancamentoInstance.hasErrors()) {
            respond lancamentoInstance.errors, view: 'create'
            return
        }

        lancamentoInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'lancamento.label', default: 'Lancamento'), lancamentoInstance.id])
                redirect lancamentoInstance
            }
            '*' { respond lancamentoInstance, [status: CREATED] }
        }
    }

    def edit(Lancamento lancamentoInstance) {
        respond lancamentoInstance
    }

    @Transactional
    def update(Lancamento lancamentoInstance) {
        if (lancamentoInstance == null) {
            notFound()
            return
        }

        if (lancamentoInstance.hasErrors()) {
            respond lancamentoInstance.errors, view: 'edit'
            return
        }

        lancamentoInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Lancamento.label', default: 'Lancamento'), lancamentoInstance.id])
                redirect lancamentoInstance
            }
            '*' { respond lancamentoInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Lancamento lancamentoInstance) {

        if (lancamentoInstance == null) {
            notFound()
            return
        }

        lancamentoInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Lancamento.label', default: 'Lancamento'), lancamentoInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'lancamento.label', default: 'Lancamento'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}

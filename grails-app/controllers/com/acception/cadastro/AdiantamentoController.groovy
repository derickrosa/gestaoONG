package com.acception.cadastro

import com.acception.cadastro.enums.StatusAdiantamento
import com.acception.cadastro.enums.StatusLancamento
import com.acception.cadastro.enums.TipoLancamento
import com.acception.util.Util
import grails.converters.JSON

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AdiantamentoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def exportService

    def index() {
        params?.remove('max')
        Map<String, String> pesquisa = params.pesquisa ?: params.subMap(['dataInicio', 'dataFinal', 'centroCusto', 'status'])
        pesquisa = Util.trimMap(pesquisa)

        Closure criteria = {
            if (pesquisa.containsKey('dataInicio')) {
                Date inicio = Date.parse('dd/MM/yyyy', pesquisa.dataInicio).clearTime()
                ge('data', inicio)
            }
            if (pesquisa.containsKey('dataFinal')) {
                Date fim = Date.parse('dd/MM/yyyy', pesquisa.dataFinal).clearTime() + 1
                le('data', fim)
            }
            if (pesquisa.containsKey('centroCusto')) {
                centroCusto {
                    idEq(pesquisa.centroCusto as Long)
                }
            }
            if (pesquisa.containsKey('status'))
                eq('statusAdiantamento', StatusAdiantamento.valueOf(pesquisa.status))
        }

        if (params?.exportFormat && params.exportFormat != "html") {
            response.contentType = grailsApplication.config.grails.mime.types[params.exportFormat]
            response.setHeader("Content-disposition", "attachment; filename=Relatório de Adiantamentos.${params.extension}")

            def adiantamentoInstanceList = Adiantamento.createCriteria().list(params, criteria)

            List fields = ['id', 'data', 'centroCusto', 'descricao', 'statusAdiantamento']
            Map labels = ['id': 'Identificador', 'data': 'Data', 'centroCusto': 'Centro de Custo', 'descricao': 'Descrição', 'statusAdiantamento': 'Status']
            Map parameters = ["column.widths": [0.1, 0.1, 0.2, 1, 0.1]]

            exportService.export(params.exportFormat, response.outputStream, adiantamentoInstanceList, fields, labels, null, parameters)
            return
        }

        params.max = Math.min(params.max ?: 10, 100)

        [adiantamentoInstanceList : Adiantamento.createCriteria().list(params, criteria),
         adiantamentoInstanceCount: Adiantamento.createCriteria().count(criteria),
         pesquisa                 : pesquisa]
    }

    def show(Adiantamento adiantamentoInstance) {
        respond adiantamentoInstance
    }

    def create() {
        respond new Adiantamento(params)
    }

    @Transactional
    def save(Adiantamento adiantamentoInstance) {
        if (adiantamentoInstance == null) {
            notFound()
            return
        }

        if (adiantamentoInstance.hasErrors()) {
            respond adiantamentoInstance.errors, view: 'create'
            return
        }

        adiantamentoInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'adiantamento.label', default: 'Adiantamento'), adiantamentoInstance.id])
                redirect adiantamentoInstance
            }
            '*' { respond adiantamentoInstance, [status: CREATED] }
        }
    }

    def edit(Adiantamento adiantamentoInstance) {
        respond adiantamentoInstance
    }

    @Transactional
    def update(Adiantamento adiantamentoInstance) {
        if (adiantamentoInstance == null) {
            notFound()
            return
        }

        if (adiantamentoInstance.hasErrors()) {
            respond adiantamentoInstance.errors, view: 'edit'
            return
        }

        adiantamentoInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Adiantamento.label', default: 'Adiantamento'), adiantamentoInstance.id])
                redirect adiantamentoInstance
            }
            '*' { respond adiantamentoInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Adiantamento adiantamentoInstance) {

        if (adiantamentoInstance == null) {
            notFound()
            return
        }

        adiantamentoInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Adiantamento.label', default: 'Adiantamento'), adiantamentoInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    @Transactional
    def criarPagamentoAdiantado() {
        def pa = new Adiantamento(params)

        pa.valor = Util.parse(params.valor)
        pa.dateCreated = new Date()
        pa.lastUpdated = new Date()

        pa.lancamentoOriginal = new Lancamento()
        pa.lancamentoOriginal.numeroTitulo = pa.id.toString()

        pa.lancamentoOriginal.save()
        pa.save()

        pa.lancamentoOriginal.valor = - pa.valor
        pa.lancamentoOriginal.papel = Funcionario.get(params.papel.id)
        pa.lancamentoOriginal.tipoLancamento = TipoLancamento.DEBITO
        pa.lancamentoOriginal.dataEmissao = pa.data
        pa.lancamentoOriginal.descricao = pa.descricao
        pa.lancamentoOriginal.statusLancamento = StatusLancamento.BAIXADO
        pa.lancamentoOriginal.centroCusto = pa.centroCusto
        pa.lancamentoOriginal.eventoFinanceiro = pa;

        pa.lancamentoOriginal.save()

        response.status = CREATED.value()
        respond([msg: "Pagamento adiantado criado com sucesso", object: [data: pa.data.format('dd/MM/yyy'),
                                                             tipo: pa.lancamentoOriginal.tipoLancamento.descricao,
                                                             valor: pa.valor,
                                                             origem: pa.lancamentoOriginal.papel ? pa.lancamentoOriginal.papel.toString() : '',
                                                             saldo: 0]])
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'adiantamento.label', default: 'Adiantamento'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}

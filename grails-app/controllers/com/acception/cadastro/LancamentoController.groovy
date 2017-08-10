package com.acception.cadastro

import com.acception.cadastro.enums.StatusLancamento
import com.acception.cadastro.enums.TipoDespesa
import com.acception.cadastro.enums.TipoLancamento
import com.acception.util.Util
import grails.converters.JSON

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class LancamentoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Lancamento.list(params), model: [lancamentoInstanceCount: Lancamento.count()]
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
        lancamento.dataEmissao = Date.parse('dd/MM/yyyy',params.dataCredito)
        lancamento.descricao = params.descricaoCredito
        lancamento.centroCusto = CentroCusto.get(params.centroCustoCredito as Long)
        lancamento.papel = Papel.get(params.papelCredito as Long)
        lancamento.save(flush: true, failOnError:true)

        render(['success': true, 'credito': ['id': lancamento.id,
                                             'tipo': lancamento.tipoLancamento,
                                             'descricao': lancamento.descricao,
                                             'valor':  lancamento.valor,
                                             'data': lancamento.dataEmissao.format('dd/MM/yyyy'),
                                             'centroCusto': ['nome': lancamento.centroCusto.toString(), 'id': lancamento.centroCusto.id],
                                             'papel': lancamento.papel ? lancamento.papel.toString() : '']] as JSON)
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

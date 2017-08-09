package com.acception.cadastro

import com.acception.cadastro.enums.StatusLancamento
import com.acception.cadastro.enums.TipoLancamento
import com.acception.util.Util
import grails.converters.JSON

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AdiantamentoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Adiantamento.list(params), model: [adiantamentoInstanceCount: Adiantamento.count()]
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

        pa.lancamentoOriginal = new Lancamento()
        pa.lancamentoOriginal.numeroTitulo = pa.id.toString()

        pa.lancamentoOriginal.save()
        pa.save()

        pa.lancamentoOriginal.valor = pa.valor
        pa.lancamentoOriginal.papel = Funcionario.get(params.papel.id)
        pa.lancamentoOriginal.tipoLancamento = TipoLancamento.DEBITO
        pa.lancamentoOriginal.dataEmissao = pa.data
        pa.lancamentoOriginal.descricao = pa.descricao
        pa.lancamentoOriginal.statusLancamento = StatusLancamento.BAIXADO
        pa.lancamentoOriginal.centroCusto = pa.centroCusto
        pa.lancamentoOriginal.eventoFinanceiro = pa;

        pa.lancamentoOriginal.save()

        def pagamentoAdiantado = ['id': pa.id]

        Util.updateResponseWithValuesToSendBack(pagamentoAdiantado, pa, params.attributes)

        render(['success': true, 'pagamentoAdiantado': pagamentoAdiantado] as JSON)
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

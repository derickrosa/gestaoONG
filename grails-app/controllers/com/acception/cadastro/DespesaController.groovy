package com.acception.cadastro

import com.acception.cadastro.enums.TipoDespesa
import com.acception.cadastro.enums.TipoLancamento
import com.acception.util.Util

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class DespesaController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Despesa.list(params), model: [despesaInstanceCount: Despesa.count()]
    }

    def show(Despesa despesaInstance) {
        respond despesaInstance
    }

    def create() {
        respond new Despesa(params)
    }

    @Transactional
    def save(Despesa despesaInstance) {
        if (despesaInstance == null) {
            notFound()
            return
        }

        despesaInstance.save flush: true

        _updateDespesa(despesaInstance, params)

        if (despesaInstance.hasErrors()) {
            respond despesaInstance.errors, view: 'create'
            return
        }

        despesaInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'despesa.label', default: 'Despesa'), despesaInstance.id])
                redirect despesaInstance
            }
            '*' { respond despesaInstance, [status: CREATED] }
        }
    }

    def _updateDespesa(Despesa despesaInstance, params) {
        log.debug(despesaInstance.valor)

        def numParcelas = params.numParcelas ? params.numParcelas.toInteger() : 1
        def valorParcela = Util.parse(params.valor) / numParcelas

        log.debug("Valor Parcela: " + valorParcela)

        def tipoLancamento = despesaInstance.tipoDespesa == TipoDespesa.ADIANTAMENTO ? TipoLancamento.PAGAMENTO_ADIANTADO : TipoLancamento.PAGAR

        def lancamentosAnteriores = despesaInstance.lancamentos.collect()

        def listaAtualizadaLancamentos = []

        1.upto(numParcelas) {
            def numParcela = it

            def lancamento = lancamentosAnteriores.find {
                it.despesa == despesaInstance && it.valor == valorParcela.toDouble() && it.parcela == numParcela
            } ?: new Lancamento(valor: valorParcela, parcela: numParcela)

            lancamento.dataEmissao = despesaInstance.data
            lancamento.tipoLancamento = tipoLancamento
            lancamento.descricao = despesaInstance.descricao
            lancamento.valorBruto = valorParcela
            lancamento.despesa = despesaInstance
            lancamento.save(flush: true)

            listaAtualizadaLancamentos << lancamento
        }

        for (Lancamento lancamento in lancamentosAnteriores) {
            if (! listaAtualizadaLancamentos.contains(lancamento)) {
                log.debug(">> Lançamento ${lancamento} deve ser deletado!")
                despesaInstance.removeFromLancamentos(lancamento)
                lancamento.delete()
            }
        }
    }

    def edit(Despesa despesaInstance) {
        respond despesaInstance
    }

    @Transactional
    def update(Despesa despesaInstance) {
        if (despesaInstance == null) {
            notFound()
            return
        }

        _updateDespesa(despesaInstance, params)

        if (despesaInstance.hasErrors()) {
            respond despesaInstance.errors, view: 'edit'
            return
        }

        despesaInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Despesa.label', default: 'Despesa'), despesaInstance.id])
                redirect despesaInstance
            }
            '*' { respond despesaInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Despesa despesaInstance) {

        for (lancamento in despesaInstance.lancamentos) {
            lancamento.delete()
        }

        if (despesaInstance == null) {
            notFound()
            return
        }

        despesaInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Despesa.label', default: 'Despesa'), despesaInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'despesa.label', default: 'Despesa'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}

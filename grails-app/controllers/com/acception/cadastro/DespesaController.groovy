package com.acception.cadastro

import com.acception.cadastro.enums.StatusLancamento
import com.acception.cadastro.enums.TipoDespesa
import com.acception.cadastro.enums.TipoLancamento
import com.acception.util.Util
import grails.converters.JSON

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class DespesaController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE", criarDespesa: "POST"]

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

        def valorParcela = Util.parse(params.valor)

        log.debug("Valor Parcela: " + valorParcela)

        def tipoLancamento = despesaInstance.tipoDespesa == TipoDespesa.ADIANTAMENTO ? TipoLancamento.PAGAMENTO_ADIANTADO : TipoLancamento.DEBITO

        def lancamentosAnteriores = despesaInstance.lancamentos.collect()

        def listaAtualizadaLancamentos = []

        def lancamento = lancamentosAnteriores.find {
            it.despesa == despesaInstance && it.valor == valorParcela.toDouble()
        } ?: new Lancamento(valor: valorParcela)

        lancamento.dataEmissao = despesaInstance.data
        lancamento.tipoLancamento = tipoLancamento
        lancamento.descricao = despesaInstance.descricao
        lancamento.valorBruto = valorParcela
        lancamento.despesa = despesaInstance
        lancamento.save(flush: true)

        listaAtualizadaLancamentos << lancamento

        for (Lancamento l in lancamentosAnteriores) {
            if (! listaAtualizadaLancamentos.contains(l)) {
                log.debug(">> Lançamento ${l} deve ser deletado!")
                despesaInstance.removeFromLancamentos(l)
                l.delete()
            }
        }
    }

    @Transactional
    def criarDespesa() {
        def despesa = new Despesa(params)

        despesa.valor = Util.parse(params.valor)
        despesa.save()

        def lancamento = new Lancamento(despesa: despesa)

        lancamento.valor = despesa.valor
        lancamento.valorBruto = despesa.valor
        lancamento.tipoLancamento = despesa.tipoDespesa == TipoDespesa.ADIANTAMENTO ? TipoLancamento.PAGAMENTO_ADIANTADO : TipoLancamento.PAGAR
        lancamento.dataEmissao = despesa.data
        lancamento.descricao = despesa.descricao
        lancamento.statusLancamento = StatusLancamento.BAIXADO
        lancamento.centroCusto = despesa.centroCusto
        lancamento.save()

        despesa.save(flush: true)

        render(['success': true, 'despesa': ['id': despesa.id,
                                             'tipo': despesa.tipoDespesa.nome,
                                             'descricao': despesa.descricao,
                                             'valor': despesa.valor,
                                             'data': despesa.data.format('dd/MM/yyyy'),
                                             'centroCusto': despesa.centroCusto.toString(),
                                             'atividade': despesa.atividade ? despesa.atividade.toString() : '']] as JSON)
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

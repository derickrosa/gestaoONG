package com.acception.cadastro

import com.acception.cadastro.enums.TipoCusto
import grails.converters.JSON

import java.text.DecimalFormat
import java.text.NumberFormat

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
        if (centroCustoInstance == null) {
            notFound()
            return
        }

        if (centroCustoInstance.hasErrors()) {
            respond centroCustoInstance.errors, view: 'create'
            return
        }

        if (params.planoDeTrabalho.isEmpty()) {
            centroCustoInstance.planoDeTrabalho = null
        } else {
            centroCustoInstance.planoDeTrabalho.save flush: true
        }

        centroCustoInstance.save flush: true

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
        if (centroCustoInstance == null) {
            notFound()
            return
        }

        if (centroCustoInstance.hasErrors()) {
            respond centroCustoInstance.errors, view: 'edit'
            return
        }

        if (params.numFilesUploaded.toInteger() == 0) {
            centroCustoInstance.planoDeTrabalho = null
        } else {
            if (params.planoDeTrabalho.isEmpty()) {
                centroCustoInstance.planoDeTrabalho = Anexo.get(params.previousPlanoDeTrabalho)
            }

            centroCustoInstance.planoDeTrabalho.save flush: true
        }

        centroCustoInstance.orcamento.valorTotal = parse(params.orcamento.valorTotal)

        def itensOrcamentarios = centroCustoInstance.orcamento?.itensOrcamentarios

        centroCustoInstance.orcamento?.itensOrcamentarios?.clear()

        if (params.itensOrcamento?.codigo?.class?.array) {
            0.upto(params.itensOrcamento.codigo.size() - 1) { i ->
                createUpdateItemOrcamentario(itensOrcamentarios, params.itensOrcamento.codigo[i],
                        params.itensOrcamento.nome[i], params.itensOrcamento.valor[i], params.itensOrcamento.tipoCusto[i],
                        centroCustoInstance)
            }
        } else {
            createUpdateItemOrcamentario(itensOrcamentarios, params.itensOrcamento.codigo,
                    params.itensOrcamento.nome, params.itensOrcamento.valor, params.itensOrcamento.tipoCusto,
                    centroCustoInstance)
        }

        centroCustoInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'CentroCusto.label', default: 'CentroCusto'), centroCustoInstance.id])
                redirect centroCustoInstance
            }
            '*' { respond centroCustoInstance, [status: OK] }
        }
    }

    def getItensOrcamentarios(){
        def orcamento

        if (params.idOrcamento) {
            orcamento = Orcamento.get(Long.parseLong(params.idOrcamento))
        }

        def json = orcamento?.itensOrcamentarios?.collect { it ->
            [it.codigo, it.nome, it.valor, it.tipoCusto.name()]
        }

        render(json as JSON)
    }

    def createUpdateItemOrcamentario(itensOrcamentarios, codigo, nome, valor, tipoCusto, centroCustoInstance) {
        if (codigo) {
            def item = itensOrcamentarios?.find { it.codigo == codigo}

            println "---------------"
            println "CÓDIGO: ${codigo}"
            println "NOME: ${nome}"
            println "VALOR: ${valor}"
            println "TIPO: ${tipoCusto}"

            if (! item) {
                item = new ItemOrcamentario(codigo: codigo)
            }

            if (nome) {
                item.nome = nome
            }

            if (valor) {
                item.valor = parse(valor)
            }

            if (tipoCusto) {
                item.tipoCusto = TipoCusto.valueOf(tipoCusto)
            }

            item.orcamento = centroCustoInstance.orcamento
            item.save()

            centroCustoInstance.orcamento.addToItensOrcamentarios(item)
        }
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

    def Double parse(String amount) {
        Locale ptBr = new Locale("pt", "BR");
        final NumberFormat format = NumberFormat.getNumberInstance(ptBr);
        if (format instanceof DecimalFormat) {
            ((DecimalFormat) format).setParseBigDecimal(true);
        }
        return format.parse(amount.replaceAll("[^\\d.,]", "")).doubleValue();
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
}

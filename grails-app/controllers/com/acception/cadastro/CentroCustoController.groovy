package com.acception.cadastro

import com.acception.cadastro.enums.Moeda
import com.acception.cadastro.enums.TipoCusto
import com.acception.util.Util
import grails.converters.JSON

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
            log.debug(centroCustoInstance.orcamento.valorTotal)

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

    def atualizarItensOrcamentarios(centroCustoInstance, itensOrcamento) {
        def itensOrcamentarios = centroCustoInstance.orcamento?.itensOrcamentarios

        removerItensOrcamentarios(centroCustoInstance)

        assert centroCustoInstance.orcamento?.itensOrcamentarios?.size() == 0

        if (itensOrcamento?.codigo?.class?.array) {
            itensOrcamento.codigo.eachWithIndex { codigo, i ->
                createUpdateItemOrcamentario(itensOrcamentarios, codigo, itensOrcamento.nome[i], itensOrcamento.valor[i],
                        itensOrcamento.tipoCusto[i], centroCustoInstance)
            }
        } else {
            createUpdateItemOrcamentario(itensOrcamentarios, itensOrcamento.codigo, itensOrcamento.nome,
                    itensOrcamento.valor, itensOrcamento.tipoCusto, centroCustoInstance)
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
                item.valor = Util.parse(valor)
            }

            if (tipoCusto) {
                item.tipoCusto = TipoCusto.valueOf(tipoCusto)
            }

            item.orcamento = centroCustoInstance.orcamento
            item.save()

            centroCustoInstance.orcamento.addToItensOrcamentarios(item)
        }
    }

}

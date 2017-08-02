package com.acception.cadastro

import com.acception.util.Util
import grails.converters.JSON

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class FornecedorController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE", criarFornecedor: "POST"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Fornecedor.list(params), model:[fornecedorInstanceCount: Fornecedor.count()]
    }

    def show(Fornecedor fornecedorInstance) {
        respond fornecedorInstance
    }

    def create() {
        respond new Fornecedor(params)
    }

    @Transactional
    def save(Fornecedor fornecedorInstance) {
        def p = null
        if(params.tipoPessoa == "true")
            p = new PessoaFisica(params.participante)
        else
            p = new PessoaJuridica(params.participante)

        if (params.telefoneRaw) {
            def dadosTelefone = Util.phoneToRaw(params.telefoneRaw)
            p.telefone = Telefone.findOrSaveByDddAndNumero(dadosTelefone['ddd'], dadosTelefone['number'])
        }

        if (params.telefoneAdicionalRaw) {
            def dadosTelefone = Util.phoneToRaw(params.telefoneAdicionalRaw)
            p.telefoneAdicional = Telefone.findOrSaveByDddAndNumero(dadosTelefone['ddd'], dadosTelefone['number'])
        }
        p.addToPapeis(fornecedorInstance)

        p.save(flush: true, failOnError: true)

        if (fornecedorInstance == null) {
            notFound()
            return
        }

        if (fornecedorInstance.hasErrors()) {
            respond fornecedorInstance.errors, view:'create'
            return
        }

        fornecedorInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'fornecedor.label', default: 'Fornecedor'), fornecedorInstance.id])
                redirect fornecedorInstance
            }
            '*' { respond fornecedorInstance, [status: CREATED] }
        }
    }

    def edit(Fornecedor fornecedorInstance) {
        respond fornecedorInstance
    }

    @Transactional
    def update(Fornecedor fornecedorInstance) {
        if (fornecedorInstance == null) {
            notFound()
            return
        }

        fornecedorInstance.participante.properties = params.participante

        if (params.telefoneRaw) {
            def dadosTelefone = Util.phoneToRaw(params.telefoneRaw)
            fornecedorInstance.participante.telefone = Telefone.findOrSaveByDddAndNumero(dadosTelefone['ddd'], dadosTelefone['number'])
        }

        if (params.telefoneAdicionalRaw) {
            def dadosTelefone = Util.phoneToRaw(params.telefoneAdicionalRaw)
            fornecedorInstance.participante.telefoneAdicional = Telefone.findOrSaveByDddAndNumero(dadosTelefone['ddd'], dadosTelefone['number'])
        }

        if (fornecedorInstance.hasErrors()) {
            respond fornecedorInstance.errors, view:'edit'
            return
        }

        fornecedorInstance.participante.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Fornecedor.label', default: 'Fornecedor'), fornecedorInstance.id])
                redirect fornecedorInstance
            }
            '*'{ respond fornecedorInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Fornecedor fornecedorInstance) {

        if (fornecedorInstance == null) {
            notFound()
            return
        }

        fornecedorInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Fornecedor.label', default: 'Fornecedor'), fornecedorInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    @Transactional
    def criarFornecedor() {
        def fornecedor = new Fornecedor(params)

        def p = null

        if (params.tipoPessoa == "FISICA") {
            p = new PessoaFisica(params.participante)
        } else if (params.tipoPessoa == "JURIDICA") {
            p = new PessoaJuridica(params.participante)
        } else {
            render(['success': false, 'error': 'Escolha um tipo de fornecedor válido!'] as JSON)
        }

        if (params.telefoneRaw) {
            def dadosTelefone = Util.phoneToRaw(params.telefoneRaw)
            p.telefone = Telefone.findOrSaveByDddAndNumero(dadosTelefone['ddd'], dadosTelefone['number'])
        }

        if (params.telefoneAdicionalRaw) {
            def dadosTelefone = Util.phoneToRaw(params.telefoneAdicionalRaw)
            p.telefoneAdicional = Telefone.findOrSaveByDddAndNumero(dadosTelefone['ddd'], dadosTelefone['number'])
        }

        p.addToPapeis(fornecedor)

        p.save(flush: true, failOnError: true)
        fornecedor.save(flush: true, failOnError: true)

        render(['success': true, 'fornecedor': ['id': fornecedor.id, 'nome': fornecedor.toString()]] as JSON)
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'fornecedor.label', default: 'Fornecedor'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}

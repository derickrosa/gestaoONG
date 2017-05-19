package com.acception.cadastro

import grails.converters.JSON

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class FinanciadorController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Financiador.list(params), model:[financiadorInstanceCount: Financiador.count()]
    }

    def show(Financiador financiadorInstance) {
        respond financiadorInstance
    }

    def findSolicitacoes() {
        def financiador
        if(params.idFinanciador)
            financiador = Financiador.get(Long.parseLong(params.idFinanciador))

        def json = financiador?.responsaveis?.sort { it.nome }.collect { it ->
            [it.nome ?: '', it.email ?: '', it.telefone ?: '']
        }
        render(json as JSON)
    }

    def create() {
        respond new Financiador(params)
    }

    @Transactional
    def save(Financiador financiadorInstance) {
        if (financiadorInstance == null) {
            notFound()
            return
        }

        if (financiadorInstance.hasErrors()) {
            respond financiadorInstance.errors, view:'create'
            return
        }

        financiadorInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'financiador.label', default: 'Financiador'), financiadorInstance.id])
                redirect financiadorInstance
            }
            '*' { respond financiadorInstance, [status: CREATED] }
        }
    }

    def edit(Financiador financiadorInstance) {
        respond financiadorInstance
    }

    @Transactional
    def update(Financiador financiadorInstance) {
        if (financiadorInstance == null) {
            notFound()
            return
        }

        if (financiadorInstance.hasErrors()) {
            respond financiadorInstance.errors, view:'edit'
            return
        }

        financiadorInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Financiador.label', default: 'Financiador'), financiadorInstance.id])
                redirect financiadorInstance
            }
            '*'{ respond financiadorInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Financiador financiadorInstance) {

        if (financiadorInstance == null) {
            notFound()
            return
        }

        financiadorInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Financiador.label', default: 'Financiador'), financiadorInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'financiador.label', default: 'Financiador'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def getResponsaveis() {
        def financiador

        if (params.idFinanciador) {
            financiador = Financiador.get(Long.parseLong(params.idFinanciador))
        }

        def json = financiador?.responsaveis?.sort { it.nome }.collect { it ->
            ['nome': it.participante?.nome, 'id': it.id]
        }

        render(json as JSON)
    }
}

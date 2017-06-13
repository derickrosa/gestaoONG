package com.acception.cadastro



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CidadeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Cidade.list(params), model:[cidadeInstanceCount: Cidade.count()]
    }

    def show(Cidade cidadeInstance) {
        respond cidadeInstance
    }

    def create() {
        respond new Cidade(params)
    }

    @Transactional
    def save(Cidade cidadeInstance) {
        if (cidadeInstance == null) {
            notFound()
            return
        }

        if (cidadeInstance.hasErrors()) {
            respond cidadeInstance.errors, view:'create'
            return
        }

        cidadeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'cidade.label', default: 'Cidade'), cidadeInstance.id])
                redirect cidadeInstance
            }
            '*' { respond cidadeInstance, [status: CREATED] }
        }
    }

    def edit(Cidade cidadeInstance) {
        respond cidadeInstance
    }

    @Transactional
    def update(Cidade cidadeInstance) {
        if (cidadeInstance == null) {
            notFound()
            return
        }

        if (cidadeInstance.hasErrors()) {
            respond cidadeInstance.errors, view:'edit'
            return
        }

        cidadeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Cidade.label', default: 'Cidade'), cidadeInstance.id])
                redirect cidadeInstance
            }
            '*'{ respond cidadeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Cidade cidadeInstance) {

        if (cidadeInstance == null) {
            notFound()
            return
        }

        cidadeInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Cidade.label', default: 'Cidade'), cidadeInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    def cidadePorEstado(Estado uf) {
        def cidades = Cidade.withCriteria {
            eq('estado', uf)
            order 'nome'
        }
        render {
            cidades.each { c ->
                option(c.nome, value: c.id)
            } // each
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'cidade.label', default: 'Cidade'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}

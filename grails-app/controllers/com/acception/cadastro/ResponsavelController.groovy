package com.acception.cadastro



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ResponsavelController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Responsavel.list(params), model:[responsavelInstanceCount: Responsavel.count()]
    }

    def show(Responsavel responsavelInstance) {
        respond responsavelInstance
    }

    def create() {
        respond new Responsavel(params)
    }

    @Transactional
    def save(Responsavel responsavelInstance) {
        if (responsavelInstance == null) {
            notFound()
            return
        }

        if (responsavelInstance.hasErrors()) {
            respond responsavelInstance.errors, view:'create'
            return
        }

        responsavelInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'responsavel.label', default: 'Responsavel'), responsavelInstance.id])
                redirect responsavelInstance
            }
            '*' { respond responsavelInstance, [status: CREATED] }
        }
    }

    def edit(Responsavel responsavelInstance) {
        respond responsavelInstance
    }

    @Transactional
    def update(Responsavel responsavelInstance) {
        if (responsavelInstance == null) {
            notFound()
            return
        }

        if (responsavelInstance.hasErrors()) {
            respond responsavelInstance.errors, view:'edit'
            return
        }

        responsavelInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Responsavel.label', default: 'Responsavel'), responsavelInstance.id])
                redirect responsavelInstance
            }
            '*'{ respond responsavelInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Responsavel responsavelInstance) {

        if (responsavelInstance == null) {
            notFound()
            return
        }

        responsavelInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Responsavel.label', default: 'Responsavel'), responsavelInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'responsavel.label', default: 'Responsavel'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}

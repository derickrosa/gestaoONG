package com.acception.cadastro



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class LinhaAcaoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond LinhaAcao.list(params), model:[linhaAcaoInstanceCount: LinhaAcao.count()]
    }

    def show(LinhaAcao linhaAcaoInstance) {
        respond linhaAcaoInstance
    }

    def create() {
        respond new LinhaAcao(params)
    }

    @Transactional
    def save(LinhaAcao linhaAcaoInstance) {
        if (linhaAcaoInstance == null) {
            notFound()
            return
        }

        if (linhaAcaoInstance.hasErrors()) {
            respond linhaAcaoInstance.errors, view:'create'
            return
        }

        linhaAcaoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'linhaAcao.label', default: 'LinhaAcao'), linhaAcaoInstance.id])
                redirect linhaAcaoInstance
            }
            '*' { respond linhaAcaoInstance, [status: CREATED] }
        }
    }

    def edit(LinhaAcao linhaAcaoInstance) {
        respond linhaAcaoInstance
    }

    @Transactional
    def update(LinhaAcao linhaAcaoInstance) {
        if (linhaAcaoInstance == null) {
            notFound()
            return
        }

        if (linhaAcaoInstance.hasErrors()) {
            respond linhaAcaoInstance.errors, view:'edit'
            return
        }

        linhaAcaoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'LinhaAcao.label', default: 'LinhaAcao'), linhaAcaoInstance.id])
                redirect linhaAcaoInstance
            }
            '*'{ respond linhaAcaoInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(LinhaAcao linhaAcaoInstance) {

        if (linhaAcaoInstance == null) {
            notFound()
            return
        }

        linhaAcaoInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'LinhaAcao.label', default: 'LinhaAcao'), linhaAcaoInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'linhaAcao.label', default: 'LinhaAcao'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}

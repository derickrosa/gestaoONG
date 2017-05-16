package com.acception.cadastro



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PessoaFisicaController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PessoaFisica.list(params), model:[pessoaFisicaInstanceCount: PessoaFisica.count()]
    }

    def show(PessoaFisica pessoaFisicaInstance) {
        respond pessoaFisicaInstance
    }

    def create() {
        respond new PessoaFisica(params)
    }

    @Transactional
    def save(PessoaFisica pessoaFisicaInstance) {
        if (pessoaFisicaInstance == null) {
            notFound()
            return
        }

        if (pessoaFisicaInstance.hasErrors()) {
            respond pessoaFisicaInstance.errors, view:'create'
            return
        }

        pessoaFisicaInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'pessoaFisica.label', default: 'PessoaFisica'), pessoaFisicaInstance.id])
                redirect pessoaFisicaInstance
            }
            '*' { respond pessoaFisicaInstance, [status: CREATED] }
        }
    }

    def edit(PessoaFisica pessoaFisicaInstance) {
        respond pessoaFisicaInstance
    }

    @Transactional
    def update(PessoaFisica pessoaFisicaInstance) {
        if (pessoaFisicaInstance == null) {
            notFound()
            return
        }

        if (pessoaFisicaInstance.hasErrors()) {
            respond pessoaFisicaInstance.errors, view:'edit'
            return
        }

        pessoaFisicaInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PessoaFisica.label', default: 'PessoaFisica'), pessoaFisicaInstance.id])
                redirect pessoaFisicaInstance
            }
            '*'{ respond pessoaFisicaInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(PessoaFisica pessoaFisicaInstance) {

        if (pessoaFisicaInstance == null) {
            notFound()
            return
        }

        pessoaFisicaInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PessoaFisica.label', default: 'PessoaFisica'), pessoaFisicaInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'pessoaFisica.label', default: 'PessoaFisica'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}

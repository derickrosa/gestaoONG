package com.acception.cadastro



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PessoaJuridicaController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PessoaJuridica.list(params), model:[pessoaJuridicaInstanceCount: PessoaJuridica.count()]
    }

    def show(PessoaJuridica pessoaJuridicaInstance) {
        respond pessoaJuridicaInstance
    }

    def create() {
        respond new PessoaJuridica(params)
    }

    @Transactional
    def save(PessoaJuridica pessoaJuridicaInstance) {
        if (pessoaJuridicaInstance == null) {
            notFound()
            return
        }

        if (pessoaJuridicaInstance.hasErrors()) {
            respond pessoaJuridicaInstance.errors, view:'create'
            return
        }

        pessoaJuridicaInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'pessoaJuridica.label', default: 'PessoaJuridica'), pessoaJuridicaInstance.id])
                redirect pessoaJuridicaInstance
            }
            '*' { respond pessoaJuridicaInstance, [status: CREATED] }
        }
    }

    def edit(PessoaJuridica pessoaJuridicaInstance) {
        respond pessoaJuridicaInstance
    }

    @Transactional
    def update(PessoaJuridica pessoaJuridicaInstance) {
        if (pessoaJuridicaInstance == null) {
            notFound()
            return
        }

        if (pessoaJuridicaInstance.hasErrors()) {
            respond pessoaJuridicaInstance.errors, view:'edit'
            return
        }

        pessoaJuridicaInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PessoaJuridica.label', default: 'PessoaJuridica'), pessoaJuridicaInstance.id])
                redirect pessoaJuridicaInstance
            }
            '*'{ respond pessoaJuridicaInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(PessoaJuridica pessoaJuridicaInstance) {

        if (pessoaJuridicaInstance == null) {
            notFound()
            return
        }

        pessoaJuridicaInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PessoaJuridica.label', default: 'PessoaJuridica'), pessoaJuridicaInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'pessoaJuridica.label', default: 'PessoaJuridica'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}

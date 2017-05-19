package com.acception.cadastro


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AnexoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Anexo.list(params), model: [anexoInstanceCount: Anexo.count()]
    }

    def show(Anexo anexoInstance) {
        respond anexoInstance
    }

    def create() {
        respond new Anexo(params)
    }

    @Transactional
    def save(Anexo anexoInstance) {
        if (anexoInstance == null) {
            notFound()
            return
        }

        if (anexoInstance.hasErrors()) {
            respond anexoInstance.errors, view: 'create'
            return
        }

        anexoInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'anexo.label', default: 'Anexo'), anexoInstance.id])
                redirect anexoInstance
            }
            '*' { respond anexoInstance, [status: CREATED] }
        }
    }

    def edit(Anexo anexoInstance) {
        respond anexoInstance
    }

    @Transactional
    def update(Anexo anexoInstance) {
        if (anexoInstance == null) {
            notFound()
            return
        }

        if (anexoInstance.hasErrors()) {
            respond anexoInstance.errors, view: 'edit'
            return
        }

        anexoInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Anexo.label', default: 'Anexo'), anexoInstance.id])
                redirect anexoInstance
            }
            '*' { respond anexoInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Anexo anexoInstance) {

        if (anexoInstance == null) {
            notFound()
            return
        }

        anexoInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Anexo.label', default: 'Anexo'), anexoInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    def download() {
        def anexo = Anexo.get(params.id)
        if (anexo == null) {
            flash.message = "Anexo não encontrado!"
            redirect (action:'list')
        } else {
            response.setContentType("APPLICATION/OCTET-STREAM")
            response.setHeader("Content-Disposition", "Attachment;Filename=\"${anexo.nome}\"")
            def outputStream = response.getOutputStream()
            outputStream << anexo.filedata
            outputStream.flush()
            outputStream.close()
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'anexo.label', default: 'Anexo'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}

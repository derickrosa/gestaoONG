package com.acception.cadastro

import grails.converters.JSON
import org.apache.http.HttpStatus

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ArquivoController {
    def arquivoService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Arquivo.list(params), model: [arquivoInstanceCount: Arquivo.count()]
    }

    def find() {
        Atividade atividade = Atividade.get(params.long("atividade.id"))
        respond(atividade?.arquivos)
    }

    def show(Arquivo arquivoInstance) {
        respond arquivoInstance
    }

    @Transactional
    def create() {
        Atividade atividade = Atividade.get(params.long("atividade.id"))
        if (atividade == null) {
            notFound()
            return
        }

        def fileName = []
        def f = request.getFile('file')
        if (f) {
            Arquivo arquivoInstance = arquivoService.save(atividade, f.bytes as byte[],
                    f.contentType as String, f.size as Long, f.originalFilename as String)

            fileName.add([id: arquivoInstance.id])
        }

        respond(fileName)
    }

    @Transactional
    def save(Arquivo arquivoInstance) {
        if (arquivoInstance == null) {
            notFound()
            return
        }

        if (arquivoInstance.hasErrors()) {
            respond arquivoInstance.errors, view: 'create'
            return
        }

        arquivoInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'arquivo.label', default: 'Arquivo'), arquivoInstance.id])
                redirect arquivoInstance
            }
            '*' { respond arquivoInstance, [status: CREATED] }
        }
    }

    def edit(Arquivo arquivoInstance) {
        respond arquivoInstance
    }

    @Transactional
    def update(Arquivo arquivoInstance) {
        if (arquivoInstance == null) {
            notFound()
            return
        }

        if (arquivoInstance.hasErrors()) {
            respond arquivoInstance.errors, view: 'edit'
            return
        }

        arquivoInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Arquivo.label', default: 'Arquivo'), arquivoInstance.id])
                redirect arquivoInstance
            }
            '*' { respond arquivoInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Arquivo arquivoInstance) {
        if (arquivoInstance == null) {
            notFound()
            return
        }

        arquivoService.delete(arquivoInstance)
        response.status = HttpStatus.SC_OK
        render([text: 'OK'] as JSON)
    }


    def download(Arquivo arquivoInstance) {
        if (!arquivoInstance) {
            notFound()
            return
        }

        response.setHeader("Content-disposition", "attachment; filename=${arquivoInstance.fileName}")
        response.contentType = arquivoInstance.contentType
        response.contentLength = arquivoInstance.bytes.size()
        OutputStream out = response.outputStream
        out.write(arquivoInstance.bytes)
        out.close()
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'arquivo.label', default: 'Arquivo'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}

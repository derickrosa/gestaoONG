package com.acception.cadastro

import grails.converters.JSON

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class RelatorioAtividadeController {
    private static final okcontents = ['image/png', 'image/jpeg', 'image/jpg', 'image/gif']
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE", uploadImage: "POST"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def criteria = getCriteria(params)

        def relatorioAtividadeInstanceList = RelatorioAtividade.createCriteria().list(params, criteria)
        def relatorioAtividadeInstanceCount = RelatorioAtividade.createCriteria().count(criteria)

        def model = [relatorioAtividadeInstanceCount: relatorioAtividadeInstanceCount, relatorioAtividadeInstanceList: relatorioAtividadeInstanceList]

        model
    }

    def getCriteria(pars) {
        def criteria = {
            if (pars.searchAtividade)
                atividade {
                    eq('id', pars.searchAtividade.toLong())
                }

            if (pars.searchFinanciador)
                financiador {
                    eq('id', pars.searchFinanciador.toLong())
                }

            if (pars.searchCentroCusto)
                centroCusto {
                    eq('id', pars.searchCentroCusto.toLong())
                }
        }
        return criteria
    }

    def show(RelatorioAtividade relatorioAtividadeInstance) {
        respond relatorioAtividadeInstance
    }

    @Transactional
    def carregarArquivo(Long id) {
        def relatorioAtividadeInstance = RelatorioAtividade.get(id)
        def fileName = []
        def f = request.getFile('file')
        if (f) {
            Arquivo arquivoInstance = new Arquivo()
            arquivoInstance.bytes = f.bytes
            arquivoInstance.contentType = f.contentType
            arquivoInstance.size = f.size
            arquivoInstance.fileName = f.originalFilename
            arquivoInstance.save(flush:true)
            relatorioAtividadeInstance.addToArquivos(arquivoInstance)
            relatorioAtividadeInstance.save(flush: true)
            fileName.add([id:arquivoInstance.id])
        }
        render(fileName as JSON)
    }

    @Transactional
    def deletarArquivo(Long id) {
        def relatorioAtividadeInstance = RelatorioAtividade.get(id)
        Arquivo arquivoInstance = Arquivo.get(params.idArquivo as Long)
        relatorioAtividadeInstance.removeFromArquivos(arquivoInstance)
        relatorioAtividadeInstance.save(flush: true)
        arquivoInstance.delete(flush:true)
        render([success:'ok'] as JSON)
    }

    def baixarArquivo() {
        Arquivo arquivoInstance = Arquivo.get(params.idArquivo as Long)
        if ( arquivoInstance == null) {
            flash.message = "Document not found."
            redirect (action:'show')
        } else {
            response.setContentType("APPLICATION/OCTET-STREAM")
            response.setHeader("Content-Disposition", "Attachment;Filename=\"${arquivoInstance.fileName}\"")
            def outputStream = response.getOutputStream()
            outputStream << arquivoInstance.bytes
            outputStream.flush()
            outputStream.close()
        }
    }

    def getFiles(Long id) {
        def relatorio = RelatorioAtividade.get(params.id as Long)
        def arquivos = []
        relatorio?.arquivos?.sort{-it?.fileName?.size()}.each { arquivoInstance ->
            if (okcontents.contains(arquivoInstance.contentType)) {
                arquivos.add([name: arquivoInstance.fileName, path: createLink(action: 'imagem', id: arquivoInstance.id), size: arquivoInstance.size, id: arquivoInstance.id])
            } else {
                arquivos.add([name: arquivoInstance.fileName, path: resource(file: 'images/document.png'), size: arquivoInstance.size, id: arquivoInstance.id])
            }
        }
        render(arquivos as JSON)
    }

    def imagem(Long id) {
        def arquivoInstance = Arquivo.get(id)
        if (!arquivoInstance || !arquivoInstance.bytes || !arquivoInstance.contentType) {
            response.sendError(404)
            return
        }

        response.contentType = arquivoInstance.contentType
        response.contentLength = arquivoInstance.bytes.size()
        OutputStream out = response.outputStream
        out.write(arquivoInstance.bytes)
        out.close()
    }

    def create() {
        respond new RelatorioAtividade(params)
    }

    @Transactional
    def save(RelatorioAtividade relatorioAtividadeInstance) {
        if (relatorioAtividadeInstance == null) {
            notFound()
            return
        }

        if (relatorioAtividadeInstance.hasErrors()) {
            respond relatorioAtividadeInstance.errors, view: 'create'
            return
        }

        relatorioAtividadeInstance.dateCreated = new Date()
        relatorioAtividadeInstance.lastUpdated = new Date()
        relatorioAtividadeInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'relatorioAtividade.label', default: 'RelatorioAtividade'), relatorioAtividadeInstance.id])
                redirect relatorioAtividadeInstance
            }
            '*' { respond relatorioAtividadeInstance, [status: CREATED] }
        }
    }

    def edit(RelatorioAtividade relatorioAtividadeInstance) {
        respond relatorioAtividadeInstance
    }

    @Transactional
    def update(RelatorioAtividade relatorioAtividadeInstance) {
        if (relatorioAtividadeInstance == null) {
            notFound()
            return
        }

        if (relatorioAtividadeInstance.hasErrors()) {
            respond relatorioAtividadeInstance.errors, view: 'edit'
            return
        }
        relatorioAtividadeInstance.lastUpdated = new Date()

        relatorioAtividadeInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'RelatorioAtividade.label', default: 'RelatorioAtividade'), relatorioAtividadeInstance.id])
                redirect relatorioAtividadeInstance
            }
            '*' { respond relatorioAtividadeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(RelatorioAtividade relatorioAtividadeInstance) {

        if (relatorioAtividadeInstance == null) {
            notFound()
            return
        }

        relatorioAtividadeInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'RelatorioAtividade.label', default: 'RelatorioAtividade'), relatorioAtividadeInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'relatorioAtividade.label', default: 'RelatorioAtividade'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}

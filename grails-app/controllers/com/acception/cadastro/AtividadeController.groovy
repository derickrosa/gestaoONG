package com.acception.cadastro

import com.acception.util.Util
import grails.converters.JSON

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AtividadeController {
    def exportService
    private static final okcontents = ['image/png', 'image/jpeg', 'image/jpg', 'image/gif']
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 20, 100)

        def criteria = getCriteria(params)

        if(params?.exportFormat && params.exportFormat != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.exportFormat]
            response.setHeader("Content-disposition", "attachment; filename=Atividade.${params.extension}")

            def atividadeInstanceList = Atividade.createCriteria().list(params, criteria)

            List fields=['nome','codigo','descricao','status']
            Map labels=[nome:'Nome',
                        codigo:'Código',
                        descricao:'Descrição',
            status:'Status']


            log.debug("Gerando relatório de Atividade...")

            Map parameters = ["column.widths": [0.3, 0.2, 0.4,0.1]]

            exportService.export(params.exportFormat, response.outputStream,atividadeInstanceList, fields, labels, [:], parameters)
            return
        }

        def atividadeInstanceList = Atividade.createCriteria().list(params, criteria)
        def atividadeInstanceCount = Atividade.createCriteria().count(criteria)

        def model = [atividadeInstanceList: atividadeInstanceList, atividadeInstanceCount: atividadeInstanceCount]
        params.each { p -> if (p.key ==~ /search.*/ && p.value) model[p.key] = p.value }
        model
    }


    def getCriteria(pars){
        def criteria = {
            if (pars.searchNome)
                or{
                    ilike('nome', "%${pars.searchNome}%")
                    ilike('nomeNormalizado', "%${Util.normalizar(pars.searchNome)}%")
                }
            if (pars.searchCodigo)
                eq('codigo', pars.searchCodigo)
        }
        return criteria
    }


    def show(Atividade atividadeInstance) {
        respond atividadeInstance
    }

    def create() {
        log.debug("Ct Custo: ${params.centroCustoInstance}")
        def centroCustoInstance
        def atividadeInstance
        if(params.atividade)
            atividadeInstance = Atividade.get(params.atividade.toLong())
        if (params.atividade){
            centroCustoInstance = atividadeInstance.centroCusto
        } else {
            centroCustoInstance = CentroCusto.get(params.centroCustoInstance.toLong())
        }

        if(params.atividade)
            [atividadeInstance: new Atividade(params), atividade: atividadeInstance, centroCustoInstance: centroCustoInstance]
        else if (params.centroCustoInstance){
            log.debug("Enviando CC")
            [atividadeInstance: new Atividade(params), centroCustoInstance: centroCustoInstance]
        }
        else
            respond new Atividade(params)
    }


    @Transactional
    def save(Atividade atividadeInstance) {

        if (atividadeInstance == null) {
            notFound()
            return
        }

        log.debug("Paramentro: ${params.centroCusto}")

        if (params.centroCusto.id) {
            def cc = CentroCusto.get(params.centroCusto.id as Long)
            log.debug(" Add CC Nome: ${cc.nome}")
            cc.addToAtividades(atividadeInstance)
            cc.save flush: true, failOnError: true
        }

        if (params.list('linhaAcao')) {
            params.list('linhaAcao').each { id ->
                id = id.toLong()
                def la = LinhaAcao.get(id)
                if (la == null) {
                    notFound()
                    return
                }
                la.addToAtividades(atividadeInstance)
                atividadeInstance.addToLinhas(la)
                la.save(flush: true, failOnError: true)

            }

        }


        if (atividadeInstance.hasErrors()) {
            respond atividadeInstance.errors, view: 'create'
            return
        }

        ///atualizarAnexo(atividadeInstance, params.numFilesUploaded, params.planoDeTrabalho, params.previousPlanoDeTrabalho)

        atividadeInstance.save flush: true, failOnError: true

        if(atividadeInstance.atividade){
            redirect(controller:"atividade", action: "show", id: atividadeInstance.atividade.id)
        } else {
            redirect(controller:"centroCusto", action: "show", id: atividadeInstance.centroCusto.id)
        }

        /*request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'atividade.label', default: 'Atividade'), atividadeInstance.id])
                redirect atividadeInstance
            }
            '*' { respond atividadeInstance, [status: CREATED] }
        }*/
    }

    def edit(Atividade atividadeInstance) {
        [atividadeInstance: atividadeInstance]
    }

    def atualizarAnexo(atividade, numFilesUploaded, planoDeTrabalhoAtual, planoDeTrabalhoAnterior) {
        if(numFilesUploaded) {
            if (numFilesUploaded.toInteger() == 0) {
                atividade.anexos = null
            } else {
                if (planoDeTrabalhoAtual.isEmpty()) {
                    log.debug("Entrou isempty")
                    def an = Anexo.get(planoDeTrabalhoAnterior)
                    atividade.addToAnexos(an)
                } else {
                    def an = Anexo.get(planoDeTrabalhoAtual)
                    atividade.addToAnexos(an)
                }
            }
        }
    }

    @Transactional
    def update(Atividade atividadeInstance) {
        if (atividadeInstance == null) {
            notFound()
            return
        }

        def toRemove = new ArrayList(atividadeInstance.linhas)
        toRemove.each {
            atividadeInstance.removeFromLinhas(it)
        }
        if (params.list('linhaAcao')) {
            params.list('linhaAcao').each { id ->
                id = id.toLong()
                def la = LinhaAcao.get(id)
                if (la == null) {
                    notFound()
                    return
                }
                la.addToAtividades(atividadeInstance)
                atividadeInstance.addToLinhas(la)
                la.save(flush: true, failOnError: true)

            }

        }

        println "REQUEST"

        request.fileNames.each { obj ->
            println("FILE 1 - ${obj}")
        }

        /* request.getMultiFileMap().documentFile.each {
             println "2 - ${it.originalFilename}"
         }*/

        request.fileNames.each {
            File file = request.getFile(it)
            println "FILE 2 - ${file.name}"
        }

        if (atividadeInstance.hasErrors()) {
            respond atividadeInstance.errors, view: 'edit'
            return
        }
        //atualizarAnexo(atividadeInstance, params.numFilesUploaded, params.planoDeTrabalho, params.previousPlanoDeTrabalho)
        atividadeInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Atividade.label', default: 'Atividade'), atividadeInstance.id])
                redirect atividadeInstance
            }
            '*' { respond atividadeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Atividade atividadeInstance) {

        if (atividadeInstance == null) {
            notFound()
            return
        }

        atividadeInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Atividade.label', default: 'Atividade'), atividadeInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'atividade.label', default: 'Atividade'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }


    @Transactional
    def carregarArquivo(Long id) {
        def atividadeInstance = Atividade.get(id)
        def fileName = []
        def f = request.getFile('file')
        if (f) {
            Arquivo arquivoInstance = new Arquivo()
            arquivoInstance.bytes = f.bytes
            arquivoInstance.contentType = f.contentType
            arquivoInstance.size = f.size
            arquivoInstance.fileName = f.originalFilename
            arquivoInstance.save(flush:true)
            atividadeInstance.addToArquivos(arquivoInstance)
            atividadeInstance.save(flush: true)
            fileName.add([id:arquivoInstance.id])
        }
        render(fileName as JSON)
    }

    @Transactional
    def deletarArquivo(Long id) {
        def atividadeInstance = Atividade.get(id)
        Arquivo arquivoInstance = Arquivo.get(params.idArquivo as Long)
        atividadeInstance.removeFromArquivos(arquivoInstance)
        atividadeInstance.save(flush: true)
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
        def atividade = Atividade.get(params.id as Long)
        def arquivos = []
        atividade?.arquivos?.sort{-it?.fileName?.size()}.each { arquivoInstance ->
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
}

package com.acception.cadastro



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AtividadeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Atividade.list(params), model:[atividadeInstanceCount: Atividade.count()]
    }

    def show(Atividade atividadeInstance) {
        respond atividadeInstance
    }

    def create() {
        respond new Atividade(params)
    }

    @Transactional
    def save(Atividade atividadeInstance) {

        if (atividadeInstance == null) {
            notFound()
            return
        }

        log.debug("Alterou! AQUI PARAM: ${params.centroCusto.id.toLong()}")

        def cc = CentroCusto.get(params.centroCusto.id.toLong())

        cc.addToAtividades(atividadeInstance)

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
                la.save(flush:true, failOnError: true)

            }

        }


        if (atividadeInstance.hasErrors()) {
            respond atividadeInstance.errors, view:'create'
            return
        }

        cc.save flush:true, failOnError: true
        atualizarAnexo(atividadeInstance, params.numFilesUploaded, params.planoDeTrabalho, params.previousPlanoDeTrabalho)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'atividade.label', default: 'Atividade'), atividadeInstance.id])
                redirect atividadeInstance
            }
            '*' { respond atividadeInstance, [status: CREATED] }
        }
    }

    def edit(Atividade atividadeInstance) {
        [atividadeInstance: atividadeInstance]
    }

    def atualizarAnexo(atividade, numFilesUploaded, planoDeTrabalhoAtual, planoDeTrabalhoAnterior) {
        log.debug("Alterou! mudou de novo AQUI")
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

            atividade.save flush: true, failOnError: true
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
                la.save(flush:true, failOnError: true)

            }

        }

        println "REQUEST"

        request.fileNames.each {obj->
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
            respond atividadeInstance.errors, view:'edit'
            return
        }
        //atualizarAnexo(atividadeInstance, params.numFilesUploaded, params.planoDeTrabalho, params.previousPlanoDeTrabalho)
        atividadeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Atividade.label', default: 'Atividade'), atividadeInstance.id])
                redirect atividadeInstance
            }
            '*'{ respond atividadeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Atividade atividadeInstance) {

        if (atividadeInstance == null) {
            notFound()
            return
        }

        atividadeInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Atividade.label', default: 'Atividade'), atividadeInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'atividade.label', default: 'Atividade'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}

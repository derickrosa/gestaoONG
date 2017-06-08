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

        atualizarAnexo(atividadeInstance, params.numFilesUploaded, params.planoDeTrabalho, params.previousPlanoDeTrabalho)

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
        atividadeInstance.save flush:true, failOnError: true

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
        if (numFilesUploaded.toInteger() == 0) {
            atividade.planoDeTrabalho = null
        } else {
            if (planoDeTrabalhoAtual.isEmpty()) {
                atividade.planoDeTrabalho = Anexo.get(planoDeTrabalhoAnterior)
            }

            atividade.planoDeTrabalho.save flush: true
        }
    }

    @Transactional
    def update(Atividade atividadeInstance) {
        if (atividadeInstance == null) {
            notFound()
            return
        }

        if (atividadeInstance.hasErrors()) {
            respond atividadeInstance.errors, view:'edit'
            return
        }

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

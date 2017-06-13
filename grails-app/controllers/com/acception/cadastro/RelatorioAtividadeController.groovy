package com.acception.cadastro


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class RelatorioAtividadeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def criteria = getCriteria(params)

        def relatorioAtividadeInstanceList = RelatorioAtividade.createCriteria().list(params,criteria)
        def relatorioAtividadeInstanceCount = RelatorioAtividade.createCriteria().count(criteria)

        def model = [relatorioAtividadeInstanceCount: relatorioAtividadeInstanceCount,relatorioAtividadeInstanceList:relatorioAtividadeInstanceList]

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

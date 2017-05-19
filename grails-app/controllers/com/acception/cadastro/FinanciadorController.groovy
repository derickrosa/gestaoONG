package com.acception.cadastro

import grails.converters.JSON

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class FinanciadorController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Financiador.list(params), model:[financiadorInstanceCount: Financiador.count()]
    }

    def show(Financiador financiadorInstance) {
        respond financiadorInstance
    }

    def findSolicitacoes() {
        def financiador
        if(params.idFinanciador)
            financiador = Financiador.get(Long.parseLong(params.idFinanciador))
        def json = financiador?.responsaveis?.sort { it.nome }.collect { it ->
            [it.nome ?: '', it.email ?: '', it.telefone ?: '']
        }
        render(json as JSON)
    }

    def create() {
        respond new Financiador(params)
    }

    @Transactional
    def save(Financiador financiadorInstance) {
        log.debug("Chegou")
        if (financiadorInstance == null) {
            notFound()
            return
        }

        def participante = new PessoaJuridica(params.participante)
        participante.addToPapeis(financiadorInstance)
        participante.save(failOnError:true, flush:true)

        log.debug("Antes de entrar ${params?.listaResponsaveis} - TAM ${params?.listaResponsaveis?.nome?.size()}")

        if (params?.listaResponsaveis?.nome?.class?.array && params?.listaResponsaveis?.email?.class?.array && params?.listaResponsaveis?.telefone?.class?.array) {
            for (int i = 0; i < params?.listaResponsaveis?.nome?.size(); i++) {
                log.debug("Entrou primeiro TAM ${params?.listaResponsaveis?.ano?.size()} / $i")
                def participanteResponsavel = new Participante()

                if (params.listaResponsaveis?.nome[i])
                    participanteResponsavel.nome = params.listaResponsaveis?.nome[i]
                if (params.listaResponsaveis?.email[i])
                    participanteResponsavel.email = params.listaResponsaveis?.email[i]
                if (params.listaResponsaveis?.telefone) {
                    participanteResponsavel.telefone = new Telefone()
                    participanteResponsavel.telefone.numero = params.listaResponsaveis?.telefone[i]
                    participanteResponsavel.telefone.save(failOnError:true, flush:true)
                }


                participanteResponsavel.save(failOnError:true, flush:true)
                def responsavel = new Responsavel()
                responsavel.participante = participanteResponsavel
                responsavel.financiador = financiadorInstance
                responsavel.save(failOnError:true, flush:true)
                log.debug(" RESP: ${responsavel.properties}")
                participanteResponsavel.addToPapeis(responsavel)
                financiadorInstance.addToResponsaveis(responsavel)
                participanteResponsavel.save(failOnError:true, flush:true)
                financiadorInstance.save(failOnError:true, flush:true)

            }
        } else if (params?.listaResponsaveis?.nome && params?.listaResponsaveis?.email && params?.listaResponsaveis?.telefone) {
            def participanteResponsavel = new Participante()
            log.debug("Entrou segundo")
            if (params.listaResponsaveis?.nome)
                participanteResponsavel.nome = params.listaResponsaveis?.nome
            if (params.listaResponsaveis?.email)
                participanteResponsavel.email = params.listaResponsaveis?.email
            if (params.listaResponsaveis?.telefone) {
                participanteResponsavel.telefone = new Telefone()
                participanteResponsavel.telefone.numero = params.listaResponsaveis?.telefone
                participanteResponsavel.telefone.save(failOnError:true, flush:true)
            }
            participanteResponsavel.save(failOnError:true, flush:true)
            def responsavel = new Responsavel()
            responsavel.participante = participanteResponsavel
            responsavel.financiador = financiadorInstance
            responsavel.save(failOnError:true, flush:true)
            participanteResponsavel.addToPapeis(responsavel)
            financiadorInstance.addToResponsaveis(responsavel)
            participanteResponsavel.save(failOnError:true, flush:true)
            financiadorInstance.save(failOnError:true, flush:true)

        }
        /*log.debug("Chegou 3")
        if (financiadorInstance.hasErrors()) {
            log.debug("Chegou 4")
            respond financiadorInstance.errors, view:'create'
            return
        }

        log.debug("Finalizar")
        financiadorInstance.save flush:true*/

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'financiador.label', default: 'Financiador'), financiadorInstance.id])
                redirect financiadorInstance
            }
            '*' { respond financiadorInstance, [status: CREATED] }
        }
    }

    def edit(Financiador financiadorInstance) {
        respond financiadorInstance
    }

    @Transactional
    def update(Financiador financiadorInstance) {
        if (financiadorInstance == null) {
            notFound()
            return
        }

        if (financiadorInstance.hasErrors()) {
            respond financiadorInstance.errors, view:'edit'
            return
        }

        financiadorInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Financiador.label', default: 'Financiador'), financiadorInstance.id])
                redirect financiadorInstance
            }
            '*'{ respond financiadorInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Financiador financiadorInstance) {

        if (financiadorInstance == null) {
            notFound()
            return
        }

        financiadorInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Financiador.label', default: 'Financiador'), financiadorInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'financiador.label', default: 'Financiador'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def getResponsaveis() {
        def financiador

        if (params.idFinanciador) {
            financiador = Financiador.get(Long.parseLong(params.idFinanciador))
        }

        def json = financiador?.responsaveis?.sort { it.nome }.collect { it ->
            ['nome': it.participante?.nome, 'id': it.id]
        }

        render(json as JSON)
    }
}

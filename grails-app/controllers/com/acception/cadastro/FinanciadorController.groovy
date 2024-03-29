package com.acception.cadastro

import com.acception.cadastro.enums.Setor
import com.acception.util.Util
import grails.converters.JSON

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class FinanciadorController {
    def exportService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {
        params?.remove('max')

        Map<String, String> pesquisa = params.pesquisa ?: params.subMap(['nome', 'cnpj', 'sigla', 'setor'])
        pesquisa = Util.trimMap(pesquisa)

        def criteria = {
            participante {
                if (pesquisa.containsKey('nome')) ilike('nomeNormalizado', "%${Util.normalizar(pesquisa.nome)}%")
                if (pesquisa.containsKey('cnpj')) eq('cnpj', Util.cnpjToRaw(pesquisa.cnpj))
            }
            if (pesquisa.containsKey('sigla')) ilike('sigla', pesquisa.sigla)
            if (pesquisa.containsKey('setor')) eq('setor', Setor.valueOf(pesquisa.setor))
        }

        if (params?.exportFormat && params.exportFormat != "html") {
            response.contentType = grailsApplication.config.grails.mime.types[params.exportFormat]
            response.setHeader("Content-disposition", "attachment; filename=Relatorio de Financiadores.${params.extension}")

            def financiadorInstanceList = Financiador.createCriteria().list(params, criteria)

            List fields = ['participante.nome', 'participante.cnpj', 'sigla', 'setor', 'dateCreated']
            Map labels = ['participante.nome': 'Nome', 'participante.cnpj': 'CNPJ',
                          'sigla'            : 'Sigla', 'setor': 'Setor', 'dateCreated': 'Data Cadastro']
            Map parameters = ["column.widths": [0.4, 0.3, 0.2, 0.2, 0.2]]

            exportService.export(params.exportFormat, response.outputStream, financiadorInstanceList, fields, labels, [:], parameters)
            return
        }

        params.max = Math.min(params.max ?: 10, 100)

        [financiadorInstanceList : Financiador.createCriteria().list(params, criteria),
         financiadorInstanceCount: Financiador.createCriteria().count(criteria),
         pesquisa                : pesquisa]
    }

    def show(Financiador financiadorInstance) {
        respond financiadorInstance
    }

    def findSolicitacoes() {
        def financiador
        if (params.idFinanciador) {
            log.debug("Financiador ID ${params.idFinanciador}")
            financiador = Financiador.get(Long.parseLong(params.idFinanciador))
            log.debug("Financiador: ${financiador}")
        }

        def json = financiador?.responsaveis?.sort { it.participante.nome }.collect { it ->
            def numero = ""
            if (it.participante.telefone)
                numero = it.participante.telefone.ddd + it.participante.telefone.numero
            [it.participante.nome ?: '', it.participante.email ?: '', numero ?: '', it.id ?: '']
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

        if (params.participante.cnpj) {
            params.participante.cnpj = Util.cnpjToRaw(params.participante.cnpj)
        }
        def participante = new PessoaJuridica(params.participante)
        participante.addToPapeis(financiadorInstance)
        participante.save(failOnError: true, flush: true)

        log.debug("Antes de entrar ${params?.listaResponsaveis} - TAM ${params?.listaResponsaveis?.nome?.size()}")

        if (params?.listaResponsaveis?.nome?.class?.array && params?.listaResponsaveis?.email?.class?.array && params?.listaResponsaveis?.telefone?.class?.array) {
            for (int i = 0; i < params?.listaResponsaveis?.nome?.size(); i++) {
                log.debug("Entrou primeiro TAM ${params?.listaResponsaveis?.ano?.size()} / $i")
                def participanteResponsavel = new Participante()

                if (params.listaResponsaveis?.nome[i])
                    participanteResponsavel.nome = params.listaResponsaveis?.nome[i]
                if (params.listaResponsaveis?.email[i])
                    participanteResponsavel.email = params.listaResponsaveis?.email[i]
                if (params.listaResponsaveis?.telefone[i]) {
                    def dadosTelefone = Util.phoneToRaw(params.listaResponsaveis?.telefone[i])
                    participanteResponsavel.telefone = Telefone.findOrSaveByDddAndNumero(dadosTelefone['ddd'], dadosTelefone['number'])
                }


                participanteResponsavel.save(failOnError: true, flush: true)
                def responsavel = new Responsavel()
                responsavel.participante = participanteResponsavel
                responsavel.financiador = financiadorInstance
                responsavel.save(failOnError: true, flush: true)
                log.debug(" RESP: ${responsavel.properties}")
                participanteResponsavel.addToPapeis(responsavel)
                financiadorInstance.addToResponsaveis(responsavel)
                participanteResponsavel.save(failOnError: true, flush: true)
                financiadorInstance.save(failOnError: true, flush: true)

            }
        } else if (params?.listaResponsaveis?.nome && params?.listaResponsaveis?.email && params?.listaResponsaveis?.telefone) {
            def participanteResponsavel = new Participante()
            log.debug("Entrou segundo")
            if (params.listaResponsaveis?.nome)
                participanteResponsavel.nome = params.listaResponsaveis?.nome
            if (params.listaResponsaveis?.email)
                participanteResponsavel.email = params.listaResponsaveis?.email
            if (params.listaResponsaveis?.telefone) {
                def dadosTelefone = Util.phoneToRaw(params.listaResponsaveis?.telefone)
                participanteResponsavel.telefone = Telefone.findOrSaveByDddAndNumero(dadosTelefone['ddd'], dadosTelefone['number'])
            }
            participanteResponsavel.save(failOnError: true, flush: true)
            def responsavel = new Responsavel()
            responsavel.participante = participanteResponsavel
            responsavel.financiador = financiadorInstance
            responsavel.save(failOnError: true, flush: true)
            participanteResponsavel.addToPapeis(responsavel)
            financiadorInstance.addToResponsaveis(responsavel)
            participanteResponsavel.save(failOnError: true, flush: true)
            financiadorInstance.save(failOnError: true, flush: true)

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

        if (params.participante.cnpj) {
            params.participante.cnpj = Util.cnpjToRaw(params.participante.cnpj)
        }

        financiadorInstance.participante.properties = params.participante

        def participante = financiadorInstance.participante
        participante.save(failOnError: true, flush: true)

        //financiadorInstance?.responsaveis?.clear()
        if (params?.listaResponsaveis?.nome?.class?.array && params?.listaResponsaveis?.email?.class?.array && params?.listaResponsaveis?.telefone?.class?.array) {
            def ids = financiadorInstance?.responsaveis?.collect { it.id }
            ids.each { id ->

                if (!params?.listaResponsaveis?.id?.contains(id.toString())) {

                    def responsavel = Responsavel.get(id)
                    def partic = responsavel.participante
                    def centroC = CentroCusto.findByResponsavel(responsavel)
                    financiadorInstance.removeFromResponsaveis(responsavel)
                    partic.removeFromPapeis(responsavel)
                    responsavel.participante = null
                    responsavel.financiador = null
                    if(centroC){
                        centroC.responsavel = null
                        centroC.save(flush: true, failOnError: true)
                    }
                    responsavel.delete(flush: true, failOnError: true)
                    partic.delete(flush: true, failOnError: true)
                }
            }
            for (int i = 0; i < params?.listaResponsaveis?.nome?.size(); i++) {

                def responsavel = null
                if (params?.listaResponsaveis?.id?.class?.array && params?.listaResponsaveis?.id?.size() > i) {
                    responsavel = Responsavel.get(Long.parseLong(params.listaResponsaveis?.id[i]))

                } else if (i == 0 && params.listaResponsaveis?.id) {
                    responsavel = Responsavel.get(Long.parseLong(params.listaResponsaveis?.id))

                }

                def participanteResponsavel
                if (responsavel) {
                    participanteResponsavel = responsavel.participante
                    log.debug("Adiciona participante existente: $participanteResponsavel")
                } else {
                    log.debug("Cria participante: ${params.listaResponsaveis?.nome[i]}")
                    responsavel = new Responsavel()
                    participanteResponsavel = new Participante()
                }
                if (params.listaResponsaveis?.nome[i])
                    participanteResponsavel.nome = params.listaResponsaveis?.nome[i]
                if (params.listaResponsaveis?.email[i])
                    participanteResponsavel.email = params.listaResponsaveis?.email[i]
                if (params.listaResponsaveis?.telefone[i]) {
                    def dadosTelefone = Util.phoneToRaw(params.listaResponsaveis?.telefone[i])
                    participanteResponsavel.telefone = Telefone.findOrSaveByDddAndNumero(dadosTelefone['ddd'], dadosTelefone['number'])
                }


                participanteResponsavel.save(failOnError: true, flush: true)

                responsavel.participante = participanteResponsavel
                responsavel.financiador = financiadorInstance
                responsavel.save(failOnError: true, flush: true)

                if (!participanteResponsavel?.papeis?.contains(responsavel))
                    participanteResponsavel.addToPapeis(responsavel)
                if (!financiadorInstance?.responsaveis?.contains(responsavel))
                    financiadorInstance.addToResponsaveis(responsavel)
                participanteResponsavel.save(failOnError: true, flush: true)
                financiadorInstance.save(failOnError: true, flush: true)

            }
        } else if (params?.listaResponsaveis?.nome && params?.listaResponsaveis?.email && params?.listaResponsaveis?.telefone) {
            def ids = financiadorInstance?.responsaveis?.collect { it.id }
            ids.each { id ->
                if (params?.listaResponsaveis?.id != id.toString()) {
                    def responsavel = Responsavel.get(id)
                    def partic = responsavel.participante
                    def centroC = CentroCusto.findByResponsavel(responsavel)
                    financiadorInstance.removeFromResponsaveis(responsavel)
                    partic.removeFromPapeis(responsavel)
                    responsavel.participante = null
                    responsavel.financiador = null
                    if(centroC){
                        centroC.responsavel = null
                        centroC.save(flush: true, failOnError: true)
                    }
                    responsavel.delete(flush: true, failOnError: true)
                    partic.delete(flush: true, failOnError: true)
                }
            }
            def responsavel
            if (params.listaResponsaveis?.id)
                responsavel = Responsavel.get(Long.parseLong(params.listaResponsaveis?.id))
            else
                responsavel = null
            def participanteResponsavel
            if (responsavel)
                participanteResponsavel = responsavel.participante
            else {
                responsavel = new Responsavel()
                participanteResponsavel = new Participante()
            }
            if (params.listaResponsaveis?.nome)
                participanteResponsavel.nome = params.listaResponsaveis?.nome
            if (params.listaResponsaveis?.email)
                participanteResponsavel.email = params.listaResponsaveis?.email
            if (params.listaResponsaveis?.telefone) {
                def dadosTelefone = Util.phoneToRaw(params.listaResponsaveis?.telefone)
                participanteResponsavel.telefone = Telefone.findOrSaveByDddAndNumero(dadosTelefone['ddd'], dadosTelefone['number'])
            }
            participanteResponsavel.save(failOnError: true, flush: true)

            responsavel.participante = participanteResponsavel
            responsavel.financiador = financiadorInstance
            responsavel.save(failOnError: true, flush: true)
            log.debug(" RESP: ${responsavel.properties}")
            if (!participanteResponsavel?.papeis?.contains(responsavel))
                participanteResponsavel.addToPapeis(responsavel)
            if (!financiadorInstance?.responsaveis?.contains(responsavel))
                financiadorInstance.addToResponsaveis(responsavel)
            participanteResponsavel.save(failOnError: true, flush: true)
            financiadorInstance.save(failOnError: true, flush: true)


        }

        if (financiadorInstance.hasErrors()) {
            respond financiadorInstance.errors, view: 'edit'
            return
        }

        financiadorInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Financiador.label', default: 'Financiador'), financiadorInstance.id])
                redirect financiadorInstance
            }
            '*' { respond financiadorInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Financiador financiadorInstance) {

        if (financiadorInstance == null) {
            notFound()
            return
        }

        financiadorInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Financiador.label', default: 'Financiador'), financiadorInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'financiador.label', default: 'Financiador'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    def getResponsaveis() {
        def financiador

        if (params.idFinanciador) {
            financiador = Financiador.get(Long.parseLong(params.idFinanciador))
        }

        def json = financiador?.responsaveis?.participante?.sort { it.nome }.collect { it ->
            ['nome': it?.nome, 'id': Papel.findByParticipante(it)?.id]
        }

        render(json as JSON)
    }
}

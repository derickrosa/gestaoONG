package com.acception.cadastro

import com.acception.cadastro.enums.Setor
import com.acception.util.Util
import grails.converters.JSON

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class FornecedorController {
    def exportService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE", criarFornecedor: "POST"]

    def index() {
        params?.remove('max')
        Map<String, String> pesquisa = params.pesquisa ?: params.subMap(['nome', 'codigo', 'cnpj', 'cpf', 'ramo', 'setor'])
        pesquisa = Util.trimMap(pesquisa)

        def criteria = {
            participante {
                if (pesquisa.containsKey('nome')) ilike('nomeNormalizado', "%${Util.normalizar(pesquisa.nome)}%")
                if (pesquisa.containsKey('cnpj')) eq('cnpj', "${Util.cnpjToRaw(pesquisa.cnpj)}")
                if (pesquisa.containsKey('cpf')) eq('cpf', "${Util.cpfToRaw(pesquisa.cpf)}")
            }
            if (pesquisa.containsKey('codigo')) eq('codigo', pesquisa.codigo)
            if (pesquisa.containsKey('ramo')) ilike('ramo', "%${pesquisa.ramo}%")
            if (pesquisa.containsKey('setor')) eq('setor', Setor.valueOf(pesquisa.setor))
        }

        if (params?.exportFormat && params.exportFormat != "html") {
            response.contentType = grailsApplication.config.grails.mime.types[params.exportFormat]
            response.setHeader("Content-disposition", "attachment; filename=Relatório de Fornecedores.${params.extension}")

            def fornecedorInstanceList = Fornecedor.createCriteria().list(params, criteria)

            List fields = ['participante.nome', 'participante.telefone', 'participante.email', 'Documento', 'setor', 'codigo', 'ramo']
            Map labels = ['participante.nome'    : 'Nome',
                          'participante.telefone': 'Telefone',
                          'participante.email'   : 'E-mail', 'setor': 'Setor', 'codigo': 'Código', 'ramo': 'Ramo']
            Map parameters = ["column.widths": [0.3, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2]]
            Map formatters = [
                    Documento: { fornecedor, value ->
                        if (fornecedor.participante instanceof PessoaFisica) return Util.rawToCpf(fornecedor.participante.cpf)
                        else return Util.rawToCnpj(fornecedor.participante.cnpj)
                    }
            ]

            exportService.export(params.exportFormat, response.outputStream, fornecedorInstanceList, fields, labels, formatters, parameters)
            return
        }
        params.max = Math.min(params.max ?: 10, 100)

        [fornecedorInstanceList : Fornecedor.createCriteria().list(params, criteria),
         fornecedorInstanceCount: Fornecedor.createCriteria().count(criteria),
         pesquisa               : pesquisa]
    }

    def show(Fornecedor fornecedorInstance) {
        respond fornecedorInstance
    }

    def create() {
        respond new Fornecedor(params)
    }

    @Transactional
    def save(Fornecedor fornecedorInstance) {
        def p = null
        if (params.tipoPessoa == "true")
            p = new PessoaFisica(params.participante)
        else
            p = new PessoaJuridica(params.participante)

        if (params.telefoneRaw) {
            def dadosTelefone = Util.phoneToRaw(params.telefoneRaw)
            p.telefone = Telefone.findOrSaveByDddAndNumero(dadosTelefone['ddd'], dadosTelefone['number'])
        }

        if (params.telefoneAdicionalRaw) {
            def dadosTelefone = Util.phoneToRaw(params.telefoneAdicionalRaw)
            p.telefoneAdicional = Telefone.findOrSaveByDddAndNumero(dadosTelefone['ddd'], dadosTelefone['number'])
        }
        p.addToPapeis(fornecedorInstance)

        p.save(flush: true, failOnError: true)

        if (fornecedorInstance == null) {
            notFound()
            return
        }

        if (fornecedorInstance.hasErrors()) {
            respond fornecedorInstance.errors, view: 'create'
            return
        }

        fornecedorInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'fornecedor.label', default: 'Fornecedor'), fornecedorInstance.id])
                redirect fornecedorInstance
            }
            '*' { respond fornecedorInstance, [status: CREATED] }
        }
    }

    def edit(Fornecedor fornecedorInstance) {
        respond fornecedorInstance
    }

    @Transactional
    def update(Fornecedor fornecedorInstance) {
        if (fornecedorInstance == null) {
            notFound()
            return
        }

        fornecedorInstance.participante.properties = params.participante

        if (params.telefoneRaw) {
            def dadosTelefone = Util.phoneToRaw(params.telefoneRaw)
            fornecedorInstance.participante.telefone = Telefone.findOrSaveByDddAndNumero(dadosTelefone['ddd'], dadosTelefone['number'])
        }

        if (params.telefoneAdicionalRaw) {
            def dadosTelefone = Util.phoneToRaw(params.telefoneAdicionalRaw)
            fornecedorInstance.participante.telefoneAdicional = Telefone.findOrSaveByDddAndNumero(dadosTelefone['ddd'], dadosTelefone['number'])
        }

        if (fornecedorInstance.hasErrors()) {
            respond fornecedorInstance.errors, view: 'edit'
            return
        }

        fornecedorInstance.participante.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Fornecedor.label', default: 'Fornecedor'), fornecedorInstance.id])
                redirect fornecedorInstance
            }
            '*' { respond fornecedorInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Fornecedor fornecedorInstance) {

        if (fornecedorInstance == null) {
            notFound()
            return
        }

        fornecedorInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Fornecedor.label', default: 'Fornecedor'), fornecedorInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    @Transactional
    def criarFornecedor() {
        def fornecedor = new Fornecedor(params)

        def p = null

        if (params.tipoPessoa == "FISICA") {
            p = new PessoaFisica(params.participante)
        } else if (params.tipoPessoa == "JURIDICA") {
            p = new PessoaJuridica(params.participante)
        } else {
            response.status = NOT_ACCEPTABLE.value()
            respond([error: "Escolha um tipo de fornecedor válido!"])
            return
        }

        if (params.telefoneRaw) {
            def dadosTelefone = Util.phoneToRaw(params.telefoneRaw)
            p.telefone = Telefone.findOrSaveByDddAndNumero(dadosTelefone['ddd'], dadosTelefone['number'])
        }

        if (params.telefoneAdicionalRaw) {
            def dadosTelefone = Util.phoneToRaw(params.telefoneAdicionalRaw)
            p.telefoneAdicional = Telefone.findOrSaveByDddAndNumero(dadosTelefone['ddd'], dadosTelefone['number'])
        }

        p.addToPapeis(fornecedor)

        p.save(flush: true, failOnError: true)
        fornecedor.save(flush: true, failOnError: true)

        response.status = OK.value()
        respond(['msg': 'Fornecedor criado com sucesso!',
                 'fornecedor':
                         ['id': fornecedor.id,
                          'nome': fornecedor.toString()]])
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'fornecedor.label', default: 'Fornecedor'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}

package com.acception.cadastro

import com.acception.util.Util

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class LinhaAcaoController {
    def exportService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {
        params?.remove('max')

        Map<String, String> pesquisa = params.pesquisa ?: params.subMap(['nome', 'codigo'])
        pesquisa = Util.trimMap(pesquisa)

        def criteria = {
            if (pesquisa?.containsKey('nome'))
                ilike('nomeNormalizado', "%${Util.normalizar(pesquisa.nome)}%")
            if (pesquisa?.containsKey('codigo'))
                eq('codigo', pesquisa.codigo)
        }

        if (params?.exportFormat && params.exportFormat != "html") {
            response.contentType = grailsApplication.config.grails.mime.types[params.exportFormat]
            response.setHeader("Content-disposition", "attachment; filename=Relatório das Linhas de Ação.${params.extension}")

            def linhaAcaoList = LinhaAcao.createCriteria().list(params, criteria)

            List fields = ['nome', 'codigo', 'descricao']
            Map labels = [nome: 'Nome', codigo: 'Código', descricao: 'Descrição']
            Map parameters = ["column.widths": [0.3, 0.2, 0.5]]

            exportService.export(params.exportFormat, response.outputStream, linhaAcaoList, fields, labels, [:], parameters)
            return
        }

        params.max = Math.min(params.max ?: 10, 100)

        [linhaAcaoInstanceList : LinhaAcao.createCriteria().list(params, criteria),
         linhaAcaoInstanceCount: LinhaAcao.createCriteria().count(criteria),
         pesquisa              : pesquisa]
    }

    def show(LinhaAcao linhaAcaoInstance) {
        respond linhaAcaoInstance
    }

    def create() {
        respond new LinhaAcao(params)
    }

    @Transactional
    def save(LinhaAcao linhaAcaoInstance) {
        if (linhaAcaoInstance == null) {
            notFound()
            return
        }

        if (linhaAcaoInstance.hasErrors()) {
            respond linhaAcaoInstance.errors, view: 'create'
            return
        }

        linhaAcaoInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'linhaAcao.label', default: 'LinhaAcao'), linhaAcaoInstance.id])
                redirect linhaAcaoInstance
            }
            '*' { respond linhaAcaoInstance, [status: CREATED] }
        }
    }

    def edit(LinhaAcao linhaAcaoInstance) {
        respond linhaAcaoInstance
    }

    @Transactional
    def update(LinhaAcao linhaAcaoInstance) {
        if (linhaAcaoInstance == null) {
            notFound()
            return
        }

        if (linhaAcaoInstance.hasErrors()) {
            respond linhaAcaoInstance.errors, view: 'edit'
            return
        }

        linhaAcaoInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'LinhaAcao.label', default: 'LinhaAcao'), linhaAcaoInstance.id])
                redirect linhaAcaoInstance
            }
            '*' { respond linhaAcaoInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(LinhaAcao linhaAcaoInstance) {

        if (linhaAcaoInstance == null) {
            notFound()
            return
        }

        linhaAcaoInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'LinhaAcao.label', default: 'LinhaAcao'), linhaAcaoInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'linhaAcao.label', default: 'LinhaAcao'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}

package com.acception.cadastro

import com.acception.cadastro.enums.StatusAtividade
import com.acception.cadastro.enums.TipoAtividade
import com.acception.util.Util
import grails.converters.JSON

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AtividadeController {
    def exportService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {
        params?.remove('max')
        Map<String, String> pesquisa = params.pesquisa ?: params.subMap(['nome', 'codigo', 'centroCusto', 'dataInicio', 'dataFinal', 'status', 'tipo', 'estado'])
        pesquisa = Util.trimMap(pesquisa)

        println("pesquisa: ${pesquisa}")

        def criteria = {
            if (pesquisa.containsKey('nome')) ilike('nomeNormalizado', "%${Util.normalizar(pesquisa.nome)}%")
            if (pesquisa.containsKey('codigo')) eq('codigo', pesquisa.codigo)
            if (pesquisa.containsKey('centroCusto')) {
                centroCusto {
                    idEq(pesquisa.centroCusto as Long)
                }
            }
            if (pesquisa.containsKey('dataInicio')) {
                Date dataInicio = Date.parse("dd/MM/yyyy", pesquisa.dataInicio).clearTime()
                ge('inicio', dataInicio)
            }
            if (pesquisa.containsKey('dataFinal')) {
                Date dataFinal = Date.parse("dd/MM/yyyy", pesquisa.dataFinal).clearTime() + 1
                le('termino', dataFinal)
            }

            if (pesquisa.containsKey('status')) eq('status', StatusAtividade.valueOf(pesquisa.status))
            if (pesquisa.containsKey('tipo')) eq('tipo', TipoAtividade.valueOf(pesquisa.tipo))
            if (pesquisa.containsKey('estado')) {
                estado {
                    idEq(pesquisa.estado as Long)
                }
            }
        }

        if (params?.exportFormat && params.exportFormat != "html") {
            response.contentType = grailsApplication.config.grails.mime.types[params.exportFormat]
            response.setHeader("Content-disposition", "attachment; filename=Relatório de Atividades.${params.extension}")

            def atividadeInstanceList = Atividade.createCriteria().list(params, criteria)

            List fields = ['nome', 'codigo', 'atividade', 'centroCusto', 'inicio', 'termino', 'estado', 'municipio', 'local', 'status', 'tipo', 'descricao']
            Map labels = ['nome'  : 'Nome', 'codigo': 'Código', 'atividade': 'Atividade', 'centroCusto': 'Centro de Custo', 'inicio': 'Início', 'termino': 'Término',
                          'estado': 'Estado', 'municipio': 'Município', 'local': 'Local', 'status': 'Status', 'tipo': 'Tipo de Atividade', 'descricao': 'Descrição']
            Map parameters = ["column.widths": [0.3, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.9]]

            exportService.export(params.exportFormat, response.outputStream, atividadeInstanceList, fields, labels, [:], parameters)
            return
        }
        params.max = Math.min(params.max ?: 10, 100)


        [atividadeInstanceList : Atividade.createCriteria().list(params, criteria),
         atividadeInstanceCount: Atividade.createCriteria().count(criteria),
         pesquisa              : pesquisa]
    }


    def show(Atividade atividadeInstance) {
        [atividadeInstance: atividadeInstance]
    }

    def create() {
        log.debug("Ct Custo: ${params.centroCustoInstance}")
        def centroCustoInstance
        def atividadeInstance
        if (params.atividade)
            atividadeInstance = Atividade.get(params.atividade.toLong())
        if (params.atividade) {
            centroCustoInstance = atividadeInstance.centroCusto
        } else {
            centroCustoInstance = CentroCusto.get(params.centroCustoInstance.toLong())
        }

        if (params.atividade)
            [atividadeInstance: new Atividade(params), atividade: atividadeInstance, centroCustoInstance: centroCustoInstance]
        else if (params.centroCustoInstance) {
            log.debug("Enviando CC")
            [atividadeInstance: new Atividade(params), centroCustoInstance: centroCustoInstance]
        } else
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

        if (atividadeInstance.atividade) {
            redirect(controller: "atividade", action: "show", id: atividadeInstance.atividade.id)
        } else {
            redirect(controller: "centroCusto", action: "show", id: atividadeInstance.centroCusto.id)
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
        if (numFilesUploaded) {
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
}

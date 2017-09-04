package com.acception.cadastro

import com.acception.cadastro.enums.RamoFuncionario
import com.acception.util.Util
import grails.converters.JSON

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class FuncionarioController {
    def exportService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE", getSalariosFuncionarioFromCentroCusto: "POST", criarFuncionario: "POST"]

    def index() {
        params?.remove('max')
        Map<String, String> pesquisa = params.pesquisa ?: params.subMap(['nome', 'cargo', 'setor', 'centroCusto'])
        pesquisa = Util.trimMap(pesquisa)

        def criteria = {
            if (pesquisa.containsKey('nome')) {
                participante {
                    ilike('nomeNormalizado', "%${Util.normalizar(pesquisa.nome)}%")
                }
            }
            if (pesquisa.containsKey('cargo')) ilike('cargo', "%${pesquisa.cargo}%")
            if (pesquisa.containsKey('setor')) eq('setor', RamoFuncionario.valueOf(pesquisa.setor))
        }

        if (params?.exportFormat && params.exportFormat != "html") {
            response.contentType = grailsApplication.config.grails.mime.types[params.exportFormat]
            response.setHeader("Content-disposition", "attachment; filename=Relatório de Funcionarios.${params.extension}")

            def funcionarioInstanceList = Funcionario.createCriteria().list(params, criteria)

            List fields = ['participante.nome', 'participante.telefone', 'participante.email', 'cargo']

            Map labels = ['participante.nome'    : 'Nome',
                          'participante.telefone': 'Telefone',
                          'participante.email'   : 'E-mail',
                          'cargo'                : 'Cargo']
            Map parameters = ["column.widths": [0.3, 0.2, 0.2, 0.3]]

            exportService.export(params.exportFormat, response.outputStream, funcionarioInstanceList, fields, labels, [:], parameters)
            return
        }

        params.max = Math.min(params.max ?: 10, 100)

        [funcionarioInstanceList : Funcionario.createCriteria().list(params, criteria),
         funcionarioInstanceCount: Funcionario.createCriteria().count(criteria),
         pesquisa                : pesquisa]

    }

    def show(Funcionario funcionarioInstance) {
        respond funcionarioInstance
    }

    def create() {
        respond new Funcionario(params)
    }

    @Transactional
    def save(Funcionario funcionarioInstance) {
        if (funcionarioInstance == null) {
            notFound()
            return
        }

        _updateDadosFuncionario(funcionarioInstance, params)

        if (funcionarioInstance.hasErrors()) {
            respond funcionarioInstance.errors, view: 'create'
            return
        }

        funcionarioInstance.participante.save flush: true
        funcionarioInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'funcionario.label', default: 'Funcionario'), funcionarioInstance.id])
                redirect funcionarioInstance
            }
            '*' { respond funcionarioInstance, [status: CREATED] }
        }
    }

    def edit(Funcionario funcionarioInstance) {
        respond funcionarioInstance
    }

    @Transactional
    def update(Funcionario funcionarioInstance) {
        if (funcionarioInstance == null) {
            notFound()
            return
        }

        _updateDadosFuncionario(funcionarioInstance, params)

        if (funcionarioInstance.hasErrors()) {
            respond funcionarioInstance.errors, view: 'edit'
            return
        }

        funcionarioInstance.participante.save flush: true
        funcionarioInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Funcionario.label', default: 'Funcionario'), funcionarioInstance.id])
                redirect funcionarioInstance
            }
            '*' { respond funcionarioInstance, [status: OK] }
        }
    }

    def _updateDadosFuncionario(Funcionario funcionarioInstance, params) {
        if (params.telefoneRaw) {
            def dadosTelefone = Util.phoneToRaw(params.telefoneRaw)

            funcionarioInstance.participante.telefone = Telefone.findOrSaveByDddAndNumero(dadosTelefone['ddd'], dadosTelefone['number'])
        }

        if (params.telefoneAdicionalRaw) {
            def dadosTelefone = Util.phoneToRaw(params.telefoneAdicionalRaw)

            funcionarioInstance.participante.telefoneAdicional = Telefone.findOrSaveByDddAndNumero(dadosTelefone['ddd'], dadosTelefone['number'])
        }

        if (params.valorSalario) {
            funcionarioInstance.salario = Util.parse(params.valorSalario)
        }
    }

    @Transactional
    def delete(Funcionario funcionarioInstance) {

        if (funcionarioInstance == null) {
            notFound()
            return
        }

        funcionarioInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Funcionario.label', default: 'Funcionario'), funcionarioInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    @Transactional
    def criarFuncionario() {
        def funcionario = new Funcionario(params)

        _updateDadosFuncionario(funcionario, params)

        def itemOrcamentario = ItemOrcamentario.get(params.itemOrcamentario?.toInteger())
        def salarioCentroCusto

        if (itemOrcamentario) {
            def salario = Util.parse(params.salarioFuncionarioItemOrcamentario)

            if (salario) {
                salarioCentroCusto = new SalarioFuncionario(funcionario: funcionario, valor: salario,
                        itemOrcamentario: itemOrcamentario)

                funcionario.participante.save(flush: true, failOnError: true)
                funcionario.save(flush: true)
                salarioCentroCusto.save(flush: true)
            }
        }

        render(['success': true, 'funcionario': ['nome'              : funcionario.toString(),
                                                 'setor'             : funcionario.setor.descricao,
                                                 'salarioTotal'      : Util.moneyMask(funcionario.salario),
                                                 'salarioCentroCusto': Util.moneyMask(salarioCentroCusto?.valor)]] as JSON)
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'funcionario.label', default: 'Funcionario'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    def getSalariosFuncionarioFromCentroCusto() {
        def funcionario = Funcionario.get(params.funcionarioId)

        def salarioAnual = funcionario.salario

        def salariosFuncionario = SalarioFuncionario.findAllByFuncionario(funcionario)

        def dados = [:]

        salariosFuncionario.each {
            def nomeCentroCusto = it.itemOrcamentario.orcamento?.centroCusto?.nome ?: ''

            dados[nomeCentroCusto] = it.valor
        }

        def salarioAlocadoCentroCusto = dados.values().sum() ?: 0

        if (salarioAlocadoCentroCusto < salarioAnual) {
            dados['Não Definido'] = salarioAnual - salarioAlocadoCentroCusto
        }

        render(dados as JSON)
    }
}

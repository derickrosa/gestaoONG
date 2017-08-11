package com.acception.cadastro

import com.acception.cadastro.enums.Moeda
import com.acception.cadastro.enums.TipoCusto
import com.acception.util.Util
import grails.converters.JSON

import java.text.DecimalFormat

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class OrcamentoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE", getItensOrcamentarios: "POST"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Orcamento.list(params), model: [orcamentoInstanceCount: Orcamento.count()]
    }

    def show(Orcamento orcamentoInstance) {
        respond orcamentoInstance
    }

    def create() {
        respond new Orcamento(params)
    }

    @Transactional
    def save(Orcamento orcamentoInstance) {
        if (orcamentoInstance == null) {
            notFound()
            return
        }

        if (orcamentoInstance.hasErrors()) {
            respond orcamentoInstance.errors, view: 'create'
            return
        }

        orcamentoInstance.save()

        _updateOrcamento(orcamentoInstance, params)

        orcamentoInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = 'Orçamento replanejado com sucesso!'
                redirect(controller: 'centroCusto', action: 'show', id: orcamentoInstance.centroCusto.id, params: ['showOrcamento': true])
            }
            '*' { respond orcamentoInstance, [status: CREATED] }
        }
    }

    def edit(Orcamento orcamentoInstance) {
        respond orcamentoInstance
    }

    @Transactional
    def update(Orcamento orcamentoInstance) {
        if (orcamentoInstance == null) {
            notFound()
            return
        }

        if (orcamentoInstance.hasErrors()) {
            respond orcamentoInstance.errors, view: 'edit'
            return
        }

        _updateOrcamento(orcamentoInstance, params)

        orcamentoInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Orcamento.label', default: 'Orcamento'), orcamentoInstance.id])
                redirect orcamentoInstance
            }
            '*' { respond orcamentoInstance, [status: OK] }
        }
    }

    @Transactional
    def _updateOrcamento(Orcamento orcamento, params) {
        orcamento.ano = Integer.parseInt(params.orcamento?.ano)
        orcamento.valorTotal = Util.parse(params.valorTotalOrcamento)
        orcamento.moeda = Moeda.valueOf(params.orcamento?.moeda)
        orcamento.valorCambial = params.valorCambialOrcamento ? Util.parse(params.valorCambialOrcamento) : 1

        atualizarItensOrcamentarios(orcamento, params.itensOrcamento)

        orcamento.save(flush: true, failOnError: true)

        if (params?.orcamentoAnterior) {
            def orcamentoAnterior = Orcamento.get(params.orcamentoAnterior.toLong())

            orcamentoAnterior.orcamentoReplanejado = orcamento
            orcamentoAnterior.centroCusto.addToOrcamentos(orcamento)

            orcamentoAnterior.centroCusto.save(flush: true, failOnError: true)
        }
    }

    def atualizarItensOrcamentarios(Orcamento orcamento, itensOrcamento) {
        def itensOrcamentarios = orcamento?.itensOrcamentarios?.collect()

        removerItensOrcamentarios(orcamento)

        if (itensOrcamento?.codigo?.class?.array) {
            itensOrcamento.codigo.eachWithIndex { codigo, i ->
                createUpdateItemOrcamentario(itensOrcamentarios, codigo, itensOrcamento.nome[i], itensOrcamento.valor[i],
                        itensOrcamento.tipoCusto[i], orcamento, itensOrcamento.id[i], itensOrcamento)
            }
        } else {
            createUpdateItemOrcamentario(itensOrcamentarios, itensOrcamento.codigo, itensOrcamento.nome,
                    itensOrcamento.valor, itensOrcamento.tipoCusto, orcamento, itensOrcamento.id, itensOrcamento)
        }

        deletarItensOrcamentariosPassados(orcamento.itensOrcamentarios, itensOrcamentarios)
    }

    def removerItensOrcamentarios(Orcamento orcamento) {
        orcamento?.itensOrcamentarios?.collect()?.each {
            orcamento.removeFromItensOrcamentarios(it)
        }
    }

    def deletarItensOrcamentariosPassados(itensOrcamentariosAtuais, itensOrcamentariosPassados) {
        for (pastItemOrcamentario in itensOrcamentariosPassados) {
            if (! itensOrcamentariosAtuais.contains(pastItemOrcamentario)) {
                pastItemOrcamentario.delete()
            }
        }
    }

    def createUpdateItemOrcamentario(itensOrcamentarios, codigo, nome, valor, tipoCusto, orcamento, id, params) {
        if (codigo) {
            ItemOrcamentario item = itensOrcamentarios?.find { it.codigo == codigo}

            println "---------------"
            println "ITEM PASSADO: ${item}"
            println "ID: ${id}"
            println "CÓDIGO: ${codigo}"
            println "NOME: ${nome}"
            println "VALOR: ${valor}"
            println "TIPO: ${tipoCusto}"

            if (! item) {
                item = new ItemOrcamentario(codigo: codigo)
            }

            item.nome = nome ?: ''
            item.valor = valor ? Util.parse(valor) : 0
            item.tipoCusto = tipoCusto ? TipoCusto.valueOf(tipoCusto) : null
            item.orcamento = orcamento
            item.save()

            atualizarSalariosFuncionarios(params["listaFuncionarios_${id}"],
                    params["listaFuncionariosSalario_${id}"], item)

            orcamento.addToItensOrcamentarios(item)
        }
    }

    def atualizarSalariosFuncionarios(listaFuncionarios, listaSalarios, ItemOrcamentario item) {
        def funcionarios = listaFuncionarios.split(',')
        def salarioFuncionarios = listaSalarios.split('-')

        println "FUNCIONÁRIOS: ${funcionarios}"
        println "SALÁRIO FUNCIONÁRIOS: ${salarioFuncionarios}"

        def listaAntigaSalariosFuncionarios = item.salariosFuncionarios?.collect()

        item.salariosFuncionarios?.collect()?.each {
            item.removeFromSalariosFuncionarios(it)
        }

        if (item.tipoCusto == TipoCusto.PESSOAL) {
            if (funcionarios) {
                funcionarios.eachWithIndex { funcionarioId, i ->
                    if (funcionarioId && salarioFuncionarios[i]) {
                        def salarioFuncionario = listaAntigaSalariosFuncionarios.find { it.funcionario.id == funcionarioId.toInteger()}

                        if (! salarioFuncionario) {
                            salarioFuncionario = new SalarioFuncionario(itemOrcamentario: item,
                                    funcionario: Funcionario.get(funcionarioId))
                        }

                        salarioFuncionario.valor = salarioFuncionarios[i] ? Util.parse(salarioFuncionarios[i]) : 0

                        item.addToSalariosFuncionarios(salarioFuncionario)
                        salarioFuncionario.save()
                    }
                }
            }
        }

        for (salarioFuncionario in listaAntigaSalariosFuncionarios) {
            if (! item.salariosFuncionarios.contains(salarioFuncionario)) {
                log.debug("SF ${salarioFuncionario} deletado!")
                salarioFuncionario.delete()
            }
        }
    }

    @Transactional
    def delete(Orcamento orcamentoInstance) {

        if (orcamentoInstance == null) {
            notFound()
            return
        }

        orcamentoInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Orcamento.label', default: 'Orcamento'), orcamentoInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    def getItensOrcamentarios(){
        def df = new DecimalFormat('###,##0.00')

        def orcamento

        if (params.idOrcamento) {
            orcamento = Orcamento.get(Long.parseLong(params.idOrcamento))
        }

        def json = orcamento?.itensOrcamentarios?.collect { ItemOrcamentario it ->
            [it.codigo, it.nome, it.valor, it.tipoCusto.name(),
             it.salariosFuncionarios?.collect { it.funcionario.id }?.join(','),
             it.salariosFuncionarios?.collect { df.format(it.valor) }?.join('-')]
        }

        render(json as JSON)
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'orcamento.label', default: 'Orcamento'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}

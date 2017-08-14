package com.acception.cadastro

import com.acception.cadastro.enums.StatusProjeto
import com.acception.cadastro.enums.TipoLancamento

class CentroCusto {

    String codigo
    String nome
    String descricao
    Integer ano
    Date dateCreated
    Date dataInicio
    Date dataFinal

    Anexo planoDeTrabalho
    Responsavel responsavel
    StatusProjeto statusProjeto
    ContaBancaria contaBancaria

    static hasMany = [atividades: Atividade,
                      arquivos: Arquivo,
                      orcamentos: Orcamento,
                      lancamentos: Lancamento]

    static belongsTo = [financiador: Financiador]

    static transients = ['saldo']

    static constraints = {
        dataInicio nullable: true
        dataFinal nullable: true
        planoDeTrabalho nullable: true
        atividades nullable: true
        arquivos nullable: true
        responsavel nullable: true
        statusProjeto nullable: true
    }

    def getSaldo() {
        def despesas = 0
        def creditos = this.lancamentos.findAll{ it.tipoLancamento == TipoLancamento.CREDITO }

        def valorCredito = creditos*.valor.sum() ?: 0

        return valorCredito - despesas
    }

    def getSaldoInicial() {
        return this.lancamentos.find { it.descricao == 'Saldo Inicial' }?.valor ?: 0
    }

    def getOrcamentoOriginal() {
        return orcamentos?.min { it.dateCreated }
    }

    def getOrcamentoAtual() {
        return orcamentos?.max { it.dateCreated }
    }

    def getDespesas() {
        return orcamentos.itensOrcamentarios.despesas.flatten()
    }

    String toString() {
        "(${codigo}) ${nome}/${ano}"
    }
}

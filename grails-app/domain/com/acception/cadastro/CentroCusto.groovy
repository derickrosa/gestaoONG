package com.acception.cadastro

import com.acception.cadastro.enums.StatusProjeto

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
                      despesas:Despesa,
                      orcamentos: Orcamento]

    static belongsTo = [financiador: Financiador]

    static constraints = {
        dataInicio nullable: true
        dataFinal nullable: true
        planoDeTrabalho nullable: true
        atividades nullable: true
        arquivos nullable: true
        responsavel nullable: true
        statusProjeto nullable: true
    }

    def getOrcamentoOriginal() {
        return orcamentos?.min { it.dateCreated }
    }

    def getOrcamentoAtual() {
        return orcamentos?.max { it.dateCreated }
    }

    String toString() {
        "${nome + '/' + ano}"
    }
}

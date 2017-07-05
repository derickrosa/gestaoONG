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
    Orcamento orcamento

    static hasMany = [atividades: Atividade, despesas:Despesa]

    static belongsTo = [financiador: Financiador]

    static constraints = {
        dataInicio nullable: true
        dataFinal nullable: true
        planoDeTrabalho nullable: true
        atividades nullable: true
    }

    String toString() {
        "${nome + '/' + ano}"
    }
}

package com.acception.cadastro

class ResumoViagem {

    Date dateCreated
    Date lastUpdated

    Atividade atividade
    List<Despesa> despesas

    static belongsTo = [adiantamento: Adiantamento]

    static transients = ['despesas']

    static constraints = {
        atividade nullable: false
    }
}

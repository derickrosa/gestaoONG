package com.acception.cadastro

class ResumoViagem {

    Date dateCreated
    Date lastUpdated

    Funcionario funcionario
    Adiantamento adiantamento

    static hasMany = [despesas: Despesa]
    static belongsTo = [atividade: Atividade, contaAtividade:ContaAtividade]

    static constraints = {
        atividade nullable: false
        adiantamento nullable: true
        despesas nullable: true
    }
}

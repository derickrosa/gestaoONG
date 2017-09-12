package com.acception.cadastro

abstract class EventoFinanceiro {
    Date data
    String descricao
    Double valor

    Date dateCreated
    Date lastUpdated

    List<Lancamento> lancamentos

    static belongsTo = [centroCusto: CentroCusto]

    static transients = ['lancamentos']

    static constraints = {
        data nullable: false
        descricao nullable: true, blank: true
        valor nullable: false
        dateCreated nullable: false
        lastUpdated nullable: false
    }
}

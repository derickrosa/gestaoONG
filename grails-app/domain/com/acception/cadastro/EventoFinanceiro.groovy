package com.acception.cadastro

class EventoFinanceiro {

    Date dateCreated
    Date lastUpdated

    Papel papel
    Date data
    String descricao
    Double valor

    List<Lancamento> lancamentos



    static belongsTo = [centroCusto: CentroCusto]
    static transients = ['lancamentos']

    static constraints = {
        descricao nullable: true
    }
}

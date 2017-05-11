package com.acception.cadastro

class Orcamento {

    Integer ano
    Double valorTotal
    Integer moeda

//    static hasMany = [itensOrcamentarios: ItemOrcamentario]

    static belongsTo = [centroCusto: CentroCusto]

    static constraints = {
    }
}

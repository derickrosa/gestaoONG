package com.acception.cadastro

import com.acception.cadastro.enums.Moeda

class Orcamento {

    Integer ano
    Double valorTotal
    Moeda moeda

    static hasMany = [itensOrcamentarios: ItemOrcamentario]

    static belongsTo = [centroCusto: CentroCusto]

    static constraints = {
    }
}

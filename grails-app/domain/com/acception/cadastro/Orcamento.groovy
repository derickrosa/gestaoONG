package com.acception.cadastro

import com.acception.cadastro.enums.Moeda

class Orcamento {

    Integer ano
    Double valorTotal
    Moeda moeda
    Double valorCambial
    Date dateCreated
    Orcamento orcamentoReplanejado

    static hasMany = [itensOrcamentarios: ItemOrcamentario]

    static belongsTo = [centroCusto: CentroCusto]

    static constraints = {
        dateCreated nullable: true
        orcamentoReplanejado nullable: true
    }
}

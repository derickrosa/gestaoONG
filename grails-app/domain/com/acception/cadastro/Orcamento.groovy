package com.acception.cadastro

import com.acception.cadastro.enums.Moeda

import java.text.DecimalFormat

class Orcamento {
    Integer ano
    Double valorTotal
    Moeda moeda
    Double valorCambial
    Date dateCreated
    Orcamento orcamentoReplanejado

    static hasMany = [itensOrcamentarios: ItemOrcamentario]
    static belongsTo = [centroCusto: CentroCusto]
    static transients = ['valor']

    static constraints = {
        dateCreated nullable: true
        orcamentoReplanejado nullable: true
    }

    String getValor() {
        return "${moeda.representacao} ${new DecimalFormat("#.00").format(valorTotal)}"
    }
}

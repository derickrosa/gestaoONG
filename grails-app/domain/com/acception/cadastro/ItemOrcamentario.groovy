package com.acception.cadastro

import com.acception.cadastro.enums.TipoCusto

class ItemOrcamentario {

    String codigo
    String nome
    Double valor
    TipoCusto tipoCusto
    Date dateCreated

    static belongsTo = [orcamento: Orcamento]

    static hasMany = [salariosFuncionarios: SalarioFuncionario, despesas: Despesa]

    static constraints = {
    }

    String toString() {
        "${nome} (${codigo})"
    }
}

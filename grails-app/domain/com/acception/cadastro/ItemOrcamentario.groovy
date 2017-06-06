package com.acception.cadastro

import com.acception.cadastro.enums.TipoCusto

class ItemOrcamentario {

    String codigo
    String nome
    Double valor
    TipoCusto tipoCusto

    static belongsTo = [orcamento: Orcamento]

    static hasMany = [salariosFuncionarios: SalarioFuncionario]

    static constraints = {
    }
}

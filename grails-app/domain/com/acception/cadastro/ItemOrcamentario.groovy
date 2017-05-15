package com.acception.cadastro

import com.acception.cadastro.enums.TipoCusto

class ItemOrcamentario {

    String codigo
    String nome
    Double valor
    TipoCusto tipoCusto

//    static hasMany = [despesas: Despesa]

    static constraints = {
    }
}

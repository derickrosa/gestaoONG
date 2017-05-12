package com.acception.cadastro

import com.acception.cadastro.enums.Setor

class Financiador extends Papel {
    String nomeFantasia
    String sigla
    Setor setor

    static hasMany=[centrosCusto:CentroCusto, responsaveis:Responsavel]

    static constraints = {
        nomeFantasia maxSize:100
        sigla maxSize:10
        sigla nullable:true
    }
}

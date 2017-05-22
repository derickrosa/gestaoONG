package com.acception.cadastro

import com.acception.cadastro.enums.Setor

class Financiador extends Papel {
    String nomeFantasia
    String sigla
    Setor setor

    static hasMany=[centrosCusto:CentroCusto, responsaveis:Responsavel]

    static constraints = {
        nomeFantasia maxSize:100
        centrosCusto nullable:true
        responsaveis nullable:true
        sigla maxSize:10, nullable:true
    }

    String toString() {
        def nome = nomeFantasia

        if (sigla) {
            nome += " (${sigla})"
        }

        nome
    }
}

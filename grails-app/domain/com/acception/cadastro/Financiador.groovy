package com.acception.cadastro

import com.acception.cadastro.enums.Setor

class Financiador extends Papel {
    String sigla
    Setor setor

    static hasMany=[centrosCusto:CentroCusto, responsaveis:Responsavel]

    static constraints = {
        centrosCusto nullable:true
        responsaveis nullable:true
        sigla maxSize:10, nullable:true
    }

    String toString() {
        def nome = participante.nome

        if (sigla) {
            nome += " (${sigla})"
        }

        nome
    }
}

package com.acception.cadastro

import com.acception.util.Util

class Banco {
    String codigo
    String nome
    String nomeNormalizado
    Double taxa = 0.0

    static constraints = {
        codigo maxSize: 3
        nome maxSize: 40
        nomeNormalizado nullable: true
        taxa nullable: true
    }

    static mapping = {
        sort "nome"
    }

    void setNome(String nome) {
        this.nome = nome
        this.nomeNormalizado = Util.normalizar(this.nome)
    }

    String toString() {
        "${codigo} - ${nome}"
    }
}

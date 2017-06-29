package com.acception.cadastro

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

    String toString() {
        "${codigo} - ${nome}"
    }
}

package com.acception.cadastro

class Cidade {
    String nome
    String nomeNormalizado
    Estado estado
    Double latitude
    Double longitude

    static constraints = {
        nome(maxSize: 60, blank: false)
        estado nullable: true
        latitude nullable: true
        longitude nullable: true
        nomeNormalizado nullable: true
    }

    String toString() {
        "${nome}"
    }
    static mapping = {
        id generator: 'sequence', params: [sequence: 'cidade_seq']
    }
}

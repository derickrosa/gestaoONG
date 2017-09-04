package com.acception.cadastro

import com.acception.util.Util

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

    void setNome(String nome) {
        this.nome = nome
        this.nomeNormalizado = Util.normalizar(this.nome)
    }

    String toString() {
        "${nome}"
    }
    static mapping = {
        id generator: 'sequence', params: [sequence: 'cidade_seq']
        sort: "nome"
    }
}

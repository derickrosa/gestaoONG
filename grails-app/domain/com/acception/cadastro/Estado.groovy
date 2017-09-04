package com.acception.cadastro

class Estado {
    String nome
    String sigla
    static hasMany = [coordenadas: Coordenada]
    static constraints = {
        nome(maxSize: 40, nullable: true)
        sigla(maxSize: 2)
        coordenadas nullable: true
    }

    String toString() {
        sigla
    }

    static mapping = {
        id generator: 'sequence', params: [sequence: 'estado_seq']
        sort: "nome"
    }
}

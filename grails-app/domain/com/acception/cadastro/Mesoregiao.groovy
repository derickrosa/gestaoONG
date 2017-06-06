package com.acception.cadastro

import com.acception.cadastro.enums.NomeMesoregiao

class Mesoregiao {
    NomeMesoregiao nome
    String descricao
    static hasMany = [coordenadas: Coordenada]
    static constraints = {
        coordenadas nullable: true
        descricao nullable: true
        nome nullable: true
    }
}

package com.acception.cadastro

class Coordenada {
    String latitude
    String longitude
    Integer ordem
    static belongsTo = [mesoregiao: Mesoregiao, estado: Estado]
    static constraints = {
        latitude nullable: true
        longitude nullable: true
        ordem nullable: true
        mesoregiao nullable: true
        estado nullable: true
    }
}

package com.acception.cadastro

class Papel {

    String codigo

    Date dateCreated
    Date lastUpdated

    static belongsTo = [participante: Participante]
    static constraints = {
        codigo nullable: true, maxSize: 20
    }
}

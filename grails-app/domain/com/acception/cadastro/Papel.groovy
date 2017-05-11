package com.acception.cadastro

class Papel {

    Date dateCreated
    Date lastUpdated

    static belongsTo = [participante:Participante]
    static constraints = {
    }
}

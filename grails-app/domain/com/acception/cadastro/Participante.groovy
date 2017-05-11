package com.acception.cadastro

import com.acception.security.User

class Participante {

    static auditable = true

    Date dateCreated
    Date lastUpdated

    String nome

    /*
    Endereco endereco
    Telefone telefone
    Telefone telefone2
    Telefone celular*/

    String email
    String emailAdicional

    String senhaInicial

    User user
    static hasMany=[papeis:Papel]

    static constraints = {
        nome maxSize:100
        email email:true, nullable:true
        emailAdicional email:true, nullable:true
        user nullable:true
        papeis nullable:true
        senhaInicial nullable:true, maxSize:64
    }
}

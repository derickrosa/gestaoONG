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

    Telefone telefone
    Telefone telefoneAdicional

    String email
    String emailAdicional

    String senhaInicial

    User user
    static hasMany=[papeis:Papel]

    static constraints = {
        nome maxSize:100
        telefone nullable: true
        telefoneAdicional nullable: true
        email email:true, nullable:true
        emailAdicional email:true, nullable:true
        user nullable:true
        papeis nullable:true
        senhaInicial nullable:true, maxSize:64
    }

    String toString() {
        nome
    }
}

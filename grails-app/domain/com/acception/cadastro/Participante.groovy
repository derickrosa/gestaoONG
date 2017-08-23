package com.acception.cadastro

import com.acception.security.User
import com.acception.util.Util

class Participante {

    static auditable = true

    Date dateCreated
    Date lastUpdated

    String nome
    String nomeNormalizado

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
        nomeNormalizado nullable: true
        telefone nullable: true
        telefoneAdicional nullable: true
        email email:true, nullable:true
        emailAdicional email:true, nullable:true
        user nullable:true
        papeis nullable:true
        senhaInicial nullable:true, maxSize:64
    }

    def beforeInsert() {
        fillNomeNormalizado()
    }

    def beforeUpdate() {
        fillNomeNormalizado()
    }

    def fillNomeNormalizado() {
        if(this.nome != null) {
            this.nomeNormalizado = Util.normalizar(this.nome)
        }
    }

    String toString() {
        nome
    }
}

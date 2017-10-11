package com.acception.cadastro

import com.acception.util.Util

class ContaAtividade {
    String codigo
    String nome
    String nomeNormalizado

    static hasMany = [resumos: ResumoViagem]

    static constraints = {
        nome nullable: true
        nomeNormalizado nullable: true
        resumos nullable: true
    }

    static mapping = {
        sort "nome"
    }

    void setNome(String nome) {
        this.nome = nome
        this.nomeNormalizado = Util.normalizar(this.nome)
    }


    String toString() {
        "${codigo + ' - ' + nome}"
    }
}
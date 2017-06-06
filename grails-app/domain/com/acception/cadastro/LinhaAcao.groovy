package com.acception.cadastro

class LinhaAcao {

    String codigo
    String descricao
    String nome

    static hasMany=[atividades:Atividade]
    static constraints = {
        nome maxSize:100
        atividades nullable: true
        descricao nullable: true
    }

    String toString() {
        "${codigo + ' - ' + nome}"
    }
}

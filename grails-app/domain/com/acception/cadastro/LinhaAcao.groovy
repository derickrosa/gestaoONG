package com.acception.cadastro

import com.acception.util.Util

class LinhaAcao {

    String codigo
    String descricao
    String nome
    String nomeNormalizado

    static hasMany=[atividades:Atividade]
    static constraints = {
        nome nullable: true
        nomeNormalizado nullable: true
        atividades nullable: true
        descricao nullable: true
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
        "${codigo + ' - ' + nome}"
    }
}

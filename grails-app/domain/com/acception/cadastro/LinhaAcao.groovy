package com.acception.cadastro

import com.acception.util.Util

class LinhaAcao {

    String codigo
    String descricao
    String nome
    String nomeNormalizado

    static hasMany = [atividades: Atividade]
    static transients = ['centrosCusto']
    static constraints = {
        nome nullable: true
        nomeNormalizado nullable: true
        atividades nullable: true
        descricao nullable: true
    }

    static mapping = {
        sort "nome"
    }

    void setNome(String nome) {
        this.nome = nome
        this.nomeNormalizado = Util.normalizar(this.nome)
    }

    def getCentrosCusto() {
        return this.atividades.centroCusto.flatten().unique()
    }

    String toString() {
        "${codigo + ' - ' + nome}"
    }
}

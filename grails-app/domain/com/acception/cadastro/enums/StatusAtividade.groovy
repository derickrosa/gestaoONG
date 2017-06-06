package com.acception.cadastro.enums

import grails.converters.JSON

/**
 * Created by derick on 02/06/17.
 */
enum StatusAtividade {
    NAO_INICIADA('Não iniciada'),
    EM_ANDAMENTO('Em andamento'),
    FINALIZADA('Finalizada'),
    CANCELADA('Cancelada')

    String nome

    public StatusAtividade(String nome) {
        this.nome = nome
    }

    @Override
    String toString() {
        return nome
    }

    String getKey() {
        name()
    }

    static def toList() {
        [NAO_INICIADA, EM_ANDAMENTO, FINALIZADA, CANCELADA]
    }

    def static getDadosJSON() {
        def tiposAtividade = []

        values().each {
            tiposAtividade << ['descricao': it.nome, 'key': it.name()]
        }

        tiposAtividade as JSON
    }
}
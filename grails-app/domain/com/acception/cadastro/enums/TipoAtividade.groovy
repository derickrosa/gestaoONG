package com.acception.cadastro.enums

import grails.converters.JSON

/**
 * Created by derick on 02/06/17.
 */
enum TipoAtividade {
    GERAL('Geral'),
    REUNIAO('Reunião'),
    OFICINA('Oficina'),
    ENCONTRO('Encontro'),
    FORMACAO('Formação'),
    MONITORAMENTO('Monitoramento'),
    CONSULTORIA('Consultoria'),
    ARTICULACAO('Articulação')

    String nome

    public TipoAtividade(String nome) {
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
        [GERAL, REUNIAO, OFICINA, ENCONTRO, MONITORAMENTO, CONSULTORIA, ARTICULACAO]
    }

    def static getDadosJSON() {
        def tiposAtividade = []

        values().each {
            tiposAtividade << ['descricao': it.nome, 'key': it.name()]
        }

        tiposAtividade as JSON
    }
}
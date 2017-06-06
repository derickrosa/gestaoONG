package com.acception.cadastro.enums

/**
 * Created by elderferreira on 07/06/16.
 */
enum NomeMesoregiao {
    REGIAO_METROPOLITANA_BELEM('Região Metropolitana de Belém'),
    MARAJO('Marajó'),
    NORDESTE_PARAENSE('Nordeste Paraense'),
    SUDESTE_PARAENSE('Sudeste Paraense'),
    SUDOESTE_PARAENSE('Sudoeste Paraense'),
    BAIXO_AMAZONAS('Baixo Amazonas')

    String nome

    public NomeMesoregiao(String nome) {
        this.nome = nome
    }

    @Override
    String toString() {
        return nome
    }

    String getKey() {
        name()
    }

    def toList() {
        [REGIAO_METROPOLITANA_BELEM, MARAJO, NORDESTE_PARAENSE, SUDESTE_PARAENSE, SUDOESTE_PARAENSE, BAIXO_AMAZONAS]
    }
}
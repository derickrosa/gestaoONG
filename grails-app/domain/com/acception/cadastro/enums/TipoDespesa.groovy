package com.acception.cadastro.enums

/**
 * Created by derick on 05/07/17.
 */
enum TipoDespesa {
    ATIVIDADE('Atividade'),
    PESSOAL('Pessoal'),
    ADIANTAMENTO('Adiantamento'),
    CUSTO_ADMINISTRATIVO('Custo Administrativo')


    String nome

    TipoDespesa(nome) {
        this.nome=nome
    }

    static def list() {
        [ATIVIDADE, PESSOAL, ADIANTAMENTO, CUSTO_ADMINISTRATIVO]
    }

    String getKey(){
        name()
    }
}
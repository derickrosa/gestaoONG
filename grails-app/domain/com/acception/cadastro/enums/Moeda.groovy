package com.acception.cadastro.enums

/**
 * Created by acception on 18/05/17.
 */
enum Moeda {
    REAL(descricao: 'Real', representacao: 'R$', code: 'BRL'),
    DOLAR(descricao: 'Dólar', representacao: 'US$', code: 'USD'),
    EURO(descricao: 'Euro', representacao: '€', code: 'EUR')

    String descricao
    String representacao
    String code

    String toString() {
        "${descricao} (${representacao})"
    }

    String getKey(){
        name()
    }
}
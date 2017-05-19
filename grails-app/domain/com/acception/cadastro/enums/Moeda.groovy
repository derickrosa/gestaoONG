package com.acception.cadastro.enums

/**
 * Created by acception on 18/05/17.
 */
enum Moeda {
    REAL(descricao: 'Real', representacao: 'R$'),
    DOLAR(descricao: 'Dólar', representacao: 'US$'),
    EURO(descricao: 'Euro', representacao: '€')

    String descricao
    String representacao

    String toString() {
        "${descricao} (${representacao})"
    }

}
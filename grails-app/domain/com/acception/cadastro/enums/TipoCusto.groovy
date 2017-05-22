package com.acception.cadastro.enums

/**
 * Created by acception on 17/05/17.
 */
enum TipoCusto {
    PESSOAL(descricao: 'Pessoal'),
    ATIVIDADE(descricao: 'Atividade'),
    INVESTIMENTO(descricao: 'Investimento'),
    EQUIPAMENTO(descricao: 'Equipamento'),
    IMPREVISTO(descricao: 'Imprevisto')

    String descricao

    @Override
    String toString() {
        descricao
    }

    def static toList() {
        [PESSOAL, ATIVIDADE, INVESTIMENTO, EQUIPAMENTO, IMPREVISTO]
    }
}
package com.acception.cadastro.enums

/**
 * Created by derick on 05/07/17.
 */
public enum TipoPagamento {
    DOC('DOC'),
    TED('TED'),
    CHEQUE('Cheque')


    String nome

    TipoPagamento(nome) {
        this.nome=nome
    }

    static def list() {
        [DOC, TED, CHEQUE]
    }
}
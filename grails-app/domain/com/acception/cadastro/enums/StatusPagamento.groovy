package com.acception.cadastro.enums

/**
 * Created by derick on 05/07/17.
 */
enum StatusPagamento {
    AGENDADO('Agendado'),
    INCONSISTENTE('Inconsistente'),
    PAGO('Pago'),
    REAGENDADO('Reagendado'),
    CANCELADO('Cancelado')

    String nome


    static def list() {
        [AGENDADO,INCONSISTENTE,PAGO,CANCELADO]
    }


    StatusPagamento(nome){
        this.nome=nome
    }

    String getKey(){
        name()
    }
}
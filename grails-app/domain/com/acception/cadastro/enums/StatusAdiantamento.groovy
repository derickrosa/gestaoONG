package com.acception.cadastro.enums

/**
 * Created by derick on 01/08/17.
 */
enum StatusAdiantamento {
    EM_ABERTO('Em aberto'),
    PARCIALMENTE_LIQUIDADO('Parcialmente liquidado'),
    LIQUIDADO('Liquidado'),
    CANCELADO('Cancelado')


    String nome

    static def list() {
        [EM_ABERTO,PARCIALMENTE_LIQUIDADO,LIQUIDADO,CANCELADO]
    }

    StatusAdiantamento(nome){
        this.nome=nome
    }


}
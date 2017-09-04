package com.acception.cadastro.enums

public enum StatusLancamento {
    ABERTO('Aberto'),
    VENCIDO('Vencido'),
    BAIXADO('Baixado'),
    SUSPENSO('Suspenso'),
    CANCELADO('Cancelado'),
    ABONADO('Abonado')


    String nome

    StatusLancamento(nome) {
        this.nome=nome
    }

    static def list() {
        [ABERTO,VENCIDO,BAIXADO,SUSPENSO,CANCELADO,ABONADO]
    }

    static def listCancelados() {
        [CANCELADO,SUSPENSO]
    }

    String getKey(){
        name()
    }
}
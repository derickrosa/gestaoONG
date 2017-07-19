package com.acception.cadastro.enums

/**
 * Created by acception on 11/05/17.
 */
enum StatusProjeto {
    EM_ANDAMENTO(descricao: 'Em andamento'),
    FINALIZADO(descricao: 'Finalizado'),
    SUSPENSO(descricao: "Suspenso"),
    CANCELADO(descricao: "Cancelado")

    String descricao

    @Override
    String toString() {
        descricao
    }

}
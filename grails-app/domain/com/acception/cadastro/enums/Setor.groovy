package com.acception.cadastro.enums

/**
 * Created by derick on 11/05/17.
 */
enum Setor {
    TECNICO(descricao: 'Técnico'),
    ADMINISTRATIVO(descricao: 'Administrativo')

    String descricao

    @Override
    String toString() {
        descricao
    }
}
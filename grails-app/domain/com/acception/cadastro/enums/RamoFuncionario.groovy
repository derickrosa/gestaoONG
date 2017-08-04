package com.acception.cadastro.enums

/**
 * Created by acception on 20/06/17.
 */
enum RamoFuncionario {
    TECNICO(descricao: 'Técnico'),
    ADMINISTRATIVO(descricao: 'Administrativo')

    String descricao

    @Override
    String toString() {
        descricao
    }
}
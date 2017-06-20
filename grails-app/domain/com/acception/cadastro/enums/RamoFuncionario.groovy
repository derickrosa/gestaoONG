package com.acception.cadastro.enums

/**
 * Created by acception on 20/06/17.
 */
enum RamoFuncionario {
    ADMINISTRATIVO(descricao: 'Administrativo'),
    FINANCEIRO(descricao: 'Financeiro'),
    CONTABIL(descricao: 'Contábil')

    String descricao

    @Override
    String toString() {
        descricao
    }
}
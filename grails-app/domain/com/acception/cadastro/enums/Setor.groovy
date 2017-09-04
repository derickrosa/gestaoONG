package com.acception.cadastro.enums

/**
 * Created by derick on 11/05/17.
 */
enum Setor {
    PUBLICO(descricao: 'Público'),
    PRIVADO(descricao: 'Privado')

    String descricao

    @Override
    String toString() {
        descricao
    }

    String getKey(){
        name()
    }
}
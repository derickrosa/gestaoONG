package com.acception.cadastro

/**
 * Created by derick on 05/07/17.
 */
class TipoAjuste {
    String id
    String nome
    String descricao

    static constraints = {
        descricao nullable:true
    }
    static mapping = {
        id generator: 'assigned', type: 'string'
        descricao type:'text'
    }

    String toString() {
        nome
    }


    static TipoAjuste getAJUSTE_DEBITO() {
        TipoAjuste.get('AJUSTE_DEBITO')
    }
    static TipoAjuste getAJUSTE_CREDITO() {
        TipoAjuste.get('AJUSTE_CREDITO')
    }
}

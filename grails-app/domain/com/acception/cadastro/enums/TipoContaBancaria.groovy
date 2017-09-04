package com.acception.cadastro.enums

/**
 * Created by acception on 27/06/17.
 */
enum TipoContaBancaria {
    CONTA_CORRENTE_INDIVIDUAL('Conta Corrente Individual', 1, true, 1),
    CONTA_POUPANCA_INDIVIDUAL('Conta Poupança Individual', 2, true, 2),
    CONTA_DEPOSITO_JUDICIAL_INDIVIDUAL('Conta Depósito Judicial Individual', 3, false, 1),
    CONTA_CORRENTE_CONJUNTA('Conta Corrente Conjunta', 11, true, 1),
    CONTA_POUPANCA_CONJUNTA('Conta Poupança Conjunta', 12, true, 2),
    CONTA_DEPOSITO_JUDICIAL_CONJUNTA('Conta Depósito Judicial Conjunta', 13, false, 1)

    String nome
    Integer codigo
    boolean ativo
    Integer tipoContaFornecedor

    TipoContaBancaria(nome,codigo,ativo,tipoContaFornecedor) {
        this.nome=nome
        this.codigo=codigo
        this.ativo=ativo
        this.tipoContaFornecedor=tipoContaFornecedor
    }

    String getKey(){
        name()
    }
}
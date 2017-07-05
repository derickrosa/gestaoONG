package com.acception.cadastro

import com.acception.cadastro.enums.Lancamento
import com.acception.cadastro.enums.TipoDespesa

class Despesa {

    TipoDespesa tipoDespesa
    Fornecedor fornecedor
    Atividade atividade


    Double valor
    Date data
    String descricao
    Funcionario funcionario

    static hasMany = [lancamentos: Lancamento]
    static belongsTo = [centroCusto: CentroCusto]

    static constraints = {
        fornecedor nullable: true
        atividade nullable: true
        lancamentos nullable: true
        funcionario nullable: true
    }
}

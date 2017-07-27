package com.acception.cadastro

import com.acception.cadastro.Lancamento
import com.acception.cadastro.enums.TipoDespesa

class Despesa {

    TipoDespesa tipoDespesa
    Fornecedor fornecedor
    Atividade atividade
    Double valor
    Date data
    String descricao
    Funcionario funcionario
    Boolean parcelado = false

    String codigo

    static hasMany = [lancamentos: Lancamento]
    static belongsTo = [centroCusto: CentroCusto]

    static constraints = {
        fornecedor nullable: true
        atividade nullable: true
        lancamentos nullable: true
        funcionario nullable: true
    }
}

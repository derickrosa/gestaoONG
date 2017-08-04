package com.acception.cadastro

import com.acception.cadastro.Lancamento
import com.acception.cadastro.enums.TipoDespesa

class Despesa extends EventoFinanceiro{
    TipoDespesa tipoDespesa
    Atividade atividade

    static constraints = {
        atividade nullable: true
    }
}

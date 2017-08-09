package com.acception.cadastro

import com.acception.cadastro.enums.StatusAdiantamento

class Adiantamento extends EventoFinanceiro {

    Lancamento lancamentoOriginal
    StatusAdiantamento statusAdiantamento = StatusAdiantamento.EM_ABERTO

    static hasMany = [resumosViagem:ResumoViagem]

    static constraints = {
        lancamentoOriginal nullable: false
    }
}

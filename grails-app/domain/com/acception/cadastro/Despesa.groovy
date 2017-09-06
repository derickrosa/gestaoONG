package com.acception.cadastro

import com.acception.cadastro.enums.TipoDespesa

class Despesa extends EventoFinanceiro {
    TipoDespesa tipoDespesa
    Atividade atividade

    static belongsTo = [itemOrcamentario: ItemOrcamentario]

    static constraints = {
        tipoDespesa nullable: false
        atividade nullable: true
    }

    def getLancamento() {
        return Lancamento.createCriteria().get {
            eventoFinanceiro {
                idEq(this.id)
            }
        }
    }
}

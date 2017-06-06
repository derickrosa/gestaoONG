package com.acception.cadastro

import com.acception.cadastro.enums.StatusAtividade
import com.acception.cadastro.enums.TipoAtividade

class Atividade {
    String nome
    String descricao
    StatusAtividade status = StatusAtividade.NAO_INICIADA
    CentroCusto centroCusto

    String objetivo
    TipoAtividade tipo

    Date inicio
    Date termino
    String periodo
    Atividade atividade

    Cidade municipio
    String local

    static hasMany=[anexos:Anexo, linhas:LinhaAcao, despesas:Despesa]
    static belongsTo = [LinhaAcao, CentroCusto]
    static constraints = {
        nome maxSize:100
        anexos nullable: true
        descricao nullable: true
        despesas nullable: true
        atividade nullable: true
    }

    List<Atividade> getSubAtividades() {
        Atividade.findAllByAtividade(this)
    }

    String toString() {
        "${nome + '[' + status+']'}"
    }
}

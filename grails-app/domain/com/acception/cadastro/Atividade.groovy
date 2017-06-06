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

    Estado estado
    Cidade municipio
    String local

    static hasMany=[anexos:Anexo, linhas:LinhaAcao, despesas:Despesa]
    static belongsTo = [LinhaAcao, CentroCusto]
    static constraints = {
        nome maxSize:100
        anexos nullable: true
        descricao nullable: true
        despesas nullable: true
        status nullable: true
        centroCusto nullable: true
        tipo nullable: true
        inicio nullable: true
        termino nullable: true
        periodo nullable: true
        atividade nullable: true
        estado nullable: true
        municipio nullable: true
        anexos nullable: true
        linhas nullable: true
        despesas nullable: true
    }

    static mapping = {
        objetivo type: 'text'
        descricao type: 'text'
    }

    List<Atividade> getSubAtividades() {
        Atividade.findAllByAtividade(this)
    }

    String toString() {
        "${nome + '[' + status+']'}"
    }
}

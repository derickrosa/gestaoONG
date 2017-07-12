package com.acception.cadastro

import com.acception.cadastro.enums.StatusAtividade
import com.acception.cadastro.enums.TipoAtividade

class Atividade {
    static auditable = true

    String codigo
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

    static hasMany=[arquivos:Arquivo, linhas:LinhaAcao, despesas:Despesa, relatorios:RelatorioAtividade]
    static belongsTo = [LinhaAcao, CentroCusto]
    static constraints = {
        nome maxSize:100
        arquivos nullable: true
        descricao nullable: true
        despesas nullable: true
        status nullable: true
        centroCusto nullable: false
        tipo nullable: true
        inicio nullable: true
        termino nullable: true
        periodo nullable: true
        atividade nullable: true
        estado nullable: true
        municipio nullable: true
        linhas nullable: true
        despesas nullable: true
        relatorios nullable: true
    }

    static mapping = {
        objetivo type: 'text'
        descricao type: 'text'
    }

    List<Atividade> getSubAtividades() {
        Atividade.findAllByAtividade(this)
    }

    def beforeInsert() {
        if (!inicio) {
            inicio = new Date()
        }

        if (!codigo) {
            codigo = inicio[Calendar.YEAR] + sprintf('%06d', Atividade.count())
        }
    }

    String toString() {
        "${nome + ' [' + status+']'}"
    }
}

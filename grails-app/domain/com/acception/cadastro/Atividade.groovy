package com.acception.cadastro

import com.acception.cadastro.enums.StatusAtividade
import com.acception.cadastro.enums.TipoAtividade
import com.acception.util.Util

class Atividade {
    static auditable = true

    String codigo
    String nome
    String nomeNormalizado
    String descricao
    StatusAtividade status = StatusAtividade.NAO_INICIADA
    Integer modulo
    Double valorPlanejado

    CentroCusto centroCusto

    String objetivo
    TipoAtividade tipo

    Date inicio
    Date termino
    Atividade atividade

    Estado estado
    Cidade municipio
    String local

    static hasMany = [arquivos: Arquivo, linhas: LinhaAcao, despesas: Despesa, relatorios: RelatorioAtividade]
    static belongsTo = [LinhaAcao, CentroCusto]
    static transients = ['periodo', 'subAtividades']

    static constraints = {
        nome maxSize: 100
        nomeNormalizado nullable: true
        arquivos nullable: true
        descricao nullable: true
        despesas nullable: true
        status nullable: true
        centroCusto nullable: true
        tipo nullable: true
        inicio nullable: true
        termino nullable: false
        periodo nullable: true
        atividade nullable: true
        estado nullable: true
        municipio nullable: true
        despesas nullable: true
        relatorios nullable: true
        modulo nullable: true
        valorPlanejado nullable: true
    }

    void setNome(String nome) {
        this.nome = nome
        this.nomeNormalizado = Util.normalizar(this.nome)
    }

    static mapping = {
        objetivo type: 'text'
        descricao type: 'text'
        sort: "nome"
    }

    List<Atividade> getSubAtividades() {
        Atividade.findAllByAtividade(this)
    }

    def getPeriodo() {
        def periodo

        def date1 = Util.truncDate(this.inicio)
        def date2 = Util.truncDate(this.termino)

        use(groovy.time.TimeCategory) {
            periodo = date2 - date1
        }

        periodo
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
        "${nome + ' [' + status + ']'}"
    }

    def isSubatividade() {
        if (this.atividade)
            true
        else
            false
    }
}

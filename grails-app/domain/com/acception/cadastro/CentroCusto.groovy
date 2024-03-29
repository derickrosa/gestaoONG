package com.acception.cadastro

import com.acception.cadastro.enums.StatusLancamento
import com.acception.cadastro.enums.StatusProjeto
import com.acception.cadastro.enums.TipoLancamento
import com.acception.util.Util

class CentroCusto {

    String codigo
    String nome
    String nomeNormalizado
    String descricao
    Integer ano
    Date dateCreated
    Date dataInicio
    Date dataFinal

    Anexo planoDeTrabalho
    Responsavel responsavel
    StatusProjeto statusProjeto
    ContaBancaria contaBancaria

    static hasMany = [atividades : Atividade,
                      arquivos   : Arquivo,
                      orcamentos : Orcamento,
                      lancamentos: Lancamento]

    static belongsTo = [financiador: Financiador]

    static transients = ['saldo', 'saldoInicial', 'orcamentoAtual', 'orcamentoOriginal', 'despesas', 'funcionarios', 'valorTotalDespesas', 'valorTotalEntradas']

    static constraints = {
        dataInicio nullable: true
        dataFinal nullable: true
        planoDeTrabalho nullable: true
        atividades nullable: true
        arquivos nullable: true
        responsavel nullable: true
        statusProjeto nullable: true
        nomeNormalizado unique: true
    }

    static mapping = {
        sort "nome"
    }

    void setNome(String nome) {
        if (nome != null) {
            this.nome = nome
            this.nomeNormalizado = Util.normalizar(this.nome)
        }
    }

    Double getSaldo() {
        Double despesas = Math.abs(this.valorTotalDespesas)
        Double entradas = this.valorTotalEntradas

        return entradas - despesas
    }

    def getSaldoInicial() {
        return this.lancamentos.find { it.descricao == 'Saldo Inicial' }?.valor ?: 0
    }

    def getOrcamentoOriginal() {
        return orcamentos?.min { it.dateCreated }
    }

    def getOrcamentoAtual() {
        return orcamentos?.max { it.dateCreated }
    }

    def getDespesas() {
        return orcamentos.itensOrcamentarios.despesas.flatten()
    }

    def getFuncionarios() {
        return orcamentos.itensOrcamentarios.salariosFuncionarios.collect { it.funcionario }.flatten().unique()
    }

    Double getValorTotalDespesas() {
        return Lancamento.createCriteria().list {
            eq('centroCusto', this)
            eq('statusLancamento', StatusLancamento.BAIXADO)
            eq('tipoLancamento', TipoLancamento.DEBITO)

            projections {
                sum "valor"
            }
        }[0] as Double ?: 0D
    }

    Double getValorTotalEntradas() {
        return Lancamento.createCriteria().list {
            eq('centroCusto', this)
            eq('statusLancamento', StatusLancamento.BAIXADO)
            eq('tipoLancamento', TipoLancamento.CREDITO)

            projections {
                sum "valor"
            }
        }[0] as Double ?: 0D
    }

    String toString() {
        "(${codigo}) ${nome}/${ano}"
    }
}

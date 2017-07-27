package com.acception.cadastro

import com.acception.cadastro.Despesa
import com.acception.cadastro.Pagamento
import com.acception.cadastro.TipoAjuste
import com.acception.cadastro.enums.StatusLancamento
import com.acception.cadastro.enums.TipoLancamento


class Lancamento {

    Date dateCreated
    Date lastUpdated

    Double valor
    String numeroTitulo
    Date dataEmissao



    TipoLancamento tipoLancamento
    StatusLancamento statusLancamento = StatusLancamento.ABERTO
    String descricao
    String codigoLancamento


    Date dataPagamentoPrevista
    Date dataPagamento
    Date dataPagamentoOriginal
    Date dataAbono
    Double valorBruto

    Integer parcela
    Pagamento pagamento
    TipoAjuste tipoAjuste

    Despesa despesa

    static belongsTo = [centroCusto: CentroCusto]

    static constraints = {
        dataPagamento nullable:true
        dataAbono nullable: true
        pagamento nullable:true
        valorBruto  nullable:true
        parcela nullable:true
        tipoAjuste nullable:true
        dataPagamentoOriginal nullable:true
        despesa nullable:true
        descricao nullable: true
        codigoLancamento nullable: true
    }


    static mapping = {
        table 'lancamento';
        id generator: 'sequence', params: [sequence: 'lancamento_seq']
        statusLancamento index: 'idx_lancto_statusLanc'
    }

    String toString() {
        def df=new java.text.SimpleDateFormat('dd/MM/yyyy')
        "${this.tipoLancamento} #${this.id} ST: ${this.statusLancamento} VL: ${this.valor} PC: ${this.parcela} DE: ${df.format(this.dataEmissao)}"
    }




}

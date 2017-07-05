package com.acception.cadastro.enums

import com.acception.cadastro.Despesa
import com.acception.cadastro.Pagamento
import com.acception.cadastro.TipoAjuste

class Lancamento {

    Date dateCreated
    Date lastUpdated
    Double valor
    Date dataEmissao



    TipoLancamento tipoLancamento
    StatusLancamento statusLancamento = StatusLancamento.ABERTO
    String descricao
    String codigoLancamento



    //LancamentoConta lancamentoOriginal

    Date dataPagamentoPrevista
    Date dataPagamento
    Date dataPagamentoOriginal
    Date dataAbono
    Double valorBruto

    Integer parcela
    Pagamento pagamento
    TipoAjuste tipoAjuste

    Despesa despesa

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
        "${this.tipoLancamento} #${this.id} ST: ${this.statusLancamento} VL: ${this.valor} PC: ${this.parcela} DT.P: ${df.format(this.dataPagamentoPrevista)}"
    }




}

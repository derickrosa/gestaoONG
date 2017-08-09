package com.acception.cadastro


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
    Date dataPagamento
    Date dataCancelamento
    String codigoLancamento
    Anexo documento
    Papel papel
    Integer parcela

    TipoAjuste tipoAjuste

    EventoFinanceiro eventoFinanceiro

    static belongsTo = [centroCusto: CentroCusto]

    static constraints = {
        valor nullable:true
        numeroTitulo nullable:true
        descricao nullable:true
        tipoLancamento nullable:true
        papel nullable:true
        statusLancamento nullable:true
        dataEmissao nullable:true
        dataPagamento nullable:true
        dataCancelamento nullable: true
        parcela nullable:true
        tipoAjuste nullable:true
        descricao nullable: true
        codigoLancamento nullable: true
        numeroTitulo nullable: false
        eventoFinanceiro nullable: true
        documento nullable: true
    }


    static mapping = {
        table 'lancamento';
        id generator: 'sequence', params: [sequence: 'lancamento_seq']
        statusLancamento index: 'idx_lancto_statusLanc'
    }

    String toString() {
        def df=new java.text.SimpleDateFormat('dd/MM/yyyy')
        "${this.tipoLancamento} #${this.id} ST: ${this.statusLancamento} VL: ${this.valor} DE: ${df.format(this.dataEmissao)}"
    }




}

package com.acception.cadastro

import com.acception.cadastro.Lancamento
import com.acception.cadastro.enums.StatusPagamento
import com.acception.cadastro.enums.TipoPagamento

class Pagamento {
    Date dateCreated
    Date lastUpdated

    String numeroDocumento

    Papel papel
    Double valor

    ContaBancaria contaBancaria

    TipoPagamento tipoPagamento

    StatusPagamento statusPagamento
    List<Lancamento> lancamentos
    Date dataPagamento
    Integer numeroPagamento
    NotaFiscal notaFiscal


    static constraints = {
        numeroPagamento nullable: true
        tipoPagamento nullable: true
        contaBancaria nullable: true
        dataPagamento nullable: true
        notaFiscal nullable: true
    }
    static mapping = {
        id generator: 'sequence', params: [sequence: 'pagamento_seq']
    }
    static transients = ['lancamentos', 'lancamentosPagos']


    String toString() {
        def df = new java.text.DecimalFormat('#,##0.00')
        "$contaBancaria Val: ${df.format(valor)} [${statusPagamento.nome}]".toString()
    }

    def getLancamentosPagos() {
        Lancamento.createCriteria().list {
            eq('pagamento', this)
        }
    }
}

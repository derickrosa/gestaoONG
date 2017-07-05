package com.acception.cadastro

import com.acception.cadastro.enums.Lancamento
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
    List<Long> idsLanctos
    Date dataPagamento
    Integer numeroPagamento



    static constraints = {
        numeroPagamento nullable:true
        tipoPagamento nullable:true
        contaBancaria nullable:true
        dataPagamento nullable: true
    }
    static mapping = {
        id generator:'sequence', params:[sequence:'pagamento_seq']
    }
    static transients = ['lancamentos','idsLanctos','dadosBancarios','versoes','retornos','lancamentosPagos','localServicoBancario','numeroDocumento']
    static embedded = ['contaBancaria']

    String toString() {
        def df=new java.text.DecimalFormat('#,##0.00')
        "$contaBancaria Val: ${df.format(valor)} [${statusPagamento.nome}]".toString()
    }


    /*def setContaBancaria(ContaBancaria dados) {
        def db=new ContaBancaria()
        db.nome=dados.nome
        db.banco=dados.banco
        db.agencia=dados.agencia
        db.dvAgencia=dados.dvAgencia
        db.conta=dados.conta
        db.dvConta=dados.dvConta
        db.tipoConta=dados.tipoConta
        db.participante=dados.papel
        this.contaBancaria=db
    }*/
    def getLancamentosPagos() {
        Lancamento.createCriteria().list {
            eq('pagamento',this)
        }
    }
}

package com.acception.cadastro.enums

public enum TipoLancamento {
    DEBITO('Débito','Despesa'),
    CREDITO('Crédito','Crédito'),
    PAGAMENTO_ADIANTADO('Pagamento Adiantado')

    String nome
    String descricao

    TipoLancamento(nome,descricao=null) {
        this.nome=nome
        if (!descricao)
            this.descricao=nome
        else this.descricao=descricao
    }

    static def list() {
        [DEBITO, CREDITO, PAGAMENTO_ADIANTADO]
    }

}
package com.acception.cadastro.enums

public enum TipoLancamento {
    PAGAR('A Pagar','Venda'),
    RECEBER('A Receber','A Receber'),
    TARIFA('Tarifa','Tarifa'),
    IOF_DEVIDO('IOF Devido'),
    DESCONTO('Desconto'),
    JUROS('Juros'),
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
        [PAGAR, RECEBER, TARIFA, IOF_DEVIDO, DESCONTO, JUROS, PAGAMENTO_ADIANTADO]
    }

}
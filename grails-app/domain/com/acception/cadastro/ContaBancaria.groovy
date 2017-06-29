package com.acception.cadastro

import com.acception.cadastro.enums.TipoContaBancaria

class ContaBancaria {

    Banco banco

    String agencia
    String dvAgencia
    String conta
    String dvConta
    TipoContaBancaria tipoConta
    Double saldo

    Date dateCreated
    Date lastUpdated
    boolean active = true

    static belongsTo = [centroCusto: CentroCusto]

    static constraints = {
        agencia maxSize:10, blank:false
        dvAgencia maxSize:2, nullable:true
        conta maxSize:12, blank:false
        dvConta maxSize:2, blank:false
        tipoConta nullable:true
    }

    def toHtml() {
        """<p class='banco'>Banco: ${banco.codigo} - ${banco.nome}</p>
      <p class="agencia">Agência: ${agencia}${dvAgencia? '-'+dvAgencia : ''}<p>
      <p class="conta">Conta: ${conta} - ${dvConta}</p>
      """
    }
    String toString() {
        "[${banco.codigo}] ${banco.nome} - AG.: ${agencia}${dvAgencia ? '-'+dvAgencia : '' } CC: ${conta}-${dvConta}".toString()
    }
}

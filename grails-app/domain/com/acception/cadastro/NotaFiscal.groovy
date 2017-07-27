package com.acception.cadastro

class NotaFiscal {
    String numeroDocumento
    Anexo anexo
    Double valor

    //static belongsTo = [pagamento: Pagamento]

    static constraints = {
        anexo nullable:true
    }
}

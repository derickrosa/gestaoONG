package com.acception.cadastro

import com.acception.util.Util

class PessoaJuridica extends Participante {
    String cnpj
    String razaoSocial

    String toString() {
        return "${nome} ${this.cnpj ? ' (' + this.cnpj + ')' : ''}"
    }

    def setCnpj(cnpj) {
        this.cnpj = Util.cnpjToRaw(cnpj)
    }

    static constraints = {
        cnpj nullable: true, maxSize: 14
    }
}
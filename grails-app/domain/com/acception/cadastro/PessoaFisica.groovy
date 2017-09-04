package com.acception.cadastro

import com.acception.util.Util

class PessoaFisica extends Participante {
    String cpf
    static constraints = {
        cpf nullable: true, maxSize: 11
    }

    def setCpf(cpf) {
        this.cpf = Util.cpfToRaw(cpf)
    }

    @Override
    String toString() {
        return "${this.nome}${this.cpf ? ' (' + this.cpf + ')' : ''}"
    }
}

package com.acception.cadastro

class PessoaFisica extends Participante {
    String cpf
    static constraints = {
        cpf nullable: true, maxSize:11
    }

    @Override
    String toString() {
        return "${this.nome}${this.cpf?' ('+this.cpf+')':''}"
    }
}

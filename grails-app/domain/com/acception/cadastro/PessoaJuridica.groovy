package com.acception.cadastro

class PessoaJuridica extends Participante{
    String cnpj
    String razaoSocial

    String toString(){
        return "${nome} ${this.cnpj?' ('+this.cnpj+')':''}"
    }

    static constraints = {
        cnpj nullable: true, maxSize:14
    }
}
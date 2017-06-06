package com.acception.cadastro

class Funcionario extends Papel {

    String cargo
    String funcao
    Double salario

    static constraints = {
    }

    String toString() {
        "${participante?.nome} (${cargo})"
    }
}

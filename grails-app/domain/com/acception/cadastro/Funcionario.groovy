package com.acception.cadastro

import com.acception.cadastro.enums.RamoFuncionario

class Funcionario extends Papel {

    String cargo
    String funcao
    Double salario
    RamoFuncionario setor

    static constraints = {
    }

    String toString() {
        "${participante?.nome} (${cargo})"
    }
}

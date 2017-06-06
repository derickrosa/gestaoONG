package com.acception.cadastro

class SalarioFuncionario {

    Funcionario funcionario
    Double valor

    static belongsTo = [itemOrcamentario: ItemOrcamentario]

    static constraints = {
    }
}

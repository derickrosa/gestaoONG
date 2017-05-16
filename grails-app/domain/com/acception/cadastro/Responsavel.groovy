package com.acception.cadastro

class Responsavel extends Papel{

    static belongsTo = [financiador:Financiador]

    static constraints = {
    }
}
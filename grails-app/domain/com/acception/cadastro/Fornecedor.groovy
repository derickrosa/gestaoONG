package com.acception.cadastro

import com.acception.cadastro.enums.Setor

class Fornecedor extends Papel{

    Setor setor
    String ramo

    static constraints = {
        ramo nullable: true, maxSize:20
    }

    String toString() {
        "${participante.nome + ' [' + ramo+']'}"
    }
}

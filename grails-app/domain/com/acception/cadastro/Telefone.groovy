package com.acception.cadastro

class Telefone {
    String ddd
    String numero
    String ramal
    String tipo

    static constraints = {
        ddd(nullable: true, maxSize: 3)
        numero(nullable: true, maxSize: 12)
        ramal(nullable: true, maxSize: 5)
        tipo(nullable: true)
    }

    String toString() {
        "${ddd ? '(' + ddd + ') ' : ''}${numero ?: ''}${ramal ? ' - ' + ramal : ''}"
    }

    String toRaw() {
        "${ddd ? '(' + ddd + ') ' : ''}${numero ?: ''}${ramal ? ' - ' + ramal : ''}"
    }

    def isEqual(tel) {
        if (!tel) return false
        else return (tel.ddd == this.ddd && tel.numero == this.numero && tel.tipo == this.tipo)
    }
}

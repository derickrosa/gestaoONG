package com.acception.security

class Role implements Serializable {

    private static final long serialVersionUID = 1

    String authority
    String nome
    String descricao
    int nivelAcesso

    Role(String authority) {
        this.authority = authority
    }

    @Override
    int hashCode() {
        authority?.hashCode() ?: 0
    }

    @Override
    boolean equals(other) {
        is(other) || (other instanceof Role && other.authority == authority)
    }

    @Override
    String toString() {
        authority
    }

    static constraints = {
        authority blank: false, unique: true
        nome nullable: false, blank: false
        descricao nullable: true, blank: true
        nivelAcesso nullable: false
    }

    static mapping = {
        cache true
    }

    static namedQueries = {
        porNivelAcesso {
			order('nivelAcesso')
        }
    }
}

package com.acception.cadastro

class Arquivo {
    byte[] bytes
    String contentType
    String fileName
    Long size

    static constraints = {
        bytes nullable: true
        contentType nullable: true
        fileName nullable: true
        size nullable: true
    }
}

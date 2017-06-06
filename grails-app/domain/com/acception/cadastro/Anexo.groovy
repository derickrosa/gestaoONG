package com.acception.cadastro

import com.acception.cadastro.enums.TipoLinkArquivo
import org.springframework.web.multipart.commons.CommonsMultipartFile

class Anexo {

    String nome
    String descricao
    String formato
    byte[] filedata
    TipoLinkArquivo tipo
    Date uploadDate = new Date()

    Anexo(CommonsMultipartFile file) {
        this.nome = file.getOriginalFilename()
        this.formato = file.getContentType()
        this.filedata = file.getBytes()
    }

    static constraints = {
        descricao nullable: true
        formato nullable: true
        filedata blank: true, nullable:true, maxSize:1073741824
    }

    String toString(){
        "Anexo | ${nome}"
    }
}

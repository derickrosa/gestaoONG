package com.acception.cadastro

class ArquivoRelatorioAtividade {
    String filename
    byte[] filedata
    Date uploadDate = new Date()

    String nomeAtividade

    static belongsTo = [relatorio: RelatorioAtividade]

    static constraints = {
        filename(blank:true,nullable:true)
        relatorio(nullable:true)
        filedata(blank: true, nullable:true, maxSize:1073741824)
        nomeAtividade nullable: true
    }
}

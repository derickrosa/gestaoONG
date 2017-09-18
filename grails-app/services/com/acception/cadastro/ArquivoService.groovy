package com.acception.cadastro

import grails.transaction.Transactional

@Transactional
class ArquivoService {

    Arquivo save(Atividade atividade, byte[] bytes, String type, Long size, String fileName) {
        Arquivo arquivo = new Arquivo(bytes: bytes, contentType: type, size: size, fileName: fileName)
        arquivo.save()
        atividade.addToArquivos(arquivo)

        arquivo
    }

    void delete(Arquivo arquivo) {
        List<Atividade> atividadeList = Atividade.createCriteria().list {
            arquivos {
                idEq(arquivo.id)
            }
        }

        atividadeList.each { atividade ->
            atividade.removeFromArquivos(arquivo)
            atividade.save()
        }

        arquivo.delete()
    }
}

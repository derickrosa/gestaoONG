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

    Arquivo save(CentroCusto centroCusto, byte[] bytes, String type, Long size, String fileName) {
        Arquivo arquivo = new Arquivo(bytes: bytes, contentType: type, size: size, fileName: fileName)
        arquivo.save()
        centroCusto.addToArquivos(arquivo)

        arquivo
    }

    void delete(Arquivo arquivo) {

        Closure criteria = {
            arquivos {
                idEq(arquivo.id)
            }
        }

        List<Atividade> atividadeList = Atividade.createCriteria().list(criteria)
        List<CentroCusto> centroCustoList = CentroCusto.createCriteria().list(criteria)

        atividadeList.each { atividade ->
            atividade.removeFromArquivos(arquivo)
            atividade.save()
        }
        centroCustoList.each { centroCusto ->
            centroCusto.removeFromArquivos(arquivo)
            centroCusto.save()
        }

        arquivo.delete()
    }
}

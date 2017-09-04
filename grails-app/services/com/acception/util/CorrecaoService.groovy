package com.acception.util

import com.acception.cadastro.Atividade
import com.acception.cadastro.Banco
import com.acception.cadastro.CentroCusto
import com.acception.cadastro.Cidade
import com.acception.cadastro.LinhaAcao
import com.acception.cadastro.Participante
import grails.transaction.Transactional

@Transactional
class CorrecaoService {

    void nomeNormalizado() {
        Atividade.list().each { it.nome = it.nome }
        Banco.list().each { it.nome = it.nome }
        CentroCusto.list().each { it.nome = it.nome }
        Cidade.list().each { it.nome = it.nome }
        LinhaAcao.list().each { it.nome = it.nome }
        Participante.list().each { it.nome = it.nome }
    }
}

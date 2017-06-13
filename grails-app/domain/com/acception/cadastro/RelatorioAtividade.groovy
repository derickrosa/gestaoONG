package com.acception.cadastro

class RelatorioAtividade {
    Date dateCreated
    Date lastUpdated

    String comunidadesEnvolvidas
    String totalComunidadesEnvolvidas
    String municipiosAtendidos
    String totalMunicipiosAtendidos

    Long numeroParticipantes
    Long numeroHomens
    Long numeroMulheres

    Long jovens20anos
    Long adultos29a60anos
    Long idosos60anos

    String nomeOrganizacoesEnvolvidas
    String numeroOrganizacaoEnvolvidas

    String tipoProfissao
    String tipoAtividadeExercidaAtualmente
    Long numeroQuilombolas
    Long numeroIndigenas
    String autoDeterminacaoCor

    Long autoDeterminacaoCorNegro
    Long autoDeterminacaoCorPardo
    Long autoDeterminacaoCorAmarelo
    Long autoDeterminacaoCorBranco
    Long autoDeterminacaoCorOutras

    Financiador financiador
    CentroCusto centroCusto
    String origemRecursoProjeto

    Double valorServicoesTerceirosPessoaFisica
    Double valorHospedagem
    Double valorlocacaoAuditorioSalas
    Double valorlocacaoVeiculos
    Double valorcombustivel
    Double valorAlimentacao
    Double valorPassagensAreas
    Double valorcopiasBanner
    Double valorMaterialDidaticoCosumo
    Double valorReembolsoDiario
    Double valorTotalAtividade


    static hasMany = [arquivos: ArquivoRelatorioAtividade]

    static belongsTo = [atividade: Atividade]

    static constraints = {
        dateCreated nullable: true
        lastUpdated nullable: true
        atividade nullable: true
        arquivos nullable: true
        comunidadesEnvolvidas nullable: true
        totalComunidadesEnvolvidas nullable: true
        municipiosAtendidos nullable: true
        totalMunicipiosAtendidos nullable: true

        numeroParticipantes nullable: true
        numeroHomens nullable: true
        numeroMulheres nullable: true

        jovens20anos nullable: true
        adultos29a60anos nullable: true
        idosos60anos nullable: true

        nomeOrganizacoesEnvolvidas nullable: true
        numeroOrganizacaoEnvolvidas nullable: true

        tipoProfissao nullable: true
        tipoAtividadeExercidaAtualmente nullable: true
        numeroQuilombolas nullable: true
        numeroIndigenas nullable: true

        autoDeterminacaoCor nullable: true
        autoDeterminacaoCorNegro nullable: true
        autoDeterminacaoCorPardo nullable: true
        autoDeterminacaoCorBranco nullable: true
        autoDeterminacaoCorAmarelo nullable: true
        autoDeterminacaoCorOutras nullable: true

        financiador nullable: true
        centroCusto nullable: true
        origemRecursoProjeto nullable: true

        valorServicoesTerceirosPessoaFisica nullable: true
        valorHospedagem nullable: true
        valorlocacaoAuditorioSalas nullable: true
        valorlocacaoVeiculos nullable: true
        valorcombustivel nullable: true
        valorAlimentacao nullable: true
        valorPassagensAreas nullable: true
        valorcopiasBanner nullable: true
        valorMaterialDidaticoCosumo nullable: true
        valorReembolsoDiario nullable: true
        valorTotalAtividade nullable: true
    }
}

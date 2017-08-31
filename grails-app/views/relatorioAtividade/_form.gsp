<%@ page import="com.acception.cadastro.RelatorioAtividade" %>

<div class="row">
    <div class="col-lg-12">
        <g:if test="${relatorioAtividadeInstance?.atividade?.nome}">
            <h3 class="page-header control-label well text-center" id="btn-dropdowns" style="margin: 0px 0 20px;">
                <a class="anchorjs-link "></a> Relatório de Atividade <br> <small> ${relatorioAtividadeInstance?.atividade?.nome} <br>Período: <g:formatDate date="${relatorioAtividadeInstance?.atividade?.inicio}" format="dd/MM/yyyy"/>  a <g:formatDate date="${relatorioAtividadeInstance?.atividade?.termino}" format="dd/MM/yyyy"/></small>
            </h3>
        </g:if>
        <div class="panel panel-success">

            <div class="panel-heading">
                <g:message code="projeto.informacoesGerais.label" default="Informações Gerais"/>
            </div>

            <div class="panel-body">

                %{--<g:hiddenField name="centroCusto.id" value="${centroCustoInstance?.id}"/>
                <g:hiddenField name="atividade.id" value="${atividade?.id}"/>--}%


                <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'atividade', 'error')}">
                    <label class="control-label" for="atividade">
                        <g:message code="relatorioAtividade.atividade.label" default="Atividade"/>

                    </label>
                    <g:select class="form-control" id="atividade" name="atividade.id"
                              from="${com.acception.cadastro.Atividade.list()}" optionKey="id"
                              value="${atividade ? atividade?.id : relatorioAtividadeInstance?.atividade?.id}"
                              noSelection="['null': 'Selecione uma atividade...']" required="required"/>

                </div>



                <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'comunidadesEnvolvidas', 'has-error')} ">
                    <label class="control-label" for="comunidadesEnvolvidas">
                        <g:message code="atividade.comunidadesEnvolvidas.label" default="Comunidades Envolvidas"/>

                    </label>
                    <g:textArea class="form-control" name="comunidadesEnvolvidas"
                                value="${relatorioAtividadeInstance?.comunidadesEnvolvidas}"/>

                </div>

                <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'totalComunidadesEnvolvidas', 'has-error')} ">
                    <label class="control-label" for="totalComunidadesEnvolvidas">
                        <g:message code="atividade.totalComunidadesEnvolvidas.label" default="Total Comunidades Envolvidas"/>

                    </label>

                    <g:textField class="form-control" name="totalComunidadesEnvolvidas"
                                 value="${relatorioAtividadeInstance?.totalComunidadesEnvolvidas}"/>

                </div>

                <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'municipiosAtendidos', 'has-error')} ">
                    <label class="control-label" for="municipiosAtendidos">
                        <g:message code="atividade.municipiosAtendidos.label" default="Municípios Atendidos"/>

                    </label>
                    <g:textArea class="form-control" name="municipiosAtendidos"
                                value="${relatorioAtividadeInstance?.municipiosAtendidos}"/>

                </div>

                <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'totalMunicipiosAtendidos', 'has-error')} ">
                    <label class="control-label" for="totalMunicipiosAtendidos">
                        <g:message code="atividade.totalMunicipiosAtendidos.label" default="Total Municípios Atendidos"/>

                    </label>
                    <g:textField class="form-control" name="totalMunicipiosAtendidos"
                                 value="${relatorioAtividadeInstance?.totalMunicipiosAtendidos}"/>

                </div>

            </div>

        </div>
    </div>
</div>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-info">

            <div class="panel-heading">
                <g:message code="projeto.informacoesGerais.label" default="Informações Específicas"/>
            </div>

            <div class="panel-body">

                <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'numeroParticipantes', 'has-error')} ">
                    <label class="control-label" for="numeroParticipantes">
                        <g:message code="atividade.numeroParticipantes.label" default="Número de Participantes"/>

                    </label>
                    <g:field class="form-control" id="numeroParticipantes" name="numeroParticipantes" type="number"
                             value="${relatorioAtividadeInstance.numeroParticipantes}"/>

                </div>

                <div class="row">
                    <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'numeroHomens', 'has-error')} col-md-6">
                        <label class="control-label" for="numeroHomens">
                            <g:message code="atividade.numeroHomens.label" default="Número de Homens"/>

                        </label>
                        <g:field class="form-control" id="numeroHomens" name="numeroHomens" type="number"
                                 value="${relatorioAtividadeInstance.numeroHomens}"/>

                    </div>

                    <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'numeroMulheres', 'has-error')} col-md-6">
                        <label class="control-label" for="numeroMulheres">
                            <g:message code="atividade.numeroMulheres.label" default="Número de Mulheres"/>

                        </label>
                        <g:field class="form-control" id="numeroMulheres" name="numeroMulheres" type="number"
                                 value="${relatorioAtividadeInstance.numeroMulheres}"/>

                    </div>
                </div>

                <div class="row">
                    <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'jovens20anos', 'has-error')} col-md-4">
                        <label class="control-label" for="jovens20anos">
                            <g:message code="atividade.jovens20anos.label" default="Jovens (20 anos ou menos)"/>

                        </label>
                        <g:field class="form-control" id="jovens20anos" name="jovens20anos" type="number"
                                 value="${relatorioAtividadeInstance.jovens20anos}"/>

                    </div>

                    <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'adultos29a60anos', 'has-error')} col-md-4">
                        <label class="control-label" for="adultos29a60anos">
                            <g:message code="atividade.adultos29a60anos.label" default="Adultos (29 ate 60 anos)"/>

                        </label>
                        <g:field class="form-control" id="adultos29a60anos" name="adultos29a60anos" type="number"
                                 value="${relatorioAtividadeInstance.adultos29a60anos}"/>

                    </div>

                    <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'idosos60anos', 'has-error')} col-md-4">
                        <label class="control-label" for="idosos60anos">
                            <g:message code="atividade.idosos60anos.label" default="Idosos (60 anos ou mais)"/>

                        </label>
                        <g:field class="form-control" id="idosos60anos" name="idosos60anos" type="number"
                                 value="${relatorioAtividadeInstance.idosos60anos}"/>

                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'nomeOrganizacoesEnvolvidas', 'has-error')} ">
                    <label class="control-label" for="nomeOrganizacoesEnvolvidas">
                        <g:message code="atividade.nomeOrganizacoesEnvolvidas.label"
                                   default="Nome Organizações Envolvidas"/>

                    </label>
                    <g:textArea class="form-control" name="nomeOrganizacoesEnvolvidas"
                                value="${relatorioAtividadeInstance?.nomeOrganizacoesEnvolvidas}"/>

                </div>

                <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'numeroOrganizacaoEnvolvidas', 'has-error')} ">
                    <label class="control-label" for="numeroOrganizacaoEnvolvidas">
                        <g:message code="atividade.numeroOrganizacaoEnvolvidas.label"
                                   default="Número de Organização Envolvidas"/>

                    </label>
                    <g:textField class="form-control" name="numeroOrganizacaoEnvolvidas"
                                 value="${relatorioAtividadeInstance?.numeroOrganizacaoEnvolvidas}"/>

                </div>

                <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'tipoProfissao', 'has-error')} ">
                    <label class="control-label" for="tipoProfissao">
                        <g:message code="atividade.tipoProfissao.label" default="Tipo de Profissão"/>

                    </label>
                    <g:textArea class="form-control" name="tipoProfissao" value="${relatorioAtividadeInstance?.tipoProfissao}"/>

                </div>

                <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'tipoAtividadeExercidaAtualmente', 'has-error')} ">
                    <label class="control-label" for="tipoAtividadeExercidaAtualmente">
                        <g:message code="atividade.tipoAtividadeExercidaAtualmente.label"
                                   default="Tipo de Atividade Exercida Atualmente"/>

                    </label>
                    <g:textArea class="form-control" name="tipoAtividadeExercidaAtualmente"
                                value="${relatorioAtividadeInstance?.tipoAtividadeExercidaAtualmente}"/>

                </div>

                <div class="row">
                    <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'numeroQuilombolas', 'has-error')} col-md-6">
                        <label class="control-label" for="numeroQuilombolas">
                            <g:message code="atividade.numeroQuilombolas.label" default="Número de Quilombolas"/>

                        </label>
                        <g:field class="form-control" id="numeroQuilombolas" name="numeroQuilombolas" type="number"
                                 value="${relatorioAtividadeInstance.numeroQuilombolas}"/>

                    </div>

                    <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'numeroIndigenas', 'has-error')} col-md-6">
                        <label class="control-label" for="numeroIndigenas">
                            <g:message code="atividade.numeroIndigenas.label" default="Número de Indígenas"/>

                        </label>
                        <g:field class="form-control" id="numeroIndigenas" name="numeroIndigenas" type="number"
                                 value="${relatorioAtividadeInstance.numeroIndigenas}"/>

                    </div>
                </div>

                <div class="row">
                    <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'autoDeterminacaoCorNegro', 'has-error')} col-md-4">
                        <label class="control-label" for="autoDeterminacaoCor">
                            <g:message code="atividade.autoDeterminacaoCor.label" default="Auto Determinação de Cor (Negro)"/>

                        </label>
                        <g:field class="form-control" name="autoDeterminacaoCorNegro" type="number"
                                 value="${relatorioAtividadeInstance?.autoDeterminacaoCorNegro}"/>
                    </div>

                    <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'autoDeterminacaoCorPardo', 'has-error')} col-md-4">
                        <label class="control-label" for="autoDeterminacaoCor">
                            <g:message code="atividade.autoDeterminacaoCor.label" default="Auto Determinação de Cor (Pardo)"/>

                        </label>
                        <g:field class="form-control" name="autoDeterminacaoCorPardo" type="number"
                                 value="${relatorioAtividadeInstance?.autoDeterminacaoCorPardo}"/>
                    </div>

                    <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'autoDeterminacaoCorAmarelo', 'has-error')} col-md-4">
                        <label class="control-label" for="autoDeterminacaoCor">
                            <g:message code="atividade.autoDeterminacaoCor.label" default="Auto Determinação de Cor (Moreno(a))"/>

                        </label>
                        <g:field class="form-control" name="autoDeterminacaoCorAmarelo" type="number"
                                 value="${relatorioAtividadeInstance?.autoDeterminacaoCorAmarelo}"/>
                    </div>
                </div>

                <div class="row">

                    <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'autoDeterminacaoCorBranco', 'has-error')} col-md-6">
                        <label class="control-label" for="autoDeterminacaoCor">
                            <g:message code="atividade.autoDeterminacaoCor.label" default="Auto Determinação de Cor (Branco)"/>

                        </label>
                        <g:field class="form-control" name="autoDeterminacaoCorBranco" type="number"
                                 value="${relatorioAtividadeInstance?.autoDeterminacaoCorBranco}"/>
                    </div>

                    <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'autoDeterminacaoCorOutras', 'has-error')} col-md-6">
                        <label class="control-label" for="autoDeterminacaoCor">
                            <g:message code="atividade.autoDeterminacaoCor.label" default="Auto Determinação de Cor (Outras)"/>

                        </label>
                        <g:field class="form-control" name="autoDeterminacaoCorOutras" type="number"
                                 value="${relatorioAtividadeInstance?.autoDeterminacaoCorOutras}"/>
                    </div>
                    <div class="col-md-12 ">
                    </div>


                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">

            <div class="panel-heading">
                <g:message code="projeto.informacoesGerais.label" default="INFORMAÇÕES FINANCEIRAS"/>
            </div>

            <div class="panel-body">

                <div class="row">
                    <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'financiador', 'has-error')} col-md-8">
                        <label class="control-label" for="financiador">
                            <g:message code="relatorioAtividade.financiador.label" default="Financiador"/>

                        </label>
                        <g:select class="form-control" id="financiador" name="financiador.id"
                                  from="${com.acception.cadastro.Financiador.list()}" optionKey="id"
                                  value="${financiador ? financiador?.id : relatorioAtividadeInstance?.financiador?.id}"
                                  noSelection="['null': 'Selecione um financiador...']" required="required"/>

                    </div>

                    <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'centroCusto', 'has-error')} col-md-4">
                        <label class="control-label" for="centroCusto">
                            <g:message code="relatorioAtividade.centroCusto.label" default="Centro Custo"/>

                        </label>
                        <g:select class="form-control" id="centroCusto" name="centroCusto.id"
                                  from="${com.acception.cadastro.CentroCusto.list()}" optionKey="id"
                                  value="${centroCusto ? centroCusto?.id : relatorioAtividadeInstance?.centroCusto?.id}"
                                  noSelection="['': 'Selecione Centro de Custo...']" required="required"/>
                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'origemRecursoProjeto', 'has-error')} ">
                    <label class="control-label" for="origemRecursoProjeto">
                        <g:message code="atividade.origemRecursoProjeto.label"
                                   default="Descrição da Origem do Recurso do Projeto"/>

                    </label>
                    <g:textArea class="form-control" name="origemRecursoProjeto"
                                value="${relatorioAtividadeInstance?.origemRecursoProjeto}"/>

                </div>


                %{--<div class="row">
                    <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'valorServicoesTerceirosPessoaFisica', 'has-error')} col-md-4">
                        <label class="control-label" for="valorServicoesTerceirosPessoaFisica">
                            <g:message code="atividade.valorServicoesTerceirosPessoaFisica.label"
                                       default="\$ SERVIÇOS DE TERCEIROS/PESSOA FÍSICA"/>

                        </label>
                        <g:textField class="form-control currency" id="valorServicoesTerceirosPessoaFisica"
                                     name="valorServicoesTerceirosPessoaFisica"
                                     value="${formatNumber(number: relatorioAtividadeInstance.valorServicoesTerceirosPessoaFisica, format: '#,##0.00')}" onkeyup="sum();"/>

                    </div>

                    <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'valorHospedagem', 'has-error')} col-md-4">
                        <label class="control-label" for="valorHospedagem">
                            <g:message code="atividade.valorHospedagem.label" default="\$ HOSPEDAGEM"/>

                        </label>
                        <g:textField class="form-control currency" id="valorHospedagem" name="valorHospedagem"
                                     value="${formatNumber(number: relatorioAtividadeInstance.valorHospedagem, format: '#,##0.00')}" onkeyup="sum();"/>

                    </div>

                    <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'valorlocacaoAuditorioSalas', 'has-error')} col-md-4">
                        <label class="control-label" for="valorlocacaoAuditorioSalas">
                            <g:message code="atividade.valorlocacaoAuditorioSalas.label"
                                       default="\$ LOCAÇÃO DE AUDITÓRIO/SALAS"/>

                        </label>
                        <g:textField class="form-control currency" id="valorlocacaoAuditorioSalas"
                                     name="valorlocacaoAuditorioSalas"
                                     value="${formatNumber(number: relatorioAtividadeInstance.valorlocacaoAuditorioSalas, format: '#,##0.00')}" onkeyup="sum();"/>

                    </div>
                </div>

                <div class="row">
                    <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'valorlocacaoVeiculos', 'has-error')} col-md-4">
                        <label class="control-label" for="valorlocacaoVeiculos">
                            <g:message code="atividade.valorlocacaoVeiculos.label" default="\$ Locação de Veículos"/>

                        </label>
                        <g:textField class="form-control currency" id="valorlocacaoVeiculos" name="valorlocacaoVeiculos"
                                     value="${formatNumber(number: relatorioAtividadeInstance.valorlocacaoVeiculos, format: '#,##0.00')}" onkeyup="sum();"/>

                    </div>

                    <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'valorcombustivel', 'has-error')} col-md-4">
                        <label class="control-label" for="valorcombustivel">
                            <g:message code="atividade.valorcombustivel.label" default="\$ Combustível"/>

                        </label>
                        <g:textField class="form-control currency" id="valorcombustivel" name="valorcombustivel"
                                     value="${formatNumber(number: relatorioAtividadeInstance.valorcombustivel, format: '#,##0.00')}" onkeyup="sum();"/>

                    </div>

                    <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'valorAlimentacao', 'has-error')} col-md-4">
                        <label class="control-label" for="valorAlimentacao">
                            <g:message code="atividade.valorAlimentacao.label" default="\$ Alimentação"/>

                        </label>
                        <g:textField class="form-control currency" id="valorAlimentacao" name="valorAlimentacao"
                                     value="${formatNumber(number: relatorioAtividadeInstance.valorAlimentacao, format: '#,##0.00')}" onkeyup="sum();"/>

                    </div>
                </div>

                <div class="row">
                    <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'valorPassagensAreas', 'has-error')} col-md-4">
                        <label class="control-label" for="valorPassagensAreas">
                            <g:message code="atividade.valorPassagensAreas.label" default="\$ Passagens Aéreas"/>

                        </label>
                        <g:textField class="form-control currency" id="valorPassagensAreas" name="valorPassagensAreas"
                                     value="${formatNumber(number: relatorioAtividadeInstance.valorPassagensAreas, format: '#,##0.00')}" onkeyup="sum();"/>

                    </div>

                    <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'valorcopiasBanner', 'has-error')} col-md-4">
                        <label class="control-label" for="valorcopiasBanner">
                            <g:message code="atividade.valorcopiasBanner.label" default="\$ Cópias/Banner"/>

                        </label>
                        <g:textField class="form-control currency" id="valorcopiasBanner" name="valorcopiasBanner"
                                     value="${formatNumber(number: relatorioAtividadeInstance.valorcopiasBanner, format: '#,##0.00')}" onkeyup="sum();"/>

                    </div>

                    <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'valorMaterialDidaticoCosumo', 'has-error')} col-md-4">
                        <label class="control-label" for="valorMaterialDidaticoCosumo">
                            <g:message code="atividade.valorMaterialDidaticoCosumo.label"
                                       default="\$ Material Didático/Consumo"/>

                        </label>
                        <g:textField class="form-control currency" id="valorMaterialDidaticoCosumo"
                                     name="valorMaterialDidaticoCosumo"
                                     value="${formatNumber(number: relatorioAtividadeInstance.valorMaterialDidaticoCosumo, format: '#,##0.00')}" onkeyup="sum();"/>

                    </div>
                </div>

                <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'valorReembolsoDiario', 'has-error')} ">
                    <label class="control-label" for="valorReembolsoDiario">
                        <g:message code="atividade.valorReembolsoDiario.label" default="\$ Reembolso Diário"/>

                    </label>
                    <g:textField class="form-control currency" id="valorReembolsoDiario" name="valorReembolsoDiario"
                                 value="${formatNumber(number: relatorioAtividadeInstance.valorReembolsoDiario, format: '#,##0.00')}" onkeyup="sum();"/>

                </div>

                <div class="form-group ${hasErrors(bean: relatorioAtividadeInstance, field: 'valorTotalAtividade', 'has-error')} ">
                    <label class="control-label" for="valorTotalAtividade">
                        <g:message code="atividade.valorTotalAtividade.label" default="\$ Valor Total das Atividades"/>

                    </label>
                    <g:textField class="form-control currency" id="valorTotalAtividade" name="valorTotalAtividade"
                                 value="${formatNumber(number: relatorioAtividadeInstance.valorTotalAtividade, format: '#,##0.00')}" onkeyup="sum();"/>
                    <small class="text-muted">O valor total da atividade é calculado automaticamente com base nas entradas das outras despesas.</small>

                </div>--}%

            </div>

        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $('select').attr('disabled', 'disabled');

        var numeroArquivos = "${relatorioAtividadeInstance?.arquivos?.size()}";

        if (! numeroArquivos || numeroArquivos === '0') {
            $("#tabelaArquivos").addClass("hidden");
        }

        $('form').submit(function() {
            $('select').removeAttr('disabled');
        });
    });

    function sum() {
        var valorServicoesTerceirosPessoaFisica = document.getElementById('valorServicoesTerceirosPessoaFisica').value;
        var valorHospedagem = document.getElementById('valorHospedagem').value;
        var valorlocacaoAuditorioSalas = document.getElementById('valorlocacaoAuditorioSalas').value;
        var valorlocacaoVeiculos = document.getElementById('valorlocacaoVeiculos').value;
        var valorcombustivel = document.getElementById('valorcombustivel').value;
        var valorAlimentacao = document.getElementById('valorAlimentacao').value;
        var valorPassagensAreas = document.getElementById('valorPassagensAreas').value;
        var valorcopiasBanner = document.getElementById('valorcopiasBanner').value;
        var valorMaterialDidaticoCosumo = document.getElementById('valorMaterialDidaticoCosumo').value;
        var valorReembolsoDiario = document.getElementById('valorReembolsoDiario').value;

        var result = trataNumero(valorServicoesTerceirosPessoaFisica) + trataNumero(valorHospedagem) +
                trataNumero(valorlocacaoAuditorioSalas) + trataNumero(valorlocacaoVeiculos) +
                trataNumero(valorcombustivel) + trataNumero(valorAlimentacao) +
                trataNumero(valorPassagensAreas) + trataNumero(valorcopiasBanner) +
                trataNumero(valorMaterialDidaticoCosumo) + trataNumero(valorReembolsoDiario);

        var result = result.toFixed(2);

        if (!isNaN(result)) {
            document.getElementById('valorTotalAtividade').value = numberWithCommas(result);
        }
    }

    function numberWithCommas(x) {
        var parts = x.toString().split(".");
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ".");
        return parts.join(",");
    }

    function trataNumero(numero){
        if(numero) {
            return parseFloat(numero.replace(/[^\d,-]/g, '', '').replace(',', '.'));
        } else {
            return 0.0;
        }
    }
</script>


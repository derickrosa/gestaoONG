<%@ page import="com.acception.cadastro.RelatorioAtividade" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'relatorioAtividade.label', default: 'RelatorioAtividade')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <asset:stylesheet src="uploadfile.css"/>
    <asset:javascript src="jquery.uploadfile.min.js"/>
</head>

<body>
<div id="content">
    <div class="inner" style="min-height: 700px;">
        <div class="row">
            <div class="col-lg-12">
                <h1><g:message code="default.show.label" args="[entityName]"/></h1>
            </div>
        </div>
        <hr/>
        <!--BLOCK SECTION -->
        <div class="nav" role="navigation">
            <p>
                <g:link class="btn btn-default" action="index"><span class="glyphicon glyphicon-list"></span> <g:message
                        code="default.list.label" args="[entityName]"/></g:link>
                <g:link class="btn btn-default" action="create"><span
                        class="glyphicon glyphicon-plus"></span> <g:message code="default.new.label"
                                                                            args="[entityName]"/></g:link>
            </p>
        </div>

        <div id="show-relatorioAtividade" class="content scaffold-show" role="main">
            <g:if test="${flash.message}">
                <div class="alert alert-info" role="status">${flash.message}</div>
            </g:if>

            <br/>


            <table class="table table-bordered atividade">

                <g:if test="${relatorioAtividadeInstance?.atividade}">
                    <tr>
                        <th id="nome-label" class="property-label"><g:message code="atividade.nome.label"
                                                                              default="Atividade"/></th>

                        <td aria-labelledby="nome-label"><g:link controller="atividade" action="show"
                                                                 id="${relatorioAtividadeInstance?.atividade?.id}">${relatorioAtividadeInstance?.atividade?.nome} [${relatorioAtividadeInstance?.atividade?.status}]</g:link></td>

                    </tr>
                </g:if>
                <g:else>
                    <tr>
                        <th id="nome-label" class="property-label"><g:message code="atividade.nome.label"
                                                                              default="Nome"/></th>

                        <td aria-labelledby="nome-label">Não informado.</td>

                    </tr>
                </g:else>

                <tr>
                    <th id="nome-label" class="property-label"><g:message code="atividade.nome.label"
                                                                          default="Data de Criação do Relatório"/></th>

                    <td aria-labelledby="nome-label"><g:formatDate value="${relatorioAtividadeInstance.dateCreated}"
                                                                   format="dd/MM/yyyy"/></td>

                </tr>

            </table>

            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-success">
                        <div class="panel-heading control-label">
                            Municípios Atendidos
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">

                                <g:if test="${relatorioAtividadeInstance?.municipiosAtendidos}">
                                    <table class="table table-striped table-bordered table-hover">
                                        <tbody>
                                        <tr>
                                            <td class="col-md-12">${relatorioAtividadeInstance?.municipiosAtendidos}</td>
                                        </tr>
                                        </tbody>
                                    </table>

                                </g:if>
                                <g:else>
                                    <p>Não informados.</p>
                                </g:else>

                            </div>
                            <!-- /.table-responsive -->
                        </div>
                    <!-- /.panel-body -->
                        <g:if test="${relatorioAtividadeInstance?.totalMunicipiosAtendidos}">
                            <div class="panel-footer control-label">
                                Total de municípios atendidos: ${relatorioAtividadeInstance?.totalMunicipiosAtendidos}
                            </div>
                        </g:if>
                    </div>
                    <!-- /.panel -->
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-success">
                        <div class="panel-heading control-label">
                            Comunidades Envolvidas
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">

                                <g:if test="${relatorioAtividadeInstance?.comunidadesEnvolvidas}">
                                    <table class="table table-striped table-bordered table-hover">
                                        <tbody>
                                        <tr>
                                            <td class="col-md-12">${relatorioAtividadeInstance?.comunidadesEnvolvidas}</td>
                                        </tr>
                                        </tbody>
                                    </table>

                                </g:if>
                                <g:else>
                                    <p>Não informadas.</p>
                                </g:else>

                            </div>
                            <!-- /.table-responsive -->
                        </div>
                    <!-- /.panel-body -->
                        <g:if test="${relatorioAtividadeInstance?.totalComunidadesEnvolvidas}">
                            <div class="panel-footer control-label">
                                Total de comunidades envolvidas: ${relatorioAtividadeInstance?.totalComunidadesEnvolvidas}
                            </div>
                        </g:if>
                    </div>
                    <!-- /.panel -->
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-info">
                        <div class="panel-heading control-label">
                            Participantes</div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">

                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                    <tr style="
                                    background-color: #F6F6F6;
                                    ">
                                        <th class="text-center">Total de Participantes</th>
                                        <th class="text-center">Total de Homens</th>
                                        <th class="text-center">Total de Mulheres</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td class="text-center">${relatorioAtividadeInstance?.numeroParticipantes ?: 0}</td>
                                        <td class="text-center">${relatorioAtividadeInstance?.numeroHomens ?: 0}</td>
                                        <td class="text-center">${relatorioAtividadeInstance?.numeroMulheres ?: 0}</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                    <tr style="
                                    background-color: #F6F6F6;
                                    ">
                                        <th class="text-center">Faixas Etárias</th>
                                        <th class="text-center">Total de Indivíduos</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td class="text-center">Jovens (20 ou menos)</td>
                                        <td class="text-center">${relatorioAtividadeInstance?.jovens20anos ?: 0}</td>
                                    </tr>
                                    <tr>
                                        <td class="text-center">Adultos (29 até 60)</td>
                                        <td class="text-center">${relatorioAtividadeInstance?.adultos29a60anos ?: 0}</td>
                                    </tr>
                                    <tr>
                                        <td class="text-center">Idosos (60 ou mais)</td>
                                        <td class="text-center">${relatorioAtividadeInstance?.idosos60anos ?: 0}</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>

                            <hr/>
                            <table class="table table-bordered atividade">
                                <g:if test="${relatorioAtividadeInstance?.nomeOrganizacoesEnvolvidas}">
                                    <tr>
                                        <th id="tipoProfissao-label" class="property-label"><g:message
                                                code="atividade.tipoProfissao.label"
                                                default="Organizações Envolvidas"/></th>

                                        <td aria-labelledby="tipoProfissao-label"><g:fieldValue
                                                bean="${relatorioAtividadeInstance}"
                                                field="nomeOrganizacoesEnvolvidas"/></td>

                                    </tr>
                                </g:if>
                                <g:else>
                                    <tr>
                                        <th id="tipoProfissao-label" class="property-label"><g:message
                                                code="atividade.tipoProfissao.label"
                                                default="Organizações Envolvidas"/></th>

                                        <td aria-labelledby="tipoProfissao-label">Não informadas.</td>

                                    </tr>
                                </g:else>

                                <g:if test="${relatorioAtividadeInstance?.nomeOrganizacoesEnvolvidas}">
                                    <tr>
                                        <th id="tipoProfissao-label" class="property-label"><g:message
                                                code="atividade.tipoProfissao.label"
                                                default="Total de Organizações Envolvidas"/></th>

                                        <td aria-labelledby="tipoProfissao-label"><g:fieldValue
                                                bean="${relatorioAtividadeInstance}"
                                                field="numeroOrganizacaoEnvolvidas"/></td>

                                    </tr>
                                </g:if>
                                <g:else>
                                    <tr>
                                        <th id="tipoProfissao-label" class="property-label"><g:message
                                                code="atividade.tipoProfissao.label"
                                                default="Total de Organizações Envolvidas"/></th>

                                        <td aria-labelledby="tipoProfissao-label">Não informado.</td>

                                    </tr>
                                </g:else>

                                <g:if test="${relatorioAtividadeInstance?.tipoProfissao}">
                                    <tr>
                                        <th id="tipoProfissao-label" class="property-label"><g:message
                                                code="atividade.tipoProfissao.label" default="Tipo Profissão"/></th>

                                        <td aria-labelledby="tipoProfissao-label"><g:fieldValue
                                                bean="${relatorioAtividadeInstance}"
                                                field="tipoProfissao"/></td>

                                    </tr>
                                </g:if>
                                <g:else>
                                    <tr>
                                        <th id="tipoProfissao-label" class="property-label"><g:message
                                                code="atividade.tipoProfissao.label" default="Tipo Profissão"/></th>

                                        <td aria-labelledby="tipoProfissao-label">Não informado.</td>

                                    </tr>
                                </g:else>


                                <g:if test="${relatorioAtividadeInstance?.tipoAtividadeExercidaAtualmente}">
                                    <tr>
                                        <th id="tipoAtividadeExercidaAtualmente-label" class="property-label"><g:message
                                                code="atividade.tipoAtividadeExercidaAtualmente.label"
                                                default="Tipo Atividade Exercida Atualmente"/></th>

                                        <td aria-labelledby="tipoAtividadeExercidaAtualmente-label"><g:fieldValue
                                                bean="${relatorioAtividadeInstance}"
                                                field="tipoAtividadeExercidaAtualmente"/></td>

                                    </tr>
                                </g:if>
                                <g:else>
                                    <tr>
                                        <th id="tipoAtividadeExercidaAtualmente-label" class="property-label"><g:message
                                                code="atividade.tipoAtividadeExercidaAtualmente.label"
                                                default="Tipo Atividade Exercida Atualmente"/></th>

                                        <td aria-labelledby="tipoAtividadeExercidaAtualmente-label">Não informado.</td>

                                    </tr>
                                </g:else>

                                <g:if test="${relatorioAtividadeInstance?.numeroQuilombolas}">
                                    <tr>
                                        <th id="numeroQuilombolas-label" class="property-label"><g:message
                                                code="atividade.numeroQuilombolas.label"
                                                default="Número Quilombolas"/></th>

                                        <td aria-labelledby="numeroQuilombolas-label"><g:fieldValue
                                                bean="${relatorioAtividadeInstance}"
                                                field="numeroQuilombolas"/></td>

                                    </tr>
                                </g:if>
                                <g:else>
                                    <tr>
                                        <th id="numeroQuilombolas-label" class="property-label"><g:message
                                                code="atividade.numeroQuilombolas.label"
                                                default="Número Quilombolas"/></th>

                                        <td aria-labelledby="numeroQuilombolas-label">Não informado.</td>

                                    </tr>
                                </g:else>

                                <g:if test="${relatorioAtividadeInstance?.numeroIndigenas}">
                                    <tr>
                                        <th id="numeroIndigenas-label" class="property-label"><g:message
                                                code="atividade.numeroIndigenas.label" default="Número Indigenas"/></th>

                                        <td aria-labelledby="numeroIndigenas-label"><g:fieldValue
                                                bean="${relatorioAtividadeInstance}"
                                                field="numeroIndigenas"/></td>

                                    </tr>
                                </g:if>
                                <g:else>
                                    <tr>
                                        <th id="numeroIndigenas-label" class="property-label"><g:message
                                                code="atividade.numeroIndigenas.label" default="Número Indigenas"/></th>

                                        <td aria-labelledby="numeroIndigenas-label">Não informado.</td>

                                    </tr>
                                </g:else>

                                <g:each in="['Negro', 'Pardo', 'Amarelo', 'Branco', 'Outras']" var="cor">
                                    <tr>
                                        <th id="autoDeterminacaoCor-label" class="property-label"><g:message
                                                code="atividade.autoDeterminacaoCor.label"
                                                default="Auto Determinacao Cor (${cor.equals('Amarelo') ? 'Moreno(a)' : cor})"/></th>

                                        <td aria-labelledby="autoDeterminacaoCor-label">
                                            <g:if test="${relatorioAtividadeInstance?."autoDeterminacaoCor${cor}"}">
                                                <g:fieldValue
                                                        bean="${relatorioAtividadeInstance}"
                                                        field="autoDeterminacaoCor${cor}"/>
                                            </g:if>
                                            <g:else>
                                                Não informado.
                                            </g:else>
                                        </td>
                                    </tr>
                                </g:each>

                            </table>
                        </div>
                        <!-- /.panel-body -->

                    </div>
                    <!-- /.panel -->
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading control-label">
                            Financeiro</div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table class="table table-bordered atividade">
                                <g:if test="${relatorioAtividadeInstance?.financiador}">
                                    <tr>
                                        <th id="financiador-label" class="property-label"><g:message
                                                code="atividade.financiador.label"
                                                default="Financiador"/></th>

                                        <td aria-labelledby="financiador-label"><g:link controller="financiador"
                                                                                        action="show"
                                                                                        id="${relatorioAtividadeInstance?.financiador?.id}">${relatorioAtividadeInstance?.financiador?.encodeAsHTML()}</g:link></td>

                                    </tr>
                                </g:if>

                                <g:else>
                                    <tr>
                                        <th id="financiador-label" class="property-label"><g:message
                                                code="atividade.financiador.label"
                                                default="Financiador"/></th>

                                        <td aria-labelledby="financiador-label">Não informado.</td>

                                    </tr>
                                </g:else>

                                <g:if test="${relatorioAtividadeInstance?.centroCusto}">
                                    <tr>
                                        <th id="centroCusto-label" class="property-label"><g:message
                                                code="atividade.centroCusto.label"
                                                default="Centro Custo"/></th>

                                        <td aria-labelledby="centroCusto-label"><g:fieldValue
                                                bean="${relatorioAtividadeInstance}"
                                                field="centroCusto"/></td>

                                    </tr>
                                </g:if>

                                <g:else>
                                    <tr>
                                        <th id="centroCusto-label" class="property-label"><g:message
                                                code="atividade.centroCusto.label"
                                                default="Centro Custo"/></th>

                                        <td aria-labelledby="centroCusto-label">Não informado.</td>

                                    </tr>
                                </g:else>

                                <g:if test="${relatorioAtividadeInstance?.origemRecursoProjeto}">
                                    <tr>
                                        <th id="origemRecursoProjeto-label" class="property-label"><g:message
                                                code="atividade.origemRecursoProjeto.label"
                                                default="Origem Recurso Projeto"/></th>

                                        <td aria-labelledby="origemRecursoProjeto-label"><g:fieldValue
                                                bean="${relatorioAtividadeInstance}"
                                                field="origemRecursoProjeto"/></td>

                                    </tr>
                                </g:if>
                                <g:else>
                                    <tr>
                                        <th id="origemRecursoProjeto-label" class="property-label"><g:message
                                                code="atividade.origemRecursoProjeto.label"
                                                default="Origem Recurso Projeto"/></th>

                                        <td aria-labelledby="origemRecursoProjeto-label">Não informada.</td>

                                    </tr>
                                </g:else>
                            </table>

                            <g:set var="df" value="${new java.text.DecimalFormat('###,##0.00')}"/>
                            %{--<div class="table-responsive">
                                <table class="table table-hover">
                                    <tbody>
                                    <tr>
                                        <td class="text-left control-label"
                                            style="width: 316px;">$ Serviços de Terceiros/Pessoa Física</td>
                                        <td class="text-left">R$${df.format(relatorioAtividadeInstance?.valorServicoesTerceirosPessoaFisica ?: 0)}</td>
                                    </tr>
                                    <tr>
                                        <td class="text-left control-label" style="width: 316px;">$ Hospedagem</td>
                                        <td class="text-left">R$${df.format(relatorioAtividadeInstance?.valorHospedagem ?: 0)}</td>
                                    </tr>
                                    <tr>
                                        <td class="text-left control-label"
                                            style="width: 316px;">$ Locação de Auditório/Salas</td>
                                        <td class="text-left">R$${df.format(relatorioAtividadeInstance?.valorlocacaoAuditorioSalas ?: 0)}</td>
                                    </tr>

                                    <tr>
                                        <td class="text-left control-label"
                                            style="width: 316px;">$ Locação de Veículos</td>
                                        <td class="text-left">R$${df.format(relatorioAtividadeInstance?.valorlocacaoVeiculos ?: 0)}</td>
                                    </tr>
                                    <tr>
                                        <td class="text-left control-label" style="width: 316px;">$ Combustível</td>
                                        <td class="text-left">R$${df.format(relatorioAtividadeInstance?.valorcombustivel ?: 0)}</td>
                                    </tr>
                                    <tr>
                                        <td class="text-left control-label" style="width: 316px;">$ Alimentação</td>
                                        <td class="text-left">R$${df.format(relatorioAtividadeInstance?.valorAlimentacao ?: 0)}</td>
                                    </tr>
                                    <tr>
                                        <td class="text-left control-label"
                                            style="width: 316px;">$ Passagens Aéreas</td>
                                        <td class="text-left">R$${df.format(relatorioAtividadeInstance?.valorPassagensAreas ?: 0)}</td>
                                    </tr>
                                    <tr>
                                        <td class="text-left control-label" style="width: 316px;">$ Cópias/Banner</td>
                                        <td class="text-left">R$${df.format(relatorioAtividadeInstance?.valorcopiasBanner ?: 0)}</td>
                                    </tr>
                                    <tr>
                                        <td class="text-left control-label"
                                            style="width: 316px;">$ Material Didático/Consumo</td>
                                        <td class="text-left">R$${df.format(relatorioAtividadeInstance?.valorMaterialDidaticoCosumo ?: 0)}</td>
                                    </tr>

                                    <tr>
                                        <td class="text-left control-label"
                                            style="width: 316px;">$ Reembolso Diário</td>
                                        <td class="text-left">R$${df.format(relatorioAtividadeInstance?.valorReembolsoDiario ?: 0)}</td>
                                    </tr>
                                    <tr>
                                        <td class="text-left control-label"
                                            style="width: 316px; font-weight: bold !important;">$ Valor Total das Atividades</td>
                                        <td class="text-left"
                                            style="font-weight: bold !important;">R$${df.format(relatorioAtividadeInstance?.valorTotalAtividade ?: 0)}</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>--}%

                        </div>
                        <!-- /.panel-body -->

                    </div>
                    <!-- /.panel -->
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">

                        <div class="panel-heading">
                            <g:message code="projeto.informacoesGerais.label" default="Arquivos"/>
                        </div>

                        <div class="panel-body">
                            <div id="fileuploader">Upload</div>
                        </div>

                    </div>
                </div>
            </div>


            <g:form url="[resource: relatorioAtividadeInstance, action: 'delete']" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="btn btn-default" action="edit" resource="${relatorioAtividadeInstance}">
                        <span class="glyphicon glyphicon-edit"></span>
                        <g:message code="default.button.edit.label" default="Edit"/>
                    </g:link>
                    <button type="submit" class="btn btn-default"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
                        <span class="glyphicon glyphicon-floppy-remove"></span>
                        <g:message code="default.button.delete.label"/>
                    </button>
                </fieldset>
            </g:form>
            <br/>
        </div>
    </div>
</div>
<script>
    $(document).ready(function()
    {
        $("#fileuploader").uploadFile({
            url:"${createLink(action: 'carregarArquivo', controller: 'relatorioAtividade',id: "${relatorioAtividadeInstance.id}")}",
            fileName:"file",
            showDelete: true,
            showDownload:true,
            showPreview:true,
            previewHeight: "200px",
            previewWidth: "200px",
            statusBarWidth:'250px',
            onLoad:function(obj)
            {
                $.ajax({
                    cache: false,
                    url: "${createLink(action:'getFiles',id: "${relatorioAtividadeInstance.id}")}",
                    dataType: "json",
                    success: function(data)
                    {
                        for(var i=0;i<data.length;i++)
                        {
                            obj.createProgress(data[i].name,data[i].path,data[i].size,data[i].id);
                        }
                    }
                });
            },
            downloadCallback:function(id,pd)
            {
                location.href = "${createLink(action: 'baixarArquivo', controller: 'relatorioAtividade')}?idArquivo=" + id
            },
            deleteCallback: function (id, pd) {
                $.ajax({
                    url: "${createLink(action:'deletarArquivo',id: "${relatorioAtividadeInstance.id}")}",
                    dataType: "json",
                    data: {idArquivo:id},
                    success: function(data)
                    {
                        console.log('Documento removido...')
                    }
                });
            },
        });
    });
</script>
</body>
</html>

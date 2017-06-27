<%@ page import="com.acception.cadastro.Atividade" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'atividade.label', default: 'Atividade')}"/>
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

        <div id="show-atividade" class="content scaffold-show" role="main">
            <g:if test="${flash.message}">
                <div class="alert alert-info" role="status">${flash.message}</div>
            </g:if>

            <table class="table table-bordered atividade">

                <g:if test="${atividadeInstance?.nome}">
                    <tr>
                        <th id="nome-label" class="property-label"><g:message code="atividade.nome.label"
                                                                              default="Nome"/></th>

                        <td aria-labelledby="nome-label"><g:fieldValue bean="${atividadeInstance}" field="nome"/></td>

                    </tr>
                </g:if>

                <g:if test="${atividadeInstance?.descricao}">
                    <tr>
                        <th id="descricao-label" class="property-label"><g:message code="atividade.descricao.label"
                                                                                   default="Descricao"/></th>

                        <td aria-labelledby="descricao-label"><g:fieldValue bean="${atividadeInstance}"
                                                                            field="descricao"/></td>

                    </tr>
                </g:if>

                <g:if test="${atividadeInstance?.despesas}">
                    <tr>
                        <th id="despesas-label" class="property-label"><g:message code="atividade.despesas.label"
                                                                                  default="Despesas"/></th>

                        <g:each in="${atividadeInstance.despesas}" var="d">
                            <td aria-labelledby="despesas-label"><g:link controller="despesa" action="show"
                                                                         id="${d.id}">${d?.encodeAsHTML()}</g:link></td>
                        </g:each>

                    </tr>
                </g:if>

                <g:if test="${atividadeInstance?.atividade}">
                    <tr>
                        <th id="atividade-label" class="property-label"><g:message code="atividade.atividade.label"
                                                                                   default="Atividade"/></th>

                        <td aria-labelledby="atividade-label"><g:link controller="atividade" action="show"
                                                                      id="${atividadeInstance?.atividade?.id}">${atividadeInstance?.atividade?.encodeAsHTML()}</g:link></td>

                    </tr>
                </g:if>

                <g:if test="${atividadeInstance?.centroCusto}">
                    <tr>
                        <th id="centroCusto-label" class="property-label"><g:message code="atividade.centroCusto.label"
                                                                                     default="Centro Custo"/></th>

                        <td aria-labelledby="centroCusto-label"><g:link controller="centroCusto" action="show"
                                                                        id="${atividadeInstance?.centroCusto?.id}">${atividadeInstance?.centroCusto?.encodeAsHTML()}</g:link></td>

                    </tr>
                </g:if>

                <g:if test="${atividadeInstance?.inicio}">
                    <tr>
                        <th id="inicio-label" class="property-label"><g:message code="atividade.inicio.label"
                                                                                default="Inicio"/></th>

                        <td aria-labelledby="inicio-label"><g:formatDate date="${atividadeInstance?.inicio}"/></td>

                    </tr>
                </g:if>

                <g:if test="${atividadeInstance?.linhas}">
                    <tr>
                        <th id="linhas-label" class="property-label"><g:message code="atividade.linhas.label"
                                                                                default="Linhas"/></th>

                        <g:each in="${atividadeInstance.linhas}" var="l">
                            <td aria-labelledby="linhas-label"><g:link controller="linhaAcao" action="show"
                                                                       id="${l.id}">${l?.encodeAsHTML()}</g:link></td>
                        </g:each>

                    </tr>
                </g:if>

                <g:if test="${atividadeInstance?.local}">
                    <tr>
                        <th id="local-label" class="property-label"><g:message code="atividade.local.label"
                                                                               default="Local"/></th>

                        <td aria-labelledby="local-label"><g:fieldValue bean="${atividadeInstance}" field="local"/></td>

                    </tr>
                </g:if>

                <g:if test="${atividadeInstance?.municipio}">
                    <tr>
                        <th id="municipio-label" class="property-label"><g:message code="atividade.municipio.label"
                                                                                   default="Municipio"/></th>

                        <td aria-labelledby="municipio-label"><g:link controller="cidade" action="show"
                                                                      id="${atividadeInstance?.municipio?.id}">${atividadeInstance?.municipio?.encodeAsHTML()}</g:link></td>

                    </tr>
                </g:if>

                <g:if test="${atividadeInstance?.objetivo}">
                    <tr>
                        <th id="objetivo-label" class="property-label"><g:message code="atividade.objetivo.label"
                                                                                  default="Objetivo"/></th>

                        <td aria-labelledby="objetivo-label"><g:fieldValue bean="${atividadeInstance}"
                                                                           field="objetivo"/></td>

                    </tr>
                </g:if>

                <g:if test="${atividadeInstance?.periodo}">
                    <tr>
                        <th id="periodo-label" class="property-label"><g:message code="atividade.periodo.label"
                                                                                 default="Periodo"/></th>

                        <td aria-labelledby="periodo-label"><g:fieldValue bean="${atividadeInstance}"
                                                                          field="periodo"/></td>

                    </tr>
                </g:if>

                <g:if test="${atividadeInstance?.status}">
                    <tr>
                        <th id="status-label" class="property-label"><g:message code="atividade.status.label"
                                                                                default="Status"/></th>

                        <td aria-labelledby="status-label"><g:fieldValue bean="${atividadeInstance}"
                                                                         field="status"/></td>

                    </tr>
                </g:if>

                <g:if test="${atividadeInstance?.termino}">
                    <tr>
                        <th id="termino-label" class="property-label"><g:message code="atividade.termino.label"
                                                                                 default="Termino"/></th>

                        <td aria-labelledby="termino-label"><g:formatDate date="${atividadeInstance?.termino}"/></td>

                    </tr>
                </g:if>

                <g:if test="${atividadeInstance?.tipo}">
                    <tr>
                        <th id="tipo-label" class="property-label"><g:message code="atividade.tipo.label"
                                                                              default="Tipo"/></th>

                        <td aria-labelledby="tipo-label"><g:fieldValue bean="${atividadeInstance}" field="tipo"/></td>

                    </tr>
                </g:if>

            </table>

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

            <g:form url="[resource: atividadeInstance, action: 'delete']" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="btn btn-default" action="edit" resource="${atividadeInstance}">
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
        </div>
    </div>
</div>
<script>
    $(document).ready(function()
    {
        $("#fileuploader").uploadFile({
            url:"${createLink(action: 'carregarArquivo', controller: 'atividade',id: "${atividadeInstance.id}")}",
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
                    url: "${createLink(action:'getFiles',id: "${atividadeInstance.id}")}",
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
                location.href = "${createLink(action: 'baixarArquivo', controller: 'atividade')}?idArquivo=" + id
            },
            deleteCallback: function (id, pd) {
                $.ajax({
                    url: "${createLink(action:'deletarArquivo',id: "${atividadeInstance.id}")}",
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

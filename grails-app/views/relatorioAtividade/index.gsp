<%@ page import="com.acception.cadastro.RelatorioAtividade" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'relatorioAtividade.label', default: 'RelatorioAtividade')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
    <export:resource/>
</head>

<body>
<%
    def pars = [:]
    pageScope.variables.each { k, v ->
        if (k ==~ /search.*/ && v) pars[k] = v
    }
%>
<div id="content">
    <div class="inner" style="min-height: 700px;">
        <div class="row">
            <div class="col-lg-12">
                <h1><g:message code="default.list.label" args="[entityName]"/></h1>
            </div>
        </div>
        <hr/>
        <!--BLOCK SECTION -->

        <div class="nav" role="navigation">
            <p>
                <g:link class="btn btn-default" action="create"><span
                        class="glyphicon glyphicon-plus"></span> <g:message code="default.new.label"
                                                                            args="[entityName]"/></g:link>
            </p>
        </div>
        <br>

        <div id="list-relatorioAtividade" class="body" role="main">
            <g:if test="${flash.message}">
                <div class="alert alert-info" role="status">${flash.message}</div>
            </g:if>

            <div class="form-group">
                <g:form controller="relatorioAtividade" action="index" class="search-form">
                    <div class="form-group">
                        <g:render template="search"/>
                    </div>

                    <div class="row">
                        <button class="btn btn-default center-block search">Procurar <i class="icon-search"></i>
                        </button>
                    </div>
                </g:form>
            </div>
            <table class="table table-bordered table-striped">
                <thead>
                <tr>

                    <g:sortableColumn property="atividade"
                                      title="${message(code: 'relatorioAtividade.comunidadesEnvolvidas.label', default: 'Atividade')}"/>
                    <g:sortableColumn property="atividade"
                                      title="${message(code: 'relatorioAtividade.comunidadesEnvolvidas.label', default: 'Data de Criação do Relatório')}"/>

                    %{--  <g:sortableColumn property="municipiosAtendidos"
                                        title="${message(code: 'relatorioAtividade.totalComunidadesEnvolvidas.label', default: 'Municípios Envolvidas')}"/>

                      <g:sortableColumn property="comunidadesEnvolvidas"
                                        title="${message(code: 'relatorioAtividade.totalComunidadesEnvolvidas.label', default: 'Comunidades Atendidos')}"/>

                      <g:sortableColumn property="numeroParticipantes"
                                        title="${message(code: 'relatorioAtividade.totalComunidadesEnvolvidas.label', default: 'Total de Participantes')}"/>
  --}%
                    <g:sortableColumn property="financiador"
                                      title="${message(code: 'relatorioAtividade.municipiosAtendidos.label', default: 'Financiador')}"/>

                    <g:sortableColumn property="centroCusto"
                                      title="${message(code: 'relatorioAtividade.totalMunicipiosAtendidos.label', default: 'Centro de Custo')}"/>

                </tr>
                </thead>
                <tbody>
                <g:if test="${relatorioAtividadeInstanceList.size() > 0}">
                    <g:each in="${relatorioAtividadeInstanceList}" status="i" var="relatorioAtividadeInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td><g:link action="show"
                                        id="${relatorioAtividadeInstance.id}">${fieldValue(bean: relatorioAtividadeInstance, field: "atividade")}</g:link></td>
                            <td><g:formatDate value="${relatorioAtividadeInstance.dateCreated}"
                                              format="dd/MM/yyyy"/></td>

                            %{--                        <td>${fieldValue(bean: relatorioAtividadeInstance, field: "municipiosAtendidos")}</td>

                                                    <td>${fieldValue(bean: relatorioAtividadeInstance, field: "comunidadesEnvolvidas")}</td>

                                                    <td>${fieldValue(bean: relatorioAtividadeInstance, field: "numeroParticipantes")}</td>--}%

                            <td>${relatorioAtividadeInstance.financiador ?: 'Não informado.'}</td>

                            <td>${relatorioAtividadeInstance.centroCusto ?: 'Não informado.'}</td>

                        </tr>
                    </g:each>
                </g:if>
                <g:else>
                    <tr><td colspan="4" class="text-center nao-ha-registros">Não há registros de ${entityName}.</td>
                    </tr>
                </g:else>
                </tbody>
            </table>

            <blockquote class="relatorio">
                <p>Geração de Relatórios</p>
                <export:formats formats="['excel', 'pdf']" params="${params}"/>
            </blockquote>

            <div class="row">
                <div class="col-sm-6">
                    <div class="dataTables_info" id="dataTables-example_info" role="alert" aria-live="polite"
                         aria-relevant="all">Exibindo 1 a 20 de ${relatorioAtividadeInstanceCount == 1 ? relatorioAtividadeInstanceCount + ' relatório cadastrado' : relatorioAtividadeInstanceCount + ' relatórios cadastrados'}.</div>
                </div>

                <div class="col-sm-6">
                    <div class="pagination">
                        <g:paginate total="${relatorioAtividadeInstanceCount ?: 0}"/>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
</body>
</html>

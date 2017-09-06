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
    <p>
        <g:link class="btn btn-default" action="create">
            <span class="glyphicon glyphicon-plus"></span>
            <g:message code="default.new.label" args="[entityName]"/>
        </g:link>
    </p>

    <pesquisa:painel>
        <div class="form-group col-md-4">
            <label class="control-label" for="searchFinanciador">Atividade:</label>
            <g:select class="form-control select" from="${com.acception.cadastro.Atividade.list()}" optionKey="id"
                      name="searchAtividade" value="${searchAtividade}" noSelection="['': 'Todos']"/>
        </div>

        <div class="form-group col-md-4">
            <label class="control-label" for="searchFinanciador">Financiador:</label>
            <g:select class="form-control select" from="${com.acception.cadastro.Financiador.list()}" optionKey="id"
                      name="searchFinanciador" value="${searchFinanciador}" noSelection="['': 'Todos']"/>
        </div>

        <div class="form-group col-md-4">
            <label class="control-label" for="searchFinanciador">Centro de Custo:</label>
            <g:select class="form-control select" from="${com.acception.cadastro.CentroCusto.list()}" optionKey="id"
                      name="searchCentroCusto" value="${searchCentroCusto}" noSelection="['': 'Todos']"/>
        </div>
    </pesquisa:painel>

<g:if test="${relatorioAtividadeInstanceList.size() > 0}">
    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <g:sortableColumn property="atividade" title="${message(code: 'relatorioAtividade.comunidadesEnvolvidas.label', default: 'Atividade')}"/>
            <g:sortableColumn property="atividade" title="${message(code: 'relatorioAtividade.comunidadesEnvolvidas.label', default: 'Data de Criação do Relatório')}"/>
            <g:sortableColumn property="financiador" title="${message(code: 'relatorioAtividade.municipiosAtendidos.label', default: 'Financiador')}"/>
            <g:sortableColumn property="centroCusto" title="${message(code: 'relatorioAtividade.totalMunicipiosAtendidos.label', default: 'Centro de Custo')}"/>
        </tr>
        </thead>
        <tbody>
        <g:each in="${relatorioAtividadeInstanceList}" var="relatorioAtividadeInstance">
            <tr>
                <td><g:link action="show" id="${relatorioAtividadeInstance.id}">${fieldValue(bean: relatorioAtividadeInstance, field: "atividade")}</g:link></td>
                <td><g:formatDate value="${relatorioAtividadeInstance.dateCreated}" format="dd/MM/yyyy"/></td>
                <td>${relatorioAtividadeInstance.financiador ?: 'Não informado.'}</td>
                <td>${relatorioAtividadeInstance.centroCusto ?: 'Não informado.'}</td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <g:paginate total="${relatorioAtividadeInstanceCount ?: 0}"/>

    <blockquote>
        <p>Exportar Relatório</p>
        <export:formats formats="['excel', 'pdf']" params="${params}"/>
    </blockquote>
</g:if>
<g:else>
    <pesquisa:dadosNaoEncontrados/>
</g:else>
</body>
</html>

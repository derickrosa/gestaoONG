
<%@ page import="com.acception.cadastro.Adiantamento" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'adiantamento.label', default: 'Adiantamento')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<p>
    <g:link class="btn btn-default" action="create"><span class="glyphicon glyphicon-plus"></span> <g:message code="default.new.label" args="[entityName]" /></g:link>
</p>

<g:if test="${adiantamentoInstanceCount > 0}">
    <table class="table table-bordered table-striped">
        <thead>
        <tr>

            <g:sortableColumn property="descricao"
                              title="${message(code: 'adiantamento.descricao.label', default: 'Descricao')}"/>

            <th><g:message code="adiantamento.lancamentoOriginal.label" default="Lancamento Original"/></th>

            <th><g:message code="adiantamento.centroCusto.label" default="Centro Custo"/></th>

            <g:sortableColumn property="data"
                              title="${message(code: 'adiantamento.data.label', default: 'Data')}"/>

            <g:sortableColumn property="dateCreated"
                              title="${message(code: 'adiantamento.dateCreated.label', default: 'Date Created')}"/>

            <g:sortableColumn property="lastUpdated"
                              title="${message(code: 'adiantamento.lastUpdated.label', default: 'Last Updated')}"/>

        </tr>
        </thead>
        <tbody>
        <g:each in="${adiantamentoInstanceList}" status="i" var="adiantamentoInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${adiantamentoInstance.id}">${fieldValue(bean: adiantamentoInstance, field: "descricao")}</g:link></td>

                <td>${fieldValue(bean: adiantamentoInstance, field: "lancamentoOriginal")}</td>

                <td>${fieldValue(bean: adiantamentoInstance, field: "centroCusto")}</td>

                <td><g:formatDate date="${adiantamentoInstance.data}"/></td>

                <td><g:formatDate date="${adiantamentoInstance.dateCreated}"/></td>

                <td><g:formatDate date="${adiantamentoInstance.lastUpdated}"/></td>

            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${adiantamentoInstanceCount ?: 0}"/>
    </div>
</g:if>
<g:else>
    <div class="well text-center"><strong>SEM REGISTROS</strong></div>
</g:else>
</body>
</html>

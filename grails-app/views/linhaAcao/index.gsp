<%@ page import="com.acception.cadastro.LinhaAcao" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'linhaAcao.label')}"/>
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

<p>
    <g:link class="btn btn-default" action="create"><span
            class="glyphicon glyphicon-plus"></span> Criar Linha de Ação</g:link>
</p>

<pesquisa:painel>
    <div class="form-group col-md-6">
        <label class="control-label" for="searchCodigo">Código:</label>
        <g:textField class="form-control" name="searchCodigo" value="${searchCodigo}"/>
    </div>

    <div class="form-group col-md-6">
        <label class="control-label" for="searchNome">Nome:</label>
        <g:textField class="form-control" name="searchNome" value="${searchNome}"/>
    </div>
</pesquisa:painel>

<table class="table table-bordered table-striped">
    <thead>
    <tr>

        <g:sortableColumn property="nome"
                          title="${message(code: 'linhaAcao.nome.label', default: 'Nome')}"/>

        <g:sortableColumn property="codigo"
                          title="${message(code: 'linhaAcao.codigo.label', default: 'Código')}"/>

        <g:sortableColumn property="descricao"
                          title="${message(code: 'linhaAcao.descricao.label', default: 'Descrição')}"/>

    </tr>
    </thead>
    <tbody>
    <g:if test="${linhaAcaoInstanceCount != 0}">
        <g:each in="${linhaAcaoInstanceList}" status="i" var="linhaAcaoInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${linhaAcaoInstance.id}">${fieldValue(bean: linhaAcaoInstance, field: "nome")}</g:link></td>

                <td>${fieldValue(bean: linhaAcaoInstance, field: "codigo")}</td>

                <td>${fieldValue(bean: linhaAcaoInstance, field: "descricao")}</td>

            </tr>
        </g:each>
    </g:if>
    <g:else>
        <tr><td colspan="3" class="text-center nao-ha-registros">Não há registros de ${entityName}.</td></tr>
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
             aria-relevant="all">Exibindo 1 a 20 de ${linhaAcaoInstanceCount == 1?linhaAcaoInstanceCount + ' linha de ação cadastrada':linhaAcaoInstanceCount + ' linhas de ação cadastradas' }.</div>
    </div>

    <div class="col-sm-6">
        <div class="pagination">
            <g:paginate total="${relatorioAtividadeInstanceCount ?: 0}"/>
            linhaAcaoInstanceCount
        </div>
    </div>
</div>

</body>
</html>

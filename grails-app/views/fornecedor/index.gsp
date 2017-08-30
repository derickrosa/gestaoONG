<%@ page import="com.acception.cadastro.Fornecedor" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'fornecedor.label', default: 'Fornecedor')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
    <export:resource/>
</head>

<body>
<p>
    <g:link class="btn btn-default" action="create"><span
            class="glyphicon glyphicon-plus"></span> <g:message code="default.new.label"
                                                                args="[entityName]"/></g:link>
</p>

<%
    def pars = [:]
    pageScope.variables.each { k, v ->
        if (k ==~ /search.*/ && v) pars[k] = v
    }
%>
<pesquisa:painel>
    <div class="form-group col-md-12">
        <label class="control-label" for="searchNome">Nome:</label>
        <g:textField class="form-control" name="searchNome" value="${searchNome}"/>
    </div>
</pesquisa:painel>

<table class="table table-bordered table-striped">
    <thead>
    <tr>

        <g:sortableColumn property="nome"
                          title="${message(code: 'fornecedor.codigo.label', default: 'Nome')}"/>
        <g:sortableColumn property="codigo"
                          title="${message(code: 'fornecedor.codigo.label', default: 'Codigo')}"/>

        <g:sortableColumn property="ramo"
                          title="${message(code: 'fornecedor.ramo.label', default: 'Ramo')}"/>


        <g:sortableColumn property="setor"
                          title="${message(code: 'fornecedor.setor.label', default: 'Setor')}"/>

    </tr>
    </thead>
    <tbody>
    <g:if test="${fornecedorInstanceCount != 0}">
        <g:each in="${fornecedorInstanceList}" status="i" var="fornecedorInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${fornecedorInstance.id}">${fieldValue(bean: fornecedorInstance, field: "participante.nome")}</g:link></td>
                <td><g:link action="show"
                            id="${fornecedorInstance.id}">${fieldValue(bean: fornecedorInstance, field: "codigo")}</g:link></td>

                <td>${fieldValue(bean: fornecedorInstance, field: "ramo")}</td>

                <td>${fieldValue(bean: fornecedorInstance, field: "setor")}</td>

            </tr>
        </g:each>
    </g:if>
    <g:else>
        <tr>
            <td colspan="6" class="text-center nao-ha-registros">Não há registros de ${entityName}.</td>
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
             aria-relevant="all">Exibindo 1 a 20 de ${fornecedorInstanceCount == 1 ? fornecedorInstanceCount + ' fornecedor cadastrado' : fornecedorInstanceCount + ' fornecedores cadastrados'}.</div>
    </div>

    <div class="col-sm-6">
        <div class="pagination">
            <g:paginate total="${fornecedorInstanceCount ?: 0}"/>
        </div>
    </div>
</div>
</body>
</html>

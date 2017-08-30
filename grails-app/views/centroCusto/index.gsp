<%@ page import="com.acception.cadastro.CentroCusto" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'centroCusto.label', default: 'Centro de Custo')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
    <style>
    th {
        text-align: center;
    }
    </style>
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
            class="glyphicon glyphicon-plus"></span> <g:message code="default.new.label"
                                                                args="[entityName]"/></g:link>
</p>

<pesquisa:painel>
    <div class="form-group col-md-6">
        <label for="searchCodigo">Código:</label>
        <g:textField class="form-control" name="searchCodigo" value="${searchCodigo}"/>
    </div>

    <div class="form-group col-md-6">
        <label for="searchNome">Nome:</label>
        <g:textField class="form-control" name="searchNome" value="${searchNome}"/>
    </div>
</pesquisa:painel>

<table class="table table-bordered table-striped">
    <thead>
    <tr>
        <g:sortableColumn property="codigo" title="${message(code: 'centroCusto.codigo.label', default: 'Código')}"/>
        <g:sortableColumn property="nome" title="${message(code: 'centroCusto.nome.label', default: 'Nome')}"/>
        <g:sortableColumn property="ano" title="${message(code: 'centroCusto.ano.label', default: 'Ano')}"/>
        <g:sortableColumn property="dataInicio" title="${message(code: 'centroCusto.dataInicio.label', default: 'Data Início')}"/>
        <g:sortableColumn property="dataFinal" title="${message(code: 'centroCusto.dataFinal.label', default: 'Data Final')}"/>
        <th><g:message code="centroCusto.planoDeTrabalho.label" default="Plano De Trabalho"/></th>
        <g:sortableColumn property="statusProjeto" title="${message(code: 'centroCusto.statusProjeto.label', default: 'Status Projeto')}"/>
    </tr>
    </thead>
    <tbody class="text-center">
    <g:if test="${centroCustoInstanceCount > 0}">
        <g:each in="${centroCustoInstanceList}" var="centroCustoInstance">
            <tr>
                <td><g:link action="show"
                            id="${centroCustoInstance.id}">${fieldValue(bean: centroCustoInstance, field: "codigo")}</g:link></td>

                <td>${fieldValue(bean: centroCustoInstance, field: "nome")}</td>

                <td><g:formatNumber number="${centroCustoInstance.ano}" format="##0"/></td>

                <td><g:formatDate format="dd/MM/yyyy" date="${centroCustoInstance.dataInicio}"/></td>

                <td><g:formatDate format="dd/MM/yyyy" date="${centroCustoInstance.dataFinal}"/></td>

                <td><g:link controller="anexo" action="show"
                            id="${centroCustoInstance?.planoDeTrabalho?.id}">${centroCustoInstance?.planoDeTrabalho}</g:link></td>

                <td>${fieldValue(bean: centroCustoInstance, field: "statusProjeto")}</td>
            </tr>
        </g:each>
    </g:if>
    <g:else>
        <tr>
            <td colspan="7" class="text-center nao-ha-registros">Não há registros de ${entityName}.</td>
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
             aria-relevant="all">Exibindo 1 a 20 de ${centroCustoInstanceCount == 1 ? centroCustoInstanceCount + ' centro de custo cadastrado' : centroCustoInstanceCount + ' centros de custo cadastrados'}.</div>
    </div>

    <div class="col-sm-6">
        <div class="pagination">
            <g:paginate total="${centroCustoInstanceCount ?: 0}"/>
        </div>
    </div>
</div>

</body>
</html>

<%@ page import="com.acception.cadastro.CentroCusto" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'centroCusto.label', default: 'Centro de Custo')}"/>
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
    <div class="form-group col-md-2">
        <label for="pesquisa.codigo">Código:</label>
        <g:textField class="form-control" name="pesquisa.codigo" value="${pesquisa?.codigo}"/>
    </div>

    <div class="form-group col-md-4">
        <label for="pesquisa.nome">Nome:</label>
        <g:textField class="form-control" name="pesquisa.nome" value="${pesquisa?.nome}"/>
    </div>

    <div class="form-group col-md-2">
        <label for="pesquisa.ano">Ano:</label>
        <g:select name="pesquisa.ano" from="${Calendar.getInstance().get(Calendar.YEAR)..1900}"
                  class="form-control select" noSelection="['': 'Todos']" value="${pesquisa?.ano}"/>
    </div>

    <div class="form-group col-md-2">
        <label for="pesquisa.financiador">Financiador:</label>
        <g:select name="pesquisa.financiador" from="${com.acception.cadastro.Financiador.list()}"
                  class="form-control select" noSelection="['': 'Todos']"
                  optionKey="id" value="${pesquisa?.financiador}"/>
    </div>

    <div class="form-group col-md-2">
        <label for="pesquisa.status">Status Projeto:</label>
        <g:select name="pesquisa.status" from="${com.acception.cadastro.enums.StatusProjeto.values()}"
                  class="form-control" noSelection="['': 'Todos']"
                  optionKey="key" value="${pesquisa?.status}"/>
    </div>
</pesquisa:painel>

<g:if test="${centroCustoInstanceCount > 0}">
    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <g:sortableColumn params="${pesquisa}" property="codigo" title="${message(code: 'centroCusto.codigo.label', default: 'Código')}"/>
            <g:sortableColumn params="${pesquisa}" property="nome" title="${message(code: 'centroCusto.nome.label', default: 'Nome')}"/>
            <g:sortableColumn params="${pesquisa}" property="ano" title="${message(code: 'centroCusto.ano.label', default: 'Ano')}"/>
            <g:sortableColumn params="${pesquisa}" property="dataInicio" title="${message(code: 'centroCusto.dataInicio.label', default: 'Data Início')}"/>
            <g:sortableColumn params="${pesquisa}" property="dataFinal" title="${message(code: 'centroCusto.dataFinal.label', default: 'Data Final')}"/>
            <th><g:message code="centroCusto.planoDeTrabalho.label" default="Plano De Trabalho"/></th>
            <g:sortableColumn params="${pesquisa}" property="statusProjeto" title="${message(code: 'centroCusto.statusProjeto.label', default: 'Status Projeto')}"/>
        </tr>
        </thead>
        <tbody>
        <g:each in="${centroCustoInstanceList}" var="centroCustoInstance">
            <tr>
                <td><g:link action="show" id="${centroCustoInstance.id}">${fieldValue(bean: centroCustoInstance, field: "codigo")}</g:link></td>
                <td>${fieldValue(bean: centroCustoInstance, field: "nome")}</td>
                <td><g:formatNumber number="${centroCustoInstance.ano}" format="##0"/></td>
                <td><g:formatDate format="dd/MM/yyyy" date="${centroCustoInstance.dataInicio}"/></td>
                <td><g:formatDate format="dd/MM/yyyy" date="${centroCustoInstance.dataFinal}"/></td>
                <td><g:link controller="anexo" action="show" id="${centroCustoInstance?.planoDeTrabalho?.id}">${centroCustoInstance?.planoDeTrabalho}</g:link></td>
                <td>${fieldValue(bean: centroCustoInstance, field: "statusProjeto")}</td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <g:paginate total="${centroCustoInstanceCount ?: 0}"/>

    <blockquote>
        <p>Exportar Relatório</p>
        <export:formats formats="['excel', 'pdf']" params="${pesquisa}"/>
    </blockquote>
</g:if>
<g:else>
    <pesquisa:dadosNaoEncontrados/>
</g:else>

</body>
</html>

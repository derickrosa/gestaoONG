<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'orcamento.label', default: 'Orcamento')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
    <export:resource/>
</head>

<body>
<p>
    <g:link class="btn btn-default" action="create"><span class="glyphicon glyphicon-plus"></span> <g:message code="default.new.label" args="[entityName]" /></g:link>
</p>

<pesquisa:painel>
    <div class="form-group col-md-3">
        <label for="pesquisa.centroCusto">Centro Custo</label>
        <g:select name="pesquisa.centroCusto" from="${com.acception.cadastro.CentroCusto.list()}"
        class="form-control select" noSelection="['': 'Todos']" optionKey="id" value="${pesquisa.centroCusto}"/>
    </div>


    <div class="form-group col-md-2">
        <label for="pesquisa.ano">Ano</label>
        <g:select name="pesquisa.ano" from="${Calendar.getInstance().get(Calendar.YEAR)..1900}"
        class="form-control select" noSelection="['': 'Todos']" value="${pesquisa.ano}"/>
    </div>

    <div class="form-group col-md-3">
        <label for="pesquisa.moeda">Moeda</label>
        <g:select name="pesquisa.moeda" from="${com.acception.cadastro.enums.Moeda.values()}"
                  class="form-control" noSelection="['': 'Todas']" optionKey="key" value="${pesquisa.moeda}"/>
    </div>
</pesquisa:painel>

<g:if test="${orcamentoInstanceCount > 0}">
    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <th>Identificador</th>
            <g:sortableColumn params="${pesquisa}" property="dateCreated" title="${message(code: 'orcamento.dateCreated.label', default: 'Data Cadastro')}"/>
            <g:sortableColumn params="${pesquisa}" property="ano" title="${message(code: 'orcamento.ano.label', default: 'Ano')}"/>
            <th><g:message params="${pesquisa}" code="orcamento.centroCusto.label" default="Centro Custo"/></th>
            <g:sortableColumn params="${pesquisa}" property="valorTotal" title="${message(code: 'orcamento.valorTotal.label', default: 'Valor')}"/>
            <g:sortableColumn params="${pesquisa}" property="valorCambial" title="${message(code: 'orcamento.valorCambial.label', default: 'Valor Cambial')}"/>
        </tr>
        </thead>
        <tbody>
        <g:each in="${orcamentoInstanceList}" var="orcamentoInstance">
            <tr>
                <td><g:link action="show" id="${orcamentoInstance.id}">${fieldValue(bean: orcamentoInstance, field: "id")}</g:link></td>
                <td><g:formatDate date="${orcamentoInstance.dateCreated}" format="dd/MM/yyyy"/></td>
                <td>${orcamentoInstance.ano}</td>
                <td>${fieldValue(bean: orcamentoInstance, field: "centroCusto")}</td>
                <td><g:formatNumber number="${orcamentoInstance.valorTotal}" type="currency" currencyCode="${orcamentoInstance?.moeda?.code}"/></td>
                <td><g:formatNumber number="${orcamentoInstance.valorCambial}" type="currency" currencyCode="${com.acception.cadastro.enums.Moeda.REAL.code}"/></td>
            </tr>
        </g:each>
        </tbody>
    </table>
    <g:paginate total="${orcamentoInstanceCount ?: 0}"/>

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

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'adiantamento.label', default: 'Adiantamento')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
    <export:resource/>
</head>

<body>
<p>
    <g:link class="btn btn-default" action="create"><span class="glyphicon glyphicon-plus"></span> <g:message code="default.new.label" args="[entityName]" /></g:link>
</p>

<pesquisa:painel>
    <div class="form-group col-md-4">
        <label>Período</label>
        <div class="input-group input-daterange">
            <g:textField class="form-control" placeholder="Data Inicial" name="pesquisa.dataInicio" value="${pesquisa.dataInicio}"/>
            <div class="input-group-addon">até</div>
            <g:textField class="form-control" placeholder="Data Final" name="pesquisa.dataFinal" value="${pesquisa.dataFinal}"/>
        </div>
    </div>

    <div class="form-group col-md-2">
        <label for="pesquisa.centroCusto">Centro de Custo</label>
        <g:select name="pesquisa.centroCusto" from="${com.acception.cadastro.CentroCusto.list()}"
                  class="form-control select" noSelection="['': 'Todos']" optionKey="id"
                  value="${pesquisa?.centroCusto}"/>
    </div>

</pesquisa:painel>

<g:if test="${adiantamentoInstanceCount > 0}">
    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <g:sortableColumn params="${pesquisa}" property="id" title="Identificador"/>
            <g:sortableColumn params="${pesquisa}" property="data" title="${message(code: 'adiantamento.data.label', default: 'Data')}"/>
            <th><g:message code="adiantamento.lancamentoOriginal.label" default="Lancamento Original"/></th>
            <th><g:message code="adiantamento.centroCusto.label" default="Centro Custo"/></th>
            <th><g:message code="adiantamento.descricao.label" default="Descrição"/></th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${adiantamentoInstanceList}" var="adiantamentoInstance">
            <tr>
                <td><g:link action="show" id="${adiantamentoInstance.id}">${adiantamentoInstance.id}</g:link></td>
                <td><g:formatDate date="${adiantamentoInstance.data}" format="dd/MM/yyyy"/></td>
                <td><g:link controller="lancamento" action="show" id="${adiantamentoInstance?.lancamentoOriginal?.id}">${fieldValue(bean: adiantamentoInstance, field: "lancamentoOriginal")}</g:link></td>
                <td><g:link controller="centroCusto" action="show" id="${adiantamentoInstance?.centroCusto?.id}">${fieldValue(bean: adiantamentoInstance, field: "centroCusto")}</g:link></td>
                <td><g:fieldValue field="descricao" bean="${adiantamentoInstance}"/></td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <g:paginate total="${adiantamentoInstanceCount ?: 0}"/>

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
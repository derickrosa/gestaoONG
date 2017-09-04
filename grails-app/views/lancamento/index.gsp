<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'lancamento.label', default: 'Lancamento')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
    <export:resource/>
</head>

<body>
<p>
    <g:link class="btn btn-default" action="create"><span class="glyphicon glyphicon-plus"></span> <g:message code="default.new.label" args="[entityName]" /></g:link>
</p>

<pesquisa:painel>
    <div class="form-group col-md-2">
        <label for="pesquisa.dataCriacao">Data Criação</label>
        <g:textField name="pesquisa.dataCriacao" class="form-control datepicker" value="${pesquisa.dataCriacao}"/>
    </div>

    <div class="form-group col-md-2">
        <label for="pesquisa.dataPagamento">Data Pagamento</label>
        <g:textField name="pesquisa.dataPagamento" class="form-control datepicker" value="${pesquisa.dataPagamento}"/>
    </div>

    <div class="form-group col-md-2">
        <label for="pesquisa.tipo">Tipo</label>
        <g:select name="pesquisa.tipo" from="${com.acception.cadastro.enums.TipoLancamento.values()}"
        class="form-control" optionKey="key" optionValue="nome" value="${pesquisa.tipo}" noSelection="['': 'Todos']"/>
    </div>

    <div class="form-group col-md-2">
        <label for="pesquisa.codigo">Código</label>
        <g:textField name="pesquisa.codigo" class="form-control" value="${pesquisa.codigo}"/>
    </div>
</pesquisa:painel>

<g:if test="${lancamentoInstanceCount > 0}">
    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <g:sortableColumn params="${pesquisa}" property="id" title="Identificador"/>
            <g:sortableColumn params="${pesquisa}" property="dateCreated" title="${message(code: 'lancamento.dateCreated.label', default: 'Criação')}"/>
            <g:sortableColumn params="${pesquisa}" property="dataPagamento" title="${message(code: 'lancamento.dataPagamento.label', default: 'Data Pagamento')}"/>
            <g:sortableColumn params="${pesquisa}" property="dataCancelamento" title="${message(code: 'lancamento.dataCancelamento.label', default: 'Data Cancelamento')}"/>
            <g:sortableColumn params="${pesquisa}" property="parcela" title="${message(code: 'lancamento.parcela.label', default: 'Parcelas')}"/>
            <g:sortableColumn params="${pesquisa}" property="codigoLancamento" title="${message(code: 'lancamento.codigoLancamento.label', default: 'Código')}"/>
            <th><g:message code="lancamento.tipoLancamento.label" default="Tipo"/></th>
            <th><g:message code="lancamento.descricao.label" default="Descrição"/></th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${lancamentoInstanceList}" var="lancamentoInstance">
            <tr>
                <td><g:link action="show" id="${lancamentoInstance.id}">${fieldValue(bean: lancamentoInstance, field: "id")}</g:link></td>
                <td><g:formatDate date="${lancamentoInstance.dateCreated}" format="dd/MM/yyyy"/> </td>
                <td>${fieldValue(bean: lancamentoInstance, field: "dataPagamento")}</td>
                <td><g:formatDate date="${lancamentoInstance.dataCancelamento}"/></td>
                <td>${fieldValue(bean: lancamentoInstance, field: "parcela")}</td>
                <td>${fieldValue(bean: lancamentoInstance, field: "codigoLancamento")}</td>
                <td>${fieldValue(bean: lancamentoInstance, field: "tipoLancamento.nome")}</td>
                <td>${fieldValue(bean: lancamentoInstance, field: "descricao")}</td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <g:paginate total="${lancamentoInstanceCount ?: 0}"/>

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

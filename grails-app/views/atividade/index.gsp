<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'atividade.label', default: 'Atividade')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
    <export:resource/>
</head>

<body>
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
        <label for="pesquisa.centroCusto">Centro de Custo:</label>
        <g:select name="pesquisa.centroCusto" from="${com.acception.cadastro.CentroCusto.list()}"
                  class="form-control select" optionKey="id" optionValue="nome"
                  noSelection="['': 'Todos']" value="${pesquisa?.centroCusto}"/>
    </div>

    <div class="form-group col-md-4">
        <label>Período:</label>
        <div class="input-group input-daterange">
            <input type="text" class="form-control" name="pesquisa.dataInicio" id="pesquisa.dataInicio" value="${pesquisa.dataInicio}">
            <div class="input-group-addon">até</div>
            <input type="text" class="form-control" name="pesquisa.dataFinal" id="pesquisa.dataFinal" value="${pesquisa.dataFinal}">
        </div>
    </div>

    <div class="form-group col-md-2">
        <label for="pesquisa.status">Status:</label>
        <g:select name="pesquisa.status" from="${com.acception.cadastro.enums.StatusAtividade.values()}"
                  class="form-control" optionKey="key"
                  noSelection="['': 'Todos']" value="${pesquisa?.status}"/>
    </div>

    <div class="form-group col-md-2">
        <label for="pesquisa.tipo">Tipo:</label>
        <g:select name="pesquisa.tipo" from="${com.acception.cadastro.enums.TipoAtividade.values()}"
                  class="form-control" optionKey="key"
                  noSelection="['': 'Todos']" value="${pesquisa?.tipo}"/>
    </div>

    <div class="form-group col-md-2">
        <label for="pesquisa.estado">Estado:</label>
        <g:select name="pesquisa.estado" from="${com.acception.cadastro.Estado.list()}"
                  class="form-control select" optionKey="id" optionValue="nome"
                  noSelection="['': 'Todos']" value="${pesquisa?.estado}"/>
    </div>

</pesquisa:painel>

<g:if test="${atividadeInstanceCount != 0}">
    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <g:sortableColumn params="${pesquisa}" property="codigo" title="${message(code: 'atividade.codigo.label', default: 'Código')}"/>
            <g:sortableColumn params="${pesquisa}" property="nome" title="${message(code: 'atividade.nome.label', default: 'Nome')}"/>
            <th><g:message code="atividade.atividade.label" default="Tipo"/></th>
            <th><g:message code="atividade.centroCusto.label" default="Centro de Custo"/></th>
            <th>Período</th>
            <g:sortableColumn params="${pesquisa}" property="local" title="${message(code: 'atividade.local.label', default: 'Local')}"/>
            <g:sortableColumn params="${pesquisa}" property="status" title="${message(code: 'atividade.status.label', default: 'Status')}"/>
        </tr>
        </thead>
        <tbody>
        <g:each in="${atividadeInstanceList}" var="atividadeInstance">
            <tr>
                <td><g:link action="show"
                            id="${atividadeInstance.id}">${fieldValue(bean: atividadeInstance, field: "codigo")}</g:link></td>
                <td>${fieldValue(bean: atividadeInstance, field: "nome")}</td>
                <td>${fieldValue(bean: atividadeInstance, field: "tipo")}</td>
                <td>${atividadeInstance.centroCusto*.nome?.join(', ')}</td>
                <td><g:formatDate date="${atividadeInstance.inicio}" format="dd/MM/yyyy"/> - <g:formatDate date="${atividadeInstance.termino}" format="dd/MM/yyyy"/></td>
                <td>${fieldValue(bean: atividadeInstance, field: "local")}</td>
                <td>${fieldValue(bean: atividadeInstance, field: "status")}</td>
            </tr>
        </g:each>
        </tbody>
    </table>
    <g:paginate total="${atividadeInstanceCount ?: 0}"/>

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

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'financiador.label', default: 'Financiador')}"/>
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
        <label class="control-label" for="pesquisa.nome">Nome:</label>
        <g:textField class="form-control" name="pesquisa.nome" value="${pesquisa?.nome}"/>
    </div>

    <div class="form-group col-md-2">
        <label class="control-label" for="pesquisa.cnpj">CNPJ:</label>
        <g:textField class="form-control cnpj" name="pesquisa.cnpj" value="${pesquisa?.cnpj}"/>
    </div>

    <div class="form-group col-md-2">
        <label class="control-label" for="pesquisa.sigla">Sigla:</label>
        <g:textField class="form-control" name="pesquisa.sigla" value="${pesquisa?.sigla}"/>
    </div>

    <div class="form-group col-md-2">
        <label class="control-label" for="pesquisa.setor">Setor:</label>
        <g:select name="pesquisa.setor" from="${com.acception.cadastro.enums.Setor.values()}"
            class="form-control" optionKey="key" noSelection="['': 'Todos']" value="${pesquisa?.setor}"/>
    </div>
</pesquisa:painel>

<g:if test="${financiadorInstanceCount != 0}">
    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <g:sortableColumn params="${pesquisa}" property="id" title="Identificador"/>
            <g:sortableColumn params="${pesquisa}" property="participante.nome" title="${message(code: 'financiador.nome.label', default: 'Nome')}"/>
            <g:sortableColumn params="${pesquisa}" property="participante.cnpj" title="${message(code: 'financiador.cnpj.label', default: 'CNPJ')}"/>
            <g:sortableColumn params="${pesquisa}" property="sigla" title="${message(code: 'financiador.sigla.label', default: 'Sigla')}"/>
            <g:sortableColumn params="${pesquisa}" property="dateCreated" title="${message(code: 'financiador.dateCreated.label', default: 'Data de Cadastro')}"/>
        </tr>
        </thead>
        <tbody>
        <g:each in="${financiadorInstanceList}" var="financiadorInstance">
            <tr>
                <td><g:link action="show" id="${financiadorInstance.id}">${financiadorInstance.id}</g:link></td>
                <td>${fieldValue(bean: financiadorInstance, field: "participante.nome")}</td>
                <td><g:formatCnpj cnpj="${financiadorInstance.participante.cnpj}"/></td>
                <td>${fieldValue(bean: financiadorInstance, field: "sigla")}</td>
                <td><g:formatDate date="${financiadorInstance.dateCreated}" format="dd/MM/yyyy"/></td>
            </tr>
        </g:each>
        </tbody>
    </table>
    <g:paginate total="${financiadorInstanceCount ?: 0}"/>

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

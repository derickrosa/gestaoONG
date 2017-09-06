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

<p>
    <g:link class="btn btn-default" action="create"><span
            class="glyphicon glyphicon-plus"></span> Criar Linha de Ação</g:link>
</p>

<pesquisa:painel>
    <div class="form-group col-md-6">
        <label class="control-label" for="pesquisa.codigo">Código:</label>
        <g:textField class="form-control" name="pesquisa.codigo" value="${pesquisa?.codigo}"/>
    </div>

    <div class="form-group col-md-6">
        <label class="control-label" for="pesquisa.nome">Nome:</label>
        <g:textField class="form-control" name="pesquisa.nome" value="${pesquisa?.nome}"/>
    </div>
</pesquisa:painel>

<g:if test="${linhaAcaoInstanceCount != 0}">
    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <g:sortableColumn params="${pesquisa}" property="codigo" title="${message(code: 'linhaAcao.codigo.label', default: 'Código')}"/>
            <g:sortableColumn params="${pesquisa}" property="nome" title="${message(code: 'linhaAcao.nome.label', default: 'Nome')}"/>
            <th><g:message code="linhaAcao.descricao.label" default="Descrição"/></th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${linhaAcaoInstanceList}" var="linhaAcaoInstance">
            <tr>
                <td><g:link action="show" id="${linhaAcaoInstance.id}">${fieldValue(bean: linhaAcaoInstance, field: "codigo")}</g:link></td>
                <td>${fieldValue(bean: linhaAcaoInstance, field: "nome")}</td>
                <td>${fieldValue(bean: linhaAcaoInstance, field: "descricao")}</td>
            </tr>
        </g:each>

        </tbody>
    </table>
    <g:paginate total="${relatorioAtividadeInstanceCount ?: 0}"/>

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

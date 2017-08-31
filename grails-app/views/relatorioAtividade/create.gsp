<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'relatorioAtividade.label', default: 'RelatorioAtividade')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
<p>
    <g:link class="btn btn-default" controller="atividade" action="show" id="${relatorioAtividadeInstance?.atividade?.id}"><span class="glyphicon glyphicon-arrow-left"></span> <g:message
            code="default.list.label.voltar" default="Voltar"></g:message></g:link>
    <g:link class="btn btn-default" action="index"><span class="glyphicon glyphicon-list"></span> <g:message
            code="default.list.label" args="[entityName]"/></g:link>
</p>
<g:form url="[resource:relatorioAtividadeInstance, action:'save']" >
    <g:render template="form"/>
    <g:submitButton name="create" class="btn btn-default"
                    value="${message(code: 'default.button.create.label', default: 'Create')}"/>
</g:form>
</body>
</html>

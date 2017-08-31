<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'atividade.label', default: 'Atividade')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
    <asset:stylesheet src="normalize.css"/>
    <asset:stylesheet src="wizardMain.css"/>
</head>

<body>
<p>
    <g:if test="${atividadeInstance.isSubatividade()}">
        <g:link class="btn btn-default" controller="atividade" action="show" id="${atividadeInstance?.atividade?.id}"><span class="glyphicon glyphicon-arrow-left"></span> <g:message
                code="default.list.label.voltar" default="Voltar"></g:message></g:link>
    </g:if>
    <g:else>
        <g:link class="btn btn-default" controller="centroCusto" action="show" id="${centroCustoInstance.id}"><span class="glyphicon glyphicon-arrow-left"></span> <g:message
                code="default.list.label.voltar" default="Voltar"></g:message></g:link>
    </g:else>
    <g:link class="btn btn-default" action="index"><span class="glyphicon glyphicon-list"></span> <g:message
            code="default.list.label" args="[entityName]"/></g:link>
</p>

<g:form url="[resource:atividadeInstance, action:'save']" enctype="multipart/form-data" >
    <g:render template="form"/>
    <g:submitButton name="create" class="btn btn-default"
                    value="${message(code: 'default.button.create.label', default: 'Create')}"/>
</g:form>
</body>
</html>

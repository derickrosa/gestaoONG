<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'linhaAcao.label', default: 'LinhaAcao')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
<p>
    <g:link class="btn btn-default" action="index"><span class="glyphicon glyphicon-list"></span> <g:message
            code="default.list.label" args="[entityName]"/></g:link>
</p>

<g:form url="[resource:linhaAcaoInstance, action:'save']" >
    <g:render template="form"/>
    <g:submitButton name="create" class="btn btn-default" value="${message(code: 'default.button.create.label', default: 'Create')}"/>
</g:form>

</body>
</html>

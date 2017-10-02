<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
    <p>
        <g:link class="btn btn-default" action="index"><span class="glyphicon glyphicon-list"></span>
            <g:message code="default.list.label" args="[entityName]"/>
        </g:link>
    </p>

    <g:form controller="user" action="save">
        <g:render template="form" model="[userInstance: userInstance, authorityList: authorityList]"/>
        <button type="submit" class="btn btn-primary">
            <i class="glyphicon glyphicon-floppy-disk"></i> Criar
        </button>
    </g:form>
</body>
</html>

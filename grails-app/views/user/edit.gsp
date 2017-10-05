<%@ page import="com.acception.security.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>
    <p>
        <g:link class="btn btn-default" action="index">
            <span class="glyphicon glyphicon-list"></span>
            <g:message code="default.list.label" args="[entityName]"/>
        </g:link>
        <g:link class="btn btn-default" action="create">
            <span class="glyphicon glyphicon-plus"></span>
            <g:message code="default.new.label" args="[entityName]"/>
        </g:link>
    </p>

    <g:form controller="user" action="update" method="PUT">
        <g:hiddenField name="id" value="${userInstance?.id}"/>
        <g:hiddenField name="version" value="${userInstance?.version}"/>
        <g:render template="form" model="[userInstance: userInstance, authorityList: authorityList]"/>
        <button type="submit" class="btn btn-primary">
            <i class="glyphicon glyphicon-floppy-disk"></i> Alterar
        </button>
    </g:form>
</body>
</html>

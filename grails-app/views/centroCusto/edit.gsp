<%@ page import="com.acception.cadastro.CentroCusto" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'centroCusto.label', default: 'Centro de Custo')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
    <asset:stylesheet src="normalize.css"/>
    <asset:stylesheet src="wizardMain.css"/>
</head>

<body>
<p>
    <g:link class="btn btn-default" action="index"><span class="glyphicon glyphicon-list"></span> <g:message
            code="default.list.label" args="[entityName]"/></g:link>
    <g:link class="btn btn-default" action="create"><span
            class="glyphicon glyphicon-plus"></span> <g:message code="default.new.label"
                                                                args="[entityName]"/></g:link>
</p>

<g:form url="[resource: centroCustoInstance, action: 'update']" enctype="multipart/form-data" id="form">
    <g:hiddenField name="version" value="${centroCustoInstance?.version}"/>
    <g:render template="form"/>
</g:form>
</body>
</html>

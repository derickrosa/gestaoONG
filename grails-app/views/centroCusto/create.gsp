<%@ page import="com.acception.cadastro.enums.TipoCusto" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'centroCusto.label', default: 'Centro de Custo')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
    <asset:stylesheet src="normalize.css"/>
    <asset:stylesheet src="wizardMain.css"/>
</head>

<body>
<p>
    <g:link class="btn btn-default" action="index"><span class="glyphicon glyphicon-list"></span> <g:message
            code="default.list.label" args="[entityName]"/></g:link>
</p>
<g:form url="[resource: centroCustoInstance, action: 'save']" enctype="multipart/form-data" id="form">
    <g:render template="form"/>
</g:form>
</body>

</html>

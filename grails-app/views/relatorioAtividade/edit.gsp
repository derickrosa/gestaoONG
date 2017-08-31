<%@ page import="com.acception.cadastro.RelatorioAtividade" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'relatorioAtividade.label', default: 'RelatorioAtividade')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>
<p>
    <g:link class="btn btn-default" action="index"><span class="glyphicon glyphicon-list"></span> <g:message
            code="default.list.label" args="[entityName]"/></g:link>
    <g:link class="btn btn-default" action="create"><span
            class="glyphicon glyphicon-plus"></span> <g:message code="default.new.label"
                                                                args="[entityName]"/></g:link>
</p>
<g:form url="[resource:relatorioAtividadeInstance, action:'update']" method="PUT" >
    <g:hiddenField name="version" value="${relatorioAtividadeInstance?.version}"/>
    <g:render template="form"/>
    <button type="submit" class="btn btn-default">
        <span class="glyphicon glyphicon-edit"></span>
        <g:message code="default.button.update.label" default="Update"/></button>
</g:form>
</body>
</html>

<%@ page import="com.acception.security.Role" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'role.label', default: 'Role')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<p>
    <g:link class="btn btn-default" action="index"><span class="glyphicon glyphicon-list"></span> <g:message
            code="default.list.label" args="[entityName]"/></g:link>
    <g:link class="btn btn-default" action="create"><span class="glyphicon glyphicon-plus"></span> <g:message
            code="default.new.label" args="[entityName]"/></g:link>
</p>

<table class="table table-bordered role">
    <tr>
        <th class="property-label"><g:message code="role.authority.label" default="Authority"/></th>
        <td aria-labelledby="authority-label"><g:fieldValue bean="${roleInstance}" field="authority"/></td>
    </tr>
    <tr>
        <th class="property-label"><g:message code="role.nome.label" default="Nome"/></th>
        <td aria-labelledby="nome-label"><g:fieldValue bean="${roleInstance}" field="nome"/></td>
    </tr>
    <tr>
        <th class="property-label"><g:message code="role.descricao.label" default="Descrição"/></th>
        <td aria-labelledby="nome-label"><g:fieldValue bean="${roleInstance}" field="descricao"/></td>
    </tr>
</table>

<g:form url="[resource: roleInstance, action: 'delete']" method="DELETE">
    <fieldset class="buttons">
        <g:link class="btn btn-default" action="edit" resource="${roleInstance}">
            <span class="glyphicon glyphicon-edit"></span>
            <g:message code="default.button.edit.label" default="Edit"/>
        </g:link>
        <button type="submit" class="btn btn-default"
                onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
            <span class="glyphicon glyphicon-floppy-remove"></span>
            <g:message code="default.button.delete.label"/>
        </button>
    </fieldset>
</g:form>
</html>

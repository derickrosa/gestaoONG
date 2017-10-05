
<%@ page import="com.acception.security.Role" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'role.label', default: 'Role')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<p>
    <g:link class="btn btn-default" action="create"><span class="glyphicon glyphicon-plus"></span> <g:message code="default.new.label" args="[entityName]" /></g:link>
</p>

<g:if test="${roleInstanceCount > 0}">
    <div class="list-group">
        <g:each in="${roleInstanceList}" var="authority">
            <g:link class="list-group-item" controller="role" action="show" id="${authority.id}">
                <h4 class="list-group-item-heading">${authority.nome}</h4>
                <p class="list-group-item-text">${authority.descricao}</p>
            </g:link>
        </g:each>
    </div>
</g:if>
<g:else>
    <pesquisa:dadosNaoEncontrados/>
</g:else>

<div class="pagination">
    <g:paginate total="${roleInstanceCount ?: 0}"/>
</div>

</body>
</html>

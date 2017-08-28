
<%@ page import="com.acception.security.Role" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'role.label', default: 'Role')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div id="content">
    <div class="inner" style="min-height: 700px;">
        <div class="row">
            <div class="col-lg-12">
                <h1><g:message code="default.list.label" args="[entityName]"/></h1>
            </div>
        </div>
        <hr/>
        <!--BLOCK SECTION -->

        <div class="nav" role="navigation">
        <p>
            <g:link class="btn btn-default" action="create"><span class="glyphicon glyphicon-plus"></span> <g:message code="default.new.label" args="[entityName]" /></g:link>
        </p>
        </div>

        <div id="list-role" class="body" role="main">
            <g:if test="${flash.message}">
                <div class="alert alert-info" role="status">${flash.message}</div>
            </g:if>
            <table class="table table-bordered table-striped">
                <thead>
                <tr>
                    
                    <g:sortableColumn property="authority"
                                      title="${message(code: 'role.authority.label', default: 'Nome')}"/>
                    
                    <g:sortableColumn property="nome"
                                      title="${message(code: 'role.nome.label', default: 'Descrição')}"/>
                    
                </tr>
                </thead>
                <tbody>
                <g:each in="${roleInstanceList}" status="i" var="roleInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        
                        <td><g:link action="show"
                                    id="${roleInstance.id}">${fieldValue(bean: roleInstance, field: "authority")}</g:link></td>
                        
                        <td>${fieldValue(bean: roleInstance, field: "nome")}</td>
                        
                    </tr>
                </g:each>
                </tbody>
            </table>

            <div class="pagination">
                <g:paginate total="${roleInstanceCount ?: 0}"/>
            </div>
        </div>
    </div>
</div>
</body>
</html>

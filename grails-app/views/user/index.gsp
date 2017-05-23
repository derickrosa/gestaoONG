
<%@ page import="com.acception.security.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
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

        <div id="list-user" class="body" role="main">
            <g:if test="${flash.message}">
                <div class="alert alert-info" role="status">${flash.message}</div>
            </g:if>
            <table class="table table-bordered table-striped">
                <thead>
                <tr>
                    
                    <g:sortableColumn property="nome"
                                      title="${message(code: 'user.nome.label', default: 'Nome')}"/>

                    <g:sortableColumn property="username"
                                      title="${message(code: 'user.username.label', default: 'Login')}"/>

                    <g:sortableColumn property="email"
                                      title="${message(code: 'user.email.label', default: 'E-mail')}"/>

                    <g:sortableColumn property="email"
                                      title="${message(code: 'user.email.label', default: 'Permissões')}"/>

                    <sec:ifAnyGranted roles='ROLE_SUPORTE, ROLE_MASTER'>
                        <th></th>
                    </sec:ifAnyGranted>
                    
                </tr>
                </thead>
                <tbody>
                <g:each in="${userInstanceList}" status="i" var="userInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        
                        <td><g:link action="show"
                                    id="${userInstance.id}">${fieldValue(bean: userInstance, field: "nome")}</g:link></td>

                        <td><g:link action="show"
                                    id="${userInstance.id}">${fieldValue(bean: userInstance, field: "username")}</g:link></td>

                        
                        <td>${fieldValue(bean: userInstance, field: "email")}</td>

                        <td>${userInstance?.authorities?userInstance?.authorities?.nome?.join(', '):'Nenhuma permissão definida para este usuário.'}</td>

                        <sec:ifAnyGranted roles='ROLE_SUPORTE, ROLE_ADMINISTRADOR_SISTEMA'>
                            <td>
                                <form action='${request.contextPath}/j_spring_security_switch_user' method='POST'>
                                    <input class="btn btn-primary" type='submit' value='Logar'/>
                                    <input type='hidden' name='j_username' value="${userInstance.username}"/> <br/>
                                </form>
                            </td>
                        </sec:ifAnyGranted>
                        
                    </tr>
                </g:each>
                </tbody>
            </table>

            <div class="pagination">
                <g:paginate total="${userInstanceCount ?: 0}"/>
            </div>
        </div>
    </div>
</div>
</body>
</html>

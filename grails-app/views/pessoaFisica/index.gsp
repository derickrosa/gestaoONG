
<%@ page import="com.acception.cadastro.PessoaFisica" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'pessoaFisica.label', default: 'PessoaFisica')}"/>
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

        <div id="list-pessoaFisica" class="body" role="main">
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <table class="table table-bordered table-striped">
                <thead>
                <tr>
                    
                    <g:sortableColumn property="nome"
                                      title="${message(code: 'pessoaFisica.nome.label', default: 'Nome')}"/>
                    
                    <th><g:message code="pessoaFisica.telefone.label" default="Telefone"/></th>
                    
                    <th><g:message code="pessoaFisica.telefoneAdicional.label" default="Telefone Adicional"/></th>
                    
                    <g:sortableColumn property="email"
                                      title="${message(code: 'pessoaFisica.email.label', default: 'Email')}"/>
                    
                    <g:sortableColumn property="emailAdicional"
                                      title="${message(code: 'pessoaFisica.emailAdicional.label', default: 'Email Adicional')}"/>
                    
                    <th><g:message code="pessoaFisica.user.label" default="User"/></th>
                    
                </tr>
                </thead>
                <tbody>
                <g:each in="${pessoaFisicaInstanceList}" status="i" var="pessoaFisicaInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        
                        <td><g:link action="show"
                                    id="${pessoaFisicaInstance.id}">${fieldValue(bean: pessoaFisicaInstance, field: "nome")}</g:link></td>
                        
                        <td>${fieldValue(bean: pessoaFisicaInstance, field: "telefone")}</td>
                        
                        <td>${fieldValue(bean: pessoaFisicaInstance, field: "telefoneAdicional")}</td>
                        
                        <td>${fieldValue(bean: pessoaFisicaInstance, field: "email")}</td>
                        
                        <td>${fieldValue(bean: pessoaFisicaInstance, field: "emailAdicional")}</td>
                        
                        <td>${fieldValue(bean: pessoaFisicaInstance, field: "user")}</td>
                        
                    </tr>
                </g:each>
                </tbody>
            </table>

            <div class="pagination">
                <g:paginate total="${pessoaFisicaInstanceCount ?: 0}"/>
            </div>
        </div>
    </div>
</div>
</body>
</html>

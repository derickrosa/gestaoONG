
<%@ page import="com.acception.cadastro.Financiador" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'financiador.label', default: 'Financiador')}"/>
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

        <div id="list-financiador" class="body" role="main">
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <table class="table table-bordered table-striped">
                <thead>
                <tr>
                    
                    <g:sortableColumn property="codigo"
                                      title="${message(code: 'financiador.codigo.label', default: 'Codigo')}"/>
                    
                    <g:sortableColumn property="nomeFantasia"
                                      title="${message(code: 'financiador.nomeFantasia.label', default: 'Nome Fantasia')}"/>
                    
                    <g:sortableColumn property="sigla"
                                      title="${message(code: 'financiador.sigla.label', default: 'Sigla')}"/>
                    
                    <g:sortableColumn property="dateCreated"
                                      title="${message(code: 'financiador.dateCreated.label', default: 'Date Created')}"/>
                    
                    <g:sortableColumn property="lastUpdated"
                                      title="${message(code: 'financiador.lastUpdated.label', default: 'Last Updated')}"/>
                    
                    <th><g:message code="financiador.participante.label" default="Participante"/></th>
                    
                </tr>
                </thead>
                <tbody>
                <g:each in="${financiadorInstanceList}" status="i" var="financiadorInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        
                        <td><g:link action="show"
                                    id="${financiadorInstance.id}">${fieldValue(bean: financiadorInstance, field: "codigo")}</g:link></td>
                        
                        <td>${fieldValue(bean: financiadorInstance, field: "nomeFantasia")}</td>
                        
                        <td>${fieldValue(bean: financiadorInstance, field: "sigla")}</td>
                        
                        <td><g:formatDate date="${financiadorInstance.dateCreated}"/></td>
                        
                        <td><g:formatDate date="${financiadorInstance.lastUpdated}"/></td>
                        
                        <td>${fieldValue(bean: financiadorInstance, field: "participante")}</td>
                        
                    </tr>
                </g:each>
                </tbody>
            </table>

            <div class="pagination">
                <g:paginate total="${financiadorInstanceCount ?: 0}"/>
            </div>
        </div>
    </div>
</div>
</body>
</html>

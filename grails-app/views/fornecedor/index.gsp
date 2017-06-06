
<%@ page import="com.acception.cadastro.Fornecedor" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'fornecedor.label', default: 'Fornecedor')}"/>
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

        <div id="list-fornecedor" class="body" role="main">
            <g:if test="${flash.message}">
                <div class="alert alert-info" role="status">${flash.message}</div>
            </g:if>
            <table class="table table-bordered table-striped">
                <thead>
                <tr>
                    
                    <g:sortableColumn property="codigo"
                                      title="${message(code: 'fornecedor.codigo.label', default: 'Codigo')}"/>
                    
                    <g:sortableColumn property="ramo"
                                      title="${message(code: 'fornecedor.ramo.label', default: 'Ramo')}"/>
                    
                    <g:sortableColumn property="dateCreated"
                                      title="${message(code: 'fornecedor.dateCreated.label', default: 'Date Created')}"/>
                    
                    <g:sortableColumn property="lastUpdated"
                                      title="${message(code: 'fornecedor.lastUpdated.label', default: 'Last Updated')}"/>
                    
                    <th><g:message code="fornecedor.participante.label" default="Participante"/></th>
                    
                    <g:sortableColumn property="setor"
                                      title="${message(code: 'fornecedor.setor.label', default: 'Setor')}"/>
                    
                </tr>
                </thead>
                <tbody>
                <g:each in="${fornecedorInstanceList}" status="i" var="fornecedorInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        
                        <td><g:link action="show"
                                    id="${fornecedorInstance.id}">${fieldValue(bean: fornecedorInstance, field: "codigo")}</g:link></td>
                        
                        <td>${fieldValue(bean: fornecedorInstance, field: "ramo")}</td>
                        
                        <td><g:formatDate date="${fornecedorInstance.dateCreated}"/></td>
                        
                        <td><g:formatDate date="${fornecedorInstance.lastUpdated}"/></td>
                        
                        <td>${fieldValue(bean: fornecedorInstance, field: "participante")}</td>
                        
                        <td>${fieldValue(bean: fornecedorInstance, field: "setor")}</td>
                        
                    </tr>
                </g:each>
                </tbody>
            </table>

            <div class="pagination">
                <g:paginate total="${fornecedorInstanceCount ?: 0}"/>
            </div>
        </div>
    </div>
</div>
</body>
</html>

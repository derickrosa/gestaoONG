
<%@ page import="com.acception.cadastro.Responsavel" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'responsavel.label', default: 'Responsavel')}"/>
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

        <div id="list-responsavel" class="body" role="main">
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <table class="table table-bordered table-striped">
                <thead>
                <tr>
                    
                    <g:sortableColumn property="codigo"
                                      title="${message(code: 'responsavel.codigo.label', default: 'Codigo')}"/>
                    
                    <g:sortableColumn property="dateCreated"
                                      title="${message(code: 'responsavel.dateCreated.label', default: 'Date Created')}"/>
                    
                    <th><g:message code="responsavel.financiador.label" default="Financiador"/></th>
                    
                    <g:sortableColumn property="lastUpdated"
                                      title="${message(code: 'responsavel.lastUpdated.label', default: 'Last Updated')}"/>
                    
                    <th><g:message code="responsavel.participante.label" default="Participante"/></th>
                    
                </tr>
                </thead>
                <tbody>
                <g:each in="${responsavelInstanceList}" status="i" var="responsavelInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        
                        <td><g:link action="show"
                                    id="${responsavelInstance.id}">${fieldValue(bean: responsavelInstance, field: "codigo")}</g:link></td>
                        
                        <td><g:formatDate date="${responsavelInstance.dateCreated}"/></td>
                        
                        <td>${fieldValue(bean: responsavelInstance, field: "financiador")}</td>
                        
                        <td><g:formatDate date="${responsavelInstance.lastUpdated}"/></td>
                        
                        <td>${fieldValue(bean: responsavelInstance, field: "participante")}</td>
                        
                    </tr>
                </g:each>
                </tbody>
            </table>

            <div class="pagination">
                <g:paginate total="${responsavelInstanceCount ?: 0}"/>
            </div>
        </div>
    </div>
</div>
</body>
</html>

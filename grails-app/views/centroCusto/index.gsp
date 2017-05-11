
<%@ page import="com.acception.cadastro.CentroCusto" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'centroCusto.label', default: 'CentroCusto')}"/>
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

        <div id="list-centroCusto" class="body" role="main">
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <table class="table table-bordered table-striped">
                <thead>
                <tr>
                    
                    <g:sortableColumn property="dataInicio"
                                      title="${message(code: 'centroCusto.dataInicio.label', default: 'Data Inicio')}"/>
                    
                    <g:sortableColumn property="dataFinal"
                                      title="${message(code: 'centroCusto.dataFinal.label', default: 'Data Final')}"/>
                    
                    <th><g:message code="centroCusto.planoDeTrabalho.label" default="Plano De Trabalho"/></th>
                    
                    <g:sortableColumn property="ano"
                                      title="${message(code: 'centroCusto.ano.label', default: 'Ano')}"/>
                    
                    <g:sortableColumn property="codigo"
                                      title="${message(code: 'centroCusto.codigo.label', default: 'Codigo')}"/>
                    
                    <g:sortableColumn property="dateCreated"
                                      title="${message(code: 'centroCusto.dateCreated.label', default: 'Date Created')}"/>
                    
                </tr>
                </thead>
                <tbody>
                <g:each in="${centroCustoInstanceList}" status="i" var="centroCustoInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        
                        <td><g:link action="show"
                                    id="${centroCustoInstance.id}">${fieldValue(bean: centroCustoInstance, field: "dataInicio")}</g:link></td>
                        
                        <td><g:formatDate date="${centroCustoInstance.dataFinal}"/></td>
                        
                        <td>${fieldValue(bean: centroCustoInstance, field: "planoDeTrabalho")}</td>
                        
                        <td>${fieldValue(bean: centroCustoInstance, field: "ano")}</td>
                        
                        <td>${fieldValue(bean: centroCustoInstance, field: "codigo")}</td>
                        
                        <td><g:formatDate date="${centroCustoInstance.dateCreated}"/></td>
                        
                    </tr>
                </g:each>
                </tbody>
            </table>

            <div class="pagination">
                <g:paginate total="${centroCustoInstanceCount ?: 0}"/>
            </div>
        </div>
    </div>
</div>
</body>
</html>

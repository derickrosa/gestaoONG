
<%@ page import="com.acception.cadastro.Orcamento" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'orcamento.label', default: 'Orcamento')}"/>
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

        <div id="list-orcamento" class="body" role="main">
            <g:if test="${flash.message}">
                <div class="alert alert-info" role="status">${flash.message}</div>
            </g:if>
            <table class="table table-bordered table-striped">
                <thead>
                <tr>
                    
                    <g:sortableColumn property="dateCreated"
                                      title="${message(code: 'orcamento.dateCreated.label', default: 'Date Created')}"/>
                    
                    <th><g:message code="orcamento.orcamentoReplanejado.label" default="Orcamento Replanejado"/></th>
                    
                    <g:sortableColumn property="ano"
                                      title="${message(code: 'orcamento.ano.label', default: 'Ano')}"/>
                    
                    <th><g:message code="orcamento.centroCusto.label" default="Centro Custo"/></th>
                    
                    <g:sortableColumn property="moeda"
                                      title="${message(code: 'orcamento.moeda.label', default: 'Moeda')}"/>
                    
                    <g:sortableColumn property="valorCambial"
                                      title="${message(code: 'orcamento.valorCambial.label', default: 'Valor Cambial')}"/>
                    
                </tr>
                </thead>
                <tbody>
                <g:each in="${orcamentoInstanceList}" status="i" var="orcamentoInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        
                        <td><g:link action="show"
                                    id="${orcamentoInstance.id}">${fieldValue(bean: orcamentoInstance, field: "dateCreated")}</g:link></td>
                        
                        <td>${fieldValue(bean: orcamentoInstance, field: "orcamentoReplanejado")}</td>
                        
                        <td>${fieldValue(bean: orcamentoInstance, field: "ano")}</td>
                        
                        <td>${fieldValue(bean: orcamentoInstance, field: "centroCusto")}</td>
                        
                        <td>${fieldValue(bean: orcamentoInstance, field: "moeda")}</td>
                        
                        <td>${fieldValue(bean: orcamentoInstance, field: "valorCambial")}</td>
                        
                    </tr>
                </g:each>
                </tbody>
            </table>

            <div class="pagination">
                <g:paginate total="${orcamentoInstanceCount ?: 0}"/>
            </div>
        </div>
    </div>
</div>
</body>
</html>


<%@ page import="com.acception.cadastro.Lancamento" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'lancamento.label', default: 'Lancamento')}"/>
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

        <div id="list-lancamento" class="body" role="main">
            <g:if test="${flash.message}">
                <div class="alert alert-info" role="status">${flash.message}</div>
            </g:if>
            <table class="table table-bordered table-striped">
                <thead>
                <tr>
                    
                    <g:sortableColumn property="dataPagamento"
                                      title="${message(code: 'lancamento.dataPagamento.label', default: 'Data Pagamento')}"/>
                    
                    <g:sortableColumn property="dataCancelamento"
                                      title="${message(code: 'lancamento.dataCancelamento.label', default: 'Data Cancelamento')}"/>
                    
                    <g:sortableColumn property="parcela"
                                      title="${message(code: 'lancamento.parcela.label', default: 'Parcela')}"/>
                    
                    <th><g:message code="lancamento.tipoAjuste.label" default="Tipo Ajuste"/></th>
                    
                    <g:sortableColumn property="descricao"
                                      title="${message(code: 'lancamento.descricao.label', default: 'Descricao')}"/>
                    
                    <g:sortableColumn property="codigoLancamento"
                                      title="${message(code: 'lancamento.codigoLancamento.label', default: 'Codigo Lancamento')}"/>
                    
                </tr>
                </thead>
                <tbody>
                <g:each in="${lancamentoInstanceList}" status="i" var="lancamentoInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        
                        <td><g:link action="show"
                                    id="${lancamentoInstance.id}">${fieldValue(bean: lancamentoInstance, field: "dataPagamento")}</g:link></td>
                        
                        <td><g:formatDate date="${lancamentoInstance.dataCancelamento}"/></td>
                        
                        <td>${fieldValue(bean: lancamentoInstance, field: "parcela")}</td>
                        
                        <td>${fieldValue(bean: lancamentoInstance, field: "tipoAjuste")}</td>
                        
                        <td>${fieldValue(bean: lancamentoInstance, field: "descricao")}</td>
                        
                        <td>${fieldValue(bean: lancamentoInstance, field: "codigoLancamento")}</td>
                        
                    </tr>
                </g:each>
                </tbody>
            </table>

            <div class="pagination">
                <g:paginate total="${lancamentoInstanceCount ?: 0}"/>
            </div>
        </div>
    </div>
</div>
</body>
</html>

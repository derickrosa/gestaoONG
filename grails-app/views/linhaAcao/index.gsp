
<%@ page import="com.acception.cadastro.LinhaAcao" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'linhaAcao.label')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div id="content">
    <div class="inner" style="min-height: 700px;">
        <div class="row">
            <div class="col-lg-12">
                <h1>Listagem de Linhas de Ação</h1>
            </div>
        </div>
        <hr/>
        <!--BLOCK SECTION -->

        <div class="nav" role="navigation">
        <p>
            <g:link class="btn btn-default" action="create"><span class="glyphicon glyphicon-plus"></span> Criar Linha de Ação</g:link>
        </p>
        </div>

        <div id="list-linhaAcao" class="body" role="main">
            <g:if test="${flash.message}">
                <div class="alert alert-info" role="status">${flash.message}</div>
            </g:if>
            <table class="table table-bordered table-striped">
                <thead>
                <tr>
                    
                    <g:sortableColumn property="nome"
                                      title="${message(code: 'linhaAcao.nome.label', default: 'Nome')}"/>
                    
                    <g:sortableColumn property="descricao"
                                      title="${message(code: 'linhaAcao.descricao.label', default: 'Descrição')}"/>
                    
                    <g:sortableColumn property="codigo"
                                      title="${message(code: 'linhaAcao.codigo.label', default: 'Código')}"/>
                    
                </tr>
                </thead>
                <tbody>
                <g:each in="${linhaAcaoInstanceList}" status="i" var="linhaAcaoInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        
                        <td><g:link action="show"
                                    id="${linhaAcaoInstance.id}">${fieldValue(bean: linhaAcaoInstance, field: "nome")}</g:link></td>
                        
                        <td>${fieldValue(bean: linhaAcaoInstance, field: "descricao")}</td>
                        
                        <td>${fieldValue(bean: linhaAcaoInstance, field: "codigo")}</td>
                        
                    </tr>
                </g:each>
                </tbody>
            </table>

            <div class="pagination">
                <g:paginate total="${linhaAcaoInstanceCount ?: 0}"/>
            </div>
        </div>
    </div>
</div>
</body>
</html>

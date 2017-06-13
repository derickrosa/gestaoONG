
<%@ page import="com.acception.cadastro.RelatorioAtividade" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'relatorioAtividade.label', default: 'RelatorioAtividade')}"/>
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

        <div id="list-relatorioAtividade" class="body" role="main">
            <g:if test="${flash.message}">
                <div class="alert alert-info" role="status">${flash.message}</div>
            </g:if>
            <table class="table table-bordered table-striped">
                <thead>
                <tr>
                    
                    <g:sortableColumn property="comunidadesEnvolvidas"
                                      title="${message(code: 'relatorioAtividade.comunidadesEnvolvidas.label', default: 'Comunidades Envolvidas')}"/>
                    
                    <g:sortableColumn property="totalComunidadesEnvolvidas"
                                      title="${message(code: 'relatorioAtividade.totalComunidadesEnvolvidas.label', default: 'Total Comunidades Envolvidas')}"/>
                    
                    <g:sortableColumn property="municipiosAtendidos"
                                      title="${message(code: 'relatorioAtividade.municipiosAtendidos.label', default: 'Municipios Atendidos')}"/>
                    
                    <g:sortableColumn property="totalMunicipiosAtendidos"
                                      title="${message(code: 'relatorioAtividade.totalMunicipiosAtendidos.label', default: 'Total Municipios Atendidos')}"/>
                    
                    <g:sortableColumn property="numeroParticipantes"
                                      title="${message(code: 'relatorioAtividade.numeroParticipantes.label', default: 'Numero Participantes')}"/>
                    
                    <g:sortableColumn property="numeroHomens"
                                      title="${message(code: 'relatorioAtividade.numeroHomens.label', default: 'Numero Homens')}"/>
                    
                </tr>
                </thead>
                <tbody>
                <g:each in="${relatorioAtividadeInstanceList}" status="i" var="relatorioAtividadeInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        
                        <td><g:link action="show"
                                    id="${relatorioAtividadeInstance.id}">${fieldValue(bean: relatorioAtividadeInstance, field: "comunidadesEnvolvidas")}</g:link></td>
                        
                        <td>${fieldValue(bean: relatorioAtividadeInstance, field: "totalComunidadesEnvolvidas")}</td>
                        
                        <td>${fieldValue(bean: relatorioAtividadeInstance, field: "municipiosAtendidos")}</td>
                        
                        <td>${fieldValue(bean: relatorioAtividadeInstance, field: "totalMunicipiosAtendidos")}</td>
                        
                        <td>${fieldValue(bean: relatorioAtividadeInstance, field: "numeroParticipantes")}</td>
                        
                        <td>${fieldValue(bean: relatorioAtividadeInstance, field: "numeroHomens")}</td>
                        
                    </tr>
                </g:each>
                </tbody>
            </table>

            <div class="pagination">
                <g:paginate total="${relatorioAtividadeInstanceCount ?: 0}"/>
            </div>
        </div>
    </div>
</div>
</body>
</html>

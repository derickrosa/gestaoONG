<%@ page import="com.acception.cadastro.Atividade" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'atividade.label', default: 'Atividade')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<p>
    <g:link class="btn btn-default" action="index"><span class="glyphicon glyphicon-list"></span> <g:message
            code="default.list.label" args="[entityName]"/></g:link>
</p>

<ul class="nav nav-tabs">
    <li class="active"><a href="#dadosBasicos" data-toggle="tab" aria-expanded="false">Dados Básicos</a>
    </li>

    <g:if test="${!atividadeInstance.isSubatividade()}">

        <li><a href="#subatividades " data-toggle="tab" aria-expanded="true">Subatividades / Módulos</a>
        </li>
    </g:if>

    <li><a href="#relatorios" data-toggle="tab" aria-expanded="true">Relatórios</a>
    </li>

    <li><a href="#despesas" data-toggle="tab" aria-expanded="true">Despesas</a></li>
</ul>

<div class="tab-content">
    <div class="tab-pane fade in active" id="dadosBasicos">
        <g:render template="show" model="[atividadeInstance: atividadeInstance]"/>
    </div>
    <g:if test="${!atividadeInstance.isSubatividade()}">
        <div class="tab-pane fade in" id="subatividades">
            <g:render template="showSubatividades" model="[atividadeInstance: atividadeInstance]"/>
        </div>
    </g:if>

    <div class="tab-pane fade in" id="relatorios">
        <g:render template="showRelatorios" model="[atividadeInstance: atividadeInstance]"/>
    </div>

    <div class="tab-pane fade in" id="despesas">
        <g:render template="showDespesas" model="[atividadeInstance: atividadeInstance]"/>
    </div>
</div>
</body>
</html>

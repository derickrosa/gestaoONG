<%@ page import="com.acception.cadastro.Atividade" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'atividade.label', default: 'Atividade')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
    <export:resource/>
</head>

<body>
<%
    def pars = [:]
    pageScope.variables.each { k, v ->
        if (k ==~ /search.*/ && v) pars[k] = v
    }
%>
<div id="content">
    <div class="inner" style="min-height: 700px;">
        <div class="row">
            <div class="col-lg-12">
                <h1>Listagem de Atividade</h1>
            </div>
        </div>
        <hr/>

        <div id="list-atividade" class="body" role="main">
            <g:if test="${flash.message}">
                <div class="alert alert-info" role="status">${flash.message}</div>
            </g:if>


            <div class="form-group">
                <g:form controller="atividade" action="index" class="search-form">
                    <div class="form-group">
                        <g:render template="searchAtividade"/>
                    </div>

                    <div class="row">
                        <button class="btn btn-default center-block search">Procurar <i class="icon-search"></i>
                        </button>
                    </div>
                </g:form>
            </div>

            <table class="table table-bordered table-striped">
                <thead>
                <tr>

                    <g:sortableColumn property="nome"
                                      title="${message(code: 'atividade.nome.label', default: 'Nome')}"/>

                    <g:sortableColumn property="descricao"
                                      title="${message(code: 'atividade.descricao.label', default: 'Descrição')}"/>

                    <th><g:message code="atividade.atividade.label" default="Atividade"/></th>

                    <th><g:message code="atividade.centroCusto.label" default="Centro de Custo"/></th>

                    <g:sortableColumn property="inicio"
                                      title="${message(code: 'atividade.inicio.label', default: 'Início')}"/>

                    <g:sortableColumn property="local"
                                      title="${message(code: 'atividade.local.label', default: 'Local')}"/>

                </tr>
                </thead>
                <tbody>
                <g:if test="${atividadeInstanceCount != 0}">
                    <g:each in="${atividadeInstanceList}" status="i" var="atividadeInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td><g:link action="show"
                                        id="${atividadeInstance.id}">${fieldValue(bean: atividadeInstance, field: "nome")}</g:link></td>

                            <td>${fieldValue(bean: atividadeInstance, field: "descricao")}</td>

                            <td>${fieldValue(bean: atividadeInstance, field: "atividade")}</td>

                            <td>${fieldValue(bean: atividadeInstance, field: "centroCusto")}</td>

                            <td><g:formatDate date="${atividadeInstance.inicio}" format="dd/MM/yyyy"/></td>

                            <td>${fieldValue(bean: atividadeInstance, field: "local")}</td>

                        </tr>
                    </g:each>
                </g:if>
                <g:else>
                    <tr><td colspan="6" class="text-center nao-ha-registros">Não há registros de ${entityName}.</td>
                    </tr>
                </g:else>
                </tbody>
            </table>

            <blockquote class="relatorio">
                <p>Geração de Relatórios</p>
                <export:formats formats="['excel', 'pdf']" params="${params}"/>
            </blockquote>


            <div class="row">
                <div class="col-sm-6">
                    <div class="dataTables_info" id="dataTables-example_info" role="alert" aria-live="polite"
                         aria-relevant="all">Exibindo 1 a 20 de ${atividadeInstanceCount == 1 ? atividadeInstanceCount + ' atividade cadastrada' : atividadeInstanceCount + ' atividades cadastradas'}.</div>
                </div>

                <div class="col-sm-6">
                    <div class="pagination">
                        <g:paginate total="${atividadeInstanceCount ?: 0}"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>

<%@ page import="com.acception.cadastro.CentroCusto" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'centroCusto.label', default: 'Centro de Custo')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
    <style>
    th {
        text-align: center;
    }
    </style>
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
                <h1><g:message code="default.list.label" args="[entityName]"/></h1>
            </div>
        </div>
        <hr/>
        <!--BLOCK SECTION -->

        <div class="nav" role="navigation">
            <p>
                <g:link class="btn btn-default" action="create"><span
                        class="glyphicon glyphicon-plus"></span> <g:message code="default.new.label"
                                                                            args="[entityName]"/></g:link>
            </p>
        </div>

        <div id="list-centroCusto" class="body" role="main">
            <g:if test="${flash.message}">
                <div class="alert alert-info" role="status">${flash.message}</div>
            </g:if>

            <div class="form-group">
                <g:form controller="centroCusto" action="index" class="search-form">
                    <div class="form-group">
                        <g:render template="searchCentroCusto"/>
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
                    <g:sortableColumn property="codigo"
                                      title="${message(code: 'centroCusto.codigo.label', default: 'Código')}"/>

                    <g:sortableColumn property="nome"
                                      title="${message(code: 'centroCusto.nome.label', default: 'Nome')}"/>

                    <g:sortableColumn property="ano"
                                      title="${message(code: 'centroCusto.ano.label', default: 'Ano')}"/>

                    <g:sortableColumn property="dataInicio"
                                      title="${message(code: 'centroCusto.dataInicio.label', default: 'Data Início')}"/>

                    <g:sortableColumn property="dataFinal"
                                      title="${message(code: 'centroCusto.dataFinal.label', default: 'Data Final')}"/>

                    <th><g:message code="centroCusto.planoDeTrabalho.label" default="Plano De Trabalho"/></th>

                    <g:sortableColumn property="statusProjeto"
                                      title="${message(code: 'centroCusto.statusProjeto.label', default: 'Status Projeto')}"/>

                </tr>
                </thead>
                <tbody class="text-center">
                <g:if test="${centroCustoInstanceCount != 0}">
                    <g:each in="${centroCustoInstanceList}" status="i" var="centroCustoInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td><g:link action="show"
                                        id="${centroCustoInstance.id}">${fieldValue(bean: centroCustoInstance, field: "codigo")}</g:link></td>

                            <td>${fieldValue(bean: centroCustoInstance, field: "nome")}</td>

                            <td><g:formatNumber number="${centroCustoInstance.ano}" format="##0"/></td>

                            <td><g:formatDate format="dd/MM/yyyy" date="${centroCustoInstance.dataInicio}"/></td>

                            <td><g:formatDate format="dd/MM/yyyy" date="${centroCustoInstance.dataFinal}"/></td>

                            <td><g:link controller="anexo" action="show"
                                        id="${centroCustoInstance?.planoDeTrabalho?.id}">${centroCustoInstance?.planoDeTrabalho}</g:link></td>

                            <td>${fieldValue(bean: centroCustoInstance, field: "statusProjeto")}</td>

                        </tr>
                    </g:each>
                </g:if>
                <g:else>
                    <tr>
                        <td colspan="5" class="text-center nao-ha-registros">Não há registros de ${entityName}.</td>
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
                         aria-relevant="all">Exibindo 1 a 20 de ${centroCustoInstanceCount == 1 ? centroCustoInstanceCount + ' centro de custo cadastrado' : centroCustoInstanceCount + ' centros de custo cadastrados'}.</div>
                </div>

                <div class="col-sm-6">
                    <div class="pagination">
                        <g:paginate total="${centroCustoInstanceCount ?: 0}"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>

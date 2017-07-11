
<%@ page import="com.acception.cadastro.Despesa" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'despesa.label', default: 'Despesa')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
    <g:set var="df" value="${new java.text.DecimalFormat('###,##0.00')}"/>
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
            <g:link class="btn btn-default" action="create"><span class="glyphicon glyphicon-plus"></span> Criar Despesa </g:link>
        </p>
        </div>

        <div id="list-despesa" class="body" role="main">
            <g:if test="${flash.message}">
                <div class="alert alert-info" role="status">${flash.message}</div>
            </g:if>
            <table class="table table-bordered table-striped text-center">
                <thead>
                <tr>

                    <th class="text-center">Descrição</th>
                    <th class="text-center">Valor</th>
                    <th class="text-center">Tipo Despesa</th>
                    <g:sortableColumn class="text-center" property="data"
                                      title="${message(code: 'despesa.data.label', default: 'Data')}"/>

                    <th class="text-center"><g:message code="despesa.centroCusto.label" default="Centro Custo"/></th>
                    <th class="text-center"><g:message code="despesa.atividade.label" default="Atividade"/></th>

                </tr>
                </thead>
                <tbody>
                <g:each in="${despesaInstanceList}" status="i" var="despesaInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                        <td><g:link action="show" id="${despesaInstance?.id}">${despesaInstance.descricao}</g:link></td>

                        <td>R$ ${df.format(despesaInstance.valor)}</td>

                        <td>${despesaInstance.tipoDespesa?.nome}</td>

                        <td><g:formatDate format="dd/MM/yyyy" date="${despesaInstance.data}"/></td>

                        <td><g:link controller="centroCusto" action="show"
                                    id="${despesaInstance.centroCusto?.id}">${fieldValue(bean: despesaInstance, field: "centroCusto")}</g:link></td>
                        
                        <td>${fieldValue(bean: despesaInstance, field: "atividade")}</td>
                    </tr>
                </g:each>
                </tbody>
            </table>

            <div class="pagination">
                <g:paginate total="${despesaInstanceCount ?: 0}"/>
            </div>
        </div>
    </div>
</div>
</body>
</html>

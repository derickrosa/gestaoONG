<%@ page import="com.acception.cadastro.Adiantamento" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'adiantamento.label', default: 'Adiantamento')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
    <g:set var="df" value="${new java.text.DecimalFormat('###,##0.00')}"/>
</head>

<body>
<div id="content">
    <div class="inner" style="min-height: 700px;">
        <div class="row">
            <div class="col-lg-12">
                <h1><g:message code="default.show.label" args="[entityName]"/></h1>
            </div>
        </div>
        <hr/>


        <ul class="nav nav-tabs">
            <li class="active"><a href="#dadosBasicos" data-toggle="tab" aria-expanded="false">Dados Básicos</a>
            </li>

            <li><a href="#resumosViagem" data-toggle="tab" aria-expanded="true">Resumos de Viagem</a></li>
        </ul>

        <div class="tab-content">
            <g:if test="${flash.message}">
                <div class="alert alert-info" role="status">${flash.message}</div>
            </g:if>


            <div class="tab-pane fade in active" id="dadosBasicos">
                <div id="show-adiantamento" class="content scaffold-show" role="main">
                    <table class="table table-bordered adiantamento">

                        <g:if test="${adiantamentoInstance?.descricao}">
                            <tr>
                                <th id="descricao-label" class="property-label"><g:message code="adiantamento.descricao.label"
                                                                                           default="Descrição"/></th>

                                <td aria-labelledby="descricao-label"><g:fieldValue bean="${adiantamentoInstance}"
                                                                                    field="descricao"/></td>

                            </tr>
                        </g:if>

                        <g:if test="${adiantamentoInstance?.lancamentoOriginal}">
                            <tr>
                                <th id="lancamentoOriginal-label" class="property-label"><g:message
                                        code="adiantamento.lancamentoOriginal.label" default="Lançamento Original"/></th>

                                <td aria-labelledby="lancamentoOriginal-label"><g:link controller="lancamento" action="show"
                                                                                       id="${adiantamentoInstance?.lancamentoOriginal?.id}">${adiantamentoInstance?.lancamentoOriginal?.encodeAsHTML()}</g:link></td>

                            </tr>
                        </g:if>

                        <g:if test="${adiantamentoInstance?.centroCusto}">
                            <tr>
                                <th id="centroCusto-label" class="property-label"><g:message
                                        code="adiantamento.centroCusto.label" default="Centro de Custo"/></th>

                                <td aria-labelledby="centroCusto-label"><g:link controller="centroCusto" action="show"
                                                                                id="${adiantamentoInstance?.centroCusto?.id}">${adiantamentoInstance?.centroCusto?.encodeAsHTML()}</g:link></td>

                            </tr>
                        </g:if>

                        <g:if test="${adiantamentoInstance?.data}">
                            <tr>
                                <th id="data-label" class="property-label"><g:message code="adiantamento.data.label"
                                                                                      default="Data"/></th>

                                <td aria-labelledby="data-label"><g:formatDate date="${adiantamentoInstance?.data}" format="dd/MM/yyyy"/></td>

                            </tr>
                        </g:if>


                        <g:if test="${adiantamentoInstance?.lastUpdated}">
                            <tr>
                                <th id="lastUpdated-label" class="property-label"><g:message
                                        code="adiantamento.lastUpdated.label" default="Última Atualização"/></th>

                                <td aria-labelledby="lastUpdated-label"><g:formatDate
                                        date="${adiantamentoInstance?.lastUpdated}" format="dd/MM/yyyy"/></td>

                            </tr>
                        </g:if>

                        <g:if test="${adiantamentoInstance?.statusAdiantamento}">
                            <tr>
                                <th id="statusAdiantamento-label" class="property-label"><g:message
                                        code="adiantamento.statusAdiantamento.label" default="Status"/></th>

                                <td aria-labelledby="statusAdiantamento-label"><g:fieldValue bean="${adiantamentoInstance.statusAdiantamento}"
                                                                                             field="nome"/></td>

                            </tr>
                        </g:if>

                        <g:if test="${adiantamentoInstance?.valor}">
                            <tr>
                                <th id="valor-label" class="property-label"><g:message code="adiantamento.valor.label"
                                                                                       default="Valor"/></th>

                                <td aria-labelledby="valor-label">R$ ${df.format(adiantamentoInstance.valor)}</td>

                            </tr>
                        </g:if>

                    </table>

                    <g:form url="[resource: adiantamentoInstance, action: 'delete']" method="DELETE">
                        <fieldset class="buttons">
                            <g:link class="btn btn-default" action="edit" resource="${adiantamentoInstance}">
                                <span class="glyphicon glyphicon-edit"></span>
                                <g:message code="default.button.edit.label" default="Edit"/>
                            </g:link>
                            <button type="submit" class="btn btn-default"
                                    onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
                                <span class="glyphicon glyphicon-floppy-remove"></span>
                                <g:message code="default.button.delete.label"/>
                            </button>
                        </fieldset>
                    </g:form>
                    <br/>
                </div>
            </div>

            <div class="tab-pane fade in" id="resumosViagem">
            </div>
        </div>



    </div>
</div>
</body>
</html>

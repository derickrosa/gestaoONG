<%@ page import="com.acception.cadastro.Fornecedor; com.acception.cadastro.Funcionario; com.acception.cadastro.Despesa" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'despesa.label', default: 'Despesa')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
    <g:set var="df" value="${new java.text.DecimalFormat('###,##0.00')}"/>
    <style>
        th {
            text-align: center;
        }
    </style>
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
        <!--BLOCK SECTION -->
        <div class="nav" role="navigation">
            <p>
                <g:link class="btn btn-default" action="index"><span class="glyphicon glyphicon-list"></span> <g:message
                        code="default.list.label" args="[entityName]"/></g:link>
                <g:link class="btn btn-default" action="create"><span
                        class="glyphicon glyphicon-plus"></span> <g:message code="default.new.label"
                                                                            args="[entityName]"/></g:link>
            </p>
        </div>

        <div id="show-despesa" class="content scaffold-show" role="main">
            <g:if test="${flash.message}">
                <div class="alert alert-info" role="status">${flash.message}</div>
            </g:if>

            <table class="table table-bordered despesa">

                <g:if test="${despesaInstance?.valor}">
                    <tr>
                        <th id="valor-label" class="property-label"><g:message code="despesa.valor.label"
                                                                               default="Valor"/></th>

                        <td aria-labelledby="valor-label"><g:fieldValue bean="${despesaInstance}" field="valor"/></td>

                    </tr>
                </g:if>

                <g:if test="${despesaInstance?.descricao}">
                    <tr>
                        <th id="descricao-label" class="property-label"><g:message code="despesa.descricao.label"
                                                                                   default="Descrição"/></th>

                        <td aria-labelledby="descricao-label"><g:fieldValue bean="${despesaInstance}"
                                                                            field="descricao"/></td>

                    </tr>
                </g:if>

                <g:if test="${despesaInstance?.tipoDespesa}">
                    <tr>
                        <th id="tipoDespesa-label" class="property-label"><g:message code="despesa.tipoDespesa.label"
                                                                                     default="Tipo Despesa"/></th>

                        <td aria-labelledby="tipoDespesa-label"><g:fieldValue bean="${despesaInstance.tipoDespesa}"
                                                                              field="nome"/></td>

                    </tr>
                </g:if>

                %{--<g:if test="${despesaInstance?.fornecedor}">
                    <tr>
                        <th id="fornecedor-label" class="property-label"><g:message code="despesa.fornecedor.label"
                                                                                    default="Fornecedor"/></th>

                        <td aria-labelledby="fornecedor-label"><g:link controller="fornecedor" action="show"
                                                                       id="${despesaInstance?.fornecedor?.id}">${despesaInstance?.fornecedor?.encodeAsHTML()}</g:link></td>

                    </tr>
                </g:if>--}%

                <g:if test="${despesaInstance?.atividade}">
                    <tr>
                        <th id="atividade-label" class="property-label"><g:message code="despesa.atividade.label"
                                                                                   default="Atividade"/></th>

                        <td aria-labelledby="atividade-label"><g:link controller="atividade" action="show"
                                                                      id="${despesaInstance?.atividade?.id}">${despesaInstance?.atividade?.encodeAsHTML()}</g:link></td>

                    </tr>
                </g:if>

                <g:if test="${despesaInstance?.papel && despesaInstance?.papel instanceof Funcionario}">
                    <tr>
                        <th id="funcionario-label" class="property-label"><g:message code="despesa.funcionario.label"
                                                                                     default="Funcionário"/></th>

                        <td aria-labelledby="funcionario-label"><g:link controller="funcionario" action="show"
                                                                        id="${despesaInstance?.papel?.id}">${despesaInstance?.papel}</g:link></td>

                    </tr>
                </g:if>

                <g:if test="${despesaInstance?.papel && despesaInstance?.papel instanceof Fornecedor}">
                    <tr>
                        <th id="fornecedor-label" class="property-label"><g:message code="despesa.fornecedor.label"
                                                                                     default="Fornecedor"/></th>

                        <td aria-labelledby="fornecedor-label"><g:link controller="fornecedor" action="show"
                                                                        id="${despesaInstance?.papel?.id}">${despesaInstance?.papel}</g:link></td>

                    </tr>
                </g:if>

                <g:if test="${despesaInstance?.centroCusto}">
                    <tr>
                        <th id="centroCusto-label" class="property-label"><g:message code="despesa.centroCusto.label"
                                                                                     default="Centro de Custo"/></th>

                        <td aria-labelledby="centroCusto-label"><g:link controller="centroCusto" action="show"
                                                                        id="${despesaInstance?.centroCusto?.id}">${despesaInstance?.centroCusto?.encodeAsHTML()}</g:link></td>

                    </tr>
                </g:if>

                <g:if test="${despesaInstance?.data}">
                    <tr>
                        <th id="data-label" class="property-label"><g:message code="despesa.data.label"
                                                                              default="Data"/></th>

                        <td aria-labelledby="data-label"><g:formatDate date="${despesaInstance?.data}" format="dd/MM/yyyy"/></td>

                    </tr>
                </g:if>

            </table>

            <g:if test="${despesaInstance?.lancamentos}">
                <div class="panel panel-success">
                    <div class="panel-heading">
                        Lançamentos
                    </div>

                    <div class="panel-body">
                        <table class="table table-hover text-center">
                            <thead>
                            <tr>
                                <th>#</th>
                                <th>Valor</th>
                                <th>Data Emissão</th>
                                <th>Tipo</th>
                                <th>Status</th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each in="${despesaInstance?.lancamentos?.sort { it.parcela }}" var="l">
                                <tr>
                                    <td>${l.parcela}</td>
                                    <td>R$ ${df.format(l.valor ?: 0)}</td>
                                    <td><g:formatDate date="${l.dataEmissao}" format="dd/MM/yyyy"/></td>
                                    <td>${l.tipoLancamento?.nome}</td>
                                    <td>${l.statusLancamento?.nome}</td>
                                </tr>
                            </g:each>

                            </tbody>
                        </table>
                    </div>
                </div>
            </g:if>

            <g:form url="[resource: despesaInstance, action: 'delete']" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="btn btn-default" action="edit" resource="${despesaInstance}">
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
</div>
</body>
</html>

<%@ page import="com.acception.cadastro.Lancamento" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'lancamento.label', default: 'Lancamento')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<p>
    <g:link class="btn btn-default" action="index"><span class="glyphicon glyphicon-list"></span> <g:message
            code="default.list.label" args="[entityName]"/></g:link>
    <g:link class="btn btn-default" action="create"><span class="glyphicon glyphicon-plus"></span> <g:message
            code="default.new.label" args="[entityName]"/></g:link>
</p>

<table class="table table-bordered lancamento">

    <g:if test="${lancamentoInstance?.dataPagamento}">
        <tr>
            <th id="dataPagamento-label" class="property-label"><g:message code="lancamento.dataPagamento.label"
                                                                           default="Data Pagamento"/></th>

            <td aria-labelledby="dataPagamento-label"><g:formatDate date="${lancamentoInstance?.dataPagamento}"/></td>

        </tr>
    </g:if>

    <g:if test="${lancamentoInstance?.dataCancelamento}">
        <tr>
            <th id="dataCancelamento-label" class="property-label"><g:message code="lancamento.dataCancelamento.label"
                                                                              default="Data Cancelamento"/></th>

            <td aria-labelledby="dataCancelamento-label"><g:formatDate
                    date="${lancamentoInstance?.dataCancelamento}"/></td>

        </tr>
    </g:if>

    <g:if test="${lancamentoInstance?.parcela}">
        <tr>
            <th id="parcela-label" class="property-label"><g:message code="lancamento.parcela.label"
                                                                     default="Parcela"/></th>

            <td aria-labelledby="parcela-label"><g:fieldValue bean="${lancamentoInstance}" field="parcela"/></td>

        </tr>
    </g:if>

    <g:if test="${lancamentoInstance?.tipoAjuste}">
        <tr>
            <th id="tipoAjuste-label" class="property-label"><g:message code="lancamento.tipoAjuste.label"
                                                                        default="Tipo Ajuste"/></th>

            <td aria-labelledby="tipoAjuste-label"><g:link controller="tipoAjuste" action="show"
                                                           id="${lancamentoInstance?.tipoAjuste?.id}">${lancamentoInstance?.tipoAjuste?.encodeAsHTML()}</g:link></td>

        </tr>
    </g:if>

    <g:if test="${lancamentoInstance?.descricao}">
        <tr>
            <th id="descricao-label" class="property-label"><g:message code="lancamento.descricao.label"
                                                                       default="Descricao"/></th>

            <td aria-labelledby="descricao-label"><g:fieldValue bean="${lancamentoInstance}" field="descricao"/></td>

        </tr>
    </g:if>

    <g:if test="${lancamentoInstance?.codigoLancamento}">
        <tr>
            <th id="codigoLancamento-label" class="property-label"><g:message code="lancamento.codigoLancamento.label"
                                                                              default="Codigo Lancamento"/></th>

            <td aria-labelledby="codigoLancamento-label"><g:fieldValue bean="${lancamentoInstance}"
                                                                       field="codigoLancamento"/></td>

        </tr>
    </g:if>

    <g:if test="${lancamentoInstance?.numeroTitulo}">
        <tr>
            <th id="numeroTitulo-label" class="property-label"><g:message code="lancamento.numeroTitulo.label"
                                                                          default="Numero Titulo"/></th>

            <td aria-labelledby="numeroTitulo-label"><g:fieldValue bean="${lancamentoInstance}"
                                                                   field="numeroTitulo"/></td>

        </tr>
    </g:if>

    <g:if test="${lancamentoInstance?.eventoFinanceiro}">
        <tr>
            <th id="eventoFinanceiro-label" class="property-label"><g:message code="lancamento.eventoFinanceiro.label"
                                                                              default="Evento Financeiro"/></th>

            <td aria-labelledby="eventoFinanceiro-label"><g:link controller="eventoFinanceiro" action="show"
                                                                 id="${lancamentoInstance?.eventoFinanceiro?.id}">${lancamentoInstance?.eventoFinanceiro?.encodeAsHTML()}</g:link></td>

        </tr>
    </g:if>

    <g:if test="${lancamentoInstance?.documento}">
        <tr>
            <th id="documento-label" class="property-label"><g:message code="lancamento.documento.label"
                                                                       default="Documento"/></th>

            <td aria-labelledby="documento-label"><g:link controller="anexo" action="show"
                                                          id="${lancamentoInstance?.documento?.id}">${lancamentoInstance?.documento?.encodeAsHTML()}</g:link></td>

        </tr>
    </g:if>

    <g:if test="${lancamentoInstance?.centroCusto}">
        <tr>
            <th id="centroCusto-label" class="property-label"><g:message code="lancamento.centroCusto.label"
                                                                         default="Centro Custo"/></th>

            <td aria-labelledby="centroCusto-label"><g:link controller="centroCusto" action="show"
                                                            id="${lancamentoInstance?.centroCusto?.id}">${lancamentoInstance?.centroCusto?.encodeAsHTML()}</g:link></td>

        </tr>
    </g:if>

    <g:if test="${lancamentoInstance?.dataEmissao}">
        <tr>
            <th id="dataEmissao-label" class="property-label"><g:message code="lancamento.dataEmissao.label"
                                                                         default="Data Emissao"/></th>

            <td aria-labelledby="dataEmissao-label"><g:formatDate date="${lancamentoInstance?.dataEmissao}"/></td>

        </tr>
    </g:if>

    <g:if test="${lancamentoInstance?.dateCreated}">
        <tr>
            <th id="dateCreated-label" class="property-label"><g:message code="lancamento.dateCreated.label"
                                                                         default="Date Created"/></th>

            <td aria-labelledby="dateCreated-label"><g:formatDate date="${lancamentoInstance?.dateCreated}"/></td>

        </tr>
    </g:if>

    <g:if test="${lancamentoInstance?.lastUpdated}">
        <tr>
            <th id="lastUpdated-label" class="property-label"><g:message code="lancamento.lastUpdated.label"
                                                                         default="Last Updated"/></th>

            <td aria-labelledby="lastUpdated-label"><g:formatDate date="${lancamentoInstance?.lastUpdated}"/></td>

        </tr>
    </g:if>

    <g:if test="${lancamentoInstance?.papel}">
        <tr>
            <th id="papel-label" class="property-label"><g:message code="lancamento.papel.label" default="Papel"/></th>

            <td aria-labelledby="papel-label"><g:link controller="papel" action="show"
                                                      id="${lancamentoInstance?.papel?.id}">${lancamentoInstance?.papel?.encodeAsHTML()}</g:link></td>

        </tr>
    </g:if>

    <g:if test="${lancamentoInstance?.statusLancamento}">
        <tr>
            <th id="statusLancamento-label" class="property-label"><g:message code="lancamento.statusLancamento.label"
                                                                              default="Status Lancamento"/></th>

            <td aria-labelledby="statusLancamento-label"><g:fieldValue bean="${lancamentoInstance}"
                                                                       field="statusLancamento"/></td>

        </tr>
    </g:if>

    <g:if test="${lancamentoInstance?.tipoLancamento}">
        <tr>
            <th id="tipoLancamento-label" class="property-label"><g:message code="lancamento.tipoLancamento.label" default="Tipo Lancamento"/></th>
            <td aria-labelledby="tipoLancamento-label"><g:fieldValue bean="${lancamentoInstance}" field="tipoLancamento"/></td>
        </tr>
    </g:if>

    <g:if test="${lancamentoInstance?.valor}">
        <tr>
            <th id="valor-label" class="property-label"><g:message code="lancamento.valor.label" default="Valor"/></th>
            <td aria-labelledby="valor-label"><g:fieldValue bean="${lancamentoInstance}" field="valor"/></td>
        </tr>
    </g:if>

</table>

<g:form url="[resource: lancamentoInstance, action: 'delete']" method="DELETE">
    <fieldset class="buttons">
        <g:link class="btn btn-default" action="edit" resource="${lancamentoInstance}">
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
</body>
</html>

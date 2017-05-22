<%@ page import="com.acception.cadastro.CentroCusto" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'centroCusto.label', default: 'Centro de Custo')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
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

        <div id="show-centroCusto" class="content scaffold-show" role="main">
            <g:if test="${flash.message}">
                <div class="alert alert-info">
                    ${flash.message}
                </div>
            </g:if>

            <div class="panel panel-default">
                <div class="panel-heading">
                    Dados Básicos
                </div>

                <div class="panel-body">
                    <table class="table table-bordered centroCusto">

                        <g:if test="${centroCustoInstance?.codigo}">
                            <tr>
                                <th id="codigo-label" class="property-label"><g:message code="centroCusto.codigo.label"
                                                                                        default="Código"/></th>

                                <td aria-labelledby="codigo-label"><g:fieldValue bean="${centroCustoInstance}"
                                                                                 field="codigo"/></td>

                            </tr>
                        </g:if>

                        <g:if test="${centroCustoInstance?.nome}">
                            <tr>
                                <th id="nome-label" class="property-label"><g:message code="centroCusto.nome.label"
                                                                                      default="Nome"/></th>

                                <td aria-labelledby="nome-label"><g:fieldValue bean="${centroCustoInstance}" field="nome"/></td>

                            </tr>
                        </g:if>

                        <g:if test="${centroCustoInstance?.ano}">
                            <tr>
                                <th id="ano-label" class="property-label"><g:message code="centroCusto.ano.label"
                                                                                     default="Ano"/></th>

                                <td aria-labelledby="ano-label"><g:fieldValue bean="${centroCustoInstance}" field="ano"/></td>

                            </tr>
                        </g:if>

                        <g:if test="${centroCustoInstance?.descricao}">
                            <tr>
                                <th id="descricao-label" class="property-label"><g:message code="centroCusto.descricao.label"
                                                                                           default="Descrição"/></th>

                                <td aria-labelledby="descricao-label"><g:fieldValue bean="${centroCustoInstance}"
                                                                                    field="descricao"/></td>

                            </tr>
                        </g:if>

                        <g:if test="${centroCustoInstance?.dataInicio}">
                            <tr>
                                <th id="dataInicio-label" class="property-label"><g:message code="centroCusto.dataInicio.label"
                                                                                            default="Data Início"/></th>

                                <td aria-labelledby="dataInicio-label"><g:formatDate
                                        date="${centroCustoInstance?.dataInicio}" format="dd/MM/yyyy"/></td>

                            </tr>
                        </g:if>

                        <g:if test="${centroCustoInstance?.dataFinal}">
                            <tr>
                                <th id="dataFinal-label" class="property-label"><g:message code="centroCusto.dataFinal.label"
                                                                                           default="Data Final"/></th>

                                <td aria-labelledby="dataFinal-label"><g:formatDate
                                        date="${centroCustoInstance?.dataFinal}" format="dd/MM/yyyy"/></td>

                            </tr>
                        </g:if>

                        <g:if test="${centroCustoInstance?.planoDeTrabalho}">
                            <tr>
                                <th id="planoDeTrabalho-label" class="property-label"><g:message
                                        code="centroCusto.planoDeTrabalho.label" default="Plano De Trabalho"/></th>




                                <td aria-labelledby="planoDeTrabalho-label">
                                    <a href="${createLink(controller: 'anexo', action: 'download', id: "${centroCustoInstance?.planoDeTrabalho?.id}")}">${centroCustoInstance?.planoDeTrabalho?.nome}</a>
                                </td>

                            </tr>
                        </g:if>

                        <g:if test="${centroCustoInstance?.statusProjeto}">
                            <tr>
                                <th id="statusProjeto-label" class="property-label"><g:message
                                        code="centroCusto.statusProjeto.label" default="Status do Projeto"/></th>

                                <td aria-labelledby="statusProjeto-label"><g:fieldValue bean="${centroCustoInstance}"
                                                                                        field="statusProjeto"/></td>

                            </tr>
                        </g:if>

                        <g:if test="${centroCustoInstance?.financiador}">
                            <tr>
                                <th id="financiador-label" class="property-label">Financiador</th>

                                <td aria-labelledby="financiador-label">
                                    <a href="${createLink(action: 'show', controller: 'financiador',
                                            id: centroCustoInstance.financiador.id)}">${centroCustoInstance.financiador}</a>
                                </td>
                            </tr>
                        </g:if>

                        <g:if test="${centroCustoInstance?.responsavel}">
                            <tr>
                                <th id="responsavel-label" class="property-label">Responsável</th>

                                <td aria-labelledby="responsavel-label">
                                    <a href="${createLink(action: 'show', controller: 'responsavel',
                                            id: centroCustoInstance.responsavel.id)}">${centroCustoInstance.responsavel}</a>
                                </td>
                            </tr>
                        </g:if>


                    </table>
                </div>

            </div>

            %{--<g:if test="${centroCustoInstance.orcamento}">--}%
                <div class="panel panel-info">
                    <div class="panel-heading">
                        Orçamento
                    </div>

                   %{-- <div class="panel-body">
                        <table class="table table-bordered centroCusto">

                            <g:if test="${centroCustoInstance?.orcamento?.ano}">
                                <tr>
                                    <th id="orcamento.ano-label" class="property-label" width="34%">Ano</th>

                                    <td aria-labelledby="orcamento.ano-label"><g:fieldValue bean="${centroCustoInstance.orcamento}"
                                                                                     field="ano"/></td>

                                </tr>
                            </g:if>

                            <g:if test="${centroCustoInstance?.orcamento?.valorTotal}">
                                <tr>
                                    <th id="orcamento.valorTotal-label" class="property-label">Valor Total</th>

                                    <td aria-labelledby="orcamento.valorTotal-label"><g:fieldValue bean="${centroCustoInstance.orcamento}"
                                                                                            field="valorTotal"/></td>
                                </tr>
                            </g:if>

                            <g:if test="${centroCustoInstance?.orcamento?.moeda}">
                                <tr>
                                    <th id="orcamento.moeda-label" class="property-label">Moeda</th>

                                    <td aria-labelledby="orcamento.moeda-label"><g:fieldValue bean="${centroCustoInstance.orcamento}"
                                                                                                   field="moeda"/></td>
                                </tr>
                            </g:if>

                            <tr></tr>
                        </table>

                    </div>--}%
                </div>

                %{--<g:if test="${centroCustoInstance.orcamento.itensOrcamentarios}">--}%
                    <div class="panel panel-success">
                        <div class="panel-heading">
                            Itens Orçamentários
                        </div>

                        %{--<div class="panel-body">
                            <table class="table table-hover text-center">
                                <thead>
                                    <tr>
                                        <th class="text-center">Código</th>
                                        <th class="text-center">Nome</th>
                                        <th class="text-center">Valor</th>
                                        <th class="text-center">Tipo Custo</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <g:each in="${centroCustoInstance.orcamento.itensOrcamentarios}" var="item">
                                        <tr>
                                            <td>${item.codigo}</td>
                                            <td>${item.nome}</td>
                                            <td>${item.valor}</td>
                                            <td>${item.tipoCusto}</td>
                                        </tr>
                                    </g:each>
                                </tbody>
                            </table>
                        </div>--}%
                    </div>
                %{--</g:if>--}%
            %{--</g:if>--}%

            <g:form url="[resource: centroCustoInstance, action: 'delete']" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="btn btn-default" action="edit" resource="${centroCustoInstance}">
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
        </div>
    </div>
</div>
</body>
</html>

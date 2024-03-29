<%@ page import="com.acception.cadastro.Financiador" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'financiador.label', default: 'Financiador')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<p>
    <g:link class="btn btn-default" action="index"><span class="glyphicon glyphicon-list"></span> <g:message
            code="default.list.label" args="[entityName]"/></g:link>
    <g:link class="btn btn-default" action="create"><span
            class="glyphicon glyphicon-plus"></span> <g:message code="default.new.label"
                                                                args="[entityName]"/></g:link>
</p>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-primary">
            <div class="panel-heading control-label">
                Informações Básicas
            </div>

            <div class="panel-body">

                <table class="table table-bordered financiador">
                    <g:if test="${financiadorInstance?.participante?.nome}">
                        <tr>
                            <th id="participante-nome-label" class="property-label"><g:message
                                    code="financiador.participante.nome.label" default="Nome"/></th>

                            <td aria-labelledby="nomeFantasia-label"><g:fieldValue
                                    bean="${financiadorInstance}" field="participante.nome"/></td>

                        </tr>
                    </g:if>

                    <g:if test="${financiadorInstance?.participante?.cnpj}">
                        <tr>
                            <th id="participante-cnpj-label" class="property-label"><g:message
                                    code="financiador.participante.cnpj.label" default="CNPJ"/></th>

                            <td aria-labelledby="nomeFantasia-label"><g:formatCnpj cnpj="${financiadorInstance.participante.cnpj}"/></td>

                        </tr>
                    </g:if>

                    <g:if test="${financiadorInstance?.sigla}">
                        <tr>
                            <th id="sigla-label" class="property-label"><g:message
                                    code="financiador.sigla.label" default="Sigla"/></th>

                            <td aria-labelledby="sigla-label"><g:fieldValue bean="${financiadorInstance}"
                                                                            field="sigla"/></td>

                        </tr>
                    </g:if>

                    <g:if test="${financiadorInstance?.centrosCusto}">
                        <tr>
                            <th id="centrosCusto-label" class="property-label"><g:message
                                    code="financiador.centrosCusto.label" default="Centros Custo"/></th>
                            <td aria-labelledby="centrosCusto-label">
                                <g:each in="${financiadorInstance.centrosCusto}" var="c">
                                    <g:link controller="centroCusto" action="show"
                                            id="${c.id}">${c?.encodeAsHTML()},</g:link>
                                </g:each>
                            </td>

                        </tr>
                    </g:if>

                    <g:if test="${financiadorInstance?.dateCreated}">
                        <tr>
                            <th id="dateCreated-label" class="property-label"><g:message
                                    code="financiador.dateCreated.label" default="Data de Cadastro"/></th>

                            <td aria-labelledby="dateCreated-label"><g:formatDate
                                    date="${financiadorInstance?.dateCreated}"/></td>

                        </tr>
                    </g:if>

                    <g:if test="${financiadorInstance?.lastUpdated}">
                        <tr>
                            <th id="lastUpdated-label" class="property-label"><g:message
                                    code="financiador.lastUpdated.label"
                                    default="Data de Última Alteração"/></th>

                            <td aria-labelledby="lastUpdated-label"><g:formatDate
                                    date="${financiadorInstance?.lastUpdated}"/></td>

                        </tr>
                    </g:if>

                    <g:if test="${financiadorInstance?.setor}">
                        <tr>
                            <th id="setor-label" class="property-label"><g:message
                                    code="financiador.setor.label" default="Setor"/></th>

                            <td aria-labelledby="setor-label"><g:fieldValue bean="${financiadorInstance}"
                                                                            field="setor"/></td>

                        </tr>
                    </g:if>

                </table>

            </div>
        </div>
        <!-- /.panel -->
    </div>
</div>
<g:if test="${financiadorInstance?.responsaveis}">
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-primary">
                <div class="panel-heading control-label">
                    Responsáveis
                </div>
                <!-- /.panel-heading -->
                <div class="panel-body">
                    <table class="table table-striped table-bordered table-hover text-center">
                        <thead>
                        <tr>
                            <th class="text-center">Nome</th>
                            <th class="text-center">Email</th>
                            <th class="text-center">Telefone</th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:each in="${financiadorInstance.responsaveis}" var="r">
                            <tr>
                                <td>
                                    <g:link controller="responsavel" action="show"
                                            id="${r.id}">${r.participante?.nome}</g:link>
                                </td>
                                <td>
                                    ${r.participante?.email}
                                </td>
                                <td>
                                    ${r.participante?.telefone}
                                </td>

                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- /.panel -->
        </div>
    </div>
</g:if>

<g:form url="[resource: financiadorInstance, action: 'delete']" method="DELETE">
    <fieldset class="buttons">
        <g:link class="btn btn-default" action="edit" resource="${financiadorInstance}">
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

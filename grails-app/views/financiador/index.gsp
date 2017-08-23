<%@ page import="com.acception.cadastro.Financiador" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'financiador.label', default: 'Financiador')}"/>
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

        <div id="list-financiador" class="body" role="main">
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>

            <div class="form-group">
                <g:form controller="financiador" action="index" class="search-form">
                    <div class="form-group">
                        <g:render template="search"/>
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
                                      title="${message(code: 'financiador.codigo.label', default: 'Codigo')}"/>

                    <g:sortableColumn property="participante.nome"
                                      title="${message(code: 'financiador.nome.label', default: 'Nome')}"/>

                    <g:sortableColumn property="participante.cnpj"
                                      title="${message(code: 'financiador.cnpj.label', default: 'CNPJ')}"/>

                    <g:sortableColumn property="sigla"
                                      title="${message(code: 'financiador.sigla.label', default: 'Sigla')}"/>

                    <g:sortableColumn property="dateCreated"
                                      title="${message(code: 'financiador.dateCreated.label', default: 'Data de Cadastro')}"/>

                </tr>
                </thead>
                <tbody>
                <g:if test="${financiadorInstanceCount != 0}">
                    <g:each in="${financiadorInstanceList}" status="i" var="financiadorInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td><g:link action="show"
                                        id="${financiadorInstance.id}">${fieldValue(bean: financiadorInstance, field: "codigo")}</g:link></td>

                            <td>${fieldValue(bean: financiadorInstance, field: "participante.nome")}</td>


                            <td><g:formatCnpj cnpj="${financiadorInstance.participante.cnpj}"/></td>

                            <td>${fieldValue(bean: financiadorInstance, field: "sigla")}</td>

                            <td><g:formatDate date="${financiadorInstance.dateCreated}" format="dd/MM/yyyy"/></td>

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
                         aria-relevant="all">Exibindo 1 a 20 de ${financiadorInstanceCount == 1 ? financiadorInstanceCount + ' financiador cadastrado' : financiadorInstanceCount + ' financiadores cadastrados'}.</div>
                </div>

                <div class="col-sm-6">
                    <div class="pagination">
                        <g:paginate total="${financiadorInstanceCount ?: 0}"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>

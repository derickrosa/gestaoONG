<%@ page import="com.acception.cadastro.Funcionario" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'funcionario.label', default: 'Funcionários')}"/>
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
                <h1>Listagem de Funcionários</h1>
            </div>
        </div>
        <hr/>
        <!--BLOCK SECTION -->

        <div class="nav" role="navigation">
            <p>
                <g:link class="btn btn-default" action="create"><span
                        class="glyphicon glyphicon-plus"></span> Novo Funcionário</g:link>
            </p>
        </div>

        <div id="list-funcionario" class="body" role="main">
            <g:if test="${flash.message}">
                <div class="alert alert-info" role="status">
                    ${flash.message}
                </div>
            </g:if>

            <div class="form-group">
                <g:form controller="funcionario" action="index" class="search-form">
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

                    <g:sortableColumn property="nome"
                                      title="${message(code: 'funcionario.nome.label', default: 'Nome')}"/>

                    <th><g:message code="funcionario.telefone.label" default="Telefone"/></th>

                    <g:sortableColumn property="email"
                                      title="${message(code: 'funcionario.email.label', default: 'Email')}"/>

                    <th>Cargo</th>
                </tr>
                </thead>
                <tbody>
                <g:if test="${funcionarioInstanceCount != 0}">
                    <g:each in="${funcionarioInstanceList}" status="i" var="funcionarioInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td><g:link action="show"
                                        id="${funcionarioInstance.id}">${fieldValue(bean: funcionarioInstance, field: "participante.nome")}</g:link></td>

                            <td>${fieldValue(bean: funcionarioInstance, field: "participante.telefone")}</td>

                            <td>${fieldValue(bean: funcionarioInstance, field: "participante.email")}</td>


                            <td>${fieldValue(bean: funcionarioInstance, field: "cargo")}</td>

                        </tr>
                    </g:each>
                </g:if>
                <g:else>
                    <tr>
                        <td colspan="4" class="text-center nao-ha-registros">Não há registros de ${entityName}.</td>
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
                         aria-relevant="all">Exibindo 1 a 20 de ${funcionarioInstanceCount == 1 ? funcionarioInstanceCount + ' funcionário cadastrado' : funcionarioInstanceCount + ' funcionários cadastrados'}.</div>
                </div>

                <div class="col-sm-6">
                    <div class="pagination">
                        <g:paginate total="${funcionarioInstanceCount ?: 0}"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>

<%@ page import="com.acception.cadastro.Funcionario" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
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
<p>
    <g:link class="btn btn-default" action="create"><span
            class="glyphicon glyphicon-plus"></span> Novo Funcionário</g:link>
</p>

<pesquisa:painel>
    <div class="form-group col-md-12">
        <label class="control-label" for="searchNome">Nome:</label>
        <g:textField class="form-control" name="searchNome" value="${searchNome}"/>
    </div>
</pesquisa:painel>

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
</body>
</html>

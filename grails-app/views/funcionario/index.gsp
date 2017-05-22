
<%@ page import="com.acception.cadastro.Funcionario" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'funcionario.label', default: 'Funcionários')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
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
            <g:link class="btn btn-default" action="create"><span class="glyphicon glyphicon-plus"></span> Novo Funcionário</g:link>
        </p>
        </div>

        <div id="list-funcionario" class="body" role="main">
            <g:if test="${flash.message}">
                <div class="alert alert-info" role="status">
                    ${flash.message}
                </div>
            </g:if>

            <g:if test="${funcionarioInstanceList}">
                <table class="table table-bordered table-striped">
                    <thead>
                    <tr>

                        <g:sortableColumn property="nome"
                                          title="${message(code: 'funcionario.nome.label', default: 'Nome')}"/>

                        <th><g:message code="funcionario.telefone.label" default="Telefone"/></th>

                        <g:sortableColumn property="email"
                                          title="${message(code: 'funcionario.email.label', default: 'Email')}"/>

                        <th>CPF</th>

                        <th>Cargo</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${funcionarioInstanceList}" status="i" var="funcionarioInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td><g:link action="show"
                                        id="${funcionarioInstance.id}">${fieldValue(bean: funcionarioInstance, field: "nome")}</g:link></td>

                            <td>${fieldValue(bean: funcionarioInstance, field: "telefone")}</td>

                            <td>${fieldValue(bean: funcionarioInstance, field: "email")}</td>

                            <td>${com.acception.util.Util.rawToCpf(funcionarioInstance.cpf)}</td>

                            <td>${fieldValue(bean: funcionarioInstance, field: "cargo")}</td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </g:if>
            <g:else>
                <div class="well text-center">Sem registros!</div>
            </g:else>

            <div class="pagination">
                <g:paginate total="${funcionarioInstanceCount ?: 0}"/>
            </div>
        </div>
    </div>
</div>
</body>
</html>

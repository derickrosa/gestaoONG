<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'funcionario.label', default: 'Funcionários')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
    <export:resource/>
</head>

<body>

<p>
    <g:link class="btn btn-default" action="create">
        <span class="glyphicon glyphicon-plus"></span> Novo Funcionário
    </g:link>
</p>

<pesquisa:painel>
    <div class="form-group col-md-4">
        <label class="control-label" for="pesquisa.nome">Nome:</label>
        <g:textField class="form-control" name="pesquisa.nome" value="${pesquisa?.nome}"/>
    </div>

    <div class="form-group col-md-4">
        <label class="control-label" for="pesquisa.cargo">Cargo:</label>
        <g:textField class="form-control" name="pesquisa.cargo" value="${pesquisa?.cargo}"/>
    </div>

    <div class="form-group col-md-2">
        <label class="control-label" for="pesquisa.setor">Setor:</label>
        <g:select name="pesquisa.setor" from="${com.acception.cadastro.enums.RamoFuncionario.values()}"
        class="form-control" optionKey="key" value="${pesquisa?.setor}" noSelection="['': 'Todos']"/>
    </div>
</pesquisa:painel>

<g:if test="${funcionarioInstanceCount != 0}">
    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <g:sortableColumn params="${pesquisa}" property="nome" title="${message(code: 'funcionario.nome.label', default: 'Nome')}"/>
            <th><g:message code="funcionario.telefone.label" default="Telefone"/></th>
            <g:sortableColumn params="${pesquisa}" property="email" title="${message(code: 'funcionario.email.label', default: 'Email')}"/>
            <th>Cargo</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${funcionarioInstanceList}" var="funcionarioInstance">
            <tr>
                <td><g:link action="show" id="${funcionarioInstance.id}">${fieldValue(bean: funcionarioInstance, field: "participante.nome")}</g:link></td>
                <td>${fieldValue(bean: funcionarioInstance, field: "participante.telefone")}</td>
                <td>${fieldValue(bean: funcionarioInstance, field: "participante.email")}</td>
                <td>${fieldValue(bean: funcionarioInstance, field: "cargo")}</td>
            </tr>
        </g:each>
        </tbody>
    </table>
    <g:paginate total="${funcionarioInstanceCount ?: 0}"/>


    <blockquote>
        <p>Exportar Relatório</p>
        <export:formats formats="['excel', 'pdf']" params="${pesquisa}"/>
    </blockquote>
</g:if>
<g:else>
    <pesquisa:dadosNaoEncontrados/>
</g:else>
</body>
</html>

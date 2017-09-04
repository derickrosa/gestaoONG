<%@ page import="com.acception.cadastro.PessoaFisica;" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'fornecedor.label', default: 'Fornecedor')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
    <export:resource/>
</head>

<body>
<p>
    <g:link class="btn btn-default" action="create">
        <span class="glyphicon glyphicon-plus"></span>
        <g:message code="default.new.label" args="[entityName]"/>
    </g:link>
</p>

<pesquisa:painel>
    <div class="form-group col-md-2">
        <label class="control-label" for="pesquisa.nome">Nome:</label>
        <g:textField class="form-control" name="pesquisa.nome" value="${pesquisa?.nome}"/>
    </div>

    <div class="form-group col-md-2">
        <label class="control-label" for="pesquisa.codigo">Código:</label>
        <g:textField class="form-control" name="pesquisa.codigo" value="${pesquisa?.codigo}"/>
    </div>

    <div class="form-group col-md-2">
        <label class="control-label" for="pesquisa.cnpj">CNPJ:</label>
        <g:textField class="form-control cnpj" name="pesquisa.cnpj" value="${pesquisa?.cnpj}"/>
    </div>

    <div class="form-group col-md-2">
        <label class="control-label" for="pesquisa.cpf">CPF:</label>
        <g:textField class="form-control cpf" name="pesquisa.cpf" value="${pesquisa?.cpf}"/>
    </div>

    <div class="form-group col-md-2">
        <label class="control-label" for="pesquisa.ramo">Ramo:</label>
        <g:textField class="form-control" name="pesquisa.ramo" value="${pesquisa?.ramo}"/>
    </div>

    <div class="form-group col-md-2">
        <label class="control-label" for="pesquisa.setor">Setor:</label>
        <g:select name="pesquisa.setor" from="${com.acception.cadastro.enums.Setor.values()}"
            class="form-control" noSelection="['': 'Todos']" value="${pesquisa.setor}" optionKey="key"/>
    </div>
</pesquisa:painel>

<g:if test="${fornecedorInstanceCount != 0}">
    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <g:sortableColumn params="${pesquisa}" property="nome" title="${message(code: 'fornecedor.codigo.label', default: 'Nome')}"/>
            <g:sortableColumn params="${pesquisa}" property="codigo" title="${message(code: 'fornecedor.codigo.label', default: 'Codigo')}"/>
            <th>Documento</th>
            <g:sortableColumn params="${pesquisa}" property="ramo" title="${message(code: 'fornecedor.ramo.label', default: 'Ramo')}"/>
            <g:sortableColumn params="${pesquisa}" property="setor" title="${message(code: 'fornecedor.setor.label', default: 'Setor')}"/>
        </tr>
        </thead>
        <tbody>
        <g:each in="${fornecedorInstanceList}" var="fornecedorInstance">
            <tr>
                <td><g:link action="show" id="${fornecedorInstance.id}">${fieldValue(bean: fornecedorInstance, field: "participante.nome")}</g:link></td>
                <td><g:link action="show" id="${fornecedorInstance.id}">${fieldValue(bean: fornecedorInstance, field: "codigo")}</g:link></td>
                <td>
                    <g:if test="${fornecedorInstance.participante instanceof PessoaFisica}">
                        CPF: <g:formatCpf cpf="${fornecedorInstance.participante?.cpf}"/>
                    </g:if>
                    <g:else>CNPJ: <g:formatCnpj cnpj="${fornecedorInstance.participante?.cnpj}"/></g:else>
                </td>
                <td>${fieldValue(bean: fornecedorInstance, field: "ramo")}</td>
                <td>${fieldValue(bean: fornecedorInstance, field: "setor")}</td>
            </tr>
        </g:each>
        </tbody>
    </table>
    <g:paginate total="${fornecedorInstanceCount ?: 0}"/>

    <blockquote>
        <p>Geração de Relatórios</p>
        <export:formats formats="['excel', 'pdf']" params="${pesquisa}"/>
    </blockquote>
</g:if>
<g:else>
    <pesquisa:dadosNaoEncontrados/>
</g:else>
</body>
</html>

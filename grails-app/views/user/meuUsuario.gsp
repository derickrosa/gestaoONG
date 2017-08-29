<%@ page import="com.acception.security.User" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title>Meu Usuário</title>

    <script type="text/javascript">
        $(document).ready(function(){
            submitFormByAjax($("form#form-portador"));
        });
    </script>
</head>

<body>

<p>
    <g:link class="btn btn-default" controller="home" action="index">
        <span class="glyphicon glyphicon-home"></span>
        <g:message code="default.home.label" default="Início"/>
    </g:link>

    <g:link class="btn btn-default" action="index">
        <span class="glyphicon glyphicon-list"></span>
        <g:message code="default.list.label" args="[entityName]"/>
    </g:link>
</p>

<table class="table table-bordered user">
    <g:if test="${userInstance?.nome}">
        <tr>
            <th id="nome-label" class="property-label"><g:message code="user.nome.label" default="Nome" /></th>
            <td  aria-labelledby="nome-label"><g:fieldValue bean="${userInstance}" field="nome"/></td>
        </tr>
    </g:if>


    <g:if test="${userInstance?.username}">
        <tr>
            <th id="username-label" class="property-label"><g:message code="user.username.label" default="Login" /></th>
            <td  aria-labelledby="username-label"><g:fieldValue bean="${userInstance}" field="username"/></td>
        </tr>
    </g:if>

    <g:if test="${userInstance?.email}">
        <tr>
            <th id="email-label" class="property-label"><g:message code="user.email.label" default="E-mail" /></th>
            <td  aria-labelledby="email-label"><g:fieldValue bean="${userInstance}" field="email"/></td>
        </tr>
    </g:if>

    <tr>
        <th id="passwordExpired-label" class="property-label"><g:message code="user.passwordExpired.label" default="Papéis" /></th>
        <td  aria-labelledby="passwordExpired-label">${userInstance?.authorities?.nome?.join(', ')}</td>
    </tr>
</table>


<modal:criarUsandoBotaoAtivacao id="alterarSenhaModal" modalTitle="Alterar Senha" buttonClass="danger"
                                buttonIconClass="glyphicon-lock" buttonTitle="Alterar Senha">

    <g:form name="form-portador" controller="user" action="changePassword">
        <g:hiddenField name="id" value="${userInstance?.id}"/>
        <p class="form-control-static">Usuário: <strong class="text-uppercase">${userInstance.username}</strong></p>

        <div class="form-group">
            <input type="password" name="senha" id="senha" placeholder="Nova Senha" class="form-control" required/>
        </div>

        <div class="input-group">
            <input type="password" class="form-control" id="confirmarSenha" name="confirmarSenha" placeholder="Nova Senha" required>
            <span class="input-group-btn">
                <button class="btn btn-primary" type="submit">Alterar</button>
            </span>
        </div>
    </g:form>
</modal:criarUsandoBotaoAtivacao>
</body>
</html>

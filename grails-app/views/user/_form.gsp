<%@ page import="com.acception.security.UserRole" %>
<g:if test="${userInstance.hasErrors()}">
    <div class="alert alert-danger" role="alert">
        <g:renderErrors as="list" bean="${userInstance}"/>
    </div>
</g:if>

<h3>Dados Básicos</h3>

<div class="row">
    <div class="form-group col-md-6">
        <label for="nome">Nome *</label>
        <g:textField class="form-control" name="nome" value="${userInstance?.nome}"
                     required="required" placeholder="Primeiro e último nome do usuário."/>
    </div>

    <div class="form-group col-md-6">
        <label for="username">Login *</label>
        <g:textField class="form-control" name="username" value="${userInstance?.username}" required="required"
                     placeholder="Nome de usuário utilizado para acessar o sistema (sem espaços)."/>
    </div>

    <g:if test="${userInstance?.password == null}">
        <div class="form-group col-md-6">
            <label for="password">Senha *</label>
            <g:passwordField class="form-control" name="password" required="required"
                             placeholder="A senha do usuário para seu acesso."/>
        </div>
    </g:if>

    <div class="form-group col-md-6">
        <label for="email">E-mail *</label>
        <input type="email" class="form-control" name="email" id="email" value="${userInstance?.email}"
               required placeholder="E-mail para recuperação de senha."/>
    </div>
</div>

<hr/>

<h3>Permissões</h3>

<div class="list-group">
    <g:each in="${authorityList}" var="authority">
        <span class="list-group-item">
            <h4 class="list-group-item-heading">
                <g:checkBox checked="${userInstance?.id && UserRole.countByUserAndRole(userInstance, authority) > 0}"
                            value="${authority.id}" name="roles"/>
                <strong> ${authority.nome}</strong>
            </h4>

            <p class="list-group-item-text">${authority.descricao}</p>
        </span>
    </g:each>
</div>
<%@ page import="com.acception.cadastro.PessoaFisica" %>



<div class="form-group fieldcontain ${hasErrors(bean: pessoaFisicaInstance, field: 'nome', 'error')} ">
    <label for="nome">
        <g:message code="pessoaFisica.nome.label" default="Nome"/>
        
    </label>
    <g:textField class="form-control"  name="nome" maxlength="100" value="${pessoaFisicaInstance?.nome}"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: pessoaFisicaInstance, field: 'telefone', 'error')} ">
    <label for="telefone">
        <g:message code="pessoaFisica.telefone.label" default="Telefone"/>
        
    </label>
    <g:select class="form-control" id="telefone" name="telefone.id" from="${com.acception.cadastro.Telefone.list()}" optionKey="id" value="${pessoaFisicaInstance?.telefone?.id}" class="form-control" noSelection="['null': '']"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: pessoaFisicaInstance, field: 'telefoneAdicional', 'error')} ">
    <label for="telefoneAdicional">
        <g:message code="pessoaFisica.telefoneAdicional.label" default="Telefone Adicional"/>
        
    </label>
    <g:select class="form-control" id="telefoneAdicional" name="telefoneAdicional.id" from="${com.acception.cadastro.Telefone.list()}" optionKey="id" value="${pessoaFisicaInstance?.telefoneAdicional?.id}" class="form-control" noSelection="['null': '']"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: pessoaFisicaInstance, field: 'email', 'error')} ">
    <label for="email">
        <g:message code="pessoaFisica.email.label" default="Email"/>
        
    </label>
    <g:field type="email" class="form-control" placeholder="exemplo@mail.com"  name="email" value="${pessoaFisicaInstance?.email}"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: pessoaFisicaInstance, field: 'emailAdicional', 'error')} ">
    <label for="emailAdicional">
        <g:message code="pessoaFisica.emailAdicional.label" default="Email Adicional"/>
        
    </label>
    <g:field type="email" class="form-control" placeholder="exemplo@mail.com"  name="emailAdicional" value="${pessoaFisicaInstance?.emailAdicional}"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: pessoaFisicaInstance, field: 'user', 'error')} ">
    <label for="user">
        <g:message code="pessoaFisica.user.label" default="User"/>
        
    </label>
    <g:select class="form-control" id="user" name="user.id" from="${com.acception.security.User.list()}" optionKey="id" value="${pessoaFisicaInstance?.user?.id}" class="form-control" noSelection="['null': '']"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: pessoaFisicaInstance, field: 'papeis', 'error')} ">
    <label for="papeis">
        <g:message code="pessoaFisica.papeis.label" default="Papeis"/>
        
    </label>
    
<ul class="list-group">
<g:each in="${pessoaFisicaInstance?.papeis?}" var="p">
    <li class="list-group"><g:link controller="papel" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="list-group active">
<g:link controller="papel" action="create" params="['pessoaFisica.id': pessoaFisicaInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'papel.label', default: 'Papel')])}</g:link>
</li>
</ul>


</div>

<div class="form-group fieldcontain ${hasErrors(bean: pessoaFisicaInstance, field: 'senhaInicial', 'error')} ">
    <label for="senhaInicial">
        <g:message code="pessoaFisica.senhaInicial.label" default="Senha Inicial"/>
        
    </label>
    <g:textField class="form-control"  name="senhaInicial" maxlength="64" value="${pessoaFisicaInstance?.senhaInicial}"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: pessoaFisicaInstance, field: 'cpf', 'error')} ">
    <label for="cpf">
        <g:message code="pessoaFisica.cpf.label" default="Cpf"/>
        
    </label>
    <g:textField class="form-control"  name="cpf" maxlength="11" value="${pessoaFisicaInstance?.cpf}"/>

</div>


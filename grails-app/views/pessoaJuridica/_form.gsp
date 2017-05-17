<%@ page import="com.acception.cadastro.PessoaJuridica" %>



<div class="form-group fieldcontain ${hasErrors(bean: pessoaJuridicaInstance, field: 'nome', 'error')} ">
    <label for="nome">
        <g:message code="pessoaJuridica.nome.label" default="Nome"/>
        
    </label>
    <g:textField class="form-control"  name="nome" maxlength="100" value="${pessoaJuridicaInstance?.nome}"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: pessoaJuridicaInstance, field: 'telefone', 'error')} ">
    <label for="telefone">
        <g:message code="pessoaJuridica.telefone.label" default="Telefone"/>
        
    </label>
    <g:select class="form-control" id="telefone" name="telefone.id" from="${com.acception.cadastro.Telefone.list()}" optionKey="id" value="${pessoaJuridicaInstance?.telefone?.id}" class="form-control" noSelection="['null': '']"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: pessoaJuridicaInstance, field: 'telefoneAdicional', 'error')} ">
    <label for="telefoneAdicional">
        <g:message code="pessoaJuridica.telefoneAdicional.label" default="Telefone Adicional"/>
        
    </label>
    <g:select class="form-control" id="telefoneAdicional" name="telefoneAdicional.id" from="${com.acception.cadastro.Telefone.list()}" optionKey="id" value="${pessoaJuridicaInstance?.telefoneAdicional?.id}" class="form-control" noSelection="['null': '']"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: pessoaJuridicaInstance, field: 'email', 'error')} ">
    <label for="email">
        <g:message code="pessoaJuridica.email.label" default="Email"/>
        
    </label>
    <g:field type="email" class="form-control" placeholder="exemplo@mail.com"  name="email" value="${pessoaJuridicaInstance?.email}"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: pessoaJuridicaInstance, field: 'emailAdicional', 'error')} ">
    <label for="emailAdicional">
        <g:message code="pessoaJuridica.emailAdicional.label" default="Email Adicional"/>
        
    </label>
    <g:field type="email" class="form-control" placeholder="exemplo@mail.com"  name="emailAdicional" value="${pessoaJuridicaInstance?.emailAdicional}"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: pessoaJuridicaInstance, field: 'user', 'error')} ">
    <label for="user">
        <g:message code="pessoaJuridica.user.label" default="User"/>
        
    </label>
    <g:select class="form-control" id="user" name="user.id" from="${com.acception.security.User.list()}" optionKey="id" value="${pessoaJuridicaInstance?.user?.id}" class="form-control" noSelection="['null': '']"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: pessoaJuridicaInstance, field: 'papeis', 'error')} ">
    <label for="papeis">
        <g:message code="pessoaJuridica.papeis.label" default="Papeis"/>
        
    </label>
    
<ul class="list-group">
<g:each in="${pessoaJuridicaInstance?.papeis?}" var="p">
    <li class="list-group"><g:link controller="papel" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="list-group active">
<g:link controller="papel" action="create" params="['pessoaJuridica.id': pessoaJuridicaInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'papel.label', default: 'Papel')])}</g:link>
</li>
</ul>


</div>

<div class="form-group fieldcontain ${hasErrors(bean: pessoaJuridicaInstance, field: 'senhaInicial', 'error')} ">
    <label for="senhaInicial">
        <g:message code="pessoaJuridica.senhaInicial.label" default="Senha Inicial"/>
        
    </label>
    <g:textField class="form-control"  name="senhaInicial" maxlength="64" value="${pessoaJuridicaInstance?.senhaInicial}"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: pessoaJuridicaInstance, field: 'cnpj', 'error')} ">
    <label for="cnpj">
        <g:message code="pessoaJuridica.cnpj.label" default="Cnpj"/>
        
    </label>
    <g:textField class="form-control"  name="cnpj" maxlength="14" value="${pessoaJuridicaInstance?.cnpj}"/>

</div>


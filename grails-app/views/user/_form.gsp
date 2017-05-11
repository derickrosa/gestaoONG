<%@ page import="com.acception.security.User" %>



<div class="form-group fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} ">
    <label for="username">
        <g:message code="user.username.label" default="Username"/>
        
    </label>
    <g:textField class="form-control"  name="username" value="${userInstance?.username}"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} ">
    <label for="password">
        <g:message code="user.password.label" default="Password"/>
        
    </label>
    <g:textField class="form-control"  name="password" value="${userInstance?.password}"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: userInstance, field: 'email', 'error')} ">
    <label for="email">
        <g:message code="user.email.label" default="Email"/>
        
    </label>
    <g:textField class="form-control"  name="email" value="${userInstance?.email}"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: userInstance, field: 'accountExpired', 'error')} ">
    <label for="accountExpired">
        <g:message code="user.accountExpired.label" default="Account Expired"/>
        
    </label>
    <g:checkBox name="accountExpired" value="${userInstance?.accountExpired}" />

</div>

<div class="form-group fieldcontain ${hasErrors(bean: userInstance, field: 'accountLocked', 'error')} ">
    <label for="accountLocked">
        <g:message code="user.accountLocked.label" default="Account Locked"/>
        
    </label>
    <g:checkBox name="accountLocked" value="${userInstance?.accountLocked}" />

</div>

<div class="form-group fieldcontain ${hasErrors(bean: userInstance, field: 'enabled', 'error')} ">
    <label for="enabled">
        <g:message code="user.enabled.label" default="Enabled"/>
        
    </label>
    <g:checkBox name="enabled" value="${userInstance?.enabled}" />

</div>

<div class="form-group fieldcontain ${hasErrors(bean: userInstance, field: 'initialPassword', 'error')} ">
    <label for="initialPassword">
        <g:message code="user.initialPassword.label" default="Initial Password"/>
        
    </label>
    <g:textField class="form-control"  name="initialPassword" value="${userInstance?.initialPassword}"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: userInstance, field: 'nome', 'error')} ">
    <label for="nome">
        <g:message code="user.nome.label" default="Nome"/>
        
    </label>
    <g:textField class="form-control"  name="nome" value="${userInstance?.nome}"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: userInstance, field: 'passwordExpired', 'error')} ">
    <label for="passwordExpired">
        <g:message code="user.passwordExpired.label" default="Password Expired"/>
        
    </label>
    <g:checkBox name="passwordExpired" value="${userInstance?.passwordExpired}" />

</div>


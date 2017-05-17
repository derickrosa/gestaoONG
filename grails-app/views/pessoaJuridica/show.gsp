
<%@ page import="com.acception.cadastro.PessoaJuridica" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'pessoaJuridica.label', default: 'PessoaJuridica')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
	<div id="content">
		<div class="inner" style="min-height: 700px;">
			<div class="row">
				<div class="col-lg-12">
					<h1><g:message code="default.show.label" args="[entityName]"/></h1>
				</div>
			</div>
			<hr/>
			<!--BLOCK SECTION -->
		<div class="nav" role="navigation">
			<p>
				<g:link class="btn btn-default" action="index"><span class="glyphicon glyphicon-list"></span> <g:message code="default.list.label" args="[entityName]" /></g:link>
				<g:link class="btn btn-default" action="create"><span class="glyphicon glyphicon-plus"></span> <g:message code="default.new.label" args="[entityName]" /></g:link>
			</p>
		</div>

		<div id="show-pessoaJuridica" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>

			<table class="table table-bordered pessoaJuridica">
				
				<g:if test="${pessoaJuridicaInstance?.nome}">
					<tr>
						<th id="nome-label" class="property-label"><g:message code="pessoaJuridica.nome.label" default="Nome" /></th>
						
						<td  aria-labelledby="nome-label"><g:fieldValue bean="${pessoaJuridicaInstance}" field="nome"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${pessoaJuridicaInstance?.telefone}">
					<tr>
						<th id="telefone-label" class="property-label"><g:message code="pessoaJuridica.telefone.label" default="Telefone" /></th>
						
						<td  aria-labelledby="telefone-label"><g:link controller="telefone" action="show" id="${pessoaJuridicaInstance?.telefone?.id}">${pessoaJuridicaInstance?.telefone?.encodeAsHTML()}</g:link></td>
						
					</tr>
				</g:if>
				
				<g:if test="${pessoaJuridicaInstance?.telefoneAdicional}">
					<tr>
						<th id="telefoneAdicional-label" class="property-label"><g:message code="pessoaJuridica.telefoneAdicional.label" default="Telefone Adicional" /></th>
						
						<td  aria-labelledby="telefoneAdicional-label"><g:link controller="telefone" action="show" id="${pessoaJuridicaInstance?.telefoneAdicional?.id}">${pessoaJuridicaInstance?.telefoneAdicional?.encodeAsHTML()}</g:link></td>
						
					</tr>
				</g:if>
				
				<g:if test="${pessoaJuridicaInstance?.email}">
					<tr>
						<th id="email-label" class="property-label"><g:message code="pessoaJuridica.email.label" default="Email" /></th>
						
						<td  aria-labelledby="email-label"><g:fieldValue bean="${pessoaJuridicaInstance}" field="email"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${pessoaJuridicaInstance?.emailAdicional}">
					<tr>
						<th id="emailAdicional-label" class="property-label"><g:message code="pessoaJuridica.emailAdicional.label" default="Email Adicional" /></th>
						
						<td  aria-labelledby="emailAdicional-label"><g:fieldValue bean="${pessoaJuridicaInstance}" field="emailAdicional"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${pessoaJuridicaInstance?.user}">
					<tr>
						<th id="user-label" class="property-label"><g:message code="pessoaJuridica.user.label" default="User" /></th>
						
						<td  aria-labelledby="user-label"><g:link controller="user" action="show" id="${pessoaJuridicaInstance?.user?.id}">${pessoaJuridicaInstance?.user?.encodeAsHTML()}</g:link></td>
						
					</tr>
				</g:if>
				
				<g:if test="${pessoaJuridicaInstance?.papeis}">
					<tr>
						<th id="papeis-label" class="property-label"><g:message code="pessoaJuridica.papeis.label" default="Papeis" /></th>
						
						<g:each in="${pessoaJuridicaInstance.papeis}" var="p">
							<td aria-labelledby="papeis-label"><g:link controller="papel" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></td>
						</g:each>
						
					</tr>
				</g:if>
				
				<g:if test="${pessoaJuridicaInstance?.senhaInicial}">
					<tr>
						<th id="senhaInicial-label" class="property-label"><g:message code="pessoaJuridica.senhaInicial.label" default="Senha Inicial" /></th>
						
						<td  aria-labelledby="senhaInicial-label"><g:fieldValue bean="${pessoaJuridicaInstance}" field="senhaInicial"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${pessoaJuridicaInstance?.cnpj}">
					<tr>
						<th id="cnpj-label" class="property-label"><g:message code="pessoaJuridica.cnpj.label" default="Cnpj" /></th>
						
						<td  aria-labelledby="cnpj-label"><g:fieldValue bean="${pessoaJuridicaInstance}" field="cnpj"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${pessoaJuridicaInstance?.dateCreated}">
					<tr>
						<th id="dateCreated-label" class="property-label"><g:message code="pessoaJuridica.dateCreated.label" default="Date Created" /></th>
						
						<td  aria-labelledby="dateCreated-label"><g:formatDate date="${pessoaJuridicaInstance?.dateCreated}" /></td>
						
					</tr>
				</g:if>
				
				<g:if test="${pessoaJuridicaInstance?.lastUpdated}">
					<tr>
						<th id="lastUpdated-label" class="property-label"><g:message code="pessoaJuridica.lastUpdated.label" default="Last Updated" /></th>
						
						<td  aria-labelledby="lastUpdated-label"><g:formatDate date="${pessoaJuridicaInstance?.lastUpdated}" /></td>
						
					</tr>
				</g:if>
				
			</table>

			<g:form url="[resource:pessoaJuridicaInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="btn btn-default" action="edit" resource="${pessoaJuridicaInstance}">
						<span class="glyphicon glyphicon-edit"></span>
						<g:message code="default.button.edit.label" default="Edit" />
					</g:link>
					<button type="submit" class="btn btn-default" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
						<span class="glyphicon glyphicon-floppy-remove"></span>
						<g:message code="default.button.delete.label"/>
					</button>
				</fieldset>
			</g:form>
		</div>
		</div>
	</body>
</html>

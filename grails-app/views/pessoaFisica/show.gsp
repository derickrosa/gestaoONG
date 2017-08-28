
<%@ page import="com.acception.cadastro.PessoaFisica" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layout-restrito">
		<g:set var="entityName" value="${message(code: 'pessoaFisica.label', default: 'PessoaFisica')}" />
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

		<div id="show-pessoaFisica" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>

			<table class="table table-bordered pessoaFisica">
				
				<g:if test="${pessoaFisicaInstance?.nome}">
					<tr>
						<th id="nome-label" class="property-label"><g:message code="pessoaFisica.nome.label" default="Nome" /></th>
						
						<td  aria-labelledby="nome-label"><g:fieldValue bean="${pessoaFisicaInstance}" field="nome"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${pessoaFisicaInstance?.telefone}">
					<tr>
						<th id="telefone-label" class="property-label"><g:message code="pessoaFisica.telefone.label" default="Telefone" /></th>
						
						<td  aria-labelledby="telefone-label"><g:link controller="telefone" action="show" id="${pessoaFisicaInstance?.telefone?.id}">${pessoaFisicaInstance?.telefone?.encodeAsHTML()}</g:link></td>
						
					</tr>
				</g:if>
				
				<g:if test="${pessoaFisicaInstance?.telefoneAdicional}">
					<tr>
						<th id="telefoneAdicional-label" class="property-label"><g:message code="pessoaFisica.telefoneAdicional.label" default="Telefone Adicional" /></th>
						
						<td  aria-labelledby="telefoneAdicional-label"><g:link controller="telefone" action="show" id="${pessoaFisicaInstance?.telefoneAdicional?.id}">${pessoaFisicaInstance?.telefoneAdicional?.encodeAsHTML()}</g:link></td>
						
					</tr>
				</g:if>
				
				<g:if test="${pessoaFisicaInstance?.email}">
					<tr>
						<th id="email-label" class="property-label"><g:message code="pessoaFisica.email.label" default="Email" /></th>
						
						<td  aria-labelledby="email-label"><g:fieldValue bean="${pessoaFisicaInstance}" field="email"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${pessoaFisicaInstance?.emailAdicional}">
					<tr>
						<th id="emailAdicional-label" class="property-label"><g:message code="pessoaFisica.emailAdicional.label" default="Email Adicional" /></th>
						
						<td  aria-labelledby="emailAdicional-label"><g:fieldValue bean="${pessoaFisicaInstance}" field="emailAdicional"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${pessoaFisicaInstance?.user}">
					<tr>
						<th id="user-label" class="property-label"><g:message code="pessoaFisica.user.label" default="User" /></th>
						
						<td  aria-labelledby="user-label"><g:link controller="user" action="show" id="${pessoaFisicaInstance?.user?.id}">${pessoaFisicaInstance?.user?.encodeAsHTML()}</g:link></td>
						
					</tr>
				</g:if>
				
				<g:if test="${pessoaFisicaInstance?.papeis}">
					<tr>
						<th id="papeis-label" class="property-label"><g:message code="pessoaFisica.papeis.label" default="Papeis" /></th>
						
						<g:each in="${pessoaFisicaInstance.papeis}" var="p">
							<td aria-labelledby="papeis-label"><g:link controller="papel" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></td>
						</g:each>
						
					</tr>
				</g:if>
				
				<g:if test="${pessoaFisicaInstance?.senhaInicial}">
					<tr>
						<th id="senhaInicial-label" class="property-label"><g:message code="pessoaFisica.senhaInicial.label" default="Senha Inicial" /></th>
						
						<td  aria-labelledby="senhaInicial-label"><g:fieldValue bean="${pessoaFisicaInstance}" field="senhaInicial"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${pessoaFisicaInstance?.cpf}">
					<tr>
						<th id="cpf-label" class="property-label"><g:message code="pessoaFisica.cpf.label" default="Cpf" /></th>
						
						<td  aria-labelledby="cpf-label"><g:fieldValue bean="${pessoaFisicaInstance}" field="cpf"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${pessoaFisicaInstance?.dateCreated}">
					<tr>
						<th id="dateCreated-label" class="property-label"><g:message code="pessoaFisica.dateCreated.label" default="Date Created" /></th>
						
						<td  aria-labelledby="dateCreated-label"><g:formatDate date="${pessoaFisicaInstance?.dateCreated}" /></td>
						
					</tr>
				</g:if>
				
				<g:if test="${pessoaFisicaInstance?.lastUpdated}">
					<tr>
						<th id="lastUpdated-label" class="property-label"><g:message code="pessoaFisica.lastUpdated.label" default="Last Updated" /></th>
						
						<td  aria-labelledby="lastUpdated-label"><g:formatDate date="${pessoaFisicaInstance?.lastUpdated}" /></td>
						
					</tr>
				</g:if>
				
			</table>

			<g:form url="[resource:pessoaFisicaInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="btn btn-default" action="edit" resource="${pessoaFisicaInstance}">
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

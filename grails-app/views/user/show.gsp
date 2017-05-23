
<%@ page import="com.acception.security.User" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
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

		<div id="show-user" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="alert alert-info" role="status">${flash.message}</div>
			</g:if>

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

			<g:form url="[resource:userInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="btn btn-default" action="edit" resource="${userInstance}">
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

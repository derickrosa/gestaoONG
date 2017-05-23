
<%@ page import="com.acception.security.Role" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'role.label', default: 'Role')}" />
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

		<div id="show-role" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="alert alert-info" role="status">${flash.message}</div>
			</g:if>

			<table class="table table-bordered role">
				
				<g:if test="${roleInstance?.authority}">
					<tr>
						<th id="authority-label" class="property-label"><g:message code="role.authority.label" default="Authority" /></th>
						
						<td  aria-labelledby="authority-label"><g:fieldValue bean="${roleInstance}" field="authority"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${roleInstance?.nome}">
					<tr>
						<th id="nome-label" class="property-label"><g:message code="role.nome.label" default="Nome" /></th>
						
						<td  aria-labelledby="nome-label"><g:fieldValue bean="${roleInstance}" field="nome"/></td>
						
					</tr>
				</g:if>
				
			</table>

			<g:form url="[resource:roleInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="btn btn-default" action="edit" resource="${roleInstance}">
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

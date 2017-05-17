
<%@ page import="com.acception.cadastro.Responsavel" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'responsavel.label', default: 'Responsavel')}" />
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

		<div id="show-responsavel" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>

			<table class="table table-bordered responsavel">
				
				<g:if test="${responsavelInstance?.codigo}">
					<tr>
						<th id="codigo-label" class="property-label"><g:message code="responsavel.codigo.label" default="Codigo" /></th>
						
						<td  aria-labelledby="codigo-label"><g:fieldValue bean="${responsavelInstance}" field="codigo"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${responsavelInstance?.dateCreated}">
					<tr>
						<th id="dateCreated-label" class="property-label"><g:message code="responsavel.dateCreated.label" default="Date Created" /></th>
						
						<td  aria-labelledby="dateCreated-label"><g:formatDate date="${responsavelInstance?.dateCreated}" /></td>
						
					</tr>
				</g:if>
				
				<g:if test="${responsavelInstance?.financiador}">
					<tr>
						<th id="financiador-label" class="property-label"><g:message code="responsavel.financiador.label" default="Financiador" /></th>
						
						<td  aria-labelledby="financiador-label"><g:link controller="financiador" action="show" id="${responsavelInstance?.financiador?.id}">${responsavelInstance?.financiador?.encodeAsHTML()}</g:link></td>
						
					</tr>
				</g:if>
				
				<g:if test="${responsavelInstance?.lastUpdated}">
					<tr>
						<th id="lastUpdated-label" class="property-label"><g:message code="responsavel.lastUpdated.label" default="Last Updated" /></th>
						
						<td  aria-labelledby="lastUpdated-label"><g:formatDate date="${responsavelInstance?.lastUpdated}" /></td>
						
					</tr>
				</g:if>
				
				<g:if test="${responsavelInstance?.participante}">
					<tr>
						<th id="participante-label" class="property-label"><g:message code="responsavel.participante.label" default="Participante" /></th>
						
						<td  aria-labelledby="participante-label"><g:link controller="participante" action="show" id="${responsavelInstance?.participante?.id}">${responsavelInstance?.participante?.encodeAsHTML()}</g:link></td>
						
					</tr>
				</g:if>
				
			</table>

			<g:form url="[resource:responsavelInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="btn btn-default" action="edit" resource="${responsavelInstance}">
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

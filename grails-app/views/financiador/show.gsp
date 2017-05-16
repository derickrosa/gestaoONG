
<%@ page import="com.acception.cadastro.Financiador" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'financiador.label', default: 'Financiador')}" />
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

		<div id="show-financiador" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>

			<table class="table table-bordered financiador">
				
				<g:if test="${financiadorInstance?.codigo}">
					<tr>
						<th id="codigo-label" class="property-label"><g:message code="financiador.codigo.label" default="Codigo" /></th>
						
						<td  aria-labelledby="codigo-label"><g:fieldValue bean="${financiadorInstance}" field="codigo"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${financiadorInstance?.nomeFantasia}">
					<tr>
						<th id="nomeFantasia-label" class="property-label"><g:message code="financiador.nomeFantasia.label" default="Nome Fantasia" /></th>
						
						<td  aria-labelledby="nomeFantasia-label"><g:fieldValue bean="${financiadorInstance}" field="nomeFantasia"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${financiadorInstance?.sigla}">
					<tr>
						<th id="sigla-label" class="property-label"><g:message code="financiador.sigla.label" default="Sigla" /></th>
						
						<td  aria-labelledby="sigla-label"><g:fieldValue bean="${financiadorInstance}" field="sigla"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${financiadorInstance?.centrosCusto}">
					<tr>
						<th id="centrosCusto-label" class="property-label"><g:message code="financiador.centrosCusto.label" default="Centros Custo" /></th>
						
						<g:each in="${financiadorInstance.centrosCusto}" var="c">
							<td aria-labelledby="centrosCusto-label"><g:link controller="centroCusto" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></td>
						</g:each>
						
					</tr>
				</g:if>
				
				<g:if test="${financiadorInstance?.dateCreated}">
					<tr>
						<th id="dateCreated-label" class="property-label"><g:message code="financiador.dateCreated.label" default="Date Created" /></th>
						
						<td  aria-labelledby="dateCreated-label"><g:formatDate date="${financiadorInstance?.dateCreated}" /></td>
						
					</tr>
				</g:if>
				
				<g:if test="${financiadorInstance?.lastUpdated}">
					<tr>
						<th id="lastUpdated-label" class="property-label"><g:message code="financiador.lastUpdated.label" default="Last Updated" /></th>
						
						<td  aria-labelledby="lastUpdated-label"><g:formatDate date="${financiadorInstance?.lastUpdated}" /></td>
						
					</tr>
				</g:if>
				
				<g:if test="${financiadorInstance?.participante}">
					<tr>
						<th id="participante-label" class="property-label"><g:message code="financiador.participante.label" default="Participante" /></th>
						
						<td  aria-labelledby="participante-label"><g:link controller="participante" action="show" id="${financiadorInstance?.participante?.id}">${financiadorInstance?.participante?.encodeAsHTML()}</g:link></td>
						
					</tr>
				</g:if>
				
				<g:if test="${financiadorInstance?.responsaveis}">
					<tr>
						<th id="responsaveis-label" class="property-label"><g:message code="financiador.responsaveis.label" default="Responsaveis" /></th>
						
						<g:each in="${financiadorInstance.responsaveis}" var="r">
							<td aria-labelledby="responsaveis-label"><g:link controller="responsavel" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></td>
						</g:each>
						
					</tr>
				</g:if>
				
				<g:if test="${financiadorInstance?.setor}">
					<tr>
						<th id="setor-label" class="property-label"><g:message code="financiador.setor.label" default="Setor" /></th>
						
						<td aria-labelledby="setor-label"><g:fieldValue bean="${financiadorInstance}" field="setor"/></td>
						
					</tr>
				</g:if>
				
			</table>

			<g:form url="[resource:financiadorInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="btn btn-default" action="edit" resource="${financiadorInstance}">
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

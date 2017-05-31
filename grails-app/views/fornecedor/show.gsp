
<%@ page import="com.acception.cadastro.Fornecedor" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'fornecedor.label', default: 'Fornecedor')}" />
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

		<div id="show-fornecedor" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="alert alert-info" role="status">${flash.message}</div>
			</g:if>

			<table class="table table-bordered fornecedor">
				
				<g:if test="${fornecedorInstance?.codigo}">
					<tr>
						<th id="codigo-label" class="property-label"><g:message code="fornecedor.codigo.label" default="Codigo" /></th>
						
						<td  aria-labelledby="codigo-label"><g:fieldValue bean="${fornecedorInstance}" field="codigo"/></td>
						
					</tr>
				</g:if>

				<g:if test="${fornecedorInstance?.participante?.nome}">
					<tr>
						<th id="nome-label" class="property-label"><g:message code="fornecedor.nome.label" default="Nome" /></th>

						<td  aria-labelledby="nome-label"><g:fieldValue bean="${fornecedorInstance}" field="participante.nome"/></td>

					</tr>
				</g:if>

				<g:if test="${fornecedorInstance.participante instanceof com.acception.cadastro.PessoaJuridica}">
					<g:if test="${fornecedorInstance?.participante?.razaoSocial}">
						<tr>
							<th id="razaoSocial-label" class="property-label"><g:message code="fornecedor.razaoSocial.label" default="Razão Social" /></th>

							<td  aria-labelledby="razaoSocial-label"><g:fieldValue bean="${fornecedorInstance}" field="participante.razaoSocial"/></td>

						</tr>
					</g:if>
				</g:if>

				<g:if test="${fornecedorInstance.participante instanceof com.acception.cadastro.PessoaFisica}">
					<g:if test="${fornecedorInstance?.participante?.cpf}">
						<tr>
							<th id="cpf-label" class="property-label"><g:message code="fornecedor.cpf.label" default="CPF" /></th>

							<td  aria-labelledby="cpf-label" class="cpf"><g:fieldValue bean="${fornecedorInstance}" field="participante.cpf"/></td>

						</tr>
					</g:if>
				</g:if>

				<g:if test="${fornecedorInstance.participante instanceof com.acception.cadastro.PessoaJuridica}">
					<g:if test="${fornecedorInstance?.participante?.cnpj}">
						<tr>
							<th id="cnpj-label" class="property-label"><g:message code="fornecedor.cnpj.label" default="CNPJ" /></th>

							<td  aria-labelledby="cnpj-label" class="cnpj"><g:fieldValue bean="${fornecedorInstance}" field="participante.cnpj"/></td>

						</tr>
					</g:if>
				</g:if>

				
				<g:if test="${fornecedorInstance?.ramo}">
					<tr>
						<th id="ramo-label" class="property-label"><g:message code="fornecedor.ramo.label" default="Ramo" /></th>
						
						<td  aria-labelledby="ramo-label"><g:fieldValue bean="${fornecedorInstance}" field="ramo"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${fornecedorInstance?.dateCreated}">
					<tr>
						<th id="dateCreated-label" class="property-label"><g:message code="fornecedor.dateCreated.label" default="Data de Cadastro" /></th>
						
						<td  aria-labelledby="dateCreated-label"><g:formatDate date="${fornecedorInstance?.dateCreated}" /></td>
						
					</tr>
				</g:if>
				
				<g:if test="${fornecedorInstance?.lastUpdated}">
					<tr>
						<th id="lastUpdated-label" class="property-label"><g:message code="fornecedor.lastUpdated.label" default="Data de Última Alteração" /></th>
						
						<td  aria-labelledby="lastUpdated-label"><g:formatDate date="${fornecedorInstance?.lastUpdated}" /></td>
						
					</tr>
				</g:if>
				

				<g:if test="${fornecedorInstance?.setor}">
					<tr>
						<th id="setor-label" class="property-label"><g:message code="fornecedor.setor.label" default="Setor" /></th>
						
						<td aria-labelledby="setor-label"><g:fieldValue bean="${fornecedorInstance}" field="setor"/></td>
						
					</tr>
				</g:if>
				
			</table>

			<g:form url="[resource:fornecedorInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="btn btn-default" action="edit" resource="${fornecedorInstance}">
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

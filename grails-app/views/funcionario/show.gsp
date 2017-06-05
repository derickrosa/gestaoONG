
<%@ page import="com.acception.util.Util; com.acception.cadastro.Funcionario" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'funcionario.label', default: 'Funcionário')}" />
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
				<g:link class="btn btn-default" action="index"><span class="glyphicon glyphicon-list"></span> Listagem de Funcionários</g:link>
				<g:link class="btn btn-default" action="create"><span class="glyphicon glyphicon-plus"></span> Novo Funcionário </g:link>
			</p>
		</div>

		<div id="show-funcionario" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
				<div class="alert alert-info" role="status">
					${flash.message}
				</div>
			</g:if>

			<table class="table table-bordered funcionario">
				
				<g:if test="${funcionarioInstance?.participante?.nome}">
					<tr>
						<th id="nome-label" class="property-label"><g:message code="funcionario.nome.label" default="Nome" /></th>
						
						<td  aria-labelledby="nome-label"><g:fieldValue bean="${funcionarioInstance}" field="participante.nome"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${funcionarioInstance?.participante?.email}">
					<tr>
						<th id="email-label" class="property-label"><g:message code="funcionario.email.label" default="Email" /></th>
						
						<td  aria-labelledby="email-label"><g:fieldValue bean="${funcionarioInstance}" field="participante.email"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${funcionarioInstance?.participante?.emailAdicional}">
					<tr>
						<th id="emailAdicional-label" class="property-label"><g:message code="funcionario.emailAdicional.label" default="Email Adicional" /></th>
						
						<td  aria-labelledby="emailAdicional-label"><g:fieldValue bean="${funcionarioInstance}" field="participante.emailAdicional"/></td>
						
					</tr>
				</g:if>

				<g:if test="${funcionarioInstance?.participante?.telefone}">
					<tr>
						<th id="telefone-label" class="property-label"><g:message code="funcionario.telefone.label" default="Telefone" /></th>

						<td  aria-labelledby="telefone-label"><g:link controller="telefone" action="show" id="${funcionarioInstance?.participante?.telefone?.id}">${funcionarioInstance?.participante?.telefone?.encodeAsHTML()}</g:link></td>

					</tr>
				</g:if>

				<g:if test="${funcionarioInstance?.participante?.telefoneAdicional}">
					<tr>
						<th id="telefoneAdicional-label" class="property-label"><g:message code="funcionario.telefoneAdicional.label" default="Telefone Adicional" /></th>

						<td  aria-labelledby="telefoneAdicional-label"><g:link controller="telefone" action="show" id="${funcionarioInstance?.participante?.telefoneAdicional?.id}">${funcionarioInstance?.participante?.telefoneAdicional?.encodeAsHTML()}</g:link></td>

					</tr>
				</g:if>
				
				<g:if test="${funcionarioInstance?.participante?.user}">
					<tr>
						<th id="user-label" class="property-label"><g:message code="funcionario.user.label" default="User" /></th>
						
						<td  aria-labelledby="user-label"><g:link controller="user" action="show" id="${funcionarioInstance?.participante?.user?.id}">${funcionarioInstance?.participante?.user?.encodeAsHTML()}</g:link></td>
						
					</tr>
				</g:if>
				
				<g:if test="${funcionarioInstance?.participante?.papeis}">
					<tr>
						<th id="papeis-label" class="property-label"><g:message code="funcionario.papeis.label" default="Papeis" /></th>
						
						<g:each in="${funcionarioInstance.participante.papeis}" var="p">
							<td aria-labelledby="papeis-label"><g:link controller="papel" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></td>
						</g:each>
						
					</tr>
				</g:if>
				
				<g:if test="${funcionarioInstance?.participante?.senhaInicial}">
					<tr>
						<th id="senhaInicial-label" class="property-label"><g:message code="funcionario.senhaInicial.label" default="Senha Inicial" /></th>
						
						<td  aria-labelledby="senhaInicial-label"><g:fieldValue bean="${funcionarioInstance}" field="participante.senhaInicial"/></td>
						
					</tr>
				</g:if>
				
				%{--<g:if test="${funcionarioInstance?.participante?.cpf}">
					<tr>
						<th id="cpf-label" class="property-label"><g:message code="funcionario.cpf.label" default="CPF" /></th>
						
						<td  aria-labelledby="cpf-label">
							${com.acception.util.Util.rawToCpf(funcionarioInstance.participante.cpf)}
						</td>
						
					</tr>
				</g:if>--}%
				
				<g:if test="${funcionarioInstance?.cargo}">
					<tr>
						<th id="cargo-label" class="property-label"><g:message code="funcionario.cargo.label" default="Cargo" /></th>
						
						<td  aria-labelledby="cargo-label"><g:fieldValue bean="${funcionarioInstance}" field="cargo"/></td>
						
					</tr>
				</g:if>

				<g:if test="${funcionarioInstance?.funcao}">
					<tr>
						<th id="funcao-label" class="property-label"><g:message code="funcionario.funcao.label" default="Função" /></th>
						
						<td  aria-labelledby="funcao-label"><g:fieldValue bean="${funcionarioInstance}" field="funcao"/></td>
						
					</tr>
				</g:if>

			</table>

			<g:form url="[resource:funcionarioInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="btn btn-default" action="edit" resource="${funcionarioInstance}">
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
	</div>
	</body>
</html>

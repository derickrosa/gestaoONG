
<%@ page import="com.acception.cadastro.Orcamento" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layout-restrito">
		<g:set var="entityName" value="${message(code: 'orcamento.label', default: 'Orcamento')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="content">
			<div class="inner" style="min-height: 700px;">
				<div class="row">
					<div class="col-lg-12">
						<h1>Ver Orçamento</h1>
					</div>
				</div>
				<hr/>
				<!--BLOCK SECTION -->

				<div id="show-orcamento" class="content scaffold-show" role="main">
					<g:if test="${flash.message}">
					<div class="alert alert-info" role="status">${flash.message}</div>
					</g:if>

					<div class="row">
						<div class="col-md-12">
							<g:render template="/centroCusto/showOrcamento" model="[orcamento: orcamentoInstance]"/>
						</div>
					</div>



				<g:form url="[resource:orcamentoInstance, action:'delete']" method="DELETE">
						<fieldset class="buttons">
							<g:link class="btn btn-default" action="edit" resource="${orcamentoInstance}">
								<span class="glyphicon glyphicon-edit"></span>
								<g:message code="default.button.edit.label" default="Edit" />
							</g:link>
						</fieldset>
					</g:form>
					<br/>
				</div>
			</div>
		</div>
	</body>
</html>

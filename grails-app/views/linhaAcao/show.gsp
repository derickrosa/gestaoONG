
<%@ page import="com.acception.cadastro.LinhaAcao" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layout-restrito">
		<g:set var="entityName" value="${message(code: 'linhaAcao.label', default: 'LinhaAcao')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
	<div id="content">
		<div class="inner" style="min-height: 700px;">
			<div class="row">
				<div class="col-lg-12">
					<h1> Linha de Ação%{--<g:message code="default.show.label" args="[entityName]"/>--}%</h1>
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

		<div id="show-linhaAcao" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="alert alert-info" role="status">${flash.message}</div>
			</g:if>

			<table class="table table-bordered linhaAcao">
				
				<g:if test="${linhaAcaoInstance?.nome}">
					<tr>
						<th id="nome-label" class="property-label"><g:message code="linhaAcao.nome.label" default="Nome" /></th>
						
						<td  aria-labelledby="nome-label"><g:fieldValue bean="${linhaAcaoInstance}" field="nome"/></td>
						
					</tr>
				</g:if>
				
				%{--<g:if test="${linhaAcaoInstance?.atividades}">
					<tr>
						<th id="atividades-label" class="property-label"><g:message code="linhaAcao.atividades.label" default="Atividades" /></th>
						
						<g:each in="${linhaAcaoInstance.atividades}" var="a">
							<td aria-labelledby="atividades-label"><g:link controller="atividade" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></td>
						</g:each>
						
					</tr>
				</g:if>--}%
				
				<g:if test="${linhaAcaoInstance?.descricao}">
					<tr>
						<th id="descricao-label" class="property-label"><g:message code="linhaAcao.descricao.label" default="Descricao" /></th>
						
						<td  aria-labelledby="descricao-label"><g:fieldValue bean="${linhaAcaoInstance}" field="descricao"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${linhaAcaoInstance?.codigo}">
					<tr>
						<th id="codigo-label" class="property-label"><g:message code="linhaAcao.codigo.label" default="Codigo" /></th>
						
						<td  aria-labelledby="codigo-label"><g:fieldValue bean="${linhaAcaoInstance}" field="codigo"/></td>
						
					</tr>
				</g:if>
				
			</table>

			<ul class="nav nav-tabs">
				<li class="active"><a href="#centrosCusto" data-toggle="tab" aria-expanded="false">Centros de Custo</a>
				</li>

				<li><a href="#atividades" data-toggle="tab" aria-expanded="true">Atividades</a>
				</li>
			</ul>

			<div class="tab-content">

				<div class="tab-pane fade in active" id="centrosCusto">
					<g:render template="centrosCusto" model="[linhaAcaoInstance: linhaAcaoInstance]"/>
				</div>

				<div class="tab-pane fade in" id="atividades">
					<g:render template="atividades" model="[linhaAcaoInstance: linhaAcaoInstance]"/>
				</div>

			</div>


			</div>
			</div>
			<br>
			<g:form url="[resource:linhaAcaoInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="btn btn-default" action="edit" resource="${linhaAcaoInstance}">
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

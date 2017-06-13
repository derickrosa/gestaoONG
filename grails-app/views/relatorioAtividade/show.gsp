
<%@ page import="com.acception.cadastro.RelatorioAtividade" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'relatorioAtividade.label', default: 'RelatorioAtividade')}" />
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

		<div id="show-relatorioAtividade" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="alert alert-info" role="status">${flash.message}</div>
			</g:if>

			<table class="table table-bordered relatorioAtividade">
				
				<g:if test="${relatorioAtividadeInstance?.comunidadesEnvolvidas}">
					<tr>
						<th id="comunidadesEnvolvidas-label" class="property-label"><g:message code="relatorioAtividade.comunidadesEnvolvidas.label" default="Comunidades Envolvidas" /></th>
						
						<td  aria-labelledby="comunidadesEnvolvidas-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="comunidadesEnvolvidas"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.totalComunidadesEnvolvidas}">
					<tr>
						<th id="totalComunidadesEnvolvidas-label" class="property-label"><g:message code="relatorioAtividade.totalComunidadesEnvolvidas.label" default="Total Comunidades Envolvidas" /></th>
						
						<td  aria-labelledby="totalComunidadesEnvolvidas-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="totalComunidadesEnvolvidas"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.municipiosAtendidos}">
					<tr>
						<th id="municipiosAtendidos-label" class="property-label"><g:message code="relatorioAtividade.municipiosAtendidos.label" default="Municipios Atendidos" /></th>
						
						<td  aria-labelledby="municipiosAtendidos-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="municipiosAtendidos"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.totalMunicipiosAtendidos}">
					<tr>
						<th id="totalMunicipiosAtendidos-label" class="property-label"><g:message code="relatorioAtividade.totalMunicipiosAtendidos.label" default="Total Municipios Atendidos" /></th>
						
						<td  aria-labelledby="totalMunicipiosAtendidos-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="totalMunicipiosAtendidos"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.numeroParticipantes}">
					<tr>
						<th id="numeroParticipantes-label" class="property-label"><g:message code="relatorioAtividade.numeroParticipantes.label" default="Numero Participantes" /></th>
						
						<td  aria-labelledby="numeroParticipantes-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="numeroParticipantes"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.numeroHomens}">
					<tr>
						<th id="numeroHomens-label" class="property-label"><g:message code="relatorioAtividade.numeroHomens.label" default="Numero Homens" /></th>
						
						<td  aria-labelledby="numeroHomens-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="numeroHomens"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.numeroMulheres}">
					<tr>
						<th id="numeroMulheres-label" class="property-label"><g:message code="relatorioAtividade.numeroMulheres.label" default="Numero Mulheres" /></th>
						
						<td  aria-labelledby="numeroMulheres-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="numeroMulheres"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.jovens20anos}">
					<tr>
						<th id="jovens20anos-label" class="property-label"><g:message code="relatorioAtividade.jovens20anos.label" default="Jovens20anos" /></th>
						
						<td  aria-labelledby="jovens20anos-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="jovens20anos"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.adultos29a60anos}">
					<tr>
						<th id="adultos29a60anos-label" class="property-label"><g:message code="relatorioAtividade.adultos29a60anos.label" default="Adultos29a60anos" /></th>
						
						<td  aria-labelledby="adultos29a60anos-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="adultos29a60anos"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.idosos60anos}">
					<tr>
						<th id="idosos60anos-label" class="property-label"><g:message code="relatorioAtividade.idosos60anos.label" default="Idosos60anos" /></th>
						
						<td  aria-labelledby="idosos60anos-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="idosos60anos"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.nomeOrganizacoesEnvolvidas}">
					<tr>
						<th id="nomeOrganizacoesEnvolvidas-label" class="property-label"><g:message code="relatorioAtividade.nomeOrganizacoesEnvolvidas.label" default="Nome Organizacoes Envolvidas" /></th>
						
						<td  aria-labelledby="nomeOrganizacoesEnvolvidas-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="nomeOrganizacoesEnvolvidas"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.numeroOrganizacaoEnvolvidas}">
					<tr>
						<th id="numeroOrganizacaoEnvolvidas-label" class="property-label"><g:message code="relatorioAtividade.numeroOrganizacaoEnvolvidas.label" default="Numero Organizacao Envolvidas" /></th>
						
						<td  aria-labelledby="numeroOrganizacaoEnvolvidas-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="numeroOrganizacaoEnvolvidas"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.tipoProfissao}">
					<tr>
						<th id="tipoProfissao-label" class="property-label"><g:message code="relatorioAtividade.tipoProfissao.label" default="Tipo Profissao" /></th>
						
						<td  aria-labelledby="tipoProfissao-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="tipoProfissao"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.tipoAtividadeExercidaAtualmente}">
					<tr>
						<th id="tipoAtividadeExercidaAtualmente-label" class="property-label"><g:message code="relatorioAtividade.tipoAtividadeExercidaAtualmente.label" default="Tipo Atividade Exercida Atualmente" /></th>
						
						<td  aria-labelledby="tipoAtividadeExercidaAtualmente-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="tipoAtividadeExercidaAtualmente"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.numeroQuilombolas}">
					<tr>
						<th id="numeroQuilombolas-label" class="property-label"><g:message code="relatorioAtividade.numeroQuilombolas.label" default="Numero Quilombolas" /></th>
						
						<td  aria-labelledby="numeroQuilombolas-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="numeroQuilombolas"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.numeroIndigenas}">
					<tr>
						<th id="numeroIndigenas-label" class="property-label"><g:message code="relatorioAtividade.numeroIndigenas.label" default="Numero Indigenas" /></th>
						
						<td  aria-labelledby="numeroIndigenas-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="numeroIndigenas"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.autoDeterminacaoCor}">
					<tr>
						<th id="autoDeterminacaoCor-label" class="property-label"><g:message code="relatorioAtividade.autoDeterminacaoCor.label" default="Auto Determinacao Cor" /></th>
						
						<td  aria-labelledby="autoDeterminacaoCor-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="autoDeterminacaoCor"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.autoDeterminacaoCorNegro}">
					<tr>
						<th id="autoDeterminacaoCorNegro-label" class="property-label"><g:message code="relatorioAtividade.autoDeterminacaoCorNegro.label" default="Auto Determinacao Cor Negro" /></th>
						
						<td  aria-labelledby="autoDeterminacaoCorNegro-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="autoDeterminacaoCorNegro"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.autoDeterminacaoCorPardo}">
					<tr>
						<th id="autoDeterminacaoCorPardo-label" class="property-label"><g:message code="relatorioAtividade.autoDeterminacaoCorPardo.label" default="Auto Determinacao Cor Pardo" /></th>
						
						<td  aria-labelledby="autoDeterminacaoCorPardo-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="autoDeterminacaoCorPardo"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.autoDeterminacaoCorBranco}">
					<tr>
						<th id="autoDeterminacaoCorBranco-label" class="property-label"><g:message code="relatorioAtividade.autoDeterminacaoCorBranco.label" default="Auto Determinacao Cor Branco" /></th>
						
						<td  aria-labelledby="autoDeterminacaoCorBranco-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="autoDeterminacaoCorBranco"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.autoDeterminacaoCorAmarelo}">
					<tr>
						<th id="autoDeterminacaoCorAmarelo-label" class="property-label"><g:message code="relatorioAtividade.autoDeterminacaoCorAmarelo.label" default="Auto Determinacao Cor Amarelo" /></th>
						
						<td  aria-labelledby="autoDeterminacaoCorAmarelo-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="autoDeterminacaoCorAmarelo"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.autoDeterminacaoCorOutras}">
					<tr>
						<th id="autoDeterminacaoCorOutras-label" class="property-label"><g:message code="relatorioAtividade.autoDeterminacaoCorOutras.label" default="Auto Determinacao Cor Outras" /></th>
						
						<td  aria-labelledby="autoDeterminacaoCorOutras-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="autoDeterminacaoCorOutras"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.financiador}">
					<tr>
						<th id="financiador-label" class="property-label"><g:message code="relatorioAtividade.financiador.label" default="Financiador" /></th>
						
						<td  aria-labelledby="financiador-label"><g:link controller="financiador" action="show" id="${relatorioAtividadeInstance?.financiador?.id}">${relatorioAtividadeInstance?.financiador?.encodeAsHTML()}</g:link></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.centroCusto}">
					<tr>
						<th id="centroCusto-label" class="property-label"><g:message code="relatorioAtividade.centroCusto.label" default="Centro Custo" /></th>
						
						<td  aria-labelledby="centroCusto-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="centroCusto"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.origemRecursoProjeto}">
					<tr>
						<th id="origemRecursoProjeto-label" class="property-label"><g:message code="relatorioAtividade.origemRecursoProjeto.label" default="Origem Recurso Projeto" /></th>
						
						<td  aria-labelledby="origemRecursoProjeto-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="origemRecursoProjeto"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.valorServicoesTerceirosPessoaFisica}">
					<tr>
						<th id="valorServicoesTerceirosPessoaFisica-label" class="property-label"><g:message code="relatorioAtividade.valorServicoesTerceirosPessoaFisica.label" default="Valor Servicoes Terceiros Pessoa Fisica" /></th>
						
						<td  aria-labelledby="valorServicoesTerceirosPessoaFisica-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="valorServicoesTerceirosPessoaFisica"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.valorHospedagem}">
					<tr>
						<th id="valorHospedagem-label" class="property-label"><g:message code="relatorioAtividade.valorHospedagem.label" default="Valor Hospedagem" /></th>
						
						<td  aria-labelledby="valorHospedagem-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="valorHospedagem"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.valorlocacaoAuditorioSalas}">
					<tr>
						<th id="valorlocacaoAuditorioSalas-label" class="property-label"><g:message code="relatorioAtividade.valorlocacaoAuditorioSalas.label" default="Valorlocacao Auditorio Salas" /></th>
						
						<td  aria-labelledby="valorlocacaoAuditorioSalas-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="valorlocacaoAuditorioSalas"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.valorlocacaoVeiculos}">
					<tr>
						<th id="valorlocacaoVeiculos-label" class="property-label"><g:message code="relatorioAtividade.valorlocacaoVeiculos.label" default="Valorlocacao Veiculos" /></th>
						
						<td  aria-labelledby="valorlocacaoVeiculos-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="valorlocacaoVeiculos"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.valorcombustivel}">
					<tr>
						<th id="valorcombustivel-label" class="property-label"><g:message code="relatorioAtividade.valorcombustivel.label" default="Valorcombustivel" /></th>
						
						<td  aria-labelledby="valorcombustivel-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="valorcombustivel"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.valorAlimentacao}">
					<tr>
						<th id="valorAlimentacao-label" class="property-label"><g:message code="relatorioAtividade.valorAlimentacao.label" default="Valor Alimentacao" /></th>
						
						<td  aria-labelledby="valorAlimentacao-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="valorAlimentacao"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.valorPassagensAreas}">
					<tr>
						<th id="valorPassagensAreas-label" class="property-label"><g:message code="relatorioAtividade.valorPassagensAreas.label" default="Valor Passagens Areas" /></th>
						
						<td  aria-labelledby="valorPassagensAreas-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="valorPassagensAreas"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.valorcopiasBanner}">
					<tr>
						<th id="valorcopiasBanner-label" class="property-label"><g:message code="relatorioAtividade.valorcopiasBanner.label" default="Valorcopias Banner" /></th>
						
						<td  aria-labelledby="valorcopiasBanner-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="valorcopiasBanner"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.valorMaterialDidaticoCosumo}">
					<tr>
						<th id="valorMaterialDidaticoCosumo-label" class="property-label"><g:message code="relatorioAtividade.valorMaterialDidaticoCosumo.label" default="Valor Material Didatico Cosumo" /></th>
						
						<td  aria-labelledby="valorMaterialDidaticoCosumo-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="valorMaterialDidaticoCosumo"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.valorReembolsoDiario}">
					<tr>
						<th id="valorReembolsoDiario-label" class="property-label"><g:message code="relatorioAtividade.valorReembolsoDiario.label" default="Valor Reembolso Diario" /></th>
						
						<td  aria-labelledby="valorReembolsoDiario-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="valorReembolsoDiario"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.valorTotalAtividade}">
					<tr>
						<th id="valorTotalAtividade-label" class="property-label"><g:message code="relatorioAtividade.valorTotalAtividade.label" default="Valor Total Atividade" /></th>
						
						<td  aria-labelledby="valorTotalAtividade-label"><g:fieldValue bean="${relatorioAtividadeInstance}" field="valorTotalAtividade"/></td>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.arquivos}">
					<tr>
						<th id="arquivos-label" class="property-label"><g:message code="relatorioAtividade.arquivos.label" default="Arquivos" /></th>
						
						<g:each in="${relatorioAtividadeInstance.arquivos}" var="a">
							<td aria-labelledby="arquivos-label"><g:link controller="arquivoRelatorioAtividade" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></td>
						</g:each>
						
					</tr>
				</g:if>
				
				<g:if test="${relatorioAtividadeInstance?.atividade}">
					<tr>
						<th id="atividade-label" class="property-label"><g:message code="relatorioAtividade.atividade.label" default="Atividade" /></th>
						
						<td  aria-labelledby="atividade-label"><g:link controller="atividade" action="show" id="${relatorioAtividadeInstance?.atividade?.id}">${relatorioAtividadeInstance?.atividade?.encodeAsHTML()}</g:link></td>
						
					</tr>
				</g:if>
				
			</table>

			<g:form url="[resource:relatorioAtividadeInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="btn btn-default" action="edit" resource="${relatorioAtividadeInstance}">
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

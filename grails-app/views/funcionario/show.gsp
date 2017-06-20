
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

			<ul class="nav nav-tabs">
				<li class="active"><a href="#dadosBasicos" data-toggle="tab">Dados Básicos</a></li>
				<li><a href="#financeiro" data-toggle="tab">Financeiro</a></li>
			</ul>

			<div class="tab-content">
				<div class="tab-pane active fade in" id="dadosBasicos">
					<table class="table table-bordered funcionario">

						<g:if test="${funcionarioInstance?.participante?.nome}">
							<tr>
								<th id="nome-label" class="property-label"><g:message code="funcionario.nome.label" default="Nome" /></th>

								<td  aria-labelledby="nome-label"><g:fieldValue bean="${funcionarioInstance}" field="participante.nome"/></td>

							</tr>
						</g:if>

						<g:if test="${funcionarioInstance?.participante?.email}">
							<tr>
								<th id="email-label" class="property-label"><g:message code="funcionario.email.label" default="E-mail" /></th>

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

						<g:if test="${funcionarioInstance?.salario}">
							<tr>
								<th id="funcao-label" class="property-label"><g:message code="funcionario.funcao.label" default="Salário Anual" /></th>

								<td  aria-labelledby="funcao-label">R$ <g:fieldValue bean="${funcionarioInstance}" field="salario"/></td>

							</tr>
						</g:if>

					</table>
				</div>

				<div class="tab-pane fade in" id="financeiro">
					<h4 style="text-align: center">Alocação Salário por Centro de Custo</h4>

					<canvas id="myChart" style="height: 400px!important;"></canvas>

					<hr>

					<div class="row">
						<div class="col-md-10 col-md-offset-1">
							<table class="table table-hover text-center" id="tabelaSalario">
								<thead>
								<tr>
									<th class="text-center" width="33%">Centro Custo</th>
									<th class="text-center" width="33%">Salário Anual (R$)</th>
									<th class="text-center" width="33%">Porcentagem (%)</th>
								</tr>
								</thead>

								<tbody>

								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>

			<br>

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

	<asset:javascript src="Chart.min.js"/>

	%{--<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.min.js"></script>--}%

	<script>
		/**
		 * Number.prototype.format(n, x, s, c)
		 *
		 * @param integer n: length of decimal
		 * @param integer x: length of whole part
		 * @param mixed   s: sections delimiter
		 * @param mixed   c: decimal delimiter
		 */
		Number.prototype.formatAsMoney = function(n, x, s, c) {
			var re = '\\d(?=(\\d{' + (x || 3) + '})+' + (n > 0 ? '\\D' : '$') + ')',
					num = this.toFixed(Math.max(0, ~~n));

			return (c ? num.replace('.', c) : num).replace(new RegExp(re, 'g'), '$&' + (s || ','));
		};

		var atualizarTabelaSalarios = function (dados) {
			var tabela = $('#tabelaSalario tbody');

			var keys = Object.keys(dados);
			var values = Object.keys(dados).map(function(key) {
				return dados[key];
			});

			var totalValues = values.reduce(function (a, b) {
				return a + b;
			}, 0);

			for (var i = 0; i < keys.length; i++) {
				var tableRow = $('<tr>');

				tableRow.append($('<td>').text(keys[i]));

				tableRow.append($('<td>').text(values[i].formatAsMoney(2, 3, '.', ',')));

				tableRow.append($('<td>').text(((values[i] / totalValues) * 100).toFixed(2)));

				tabela.append(tableRow)
			}

			var tr = $('<tr>');
			tr.append($('<td>').html('<strong>TOTAL</strong>'));
			tr.append($('<td>').append($('<strong>').text(totalValues.formatAsMoney(2, 3, '.', ','))));
			tr.append($('<td>').append($('<strong>').text('100')));
			tabela.append(tr);
		};

		$(function() {
			$.ajax({
				url: "${createLink(controller: 'funcionario', action: 'getSalariosFuncionarioFromCentroCusto')}",
				method: "POST",
				data: {
					'funcionarioId': "${funcionarioInstance.id}"
				},
				success: function(response) {
					console.log(response)

					var ctx = document.getElementById('myChart').getContext('2d');
					var chart = new Chart(ctx, {
						// The type of chart we want to create
						type: 'pie',

						// The data for our dataset
						data: {
							labels: Object.keys(response),
							datasets: [{
								label: "My First dataset",
								backgroundColor: ['rgb(255, 250, 132)', 'rgb(155, 250, 132)'],
								data: Object.keys(response).map(function(key) {
									return response[key];
								})
							}]
						},

						// Configuration options go here
						options: {
							tooltips: {
								callbacks: {
									label: function(tooltipItem, chart) {
										return " " + chart.labels[tooltipItem.index] + ": R$ " + chart.datasets[0].data[tooltipItem.index].formatAsMoney(2, 3, '.', ',');
									}
								}
							}
						}
					});

					atualizarTabelaSalarios(response);
				}
			});


		});


	</script>

	</body>
</html>

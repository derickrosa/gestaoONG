<g:set var="df" value="${new java.text.DecimalFormat('###,##0.00')}"/>

<style>
    #tabelaDespesas td {
        text-align: center; vertical-align: middle;
    }

    #tabelaDespesas th {
        text-align: center;
    }
</style>

<table class="table table-bordered centroCusto">
    <g:if test="${centroCustoInstance?.contaBancaria?.banco}">
        <tr>
            <th class="property-label">Banco</th>

            <td>
                ${centroCustoInstance?.contaBancaria?.banco?.nome}
            </td>
        </tr>
    </g:if>

    <g:if test="${centroCustoInstance?.contaBancaria?.agencia}">
        <tr>
            <th class="property-label">Agência</th>

            <td>
                ${centroCustoInstance?.contaBancaria?.agencia}-${centroCustoInstance?.contaBancaria?.dvAgencia}
            </td>
        </tr>
    </g:if>

    <g:if test="${centroCustoInstance?.contaBancaria?.conta}">
        <tr>
            <th class="property-label">Conta</th>

            <td>
                ${centroCustoInstance?.contaBancaria?.conta}-${centroCustoInstance?.contaBancaria?.dvConta}
            </td>
        </tr>
    </g:if>

    <g:if test="${centroCustoInstance?.contaBancaria?.tipoConta}">
        <tr>
            <th class="property-label">Tipo Conta</th>

            <td>
                ${centroCustoInstance?.contaBancaria?.tipoConta?.nome}
            </td>
        </tr>
    </g:if>

    <g:if test="${centroCustoInstance?.contaBancaria?.saldo != null}">
        <tr>
            <th class="property-label">Saldo</th>

            <td>
                R$ ${df.format(centroCustoInstance?.contaBancaria?.saldo)}
            </td>
        </tr>
    </g:if>
</table>

<hr>

<h4 class="text-center">Despesas</h4>
<br>


    <table class="table table-hover text-center" id="tabelaDespesas">
        <thead>
        <tr>
            <th class="text-center">Despesa</th>
            <th class="text-center">Valor</th>
            <th class="text-center">Tipo Despesa</th>
            <th class="text-center">Data</th>
            <th class="text-center">Lançamentos</th>
        </tr>
        </thead>

        <tbody>
        <g:if test="${centroCustoInstance.despesas}">
            <g:each in="${centroCustoInstance.despesas.sort{ it.data }}" var="despesa">
                <tr>
                    <td><g:link controller="despesa" action="show" id="${despesa.id}">${despesa.descricao}</g:link></td>
                    <td>R$ ${df.format(despesa.valor)}</td>
                    <td>${despesa.tipoDespesa?.nome}</td>
                    <td><g:formatDate date="${despesa.data}" format="dd/MM/yyyy"/></td>
                    <td><button class="btn btn-default" data-toggle="collapse" data-target="#lancamentos_despesa_${despesa.id}">
                        <span class="glyphicon glyphicon-eye" aria-hidden="true"></span> Ver Lançamentos</button></td>
                </tr>

                <tr class="collapse" id="lancamentos_despesa_${despesa.id}">
                    <td colspan="5">
                        <g:if test="${despesa.lancamentos}">
                            <table class="table table-hover text-center">
                                <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Valor</th>
                                    <th>Data Emissão</th>
                                    <th>Tipo</th>
                                    <th>Status</th>
                                </tr>
                                </thead>
                                <tbody>
                                <g:each in="${despesa?.lancamentos?.sort { it.parcela }}" var="l">
                                    <tr>
                                        <td>${l.parcela}</td>
                                        <td>R$ ${df.format(l.valor)}</td>
                                        <td><g:formatDate date="${l.dataEmissao}" format="dd/MM/yyyy"/></td>
                                        <td>${l.tipoLancamento?.nome}</td>
                                        <td>${l.statusLancamento?.nome}</td>
                                    </tr>
                                </g:each>

                                </tbody>
                            </table>
                        </g:if>
                        <g:else>
                            <div class="well">Sem lançamentos para essa despesa!</div>
                        </g:else>
                    </td>
                </tr>
            </g:each>
        </g:if>

        <g:else>
            <tr id="alertNoDespesas">
                <td colspan="5">Sem despesas cadastradas para esse centro de custo!</td>
            </tr>
        </g:else>

        </tbody>
    </table>



<div class="row">
    <div class="col-md-12 text-center">
        <button type="button" class="btn btn-default" data-toggle="modal" data-target="#modalCriacaoDespesas">
            <span class="glyphicon glyphicon-plus"></span> Criar Despesa
        </button>
    </div>
</div>

<g:render template="/despesa/modalCreate" model="[centroCustoId: centroCustoInstance.id]"/>

<script>
    document.getElementById("formCriacaoDespesa").addEventListener("despesaCriada", function (e) {
        var table = $("#tabelaDespesas > tbody");

        var warningNaoHaDespesasCadastradas = $("#alertNoDespesas");

        if (warningNaoHaDespesasCadastradas) {
            warningNaoHaDespesasCadastradas.hide();
        }

        var tableRow = $("<tr>");

        tableRow.append($("<td>").append("<a href='${createLink(controller: 'despesa', action: 'show')}/" + e.detail.id +  "'>" + e.detail.descricao + "</a>"));
        tableRow.append($("<td>").text("R$ " + e.detail.valor));
        tableRow.append($("<td>").text(e.detail.tipo));
        tableRow.append($("<td>").text(e.detail.data));
        tableRow.append($("<td>").text("Lançamentos estarão disponíveis em breve!"));

        tableRow.addClass('success');

        table.append(tableRow);
    }, false);
</script>
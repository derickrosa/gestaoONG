<%@ page import="com.acception.cadastro.enums.TipoLancamento" %>

<div class="row">
    <div class="col-md-12 text-center">
        <button type="button" class="btn btn-default" data-toggle="modal" data-target="#modalCriacaoCreditoFinanceiro">
            <span class="glyphicon glyphicon-plus"></span> Criar Crédito
        </button>
    </div>
</div>

<br>

<table class="table table-hover text-center" id="tabelaCreditosFinanceiros">
    <thead>
    <tr>
        <th class="text-center">Crédito</th>
        <th class="text-center">Valor</th>
        <th class="text-center">Data</th>
        <th class="text-center">Origem</th>
    </tr>
    </thead>

    <tbody>
    <g:if test="${centroCustoInstance.lancamentos}">
        <g:each in="${centroCustoInstance.lancamentos.findAll{it.tipoLancamento == com.acception.cadastro.enums.TipoLancamento.CREDITO}.sort { it.dataEmissao }}" var="credito">
            <tr>
                <td><g:link controller="lancamento" action="show" id="${credito.id}">${credito.descricao}</g:link></td>
                <td>R$ ${df.format(credito.valor)}</td>
                <td><g:formatDate date="${credito.dataEmissao}" format="dd/MM/yyyy"/></td>
                <td>${credito.papel ?: '--'}</td>
            </tr>
        </g:each>
    </g:if>

    <g:else>
        <tr id="alertNoDespesas">
            <td colspan="5">Sem créditos cadastrados para esse centro de custo!</td>
        </tr>
    </g:else>

    </tbody>
</table>


<g:render template="/lancamento/modalCreate" model="[centroCustoId: centroCustoInstance.id]"/>

<script>
    document.getElementById("formCriacaoCreditoFinanceiro").addEventListener("creditoCriado", function (e) {
        console.log(e.detail);

        var table = $("#tabelaCreditosFinanceiros > tbody");

        var warningNaoHaDespesasCadastradas = $("#alertNoCreditos");

        if (warningNaoHaDespesasCadastradas) {
            warningNaoHaDespesasCadastradas.hide();
        }

        var tableRow = $("<tr>");

        tableRow.append($("<td>").append("<a href='${createLink(controller: 'lancamento', action: 'show')}/" + e.detail.id + "'>" + e.detail.descricao + "</a>"));
        tableRow.append($("<td>").text("R$ " + e.detail.valor));
        tableRow.append($("<td>").text(e.detail.data));
        tableRow.append($("<td>").text(e.detail.papel));

        tableRow.addClass('success');

        table.append(tableRow);
    }, false);
</script>
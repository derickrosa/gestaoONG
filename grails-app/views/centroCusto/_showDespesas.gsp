
<div class="row">
    <div class="col-md-12 text-center">
        <button type="button" class="btn btn-default" data-toggle="modal" data-target="#modalCriacaoDespesas">
            <span class="glyphicon glyphicon-plus"></span> Criar Despesa
        </button>
    </div>
</div>

<br>

<table class="table table-hover text-center" id="tabelaDespesas">
    <thead>
    <tr>
        <th class="text-center">Despesa</th>
        <th class="text-center">Valor</th>
        <th class="text-center">Tipo Despesa</th>
        <th class="text-center">Data</th>
        <th class="text-center">Destino</th>
    </tr>
    </thead>

    <tbody>
    <g:if test="${centroCustoInstance.despesas}">
        <g:each in="${centroCustoInstance.despesas.sort { it.data }}" var="despesa">
            <tr>
                <td><g:link controller="despesa" action="show" id="${despesa.id}">${despesa.descricao}</g:link></td>
                <td>R$ ${df.format(despesa.valor)}</td>
                <td>${despesa.tipoDespesa?.nome}</td>
                <td><g:formatDate date="${despesa.data}" format="dd/MM/yyyy"/></td>
                <td>${despesa.papel ?: '--'}</td>
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


<g:render template="/despesa/modalCreate" model="[centroCustoId: centroCustoInstance.id]"/>

<script>
    document.getElementById("formCriacaoDespesa").addEventListener("despesaCriada", function (e) {
        console.log(e.detail);

        var table = $("#tabelaDespesas > tbody");

        var warningNaoHaDespesasCadastradas = $("#alertNoDespesas");

        if (warningNaoHaDespesasCadastradas) {
            warningNaoHaDespesasCadastradas.hide();
        }

        var tableRow = $("<tr>");

        tableRow.append($("<td>").append("<a href='${createLink(controller: 'despesa', action: 'show')}/" + e.detail.id + "'>" + e.detail.descricao + "</a>"));
        tableRow.append($("<td>").text("R$ " + e.detail.valor));
        tableRow.append($("<td>").text(e.detail.tipo));
        tableRow.append($("<td>").text(e.detail.data));
        tableRow.append($("<td>").text(e.detail.papel));

        tableRow.addClass('success');

        table.append(tableRow);
    }, false);
</script>
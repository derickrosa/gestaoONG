
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
        <th class="text-center" data-attribute="descricao" data-render='<g:link controller="despesa" action="show" id="{id}">{descricao}</g:link>'>Despesa</th>
        <th class="text-center" data-attribute="valor" data-render="R$ {valor}">Valor</th>
        <th class="text-center" data-attribute="tipoDespesa.nome">Tipo Despesa</th>
        <th class="text-center" data-attribute="data">Data</th>
        <th class="text-center" data-attribute="lancamento.papel">Destino</th>
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
                <td>${despesa.lancamento?.papel ?: '--'}</td>
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


<g:render template="/despesa/modalCreate" model="[centroCustoId: centroCustoInstance.id, idTabelaParaAtualizar: '#tabelaDespesas']"/>

<asset:javascript src="dynamicTable.js"/>

<script>
    document.getElementById("formCriacaoDespesa").addEventListener("despesaCriada", function (e) {
        var warningNaoHaDespesasCadastradas = $("#alertNoDespesas");

        if (warningNaoHaDespesasCadastradas) {
            warningNaoHaDespesasCadastradas.hide();
        }

        addNewRowToTable('#tabelaDespesas', e.detail);
    }, false);
</script>
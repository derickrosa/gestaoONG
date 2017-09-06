<asset:stylesheet src="dataTables.bootstrap.css"/>
<asset:javascript src="dataTables.bootstrap.min.js"/>
<asset:javascript src="dataTables.pt-br.js"/>


<div class="row">
    <div class="col-md-12 text-center">
        <button type="button" class="btn btn-default" data-toggle="modal" data-target="#modalCriacaoDespesas">
            <span class="glyphicon glyphicon-plus"></span> Criar Despesa
        </button>
    </div>
</div>

<br>

<table class="table table-hover text-center" id="tabelaDespesas" width="100%">
    <thead>
    <tr>
        <th>ID</th>
        <th class="text-center">Despesa</th>
        <th class="text-center">Valor</th>
        <th class="text-center">Tipo Despesa</th>
        <th class="text-center">Data</th>
        <th class="text-center">Destino</th>
    </tr>
    </thead>

    <tbody>
    <g:if test="${centroCustoInstance.despesas}">
        <g:each in="${centroCustoInstance.despesas.sort { it.data }}" var="despesa" status="i">
            <tr>
                <td>${despesa.id}</td>
                <td>${despesa.descricao}</td>
                <td data-order="${i}">R$ ${df.format(despesa.valor)}</td>
                <td>${despesa.tipoDespesa?.nome}</td>
                <td data-order="${despesa.data.getTime()}"><g:formatDate date="${despesa.data}" format="dd/MM/yyyy"/></td>
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

<g:render template="/despesa/modalCreate" model="[centroCustoId: centroCustoInstance.id]"/>

<asset:javascript src="plugins/jquery/jquery.dataTables.min.js"/>
<asset:assetPath src="jquery.dataTables.min.css"/>

<script>
    var table = $("#tabelaDespesas").DataTable({
        "columns": [
            {
                data: "id",
                "visible": false,
                "searchable": false
            },
            {
                data: "name",
                "orderable": false,
                render: function (data, type, full, meta) {
//                    console.log(data);
//                    console.log(type);
//                    console.log(full);
//                    console.log(meta);

                    var render = '<g:link controller="despesa" action="show" id="toReplace">' + full.name + '</g:link>';

                    return render.replace('toReplace', full.id);
                }
            },
            {data: "valor", "orderable": false},
            {data: "tipo", "orderable": false},
            {data: "data", "orderable": false},
            {data: "destino"}
        ]
    });

    document.getElementById("formCriacaoDespesa").addEventListener("despesaCriada", function (e) {
        var warningNaoHaDespesasCadastradas = $("#alertNoDespesas");

        if (warningNaoHaDespesasCadastradas) {
            warningNaoHaDespesasCadastradas.hide();
        }

        table.row.add(e.detail).draw();
    }, false);
</script>
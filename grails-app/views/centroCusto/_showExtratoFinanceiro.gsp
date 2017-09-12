<%@ page import="com.acception.cadastro.Lancamento; com.acception.cadastro.enums.TipoLancamento" %>

<g:set var="df" value="${new java.text.DecimalFormat('###,##0.00')}"/>

<asset:stylesheet src="bootstrap/bootstrap-tables/bootstrap-table.min.css"/>
<asset:javascript src="plugins/bootstrap/bootstrap-tables/bootstrap-table-min.js"/>
<asset:javascript src="plugins/bootstrap/bootstrap-tables/bootstrap-table-pt-BR.js"/>

<script>
    function atualizarExtratoFinanceiro() {
        $("#extratoFinanceiro").bootstrapTable('refresh',
                {
                    query: {
                        dataInicio: $("#dataInicio").val(),
                        dataFinal: $("#dataFinal").val()
                    }
                }
        );
    }

    function currencyFormatter(value, row, index) {
        var className = value >= 0 ? "text-success" : "text-danger";

        return '<span class="' + className + '">R$ ' + value.toFixed(2) + '</span>'
    }

    function dateSorter(firstValue, secondValue) {
        function getDateObjectFromString(string) {
            var parts = string.split('/');

            return new Date(parts[2], parts[1] - 1, parts[0]);
        }

        var date1 = getDateObjectFromString(firstValue);
        var date2 = getDateObjectFromString(secondValue);

        if (date1 > date2) {
            return 1
        } else if (date1 < date2) {
            return -1
        } else {
            return 0;
        }
    }
</script>

<div class="row">
    <div class="col-md-12 text-center">
        <button type="button" class="btn btn-default" data-toggle="modal" data-target="#modalCriacaoDespesas">
            <span class="glyphicon glyphicon-plus"></span> Criar Despesa
        </button>

        <button type="button" class="btn btn-default" data-toggle="modal" data-target="#modalCriacaoCreditoFinanceiro">
            <span class="glyphicon glyphicon-plus"></span> Criar Crédito
        </button>

        <button type="button" class="btn btn-default" data-toggle="modal" data-target="#modalCriacaoPAs">
            <span class="glyphicon glyphicon-plus"></span> Criar PA
        </button>
    </div>
</div>

<hr>

<div class="row">
    <div class="col-md-12">
        <table class="table table-bordered">
            <tr>
                <th class="property-label">Total Entradas</th>

                <td>
                    R$ ${df.format(centroCustoInstance?.valorTotalEntradas)}
                </td>
            </tr>

            <tr>
                <th class="property-label">Total Despesas</th>

                <td>
                    R$ ${df.format(Math.abs(centroCustoInstance?.valorTotalDespesas))}
                </td>
            </tr>

            <tr>
                <th class="property-label">Saldo</th>

                <td>
                    <% def saldo = centroCustoInstance?.saldo %>

                    <g:if test="${saldo < 0}">
                        <span class="text-danger">
                            R$ ${df.format(centroCustoInstance?.saldo)}
                        </span>
                    </g:if>
                    <g:else>
                        <span class="text-success">
                            R$ ${df.format(centroCustoInstance?.saldo)}
                        </span>
                    </g:else>
                </td>
            </tr>
        </table>
    </div>
</div>

<div class="form-group col-md-6">
    <label>Data de Emissão:</label>
    <div class="input-group input-daterange">
        <input type="text" class="form-control" name="dataInicio" id="dataInicio">
        <div class="input-group-addon">até</div>
        <input type="text" class="form-control" name="dataFinal" id="dataFinal">
        <span class="input-group-btn">
            <button class="btn btn-primary" type="button" onclick="atualizarExtratoFinanceiro()">Procurar</button>
        </span>
    </div>
</div>

<table class="table table-hover text-center" data-toggle="table" data-pagination='true' id="extratoFinanceiro" data-url="${createLink(controller: 'centroCusto',
        action: 'getExtratoFinanceiro.json', params: ['centroCustoId': centroCustoInstance.id])}">
    <thead>
    <tr>
        <th class="text-center" data-field="data" data-sortable="true" data-sorter="dateSorter">Data</th>
        <th class="text-center" data-field="tipo">Tipo</th>
        <th class="text-center" data-field="valor" data-formatter="currencyFormatter">Valor</th>
        <th class="text-center" data-field="origem">Origem</th>
        <th class="text-center" data-field="saldo" data-formatter="currencyFormatter">Saldo</th>
    </tr>
    </thead>

    <tbody>

    </tbody>
</table>

<g:render template="/despesa/modalCreate" model="[centroCustoId: centroCustoInstance.id]"/>
<g:render template="/lancamento/modalCreate" model="[centroCustoId: centroCustoInstance.id]"/>
<g:render template="/adiantamento/modalCreate" model="[centroCustoId: centroCustoInstance.id]"/>
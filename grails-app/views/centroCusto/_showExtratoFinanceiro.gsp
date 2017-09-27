<%@ page import="com.acception.cadastro.enums.StatusLancamento;" %>

<asset:stylesheet src="bootstrap/bootstrap-tables/bootstrap-table.min.css"/>
<asset:javascript src="plugins/bootstrap/bootstrap-tables/bootstrap-table-min.js"/>
<asset:javascript src="plugins/bootstrap/bootstrap-tables/bootstrap-table-pt-BR.js"/>
<export:resource/>


<script type="application/javascript">
    $(document).ready(function () {
        var pesquisaExtrato = $("form#pesquisa-extrato");

        pesquisaExtrato.submit(function (event) {
            event.preventDefault();
            atualizarExtratoFinanceiro(pesquisaExtrato);
        });

        atualizarExtratoFinanceiro(pesquisaExtrato);
    });

    function atualizarExtratoFinanceiro(form) {
        $("#extratoFinanceiro").bootstrapTable('refresh', {
            url: form[0].action,
            query: serializeFormToJSON(form)
        });

        updateExportLinks(form.serialize());
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

    function responseHandler(res) {
        if (res.lancamentoList) {
            var saldo = 0;
            for (var i = 0; i < res.lancamentoList.length; i++) {
                saldo += res.lancamentoList[i].valor;
                res.lancamentoList[i].saldo = saldo;
            }

            return res.lancamentoList;
        }

        return res;
    }

    function updateExportLinks(pesquisaUrl) {
        pesquisaUrl = "&" + pesquisaUrl;

        var exportLinks = $("div.export span.menuButton a");
        exportLinks.attr('href', function (i, a) {
            return a.split("&centroCusto")[0] + pesquisaUrl;
        });
    }

    function serializeFormToJSON(form) {
        var json = [];
        form.serializeArray().forEach(function (item) {
            json[item.name] = item.value;
        });

        return json;
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

                <td><g:formatNumber number="${centroCustoInstance?.valorTotalEntradas}" type="currency"/></td>
            </tr>

            <tr>
                <th class="property-label">Total Despesas</th>

                <td><g:formatNumber number="${centroCustoInstance?.valorTotalDespesas}" type="currency"/></td>
            </tr>

            <tr>
                <th class="property-label">Saldo</th>

                <td>
                    <% def saldo = centroCustoInstance?.saldo %>

                    <g:if test="${saldo < 0}">
                        <span class="text-danger">
                            <g:formatNumber number="${centroCustoInstance?.saldo}" type="currency"/>
                        </span>
                    </g:if>
                    <g:else>
                        <span class="text-success">
                            <g:formatNumber number="${centroCustoInstance?.saldo}" type="currency"/>
                        </span>
                    </g:else>
                </td>
            </tr>
        </table>
    </div>
</div>

<g:form name="pesquisa-extrato" controller="extratoFinanceiro" action="index.json">
    <g:hiddenField name="centroCusto.id" value="${centroCustoInstance.id}"/>
    <g:hiddenField name="status" value="${StatusLancamento.BAIXADO}"/>

    <div class="form-group col-md-6">
        <label>Data de Emissão:</label>

        <div class="input-group input-daterange">
            <input type="text" class="form-control" name="dataInicio" id="dataInicio">

            <div class="input-group-addon">até</div>
            <input type="text" class="form-control" name="dataFinal" id="dataFinal">
            <span class="input-group-btn">
                <button class="btn btn-primary" type="submit">Procurar</button>
            </span>
        </div>
    </div>
</g:form>

<table class="table table-hover text-center" data-toggle="table" data-pagination='true' id="extratoFinanceiro"
       data-response-handler="responseHandler">
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

<export:formats controller="extratoFinanceiro" action="index" formats="['excel', 'pdf']"/>

<g:render template="/despesa/modalCreate" model="[centroCustoId: centroCustoInstance.id]"/>
<g:render template="/lancamento/modalCreate" model="[centroCustoId: centroCustoInstance.id]"/>
<g:render template="/adiantamento/modalCreate" model="[centroCustoId: centroCustoInstance.id]"/>
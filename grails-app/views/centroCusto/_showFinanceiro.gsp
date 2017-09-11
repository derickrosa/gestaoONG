<g:set var="df" value="${new java.text.DecimalFormat('###,##0.00')}"/>

<style>
#tabelaDespesas td {
    text-align: center;
    vertical-align: middle;
}

#tabelaDespesas th {
    text-align: center;
}
</style>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-primary">
            <div class="panel-heading control-label">
                Conta Bancária
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">

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

                    <g:if test="${centroCustoInstance?.saldo != null}">
                        <tr>
                            <th class="property-label">Saldo</th>

                            <td>
                                R$ ${df.format(centroCustoInstance?.saldo)}
                            </td>
                        </tr>
                    </g:if>

                    <g:if test="${centroCustoInstance?.saldoInicial != null}">
                        <tr>
                            <th class="property-label">Saldo Inicial</th>

                            <td>
                                R$ ${df.format(centroCustoInstance?.saldoInicial)}
                            </td>
                        </tr>
                    </g:if>

                </table>
            </div>
        </div>
        <!-- /.panel -->
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <div class="panel panel-success">
            <div class="panel-heading">
                Extrato Financeiro
            </div>

            <div class="panel-body">
                <g:render template="showExtratoFinanceiro" model="[centroCustoInstance: centroCustoInstance]"/>
            </div>
        </div>
    </div>
</div>




%{--<h4 class="text-center">Despesas</h4>--}%
%{--<br>--}%

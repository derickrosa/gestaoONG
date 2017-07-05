<g:set var="df" value="${new java.text.DecimalFormat('###,##0.00')}"/>

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

    <g:if test="${centroCustoInstance?.contaBancaria?.saldo}">
        <tr>
            <th class="property-label">Saldo</th>

            <td>
                R$ ${df.format(centroCustoInstance?.contaBancaria?.saldo)}
            </td>
        </tr>
    </g:if>
</table>
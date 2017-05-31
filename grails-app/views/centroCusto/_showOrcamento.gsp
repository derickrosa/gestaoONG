<g:set var="df" value="${new java.text.DecimalFormat('###,##0.00')}"/>

<g:if test="${centroCustoInstance.orcamento}">
    <table class="table table-bordered centroCusto">

        <g:if test="${centroCustoInstance?.orcamento?.ano}">
            <tr>
                <th id="orcamento.ano-label" class="property-label" width="34%">Ano</th>

                <td aria-labelledby="orcamento.ano-label">${centroCustoInstance.orcamento.ano}</td>

            </tr>
        </g:if>

        <g:if test="${centroCustoInstance?.orcamento?.valorTotal}">
            <tr>
                <th id="orcamento.valorTotal-label" class="property-label">Valor Total</th>

                <td aria-labelledby="orcamento.valorTotal-label">${centroCustoInstance.orcamento.moeda.representacao} ${df.format(centroCustoInstance.orcamento.valorTotal)}</td>
            </tr>
        </g:if>

        <g:if test="${centroCustoInstance?.orcamento?.moeda}">
            <tr>
                <th id="orcamento.moeda-label" class="property-label">Moeda</th>

                <td aria-labelledby="orcamento.moeda-label"><g:fieldValue bean="${centroCustoInstance.orcamento}"
                                                                          field="moeda"/></td>
            </tr>
        </g:if>

        <tr></tr>
    </table>

    <g:if test="${centroCustoInstance.orcamento.itensOrcamentarios}">
        <div class="panel panel-success">
            <div class="panel-heading">
                Itens Orçamentários
            </div>

            <div class="panel-body">
                <table class="table table-hover text-center">
                    <thead>
                    <tr>
                        <th class="text-center">Código</th>
                        <th class="text-center">Nome</th>
                        <th class="text-center">Valor</th>
                        <th class="text-center">Tipo Custo</th>
                    </tr>
                    </thead>

                    <tbody>
                    <g:each in="${centroCustoInstance.orcamento.itensOrcamentarios}" var="item">
                        <tr>
                            <td>${item.codigo}</td>
                            <td>${item.nome}</td>
                            <td>${centroCustoInstance.orcamento.moeda.representacao} ${df.format(item.valor)}</td>
                            <td>${item.tipoCusto}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </div>
    </g:if>
</g:if>
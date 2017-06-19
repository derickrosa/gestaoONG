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

        <g:if test="${centroCustoInstance?.orcamento?.valorCambial}">
            <tr>
                <th id="orcamento.valorCambial-label" class="property-label">Valor Cambial</th>

                <td aria-labelledby="orcamento.valorCambial-label">R$ ${df.format(centroCustoInstance.orcamento.valorCambial)}</td>
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
                <table class="table table-hover text-center" style="width: 100%">
                    <thead>
                    <tr>
                        <th class="text-center">Código</th>
                        <th class="text-center">Nome</th>
                        <th class="text-center">Valor</th>
                        <th class="text-center">Tipo Custo</th>
                        <th class="text-center" width="20%">Funcionários</th>
                    </tr>
                    </thead>

                    <tbody>
                    <g:each in="${centroCustoInstance.orcamento.itensOrcamentarios}" var="item">
                        <tr>
                            <td style="text-align: center; vertical-align: middle;">${item.codigo}</td>
                            <td style="text-align: center; vertical-align: middle;">${item.nome}</td>
                            <td style="text-align: center; vertical-align: middle;">${centroCustoInstance.orcamento.moeda.representacao} ${df.format(item.valor)}</td>
                            <td style="text-align: center; vertical-align: middle;">${item.tipoCusto}</td>
                            <td>
                                <button type="button" class="btn btn-default" data-toggle="collapse" data-target="#funcionarios_${item.id}">
                                <span class="glyphicon glyphicon-user" aria-hidden="true"></span> Ver Funcionários
                            </button></td>
                            %{--<td>${item.salariosFuncionarios}</td>--}%
                        </tr>

                        <tr id="funcionarios_${item.id}" class="collapse">
                            <td colspan="5">

                                <g:if test="${item.salariosFuncionarios}">
                                    <table class="table table-hover table-bordered text-center">
                                        <thead>
                                        <tr>
                                            <th class="text-center" width="50%">Funcionário</th>
                                            <th class="text-center" width="50%">Valor</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <g:each in="${item.salariosFuncionarios}" var="s">
                                            <tr>
                                                <td>${s.funcionario}</td>
                                                <td>R$ ${df.format(s.valor)}</td>
                                            </tr>
                                        </g:each>


                                        </tbody>
                                    </table>
                                </g:if>
                                <g:else>
                                    Não existem funcionários registrados para esse item orçamentário.
                                </g:else>

                            </td>

                        </tr>

                    </g:each>
                    </tbody>
                </table>
            </div>
        </div>
    </g:if>
</g:if>
<%@ page import="com.acception.cadastro.enums.Moeda" %>

<g:if test="${orcamento}">
    <table class="table table-bordered centroCusto">
        <g:if test="${orcamento?.ano}">
            <tr>
                <th id="orcamento.ano-label" class="property-label" width="34%">Ano</th>
                <td aria-labelledby="orcamento.ano-label">${orcamento.ano}</td>
            </tr>
        </g:if>

        <g:if test="${orcamento?.valorTotal}">
            <tr>
                <th id="orcamento.valorTotal-label" class="property-label">Valor Total</th>
                <td aria-labelledby="orcamento.valorTotal-label"><g:formatNumber number="${orcamento.valorTotal}" type="currency" currencySymbol="${orcamento.moeda.representacao}"/></td>
            </tr>
        </g:if>

        <g:if test="${orcamento?.moeda}">
            <tr>
                <th id="orcamento.moeda-label" class="property-label">Moeda</th>
                <td aria-labelledby="orcamento.moeda-label"><g:fieldValue bean="${orcamento}" field="moeda"/></td>
            </tr>
        </g:if>

        <g:if test="${orcamento?.moeda != Moeda.REAL && orcamento?.valorCambial}">
            <tr>
                <th id="orcamento.valorCambial-label" class="property-label">Valor Cambial</th>
                <td aria-labelledby="orcamento.valorCambial-label"><g:formatNumber number="${orcamento.valorCambial}" type="currency"/></td>
            </tr>
        </g:if>
    </table>
    %{--Caso seja orçamento atual, então devemos disponibilizar um botão para replanejar o orçamento--}%
    <g:if test="${isOrcamentoAtual}">
        <div class="row text-center">
            <a href="${createLink(controller: 'orcamento', action: 'create', params: ['orcamentoAnterior': centroCustoInstance.orcamentoAtual.id,
                                                                                      'orcamentoInstance.ano': centroCustoInstance.orcamentoAtual.ano,
                                                                                      'orcamentoInstance.valorTotal': centroCustoInstance.orcamentoAtual.valorTotal,
                                                                                      'orcamento.moeda': centroCustoInstance.orcamentoAtual.moeda.name(),
                                                                                      'orcamentoInstance.valorCambial': centroCustoInstance.orcamentoAtual.valorCambial])}" class="btn btn-default">
                <span class="glyphicon glyphicon-transfer" aria-hidden="true"></span> Replanejar Orçamento
            </a>
        </div>
        <br>
    </g:if>

    <g:if test="${orcamento.itensOrcamentarios}">
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
                    <g:each in="${orcamento.itensOrcamentarios}" var="item">
                        <tr>
                            <td style="text-align: center; vertical-align: middle;">${item.codigo}</td>
                            <td style="text-align: center; vertical-align: middle;">${item.nome}</td>
                            <td style="text-align: center; vertical-align: middle;"><g:formatNumber number="${item.valor}" type="currency" currencySymbol="${orcamento.moeda.representacao}"/></td>
                            <td style="text-align: center; vertical-align: middle;">${item.tipoCusto}</td>
                            <td>
                        <g:if test="${item.salariosFuncionarios}">
                                <button type="button" class="btn btn-default" data-toggle="collapse" data-target="#funcionarios_${item.id}">
                                <span class="glyphicon glyphicon-user" aria-hidden="true"></span> Ver Funcionários
                            </button></td>
                            %{--<td>${item.salariosFuncionarios}</td>--}%
                            </g:if>
                            <g:else>
                                Não se Aplica
                            </g:else>
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
                                                <td><g:formatNumber number="${s.valor}" type="currency"/></td>
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
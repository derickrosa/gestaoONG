<%@ page import="com.acception.cadastro.enums.TipoCusto; com.acception.cadastro.enums.RamoFuncionario" %>

<asset:stylesheet src="dataTables.bootstrap.css"/>
<asset:javascript src="jquery.dataTables.min.js"/>
<asset:javascript src="dataTables.bootstrap.min.js"/>


<style>
    .dataTables_info {
        display: none;
    }

    #wizard section {
        float: none;
        position: relative;
        margin: auto;
    }

</style>

<%
    def listaFuncionarios = centroCustoInstance.orcamentoAtual?.itensOrcamentarios?.salariosFuncionarios

    if (listaFuncionarios) {
        listaFuncionarios = listaFuncionarios.flatten()
    }

    Set listaFuncionariosPassados = []
    def orcamentosPassados = centroCustoInstance.orcamentos - centroCustoInstance.orcamentoAtual

    for (orcamento in orcamentosPassados) {
        def listaFuncionariosOrcamento = orcamento.itensOrcamentarios.salariosFuncionarios.funcionario

        listaFuncionariosOrcamento = listaFuncionariosOrcamento?.flatten()

        listaFuncionariosOrcamento.each {
            listaFuncionariosPassados << it
        }
    }

    listaFuncionariosPassados -= listaFuncionarios?.collect { it.funcionario }
%>

<g:if test="${listaFuncionariosPassados}">
    <ul class="nav nav-pills">
        <li class="active"><a href="#listaFuncionariosAtuais" data-toggle="tab" aria-expanded="true">Funcionários Atuais</a></li>
        <li><a href="#listaFuncionariosPassados" data-toggle="tab" aria-expanded="true">Funcionários Passados</a></li>
    </ul>

    <div class="tab-content">
        <div class="tab-pane fade in active" id="listaFuncionariosAtuais">
            <g:render template="listaFuncionariosAtuais" model="[listaFuncionarios: listaFuncionarios]"/>
        </div>

        <div class="tab-pane fade in" id="listaFuncionariosPassados">
            <h4 class="text-center">Histórico de Funcionários Passados</h4>

            <table class="table table-hover text-center" id="tableFuncionariosPassados">
                <thead>
                <tr>
                    <th class="text-center" width="25%">Nome</th>
                    <th class="text-center" width="25%">Setor</th>
                    <th class="text-center" width="25%">Salário Anual (R$)</th>
                </tr>
                </thead>

                <tbody>
                <g:each in="${listaFuncionariosPassados}" var="f">
                    <tr>
                        <td>${f}</td>
                        <td>${f.setor}</td>
                        <td><g:formatNumber number="${f.salario}" type="currency"/></td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>
    </div>
</g:if>
<g:else>
    <g:render template="listaFuncionariosAtuais" model="[listaFuncionarios: listaFuncionarios]"/>
</g:else>


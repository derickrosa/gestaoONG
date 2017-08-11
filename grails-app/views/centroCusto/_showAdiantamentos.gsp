<%@ page import="com.acception.cadastro.Adiantamento" %>
<%
    def pagamentosAdiantados = Adiantamento.createCriteria().list {
        centroCusto {
            idEq(centroCustoInstance.id)
        }
    }
%>

<div class="row">
    <div class="col-md-12 text-center">
        <button type="button" class="btn btn-default" data-toggle="modal" data-target="#modalCriacaoPAs">
            <span class="glyphicon glyphicon-plus"></span> Criar PA
        </button>
    </div>
</div>

<br>

<table class="table table-hover text-center" id="tabelaPagamentosAdiantados">
    <thead>
    <tr>
        <th class="text-center" data-attribute="descricao" data-render='<g:link controller="adiantamento" action="show" id="{id}">{descricao}</g:link>'>Descrição</th>
        <th class="text-center" data-attribute="valor" data-render="R$ {valor}">Valor</th>
        <th class="text-center" data-attribute="statusAdiantamento.nome">Status</th>
        <th class="text-center" data-attribute="lancamentoOriginal.papel">Funcionário</th>
        <th class="text-center" data-attribute="data">Data</th>
    </tr>
    </thead>

    <tbody>
    <g:if test="${pagamentosAdiantados}">
        <g:each in="${pagamentosAdiantados.sort { it.data }}" var="pa">
            <tr>
                <td><g:link controller="adiantamento" action="show" id="${pa.id}">${pa.descricao}</g:link></td>
                <td>R$ ${df.format(pa.valor)}</td>
                <td>${pa.statusAdiantamento?.nome}</td>
                <td>${pa.lancamentoOriginal.papel}</td>
                <td><g:formatDate date="${pa.data}" format="dd/MM/yyyy"/></td>
            </tr>
        </g:each>
    </g:if>

    <g:else>
        <tr id="alertNoPagamentosAdiantados">
            <td colspan="5">Sem PA's cadastradas para esse centro de custo!</td>
        </tr>
    </g:else>

    </tbody>
</table>

<g:render template="/adiantamento/modalCreate" model="[centroCustoId: centroCustoInstance.id,
                                                       idTabelaParaAtualizar: '#tabelaPagamentosAdiantados']"/>

<asset:javascript src="dynamicTable.js"/>

<script>
    document.getElementById("formCriacaoPAs").addEventListener("adiantamentoCriado", function (e) {
        var warningNaoHaDespesasCadastradas = $("#alertNoPagamentosAdiantados");

        if (warningNaoHaDespesasCadastradas) {
            warningNaoHaDespesasCadastradas.hide();
        }

        addNewRowToTable('#tabelaPagamentosAdiantados', e.detail);
    }, false);
</script>
<style>
    #historicoOrcamentos table td {
        vertical-align: middle;
    }
</style>

<table class="table table-hover text-center">
    <thead>
    <tr>
        <th class="text-center" width="10%">#</th>
        <th class="text-center">Valor</th>
        <th class="text-center">Ano</th>
        <th class="text-center">Data de Criação</th>
        <th class="text-center" width="20%">Opções</th>
    </tr>
    </thead>

    <tbody>
    <g:each in="${listaOrcamentos.sort { it.dateCreated }}" status="i" var="orcamento">
        <tr
            <g:if test="${i == 0}">
                class="warning"
            </g:if>
            <g:elseif test="${i == listaOrcamentos.size() - 1}">
                class="success"
            </g:elseif>
        >
            <td>${i + 1}</td>
            <td><g:formatNumber number="${orcamento.valorTotal}" type="currency"/></td>
            <td>${orcamento.ano}</td>
            <td><g:formatDate date="${orcamento.dateCreated}" format="dd/MM/yyyy"/></td>
            <td>
                <a target="_blank" href="${createLink(controller: 'orcamento', action: 'show', id: orcamento.id)}" type="button" class="btn btn-default">
                    <span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span> Ver Dados
                </a>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>

<span class="label label-warning">Orçamento Original</span>
<span class="label label-success">Orçamento Atual</span>

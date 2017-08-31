<g:if test="${linhaAcaoInstance?.centrosCusto}">



<div class="panel-body">
<table %{--class="table table-hover table-bordered text-center" --}%class="table table-hover text-center">
    <thead>
        <tr>
            <th class="text-center" width="33%">Código</th>
            <th class="text-center" width="33%">Nome</th>
            <th class="text-center" width="34%">Ano</th>
            <th class="text-center" width="34%">Status</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
    <g:each in="${linhaAcaoInstance?.centrosCusto}" var="cc">
        <tr>
            <td>
                ${cc.codigo}
            </td>
            <td>${cc.nome}</td>
            <td>${cc.ano}</td>
            <td>${cc.statusProjeto}</td>

            <td>
                <g:link controller="centroCusto" action="show" id="${cc.id}">
                    <spam class="glyphicon glyphicon-search" />
                </g:link>
            </td>

        </tr>
    </g:each>


    </tbody>
    </table>
    </div>
</g:if>
<g:else>
    <div class="well text-center">
        Não existem centros de custo nesta linha de ação.
    </div>
</g:else>
<g:if test="${linhaAcaoInstance?.atividades}">



<div class="panel-body">
<table %{--class="table table-hover table-bordered text-center" --}%class="table table-hover text-center">
    <thead>
    <tr>
        <th class="text-center" width="33%">Código</th>
        <th class="text-center" width="33%">Nome</th>
        <th class="text-center" width="34%"></th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${linhaAcaoInstance?.atividades}" var="a">
        <tr>
            <td>

                ${a.codigo}

            </td>
            <td>${a.nome}</td>

            <td>
                <g:link controller="atividade" action="show" id="${a.id}">
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
        Não existem atividades nesta linha de ação.
    </div>
</g:else>
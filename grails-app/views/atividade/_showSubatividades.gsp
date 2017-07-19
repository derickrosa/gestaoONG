<asset:stylesheet src="dataTables.bootstrap.css"/>
<asset:javascript src="jquery.dataTables.min.js"/>
<asset:javascript src="dataTables.bootstrap.min.js"/>

<g:if test="${atividadeInstance.subAtividades}">
    <table %{--class="table table-hover table-bordered text-center" --}%class="table table-hover text-center">
        <thead>
        <tr>
            <th class="text-center" width="33%">Código</th>
            <th class="text-center" width="33%">Nome</th>
            <th class="text-center" width="34%"></th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${atividadeInstance.subAtividades}" var="s">
            <tr>
                <td>

                        ${s?.codigo}

                </td>
                <td>${s?.nome}</td>
                <td>
                    <g:link controller="atividade" action="show" id="${s.id}">
                        <spam class="glyphicon glyphicon-search" />
                    </g:link>
                </td>
            </tr>
        </g:each>


        </tbody>
    </table>
</g:if>
<g:else>
    <div class="well text-center">
        Não existem subatividades registradas.
    </div>

</g:else>

<br>

<div class="row text-center">
    <g:link action="create" params="${[atividade:atividadeInstance.id]}" class="btn btn-default btn-sm">
        <span class="glyphicon glyphicon-plus"></span>
        Nova Subatividade
    </g:link>
</div>
<asset:stylesheet src="dataTables.bootstrap.css"/>
<asset:javascript src="jquery.dataTables.min.js"/>
<asset:javascript src="dataTables.bootstrap.min.js"/>

<g:if test="${atividadeInstance.relatorios}">
    <table %{--class="table table-hover table-bordered text-center" --}%class="table table-hover text-center">
        <thead>
        <tr>
            <th class="text-center" width="33%">ID</th>
            <th class="text-center" width="33%">Data de Criação</th>
            <th class="text-center" width="34%"></th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${atividadeInstance.relatorios}" var="r">
            <tr>
                <td>

                        ${r.id}

                </td>
                <td>${r.dateCreated}</td>

                    <td>
                        <g:link controller="relatorioAtividade" action="show" id="${r.id}">
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
        Não existem relatórios registrados.
    </div>
</g:else>

<br>

<div class="row text-center">
    <g:link controller="relatorioAtividade" action="create" params="${[atividade:atividadeInstance?.id, centroCusto:atividadeInstance?.centroCusto?.id, financiador:atividadeInstance?.centroCusto?.financiador?.id]}" class="btn btn-default btn-sm">
        <span class="glyphicon glyphicon-plus"></span>
        Novo Relatório
    </g:link>
</div>
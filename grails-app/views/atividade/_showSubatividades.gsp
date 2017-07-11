<asset:stylesheet src="dataTables.bootstrap.css"/>
<asset:javascript src="jquery.dataTables.min.js"/>
<asset:javascript src="dataTables.bootstrap.min.js"/>

<g:if test="${atividadeInstance.subAtividades}">
    <table %{--class="table table-hover table-bordered text-center" --}%class="table table-hover text-center">
        <thead>
        <tr>
            <th class="text-center" width="50%">Código</th>
            <th class="text-center" width="50%">Nome</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${atividadeInstance.subAtividades}" var="s">
            <tr>
                <td>${s.codigo}</td>
                <td>${s.nome}</td>
            </tr>
        </g:each>


        </tbody>
    </table>
</g:if>
<g:else>
    Não existem subatividades registradas.
</g:else>

<br>

<div class="row text-center">
    <g:link action="create" params="${atividadeInstance?.centroCusto?.id}" class="btn btn-default btn-sm">
        <span class="glyphicon glyphicon-floppy-remove"></span>
        Nova Subatividade
    </g:link>
</div>
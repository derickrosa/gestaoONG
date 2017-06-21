<g:set var="df" value="${new java.text.DecimalFormat('###,##0.00')}"/>

<asset:stylesheet src="dataTables.bootstrap.css"/>
<asset:javascript src="jquery.dataTables.min.js"/>
<asset:javascript src="dataTables.bootstrap.min.js"/>

<style>
    .dataTables_info {
        display: none;
    }
</style>

<%
    def listaFuncionarios = centroCustoInstance.orcamento?.itensOrcamentarios?.salariosFuncionarios

    if (listaFuncionarios) {
        listaFuncionarios = listaFuncionarios[0]
    }
%>

<g:if test="${listaFuncionarios}">
    <table class="table table-hover text-center" id="table">
        <thead>
        <tr>
            <th class="text-center" width="25%">Nome</th>
            <th class="text-center" width="25%">Setor</th>
            <th class="text-center" width="25%">Salário Centro Custo (R$)</th>
            <th class="text-center" width="25%">Salário Anual (R$)</th>
        </tr>
        </thead>

        <tbody>
            <g:each in="${listaFuncionarios}" var="f">
                <tr>
                    <td>${f.funcionario}</td>
                    <td>${f.funcionario.setor}</td>
                    <td>R$ ${df.format(f.valor)}</td>
                    <td>R$ ${df.format(f.funcionario.salario)}</td>
                </tr>
            </g:each>
        </tbody>
    </table>
</g:if>
<g:else>
    <div class="well text-center">Sem registros!</div>
</g:else>

<script>
    $(document).ready( function () {
        var table = $('#table').DataTable({
            paging: false
        });
    } );
</script>
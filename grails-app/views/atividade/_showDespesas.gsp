<g:set var="df" value="${new java.text.DecimalFormat('###,##0.00')}"/>

<g:if test="${atividadeInstance.despesas}">
    <table class="table table-hover text-center">
        <thead>
            <tr>
                <th class="text-center">Descrição</th>
                <th class="text-center">Valor</th>
                <th class="text-center">Data</th>
                <th class="text-center">Destino</th>
            </tr>
        </thead>

        <tbody>
            <g:each in="${atividadeInstance.despesas}" var="despesa">
                <tr>
                    <td><a href="${createLink(controller: 'despesa', action: 'show', id: despesa.id)}">${despesa.descricao}</a></td>
                    <td>R$ ${df.format(despesa.valor)}</td>
                    <td><g:formatDate date="${despesa.dateCreated}" format="dd/MM/yyyy"/></td>
                    <td>${despesa.papel ?: '--'}</td>
                </tr>
            </g:each>
        </tbody>
    </table>
</g:if>
<g:else>
    <div class="well text-center">
        Não existem despesas registradas para esta atividade.
    </div>
</g:else>
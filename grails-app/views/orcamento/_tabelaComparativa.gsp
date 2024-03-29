<%@ page import="com.acception.cadastro.ItemOrcamentario; com.acception.cadastro.Orcamento" %>

<%
    listaOrcamentos = listaOrcamentos.sort { it.dateCreated }

    Set codigosItensOrcamentarios = listaOrcamentos.collect { it.itensOrcamentarios.codigo }.flatten()
%>

<table class="table table-hover text-center">
    <thead>
        <th></th>
        <g:each in="${listaOrcamentos}" var="orcamento" status="i">
            <g:if test="${i == 0}">
                <th class="text-center warning">Orçamento de <g:formatDate date="${orcamento.dateCreated}" format="dd/MM/yyyy"/></th>
            </g:if>
            <g:elseif test="${i == listaOrcamentos.size() - 1}">
                <th class="text-center success">Orçamento de <g:formatDate date="${orcamento.dateCreated}" format="dd/MM/yyyy"/></th>
            </g:elseif>
            <g:else>
                <th class="text-center active">Orçamento de <g:formatDate date="${orcamento.dateCreated}" format="dd/MM/yyyy"/></th>
            </g:else>

        </g:each>

    </thead>

    <tbody>
        <g:each in="${codigosItensOrcamentarios.sort()}" var="codigo">
            <tr>
                <td align="left"><strong>${codigo} - ${listaOrcamentos.itensOrcamentarios.flatten().find{ it.codigo == codigo}.nome}</strong></td>

                <g:each in="${listaOrcamentos}" var="orcamento">
                    <g:set var="itemOrcamentario" value="${orcamento.itensOrcamentarios.find { it.codigo == codigo}}"/>

                    <g:if test="${itemOrcamentario}">
                        <td><g:formatNumber number="${itemOrcamentario.valor}" type="currency"/></td>
                    </g:if>
                    <g:else>
                        <td>--</td>
                    </g:else>
                </g:each>
            </tr>
        </g:each>
    </tbody>
</table>

<span class="label label-warning">Orçamento Original</span>
<span class="label label-success">Orçamento Atual</span>
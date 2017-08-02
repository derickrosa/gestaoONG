<%@ page import="com.acception.cadastro.ItemOrcamentario; com.acception.cadastro.Orcamento" %>

<g:set var="df" value="${new java.text.DecimalFormat('###,##0.00')}"/>

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
                <td><strong>Item | ${codigo}</strong></td>

                <g:each in="${listaOrcamentos}" var="orcamento">
                    <g:set var="itemOrcamentario" value="${orcamento.itensOrcamentarios.find { it.codigo == codigo}}"/>

                    <g:if test="${itemOrcamentario}">
                        <td>R$ ${df.format(itemOrcamentario.valor)}</td>
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
<%@ page import="com.acception.cadastro.CentroCusto" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'centroCusto.label', default: 'Centro de Custo')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<p>
    <g:link class="btn btn-default" action="index">
        <span class="glyphicon glyphicon-list"></span>
        <g:message code="default.list.label" args="[entityName]"/>
    </g:link>
    <g:link class="btn btn-default" action="create">
        <span class="glyphicon glyphicon-plus"></span>
        <g:message code="default.new.label" args="[entityName]"/>
    </g:link>
</p>

<ul class="nav nav-tabs">
    <li class="active"><a href="#dadosBasicos" data-toggle="tab" aria-expanded="false">Dados Básicos</a></li>
    <li><a href="#orcamento" data-toggle="tab" aria-expanded="true">Orçamento</a></li>
    <li><a href="#tabAtividades" data-toggle="tab" aria-expanded="true">Atividade</a></li>
    <li><a href="#pessoal" data-toggle="tab" aria-expanded="true">Pessoal</a></li>
    <li><a href="#financeiro" data-toggle="tab" aria-expanded="true">Financeiro</a></li>
</ul>

<div class="tab-content">
    <div class="tab-pane fade in active" id="dadosBasicos">
        <g:render template="showDadosBasicos" model="[centroCustoInstance: centroCustoInstance]"/>
    </div>

    <div class="tab-pane fade in" id="orcamento">
        <g:if test="${centroCustoInstance.orcamentos?.size() > 1}">
            <ul class="nav nav-pills">
                <li class="active"><a href="#orcamentoAtual" data-toggle="tab" aria-expanded="true">Orçamento Atual</a></li>
                <li><a href="#orcamentoOriginal" data-toggle="tab" aria-expanded="true">Orçamento Original</a></li>
                <li><a href="#historicoOrcamentos" data-toggle="tab" aria-expanded="true">Histórico de Orçamentos</a></li>
                <li><a href="#comparacaoOrcamentos" data-toggle="tab" aria-expanded="true">Tabela Comparativa</a></li>
            </ul>

            <div class="tab-content">
                <div class="tab-pane fade in active" id="orcamentoAtual">
                    <g:render template="showOrcamento" model="[orcamento: centroCustoInstance.orcamentoAtual, isOrcamentoAtual: true]"/>
                </div>

                <div class="tab-pane fade in" id="orcamentoOriginal">
                    <g:render template="showOrcamento" model="[orcamento: centroCustoInstance.orcamentoOriginal]"/>
                </div>

                <div class="tab-pane fade in" id="historicoOrcamentos">
                    <g:render template="historicoOrcamentos" model="[listaOrcamentos: centroCustoInstance.orcamentos]"/>
                </div>

                <div class="tab-pane fade in" id="comparacaoOrcamentos">
                    <g:render template="/orcamento/tabelaComparativa" model="[listaOrcamentos: centroCustoInstance.orcamentos]"/>
                </div>
            </div>
        </g:if>
        <g:else>
            <g:render template="showOrcamento" model="[orcamento: centroCustoInstance.orcamentoAtual, isOrcamentoAtual: true]"/>
        </g:else>

    </div>

    <div class="tab-pane fade in" id="tabAtividades">
        <g:render template="listAtividades" model="[centroCustoInstance: centroCustoInstance]"/>
    </div>

    <div class="tab-pane fade in" id="pessoal">
        <g:render template="showPessoal" model="[centroCustoInstance: centroCustoInstance]"/>
    </div>

    <div class="tab-pane fade in" id="financeiro">
        <g:render template="showFinanceiro" model="[centroCustoInstance: centroCustoInstance]"/>
    </div>
</div>

<g:form url="[resource: centroCustoInstance, action: 'delete']" method="DELETE">
    <fieldset class="buttons">
        <g:link class="btn btn-default" action="edit" resource="${centroCustoInstance}">
            <span class="glyphicon glyphicon-edit"></span>
            <g:message code="default.button.edit.label" default="Edit"/>
        </g:link>
        <button type="submit" class="btn btn-default"
                onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
            <span class="glyphicon glyphicon-floppy-remove"></span>
            <g:message code="default.button.delete.label"/>
        </button>
    </fieldset>
</g:form>

<script>
    $(document).ready(function()
    {

        var showHistorico = ${params.showOrcamento ?: false};

        if (showHistorico) {
            $('a[href="#orcamento"]').tab('show');
        }
    });
</script>

</body>
</html>

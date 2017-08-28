
<%@ page import="com.acception.cadastro.Despesa" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'despesa.label', default: 'Despesa')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
    <g:set var="df" value="${new java.text.DecimalFormat('###,##0.00')}"/>
    <asset:javascript src="dynamicTable.js"/>
</head>

<body>
<div id="content">
    <div class="inner" style="min-height: 700px;">
        <div class="row">
            <div class="col-lg-12">
                <h1><g:message code="default.list.label" args="[entityName]"/></h1>
            </div>
        </div>
        <hr/>
        <!--BLOCK SECTION -->

        <div class="nav" role="navigation">
            <button type="button" class="btn btn-default" data-toggle="modal" data-target="#modalCriacaoDespesas">
                <span class="glyphicon glyphicon-plus"></span> Criar Despesa
            </button>
        </div>

        <br>

        <div id="list-despesa" class="body" role="main">
            <g:if test="${flash.message}">
                <div class="alert alert-info" role="status">${flash.message}</div>
            </g:if>
            <table class="table table-bordered table-striped text-center" id="tableDespesas">
                <thead>
                <tr>

                    <th class="text-center" data-attribute="descricao" data-render='<g:link controller="despesa" action="show" id="{id}">{descricao}</g:link>'>Descrição</th>
                    <th class="text-center" data-attribute="valor" data-render="R$ {valor}">Valor</th>
                    <th class="text-center" data-attribute="tipoDespesa.nome">Tipo Despesa</th>
                    <th class="text-center" data-attribute="data">Data</th>

                    <th class="text-center" data-attribute="centroCusto"><g:message code="despesa.centroCusto.label" default="Centro Custo"/></th>
                    <th class="text-center" data-attribute="atividade"><g:message code="despesa.atividade.label" default="Atividade"/></th>

                </tr>
                </thead>
                <tbody>

                <g:if test="${despesaInstanceList}">
                    <g:each in="${despesaInstanceList}" status="i" var="despesaInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td><g:link action="show" id="${despesaInstance?.id}">${despesaInstance.descricao}</g:link></td>

                            <td>R$ ${df.format(despesaInstance.valor)}</td>

                            <td>${despesaInstance.tipoDespesa?.nome}</td>

                            <td><g:formatDate format="dd/MM/yyyy" date="${despesaInstance.data}"/></td>

                            <td><g:link controller="centroCusto" action="show"
                                        id="${despesaInstance?.centroCusto?.id}">${fieldValue(bean: despesaInstance, field: "centroCusto")}</g:link></td>

                            <td>${fieldValue(bean: despesaInstance, field: "atividade")}</td>
                        </tr>
                    </g:each>
                </g:if>
                <g:else>
                    <tr id="alertNoDespesas">
                        <td colspan="6"><strong>Sem despesas cadastradas!</strong></td>
                    </tr>
                </g:else>


                </tbody>
            </table>

            <div class="pagination">
                <g:paginate total="${despesaInstanceCount ?: 0}"/>
            </div>
        </div>
    </div>
</div>

<g:render template="modalCreate" model="[idTabelaParaAtualizar: '#tableDespesas']"/>

<script>
    Number.prototype.format = function(n, x, s, c) {
        n = n == undefined ? 2 : n;

        x = x == undefined ? 3 : x;

        s = s == undefined ? '.' : s;

        c = c == undefined ? ',' : c;

        var re = '\\d(?=(\\d{' + (x || 3) + '})+' + (n > 0 ? '\\D' : '$') + ')',
                num = this.toFixed(Math.max(0, ~~n));

        return (c ? num.replace('.', c) : num).replace(new RegExp(re, 'g'), '$&' + (s || ','));
    };

    document.getElementById("formCriacaoDespesa").addEventListener("despesaCriada", function (e) {
        var warningNaoHaDespesasCadastradas = $("#alertNoDespesas");

        if (warningNaoHaDespesasCadastradas) {
            warningNaoHaDespesasCadastradas.hide();
        }

        addNewRowToTable('#tableDespesas', e.detail);
    }, false);
</script>

</body>
</html>

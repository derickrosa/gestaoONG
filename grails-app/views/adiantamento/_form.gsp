<%@ page import="com.acception.cadastro.Funcionario; com.acception.cadastro.CentroCusto" %>

<asset:stylesheet src="bootstrap-datepicker.css"/>

<div class="row">
    <div class="col-md-6 form-group fieldcontain">
        <label for="centroCusto">
            <g:message code="despesa.centroCusto.label" default="Centro Custo"/>

        </label>
        <g:select class="form-control" id="centroCusto-PA" name="centroCusto.id"
                  from="${CentroCusto.list()}" optionKey="id" value="${centroCustoId ?: adiantamentoInstance?.centroCusto?.id}" noSelection="['': '']" required="required" data-placeholder="Selecione um centro de custo..."/>

    </div>
</div>

<div class="row">
    <div class="col-md-12 form-group fieldcontain">
        <label for="descricao">
            <g:message code="despesa.descricao.label" default="Descrição"/>

        </label>
        <g:textField class="form-control" required="required" id="descricao-PA" name="descricao" value="${adiantamentoInstance?.descricao}"/>
    </div>
</div>

<div class="form-group fieldcontain">
    <label for="funcionario">
        <g:message code="despesa.funcionario.label" default="Funcionário"/>

    </label>
    <g:select required="required" id="funcionario-PA" name="papel.id" from="${Funcionario.list()}"
              optionKey="id" class="form-control" noSelection="['': '']" data-placeholder="Selecione um funcionário..."
              value="${adiantamentoInstance?.lancamentoOriginal?.papel?.id}"/>
</div>

<div class="row">
    <div class="col-md-6 form-group fieldcontain">
        <label for="valor-PA">
            <g:message code="despesa.valor.label" default="Valor"/>

        </label>

        <input required="required" type="text" class="form-control currency" id="valor-PA" name="valor"
               data-allow-negative="false" value="${adiantamentoInstance?.valor}">
    </div>

    <div class="col-md-6 form-group fieldcontain">
        <label for="data-PA">
            <g:message code="despesa.data.label" default="Data"/>

        </label>

        <input type="text" required="required" id="data-PA" name="data" format="dd/MM/yyyy"
               class="form-control datepicker" value="${adiantamentoInstance?.data?.format('dd/MM/yyyy')}"/>

    </div>
</div>

<script>
    $(function () {
        $("#centroCusto-PA").chosen();
        $("#funcionario-PA").chosen();
    })
</script>
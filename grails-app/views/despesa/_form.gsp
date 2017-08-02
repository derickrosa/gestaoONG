<%@ page import="com.acception.cadastro.enums.TipoDespesa; com.acception.cadastro.Despesa" %>

<asset:stylesheet src="bootstrap-datepicker.css"/>

<div class="row">
    <div class="col-md-9 form-group fieldcontain ${hasErrors(bean: despesaInstance, field: 'descricao', 'error')} ">
        <label for="descricao">
            <g:message code="despesa.descricao.label" default="Descrição"/>

        </label>
        <g:textField class="form-control" required="required" name="descricao" value="${despesaInstance?.descricao}"/>
    </div>

    <div class="col-md-3 form-group fieldcontain ${hasErrors(bean: despesaInstance, field: 'valor', 'error')} ">
        <label for="valor">
            <g:message code="despesa.valor.label" default="Valor"/>

        </label>

        <input required="required" type="text" class="form-control currency" id="valor" name="valor" value="${despesaInstance?.valor}">
    </div>
</div>

<div class="row">
    <div class="col-md-6 form-group fieldcontain ${hasErrors(bean: despesaInstance, field: 'centroCusto', 'error')} ">
        <label for="centroCusto">
            <g:message code="despesa.centroCusto.label" default="Centro Custo"/>

        </label>
        <g:select class="form-control" id="centroCusto" name="centroCusto.id" from="${com.acception.cadastro.CentroCusto.list()}" optionKey="id" value="${despesaInstance?.centroCusto?.id}" noSelection="['null': '']" required="required" data-placeholder="Selecione um centro de custo..."/>

    </div>


    <div class="col-md-6 form-group fieldcontain ${hasErrors(bean: despesaInstance, field: 'tipoDespesa', 'error')} ">
        <label for="tipoDespesa">
            <g:message code="despesa.tipoDespesa.label" default="Tipo de Despesa"/>

        </label>
        <g:select name="tipoDespesa" from="${TipoDespesa.values().nome}" class="form-control" keys="${TipoDespesa.values()*.name()}" value="${despesaInstance?.tipoDespesa?.name()}"
                  noSelection="['': 'Selecione um tipo de despesa...']" required="required"/>

    </div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: despesaInstance, field: 'atividade', 'error')} ">
    <label for="atividade">
        <g:message code="despesa.atividade.label" default="Atividade"/>

    </label>
    <g:select required="required" id="atividade" name="atividade.id" from="${com.acception.cadastro.Atividade.list()}" optionKey="id" value="${despesaInstance?.atividade?.id}" class="form-control" noSelection="['': '']"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: despesaInstance, field: 'fornecedor', 'error')} ">
    <label for="fornecedor">
        <g:message code="despesa.fornecedor.label" default="Fornecedor"/>
        
    </label>
    <g:select required="required" id="fornecedor" name="fornecedor.id" from="${com.acception.cadastro.Fornecedor.list()}" optionKey="id" value="${despesaInstance?.fornecedor?.id}" class="form-control" noSelection="['': '']"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: despesaInstance, field: 'funcionario', 'error')} ">
    <label for="funcionario">
        <g:message code="despesa.funcionario.label" default="Funcionário"/>
        
    </label>
    <g:select required="required" id="funcionario" name="funcionario.id" from="${com.acception.cadastro.Funcionario.list()}" optionKey="id" value="${despesaInstance?.funcionario?.id}" class="form-control" noSelection="['': '']"/>

</div>

<div class="row">


    <div class="col-md-4 form-group fieldcontain ${hasErrors(bean: despesaInstance, field: 'data', 'error')} ">
        <label for="data">
            <g:message code="despesa.data.label" default="Data"/>

        </label>

        <input required="required" id="data" name="data" format="dd/MM/yyyy"
               value="${formatDate(format: "dd/MM/yyyy", date: despesaInstance?.data)}"
               class="form-control datepicker"/>

    </div>
</div>

<script>
    $(function() {
        var refreshFormBasedOnTipoDespesa = function (tipoDespesa) {
            if (tipoDespesa === "ATIVIDADE") {
                $("#atividade").prop("disabled", false);
                $("#fornecedor").prop("disabled", false);
                $("#funcionario").prop("disabled", true).val('');
            } else if (tipoDespesa === "PESSOAL" || tipoDespesa == "ADIANTAMENTO") {
                $("#atividade").prop("disabled", true).val('');
                $("#fornecedor").prop("disabled", true).val('');
                $("#funcionario").prop("disabled", false);
            } else if (tipoDespesa === "CUSTO_ADMINISTRATIVO") {
                $("#atividade").prop("disabled", true).val('');
                $("#fornecedor").prop("disabled", false).val('');
                $("#funcionario").prop("disabled", true);
            } else {
                $("#atividade").prop("disabled", true).val('');
                $("#fornecedor").prop("disabled", true).val('');
                $("#funcionario").prop("disabled", true).val('');
            }
        };

        var atualizarSelectAtividades = function (centroCustoId) {
          if (centroCustoId) {
              $.ajax({
                  url: "${createLink(controller: 'atividade', action: 'getAtividadesDeCentroCusto')}",
                  method: 'POST',
                  data: {
                      centroCustoId: centroCustoId
                  },
                  success: function (response) {
                      console.log(response);
                  },

                  failure: function (response) {
                      console.log(response);

                  }
              })
          }
        };

        refreshFormBasedOnTipoDespesa("${despesaInstance?.tipoDespesa}");

        $("#centroCusto").chosen();

        $("#centroCusto").on("change", function () {
            console.log('here');

           atualizarSelectAtividades($(this).val());
        });

        $("#tipoDespesa").on('change', function () {
            refreshFormBasedOnTipoDespesa($(this).val());
        });
    })
</script>

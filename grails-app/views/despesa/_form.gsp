<%@ page import="com.acception.cadastro.Funcionario; com.acception.cadastro.Fornecedor; com.acception.cadastro.enums.TipoDespesa; com.acception.cadastro.Despesa" %>

<style>
label.error {
    color: #8a1f11;
    display: inline-block;
    margin-left: 1.5em;
}

input.error, select.error {
    background: rgb(251, 227, 228);
}
</style>

<asset:stylesheet src="bootstrap-datepicker.css"/>

<div class="row">
    <div class="col-md-6 form-group fieldcontain ${hasErrors(bean: despesaInstance, field: 'centroCusto', 'error')} ">
        <label for="centroCusto">
            <g:message code="despesa.centroCusto.label" default="Centro Custo"/>

        </label>
        <g:select class="form-control" id="centroCusto" name="centroCusto.id" from="${com.acception.cadastro.CentroCusto.list()}" optionKey="id" value="${centroCustoId ?: despesaInstance?.centroCusto?.id}" noSelection="['': '']" required="required" data-placeholder="Selecione um centro de custo..."/>

    </div>

    <div class="col-md-6 form-group fieldcontain ${hasErrors(bean: despesaInstance, field: 'tipoDespesa', 'error')} ">
        <label for="tipoDespesa">
            <g:message code="despesa.tipoDespesa.label" default="Tipo de Despesa"/>

        </label>
        <g:select name="tipoDespesa" from="${TipoDespesa.values().nome}" class="form-control" keys="${TipoDespesa.values()*.name()}"
                  value="${despesaInstance?.tipoDespesa?.name()}"
                  noSelection="['': 'Selecione um tipo de despesa...']" required="required"/>

    </div>
</div>

<div class="row">
    <div class="col-md-12 form-group fieldcontain ${hasErrors(bean: despesaInstance, field: 'descricao', 'error')} ">
        <label for="descricao">
            <g:message code="despesa.descricao.label" default="Descrição"/>

        </label>
        <g:textField class="form-control" required="required" name="descricao" value="${despesaInstance?.descricao}"/>
    </div>
</div>

<div class="row">
    <div class="col-md-12 form-group fieldcontain ${hasErrors(bean: despesaInstance, field: 'itemOrcamentario', 'error')} ">
        <label for="despesa-itemOrcamentario">
            Item Orçamentário
        </label>


        <select required="required" id="despesa-itemOrcamentario" name="itemOrcamentario.id" class="form-control"
                data-no_results_placeholder="Selecione um centro de custo que possua itens orçamentários..."
                data-with_results_placeholder="Selecione um item orçamentário..."
                data-placeholder="Selecione um centro de custo que possua itens orçamentários..."
                initialValue="${despesaInstance?.itemOrcamentario?.id}">
            <option value></option>
        </select>
    </div>
</div>

<div class="form-group fieldcontain" style="display: none;">
    <label for="atividade">
        <g:message code="despesa.atividade.label" default="Atividade"/>

    </label>

    <select required="required" id="atividade" name="atividade.id" class="form-control"
            data-no_results_placeholder="Selecione um centro de custo que possua atividades primeiramente..."
            data-with_results_placeholder="Selecione uma atividade..."
            data-placeholder="Selecione um centro de custo que possua atividades primeiramente..."
            initialValue="${despesaInstance?.atividade?.id}">
        <option value></option>
    </select>

</div>

<div class="form-group fieldcontain" style="display: none;">
    <label for="fornecedor">
        <g:message code="despesa.fornecedor.label" default="Fornecedor"/>
    </label>
    <g:select required="required" id="fornecedor" name="papel.id" from="${com.acception.cadastro.Fornecedor.list()}"
              optionKey="id" class="form-control"
              data-placeholder="Selecione um fornecedor..."
              initialValue="${despesaInstance?.lancamento?.papel instanceof Fornecedor ? despesaInstance?.lancamento?.papel?.id : null}"
              noSelection="['': '']"/>
    <a onclick="mudarParaCadastroDeFornecedor()"><small>Criar Fornecedor</small></a>

</div>

<div class="form-group fieldcontain" style="display: none;" >
    <label for="funcionario">
        <g:message code="despesa.funcionario.label" default="Funcionário"/>

    </label>
    <g:select required="required" id="funcionario" name="papel.id" from="${com.acception.cadastro.Funcionario.list()}"
              optionKey="id" class="form-control" noSelection="['': '']"
              data-no_results_placeholder="Selecione um centro de custo que possua funcionários..."
              data-with_results_placeholder="Selecione um funcionário..."
              data-placeholder="Selecione um centro de custo que possua funcionários..."
              initialValue="${despesaInstance?.lancamento?.papel instanceof Funcionario ? despesaInstance?.lancamento?.papel?.id : null}"/>
</div>

<div class="row">
    <div class="col-md-6 form-group fieldcontain ${hasErrors(bean: despesaInstance, field: 'valor', 'error')} ">
        <label for="valor">
            <g:message code="despesa.valor.label" default="Valor"/>

        </label>

        <input required="required" type="text" class="form-control currency" id="valor" name="valor"
               data-allow-negative="false" value="${despesaInstance?.valor}">
    </div>

    <div class="col-md-6 form-group fieldcontain ${hasErrors(bean: despesaInstance, field: 'data', 'error')} ">
        <label for="data">
            <g:message code="despesa.data.label" default="Data"/>

        </label>

        <input type="text" required="required" id="despesa-data" name="data" format="dd/MM/yyyy"
               value="${formatDate(format: "dd/MM/yyyy", date: despesaInstance?.data)}"
               class="form-control datepicker"/>

    </div>
</div>

<script>
    $(function() {
        $("#centroCusto").chosen();
        $("#despesa-itemOrcamentario").chosen();
        $("#fornecedor").chosen();
        $("#atividade").chosen();
        $("#funcionario").chosen();

        var makeChosenReadOnly = function (selectSelector) {
            $(selectSelector + ' option:not(:selected)').attr('disabled', true);
            $(selectSelector).trigger('chosen:updated')
        };

        var refreshFormBasedOnTipoDespesa = function (tipoDespesa) {
            var showInput = function (elementId) {
                $(elementId).prop("disabled", false).parent().show('slow')
            };

            var hideInput = function (elementId) {
                $(elementId).prop("disabled", true).val('').parent().hide('slow')
            };

            if (tipoDespesa === "ATIVIDADE") {
                showInput("#atividade");
                showInput("#fornecedor");
                hideInput("#funcionario");
            } else if (tipoDespesa === "PESSOAL" || tipoDespesa == "ADIANTAMENTO") {
                hideInput("#atividade");
                hideInput("#fornecedor");
                showInput("#funcionario");
            } else if (tipoDespesa === "CUSTO_ADMINISTRATIVO") {
                hideInput("#atividade");
                showInput("#fornecedor");
                hideInput("#funcionario");
            } else {
                hideInput("#atividade");
                hideInput("#fornecedor");
                hideInput("#funcionario");
            }

            $("#formCriacaoDespesa").find("select:not('#centroCusto')").trigger('chosen:updated')
        };

        // Essa função atualizará o select de atividades, permitindo apenas a seleção de atividades que são do centro de
        // custo escolhido
        var atualizarSelect = function (centroCustoId, ajaxURL, idSelect) {
            var select = $(idSelect);
            select.html("<option value></option>");

            if (centroCustoId) {
                $.ajax({
                    url: ajaxURL,
                    method: "POST",
                    data: {
                        centroCustoId: centroCustoId
                    },
                    success: function (response) {
                        if (response.success === true) {
                            for (var i = 0; i < response.objects.length; i++) {
                                var obj = response.objects[i];

                                select.append($("<option>").val(obj.id)
                                        .text(obj.label));
                            }

                            if (response.objects.length > 0) {
                                select.attr('data-placeholder', select.data('with_results_placeholder'));
                            } else {
                                select.attr('data-placeholder', select.data('no_results_placeholder'));
                            }

                            if (select.attr('initialValue')) {
                                select.val(select.attr('initialValue'));
                                select.attr('initialValue', null);
                            }

                            select.trigger("chosen:updated");
                        } else {
                            swal(
                                    'Oops...',
                                    'Ocorreu um erro ao carregar as atividades. Contate o suporte técnico!',
                                    'error'
                            );
                        }
                    },

                    error: function () {
                        swal(
                                'Oops...',
                                'Ocorreu um erro ao carregar dados. Contate o suporte técnico!',
                                'error'
                        );
                    }
                })
            } else {
                select.attr('data-placeholder', select.data('no_results_placeholder'));
            }
        };

        refreshFormBasedOnTipoDespesa("${despesaInstance?.tipoDespesa}");

        $("#centroCusto").on('change', function () {
            atualizarSelect($(this).val(),
                    "${createLink(controller: 'centroCusto', action: 'getAtividadesFromCentroCusto')}",
                    "#atividade");

            atualizarSelect($(this).val(),
                    "${createLink(controller: 'centroCusto', action: 'getFuncionariosAtuaisDeCentroCusto')}",
                    "#funcionario");

            atualizarSelect($(this).val(),
                    "${createLink(controller: 'centroCusto', action: 'getItensOrcamentariosDeCentroCusto')}",
                    "#despesa-itemOrcamentario");
        });

        $("#centroCusto").change();

        $("#tipoDespesa").on('change', function () {
            refreshFormBasedOnTipoDespesa($(this).val());
        });

        var centroCustoId = "${centroCustoId}";

        if (centroCustoId) {
            makeChosenReadOnly('#centroCusto')
        }
    })
</script>

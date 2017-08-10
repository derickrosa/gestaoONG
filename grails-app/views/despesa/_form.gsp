<%@ page import="com.acception.cadastro.Funcionario; com.acception.cadastro.Fornecedor; com.acception.cadastro.enums.TipoDespesa; com.acception.cadastro.Despesa" %>

<asset:stylesheet src="bootstrap-datepicker.css"/>

<div class="row">
    <div class="col-md-6 form-group fieldcontain ${hasErrors(bean: despesaInstance, field: 'centroCusto', 'error')} ">
        <label for="centroCusto">
            <g:message code="despesa.centroCusto.label" default="Centro Custo"/>

        </label>
        <g:select class="form-control" id="centroCusto" name="centroCusto.id" from="${com.acception.cadastro.CentroCusto.list()}" optionKey="id" value="${centroCustoId}" noSelection="['': '']" required="required" data-placeholder="Selecione um centro de custo..."/>

    </div>

    <div class="col-md-6 form-group fieldcontain ${hasErrors(bean: despesaInstance, field: 'tipoDespesa', 'error')} ">
        <label for="tipoDespesa">
            <g:message code="despesa.tipoDespesa.label" default="Tipo de Despesa"/>

        </label>
        <g:select name="tipoDespesa" from="${TipoDespesa.values().nome}" class="form-control" keys="${TipoDespesa.values()*.name()}" value="${despesaInstance?.tipoDespesa?.name()}"
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

<div class="form-group fieldcontain" style="display: none;">
    <label for="atividade">
        <g:message code="despesa.atividade.label" default="Atividade"/>

    </label>

    <select required="required" id="atividade" name="atividade.id" class="form-control"
            data-placeholder="Selecione um centro de custo que possua atividades primeiramente...">
        <option value></option>
    </select>

</div>

<div class="form-group fieldcontain" style="display: none;">
    <label for="fornecedor">
        <g:message code="despesa.fornecedor.label" default="Fornecedor"/>
    </label>
    <g:select required="required" id="fornecedor" name="papel.id" from="${com.acception.cadastro.Fornecedor.list()}"
              optionKey="id" class="form-control" data-placeholder="Selecione um fornecedor..." noSelection="['': '']"/>
    <a onclick="mudarParaCadastroDeFornecedor()"><small>Criar Fornecedor</small></a>

</div>

<div class="form-group fieldcontain" style="display: none;" >
    <label for="funcionario">
        <g:message code="despesa.funcionario.label" default="Funcionário"/>

    </label>
    <g:select required="required" id="funcionario" name="papel.id" from="${com.acception.cadastro.Funcionario.list()}"
              optionKey="id" class="form-control" noSelection="['': '']" data-placeholder="Selecione um funcionário..."/>
</div>

<div class="row">
    <div class="col-md-6 form-group fieldcontain ${hasErrors(bean: despesaInstance, field: 'valor', 'error')} ">
        <label for="valor">
            <g:message code="despesa.valor.label" default="Valor"/>

        </label>

        <input required="required" type="text" class="form-control currency" id="valor" name="valor" data-allow-negative="false">
    </div>

    <div class="col-md-6 form-group fieldcontain ${hasErrors(bean: despesaInstance, field: 'data', 'error')} ">
        <label for="data">
            <g:message code="despesa.data.label" default="Data"/>

        </label>

        <input type="text" required="required" id="data" name="data" format="dd/MM/yyyy"
               value="${formatDate(format: "dd/MM/yyyy", date: despesaInstance?.data)}"
               class="form-control datepicker"/>

    </div>
</div>

<script>
    $(function() {
        $("#centroCusto").chosen();
        $("#fornecedor").chosen();
        $("#atividade").chosen();
        $("#funcionario").chosen();

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
        function atualizarSelectAtividades (centroCustoId) {
            if (centroCustoId) {
                $.ajax({
                    url: "${createLink(controller: 'centroCusto', action: 'getAtividadesFromCentroCusto')}",
                    method: "POST",
                    data: {
                        centroCustoId: centroCustoId
                    },
                    success: function (response) {
                        var selectAtividade = $("#atividade");

                        selectAtividade.html("<option value></option>");

                        if (response.success === true) {
                            for (var i = 0; i < response.atividades.length; i++) {
                                var atividade = response.atividades[i];

                                selectAtividade.append($("<option>").val(atividade.id)
                                        .text(atividade.descricao));
                            }

                            if (response.atividades.length > 0) {
                                selectAtividade.attr('data-placeholder', 'Selecione uma atividade...');
                            }

                            selectAtividade.trigger("chosen:updated");
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
                                'Ocorreu um erro ao carregar as atividades. Contate o suporte técnico!',
                                'error'
                        );
                    }
                })
            } else {
                // Retirar todas as opções das atividades
            }
        }

        refreshFormBasedOnTipoDespesa("${despesaInstance?.tipoDespesa}");

        $("#centroCusto").on('change', function () {
            atualizarSelectAtividades($(this).val());
        });

        $("#tipoDespesa").on('change', function () {
            refreshFormBasedOnTipoDespesa($(this).val());
        });
    })
</script>

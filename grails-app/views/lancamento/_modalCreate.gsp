<%@ page import="com.acception.cadastro.Financiador; com.acception.cadastro.Papel; com.acception.cadastro.Funcionario; com.acception.cadastro.Fornecedor; com.acception.cadastro.enums.TipoDespesa; com.acception.cadastro.Despesa" %>


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

<div class="modal fade" tabindex="-1" role="dialog" id="modalCriacaoCreditoFinanceiro">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Criar Crédito</h4>
            </div>
            <form id="formCriacaoCreditoFinanceiro">
                <div class="modal-body">
                    <div id="cadastroCredito">
                        <div class="row">
                            <div class="col-md-6 form-group fieldcontain ${hasErrors(bean: despesaInstance, field: 'centroCusto', 'error')} ">
                                <label for="centroCusto">
                                    <g:message code="despesa.centroCusto.label" default="Centro Custo"/>

                                </label>
                                <g:select class="form-control" id="centroCustoCredito" name="centroCustoCredito" from="${com.acception.cadastro.CentroCusto.list()}" optionKey="id" value="${centroCustoId}" required="required" data-placeholder="Selecione um centro de custo..."/>

                            </div>


                            <div class="col-md-6 form-group fieldcontain" >
                                <label for="funcionario">
                                    <g:message code="despesa.funcionario.label" default="Origem"/>

                                </label>
                                <g:select required="required" id="funcionarioCredito" name="papelCredito" from="${Papel.list().findAll{it instanceof Funcionario || it instanceof Financiador}}"
                                          optionKey="id" class="form-control" data-placeholder="Selecione um funcionário ou financiador..."/>
                            </div>

                        </div>

                        <div class="row">
                            <div class="col-md-12 form-group fieldcontain ${hasErrors(bean: despesaInstance, field: 'descricao', 'error')} ">
                                <label for="descricao">
                                    <g:message code="despesa.descricao.label" default="Descrição"/>

                                </label>
                                <g:textField class="form-control" required="required" name="descricaoCredito" value="${despesaInstance?.descricao}"/>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 form-group fieldcontain ${hasErrors(bean: despesaInstance, field: 'valor', 'error')} ">
                                <label for="valor">
                                    <g:message code="despesa.valor.label" default="Valor"/>

                                </label>

                                <input required="required" type="text" class="form-control currency" id="valorCredito" name="valorCredito" data-allow-negative="false">
                            </div>

                            <div class="col-md-6 form-group fieldcontain ${hasErrors(bean: despesaInstance, field: 'data', 'error')} ">
                                <label for="data">
                                    <g:message code="despesa.data.label" default="Data"/>

                                </label>

                                <input type="text" required="required" id="dataCredito" name="dataCredito" format="dd/MM/yyyy"
                                       value="${formatDate(format: "dd/MM/yyyy", date: despesaInstance?.data)}"
                                       class="form-control datepicker"/>

                            </div>
                        </div>

                        <div class="row" id="alertOperacaoCreditoConcluida" style="display: none">
                            <div class="col-md-12 alert alert-success text-center">Crédito '<span id="descricaoCredito"></span>', no valor de R$ <span id="valorAlertCredito"></span>, foi criada com sucesso!</div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                    <button type="submit" class="btn btn-primary" id="btnSubmit" onclick="hideAlertSuccess()">Criar</button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script>
    // Ao abrirmos o modal de criação de despesas, sempre removeremos o alerta de sucesso.
    $('#modalCriacaoDespesas').on('shown.bs.modal', function (e) {
        $("#alertOperacaoConcluida").hide();
    });

    function hideAlertSuccess() {
        $('#alertOperacaoConcluida').hide('slow');
    }

    function mudarParaCadastroDeFornecedor() {
        $("#modalCriacaoDespesas").modal('hide');
        $("#modalCriacaoFornecedor").modal('show');

        document.getElementById('formCriacaoFornecedor').reset();

        $("#btnRetornoCriacaoDespesa").removeClass("btn-success");
        $("#alertCriacaoSucessoFornecedor").hide();
    }

    function mudarCadastroFornecedorParaPessoaFisica() {
        $("#razaoSocialDiv").hide('slow');

        $("#cpfOuCnpj label").text('CPF');
        $("#cpfOuCnpj input").removeClass('cnpj').addClass('cpf').attr("name", "participante.cpf");
    }

    function mudarCadastroFornecedorParaPessoaJuridica() {
        $("#razaoSocialDiv").show('slow');

        $("#cpfOuCnpj label").text('CNPJ');
        $("#cpfOuCnpj input").removeClass('cpf').addClass('cnpj').attr("name", "participante.cnpj");
    }

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

    $(function() {
        $("#centroCusto").chosen();
        $("#fornecedor").chosen();
        $("#atividade").chosen();
        $("#funcionario").chosen();
        $("#funcionarioCredito").chosen();

        $("#centroCusto").on('change', function () {
            atualizarSelectAtividades($(this).val());
        });


        // A linha abaixo é para que a validação do form funcione para o chosen da linha acima.
        $.validator.setDefaults({ ignore: ":hidden:not(select)" });

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

        $("#tipoDespesa").on('change', function () {
            refreshFormBasedOnTipoDespesa($(this).val());
        });

        var resetFormCriacaoDespesas = function (form) {
            $(form).find("input[type=text], textarea, select:not('#centroCusto')").val("");
            $(form).find("select:not('#centroCusto')").trigger('chosen:updated');
        };

        $("#formCriacaoCreditoFinanceiro").validate({
            submitHandler: function(form) {
                if ($("#valorCredito").maskMoney('unmasked')[0] === 0) {
                    swal("Insira um valor diferente de R$ 0,00!");
                    return;
                }

                $("#btnSubmit").prop('disabled', true);

                $.ajax({
                    url: "${createLink(controller: 'lancamento', action: 'criarLancamentoAjax')}",
                    method: "POST",
                    data: $(form).serialize(),
                    success: function (response) {
                        console.log(response);
                        if (response.success === true) {
                            resetFormCriacaoDespesas(form);

                            $("#alertOperacaoCreditoConcluida").show('slow');
                            $("#descricaoDespesa").text(response.credito.descricao);
                            $("#valorAlertCredito").text(response.credito.valor);

                            form.dispatchEvent(new CustomEvent("creditoCriado",
                                    {detail: {
                                        id: response.credito.id,
                                        centroCusto: response.credito.centroCusto,
                                        data: response.credito.data,
                                        descricao: response.credito.descricao,
                                        tipo: response.credito.tipo,
                                        valor: response.credito.valor,
                                        papel: response.credito.papel
                                    }}));
                        }
                    },

                    error: function () {
                        swal(
                                'Oops...',
                                'Ocorreu um erro no cadastro do crédito. Contate o suporte técnico para resolver.',
                                'error'
                        );
                    },

                    complete: function () {
                        $("#btnSubmit").prop('disabled', false);
                    }
                })
            }
        });

        $("#formCriacaoFornecedor").validate({
            submitHandler: function(form) {
                $("#btnSubmitFornecedor").prop('disabled', true);

                $.ajax({
                    url: "${createLink(controller: 'fornecedor', action: 'criarFornecedor')}",
                    method: "POST",
                    data: $(form).serialize(),
                    success: function (response) {
                        console.log(response);

                        if (response.success === true) {
                            $("#btnRetornoCriacaoDespesa").addClass("btn-success");

                            $("#alertCriacaoSucessoFornecedor").show('slow');

                            var fornecedorSelect = $("#fornecedor");

                            fornecedorSelect.append($("<option>").text(response.fornecedor.nome).val(response.fornecedor.id));
                            fornecedorSelect.val(response.fornecedor.id);
                            fornecedorSelect.trigger('chosen:updated');
                        }
                    },

                    error: function () {
                        swal(
                                'Oops...',
                                'Ocorreu um erro no cadastro do fornecedor. Contate o suporte técnico para resolver.',
                                'error'
                        );
                    },

                    complete: function () {
                        $("#btnSubmitFornecedor").prop('disabled', false);
                    }
                })
            }
        });
    })
</script>
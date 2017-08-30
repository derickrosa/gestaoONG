<%@ page import="com.acception.cadastro.Funcionario; com.acception.cadastro.Fornecedor; com.acception.cadastro.enums.TipoDespesa; com.acception.cadastro.Despesa" %>

<div class="modal fade" tabindex="-1" role="dialog" id="modalCriacaoFornecedor">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Criar Fornecedor</h4>
            </div>

            <form id="formCriacaoFornecedor">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6 col-md-offset-3 text-center">
                            <div class="form-group fieldcontain ${hasErrors(bean: funcionarioInstance, field: 'tipoPessoa', 'error')} ">
                                <label for="tipoPessoa">
                                    <g:message code="fornecedor.tipoPessoa.label" default="Tipo de Fornecedor"/>
                                </label>
                                <br>

                                <div class="radio-inline">
                                    <label>
                                        <input type="radio" name="tipoPessoa" value="FISICA"
                                               onclick="mudarCadastroFornecedorParaPessoaFisica()" required checked>
                                        Pessoa Física
                                    </label>
                                </div>

                                <div class="radio-inline">
                                    <label>
                                        <input type="radio" name="tipoPessoa" value="JURIDICA"
                                               onclick="mudarCadastroFornecedorParaPessoaJuridica()"
                                               required>Pessoa Jurídica
                                    </label>

                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-2">
                            <div class="form-group fieldcontain">
                                <label for="codigo">
                                    <g:message code="fornecedor.codigo.label" default="Código"/>
                                </label>
                                <g:textField class="form-control" name="codigo" maxlength="20" required="required"/>
                            </div>
                        </div>

                        <div class="col-md-10">
                            <div class="form-group fieldcontain">
                                <label for="nome">
                                    <g:message code="fornecedor.participante.nome.label" default="Nome"/>

                                </label>
                                <g:textField class="form-control" name="participante.nome" maxlength="100"
                                             required="required"/>

                            </div>
                        </div>
                    </div>

                    <div class="row" id="razaoSocialDiv" style="display: none;">
                        <div class="col-md-12">
                            <div class="form-group fieldcontain">
                                <label for="participante.razaoSocial">
                                    Razão Social
                                </label>

                                <g:textField class="form-control" name="participante.razaoSocial" maxlength="100"/>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4">
                            <div id="cpfOuCnpj">
                                <div class="form-group fieldcontain">
                                    <label for="cpf">
                                        <g:message code="fornecedor.participante.cpf.label" default="CPF"/>
                                    </label>

                                    <g:textField class="form-control cpf" required='required' name="participante.cpf"/>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-8">
                            <div class="form-group fieldcontain ${hasErrors(bean: fornecedorInstance, field: 'ramo', 'error')} ">
                                <label for="ramo">
                                    <g:message code="fornecedor.ramo.label" default="Ramo"/>

                                </label>
                                <g:textField class="form-control" name="ramo" maxlength="20"
                                             value="${fornecedorInstance?.ramo}"/>

                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group fieldcontain">
                                <label for="setor">
                                    <g:message code="fornecedor.setor.label" default="Setor"/>

                                </label>
                                <g:select name="setor" from="${com.acception.cadastro.enums.Setor?.values()}"
                                          class="form-control"
                                          keys="${com.acception.cadastro.enums.Setor.values()*.name()}"
                                          noSelection="['': '']" required="required"/>

                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-group fieldcontain">
                                <label for="telefone">
                                    <g:message code="fornecedor.telefone.participante.label" default="Telefone"/>

                                </label>
                                <g:textField class="form-control phone" id="telefoneRaw" name="telefoneRaw"
                                             value="${fornecedorInstance?.participante?.telefone}"/>

                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-group fieldcontain ${hasErrors(bean: fornecedorInstance, field: 'telefoneAdicional', 'error')} ">
                                <label for="telefoneAdicional">
                                    <g:message code="fornecedor.participante.telefoneAdicional.label"
                                               default="Telefone Adicional"/>

                                </label>

                                <g:textField class="form-control phone" id="telefoneAdicionalRaw"
                                             name="telefoneAdicionalRaw"
                                             value="${fornecedorInstance?.participante?.telefoneAdicional}"/>

                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group fieldcontain">
                                <label for="email">
                                    <g:message code="fornecedor.participante.email.label" default="Email"/>

                                </label>
                                <g:field type="email" class="form-control" placeholder="exemplo@mail.com"
                                         name="participante.email"/>

                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group fieldcontain ${hasErrors(bean: fornecedorInstance, field: 'emailAdicional', 'error')}">
                                <label for="emailAdicional">
                                    <g:message code="fornecedor.participante.emailAdicional.label"
                                               default="Email Adicional"/>

                                </label>
                                <g:field type="email" class="form-control" placeholder="exemplo@mail.com"
                                         name="participante.emailAdicional"/>

                            </div>
                        </div>
                    </div>

                    <div class="row" id="alertCriacaoSucessoFornecedor" style="display: none">
                        <div class="col-md-12 alert alert-success text-center">Fornecedor criado com sucesso!</div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal" data-toggle="modal"
                            data-target="#modalCriacaoDespesas"
                            id="btnRetornoCriacaoDespesa">Voltar para criação de despesa</button>
                    <button type="submit" class="btn btn-primary" id="btnSubmitFornecedor">Criar</button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div class="modal fade" tabindex="-1" role="dialog" id="modalCriacaoDespesas">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Criar Despesa</h4>
            </div>

            <div class="modal-body">
                <div id="cadastroDespesa">
                    <form id="formCriacaoDespesa">
                        <g:render template="/despesa/form"/>
                    </form>

                    <div class="row" id="alertOperacaoConcluida" style="display: none">
                        <div class="col-md-12 alert alert-success text-center">Despesa '<span
                                id="descricaoDespesa"></span>', no valor de R$ <span
                                id="valorDespesa"></span>, foi criada com sucesso!</div>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                <button type="submit" form="formCriacaoDespesa" class="btn btn-primary" id="btnSubmit"
                        onclick="hideAlertSuccess()">Criar</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script>
    // A linha abaixo é para que a validação do form funcione para o chosen da linha acima.
    $.validator.setDefaults({ignore: ":hidden:not(select)"});

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

    $(function () {
        // A linha abaixo é para que a validação do form funcione para os chosen
        $.validator.setDefaults({ignore: ":hidden:not(select)"});

        var resetFormCriacaoDespesas = function (form) {
            $(form).find("input[type=text], textarea, select:not('#centroCusto')").val("");
            $(form).find("select:not('#centroCusto')").trigger('chosen:updated');
        };

        $("#formCriacaoDespesa").validate({
            submitHandler: function (form) {
                if ($("#valor").maskMoney('unmasked')[0] === 0) {
                    swal("Insira um valor diferente de R$ 0,00!");
                    return;
                }

                $("#btnSubmit").prop('disabled', true);

                $.ajax({
                    url: "${createLink(controller: 'despesa', action: 'criarDespesa')}",
                    method: "POST",
                    data: $(form).serialize(),
                    success: function (response) {
                        if (response.success === true) {
                            var descricao = $("#descricao").val();
                            var valor = $("#valor").val();

                            $("#alertOperacaoConcluida").show('slow');
                            $("#descricaoDespesa").text(descricao);
                            $("#valorDespesa").text(valor);

                            form.dispatchEvent(new CustomEvent("despesaCriada",
                                    { detail: {
                                        id: response.despesa.id,
                                        name: descricao,
                                        valor: "R$ " + valor,
                                        tipo: $( "#tipoDespesa option:selected" ).text(),
                                        data: $("#despesa-data").val(),
                                        destino: response.despesa.destino
                                    }}));

                            resetFormCriacaoDespesas(form);
                        }
                    },

                    error: function () {
                        swal(
                                'Oops...',
                                'Ocorreu um erro no cadastro da despesa. Contate o suporte técnico para resolver.',
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
            submitHandler: function (form) {
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
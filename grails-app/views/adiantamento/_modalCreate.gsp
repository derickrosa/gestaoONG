<%@ page import="com.acception.cadastro.Funcionario" %>
<div class="modal fade" tabindex="-1" role="dialog" id="modalCriacaoPAs">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Criar Pagamento Adiantado</h4>
            </div>
                    <div class="modal-body">
                        <form id="formCriacaoPAs">
                            <g:render template="/adiantamento/form"/>
                        </form>

                        <div class="row" id="alertOperacaoConcluida-PA" style="display: none">
                            <div class="col-md-12 alert alert-success text-center">PA '<span id="descricaoPA"></span>', no valor de R$ <span id="valorPA"></span>, foi criada com sucesso!</div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                        <button type="submit" form="formCriacaoPAs" class="btn btn-primary" id="btnSubmitFormPA">Criar</button>
                    </div>

        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<script>
    // Ao abrirmos o modal de criação de PA's, sempre removeremos o alerta de sucesso.
    $('#modalCriacaoPAs').on('shown.bs.modal', function (e) {
        $("#alertOperacaoConcluida-PA").hide();
    });

    $(function () {
        // A linha abaixo é para que a validação do form funcione para os chosen do form acima.
        $.validator.setDefaults({ ignore: ":hidden:not(select)" });

        var resetFormCriacaoPAs = function (form) {
            $(form).find("input[type=text], textarea, select:not('#centroCusto-PA')").val("");
            $(form).find("select:not('#centroCusto-PA')").trigger('chosen:updated');
        };

        $("#formCriacaoPAs").validate({
            submitHandler: function(form) {
                if ($(form).find("[name='valor']").maskMoney('unmasked')[0] === 0) {
                    swal("Insira um valor diferente de R$ 0,00!");
                    return;
                }

                $("#btnSubmitFormPA").prop('disabled', true);

                $.ajax({
                    url: "${createLink(controller: 'adiantamento', action: 'criarPagamentoAdiantado')}",
                    method: "POST",
                    data: $(form).serialize() + "&attributes=" + getAttributesNecessaryToUpdateTable("${idTabelaParaAtualizar}").join(','),
                    success: function (response) {
                        console.log(response);

                        if (response.success === true) {
                            resetFormCriacaoPAs(form);

                            $("#alertOperacaoConcluida-PA").show('slow');
                            $("#descricaoPA").text(response.pagamentoAdiantado.descricao);
                            $("#valorPA").text(response.pagamentoAdiantado.valor);

                            form.dispatchEvent(new CustomEvent("adiantamentoCriado",
                                    {detail: response.pagamentoAdiantado}));
                        }
                    },

                    error: function () {
                        swal(
                                'Oops...',
                                'Ocorreu um erro no cadastro da PA. Contate o suporte técnico para resolver.',
                                'error'
                        );
                    },

                    complete: function () {
                        $("#btnSubmitFormPA").prop('disabled', false);
                    }
                })
            }
        });
    })
</script>
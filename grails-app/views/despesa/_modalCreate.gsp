<%@ page import="com.acception.cadastro.Funcionario; com.acception.cadastro.Fornecedor; com.acception.cadastro.enums.TipoDespesa; com.acception.cadastro.Despesa" %>

<script>
    function mudarParaCadastroDeFornecedor() {
        $("#modalCriacaoDespesas").modal('hide');
        $("#modalCriacaoFornecedor").modal('show');

        document.getElementById('formCriacaoFornecedor').reset();

        $("#btnRetornoCriacaoDespesa").removeClass("btn-success");
        $("#alertCriacaoSucessoFornecedor").hide();
    }

    $(document).ready(function () {
        $('#modalCriacaoDespesas select.select').select2({
            language: 'pt-BR',
            width: "100%"
        });

        submitFormByAjax($("form#formCriacaoDespesa"), null, null, function (data) {
            $("#extratoFinanceiro").bootstrapTable('refresh', {});
        });

        submitFormByAjax($("form#formCriacaoFornecedor"), 0, null, function (data) {
            $("#btnRetornoCriacaoDespesa").addClass("btn-success");

            $("#alertCriacaoSucessoFornecedor").show('slow');

            var fornecedorSelect = $("#fornecedor");

            fornecedorSelect.append($("<option>").text(data.fornecedor.nome).val(data.fornecedor.id));
            fornecedorSelect.val(data.fornecedor.id);
        });
    });
</script>

<modal:criar id="modalCriacaoDespesas" modalTitle="Criar Despesa">

    <g:form name="formCriacaoDespesa" controller="despesa" action="criarDespesa">
        <g:render template="/despesa/form"/>

        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
            <button type="submit" class="btn btn-primary">Criar</button>
        </div>
    </g:form>
</modal:criar>

<modal:criar id="modalCriacaoFornecedor" modalTitle="Criar Fornecedor" closeButton="Voltar">
    <g:form name="formCriacaoFornecedor" controller="fornecedor" action="criarFornecedor">
        <g:render template="/fornecedor/form"/>

        <div class="row" id="alertCriacaoSucessoFornecedor" style="display: none">
            <div class="col-md-12 alert alert-success text-center">Fornecedor criado com sucesso!</div>
        </div>

        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
            <button type="button" class="btn btn-default" data-dismiss="modal" data-toggle="modal"
                    data-target="#modalCriacaoDespesas"
                    id="btnRetornoCriacaoDespesa">Voltar para criação de despesa</button>
            <button type="submit" class="btn btn-primary" id="btnSubmitFornecedor">Criar</button>
        </div>
    </g:form>
</modal:criar>



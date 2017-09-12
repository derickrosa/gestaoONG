<%@ page import="com.acception.cadastro.Funcionario" %>

<script>
    $(function () {
        $('#modalCriacaoPAs select.select').select2({
            language: 'pt-BR',
            width: "100%"
        });

        submitFormByAjax($("form#formCriacaoPAs"), null, null, function (data) {
            $("#extratoFinanceiro").bootstrapTable('refresh', {});
        });
    })
</script>

<modal:criar id="modalCriacaoPAs" modalTitle="Criar Pagamentos Adiantados">
    <g:form name="formCriacaoPAs" controller="adiantamento" action="criarPagamentoAdiantado">
        <g:render template="/adiantamento/form"/>

        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
            <button type="submit" form="formCriacaoPAs" class="btn btn-primary" id="btnSubmitFormPA">Criar</button>
        </div>
    </g:form>
</modal:criar>

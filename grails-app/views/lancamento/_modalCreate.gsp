<%@ page import="com.acception.cadastro.Financiador; com.acception.cadastro.Papel; com.acception.cadastro.Funcionario; com.acception.cadastro.Fornecedor; com.acception.cadastro.enums.TipoDespesa; com.acception.cadastro.Despesa" %>

<script>
    $(function () {
        submitFormByAjax($("form#formCriacaoCreditoFinanceiro"), null, null, function (data) {
            $("#extratoFinanceiro").bootstrapTable('refresh', {});
        });
    })
</script>

<modal:criar id="modalCriacaoCreditoFinanceiro" modalTitle="Criar Crédito">
    <g:form name="formCriacaoCreditoFinanceiro" controller="lancamento" action="criarLancamentoAjax">
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

                <input required="required" type="text" class="form-control money" id="valorCredito" name="valorCredito" data-allow-negative="false">
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

        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
            <button type="submit" class="btn btn-primary" id="btnSubmit">Criar</button>
        </div>
    </g:form>
</modal:criar>
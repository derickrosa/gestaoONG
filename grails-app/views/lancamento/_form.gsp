<%@ page import="com.acception.cadastro.Lancamento" %>



<div class="form-group fieldcontain ${hasErrors(bean: lancamentoInstance, field: 'dataPagamento', 'error')} ">
    <label for="dataPagamento">
        <g:message code="lancamento.dataPagamento.label" default="Data Pagamento"/>
        
    </label>
    <g:datePicker name="dataPagamento" precision="day"  value="${lancamentoInstance?.dataPagamento}" default="none" noSelection="['': '']" />

</div>

<div class="form-group fieldcontain ${hasErrors(bean: lancamentoInstance, field: 'dataCancelamento', 'error')} ">
    <label for="dataCancelamento">
        <g:message code="lancamento.dataCancelamento.label" default="Data Cancelamento"/>
        
    </label>
    <g:datePicker name="dataCancelamento" precision="day"  value="${lancamentoInstance?.dataCancelamento}" default="none" noSelection="['': '']" />

</div>

<div class="form-group fieldcontain ${hasErrors(bean: lancamentoInstance, field: 'parcela', 'error')} ">
    <label for="parcela">
        <g:message code="lancamento.parcela.label" default="Parcela"/>
        
    </label>
    <g:field class="form-control" id="parcela" name="parcela" type="number" value="${lancamentoInstance.parcela}"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: lancamentoInstance, field: 'tipoAjuste', 'error')} ">
    <label for="tipoAjuste">
        <g:message code="lancamento.tipoAjuste.label" default="Tipo Ajuste"/>
        
    </label>
    <g:select class="form-control" id="tipoAjuste" name="tipoAjuste.id" from="${com.acception.cadastro.TipoAjuste.list()}" optionKey="id" value="${lancamentoInstance?.tipoAjuste?.id}" class="form-control" noSelection="['null': '']"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: lancamentoInstance, field: 'descricao', 'error')} ">
    <label for="descricao">
        <g:message code="lancamento.descricao.label" default="Descricao"/>
        
    </label>
    <g:textField class="form-control"  name="descricao" value="${lancamentoInstance?.descricao}"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: lancamentoInstance, field: 'codigoLancamento', 'error')} ">
    <label for="codigoLancamento">
        <g:message code="lancamento.codigoLancamento.label" default="Codigo Lancamento"/>
        
    </label>
    <g:textField class="form-control"  name="codigoLancamento" value="${lancamentoInstance?.codigoLancamento}"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: lancamentoInstance, field: 'numeroTitulo', 'error')} required">
    <label for="numeroTitulo">
        <g:message code="lancamento.numeroTitulo.label" default="Numero Titulo"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField class="form-control"  name="numeroTitulo" required="" value="${lancamentoInstance?.numeroTitulo}"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: lancamentoInstance, field: 'eventoFinanceiro', 'error')} ">
    <label for="eventoFinanceiro">
        <g:message code="lancamento.eventoFinanceiro.label" default="Evento Financeiro"/>
        
    </label>
    <g:select class="form-control" id="eventoFinanceiro" name="eventoFinanceiro.id" from="${com.acception.cadastro.EventoFinanceiro.list()}" optionKey="id" value="${lancamentoInstance?.eventoFinanceiro?.id}" class="form-control" noSelection="['null': '']"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: lancamentoInstance, field: 'documento', 'error')} ">
    <label for="documento">
        <g:message code="lancamento.documento.label" default="Documento"/>
        
    </label>
    <g:select class="form-control" id="documento" name="documento.id" from="${com.acception.cadastro.Anexo.list()}" optionKey="id" value="${lancamentoInstance?.documento?.id}" class="form-control" noSelection="['null': '']"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: lancamentoInstance, field: 'centroCusto', 'error')} ">
    <label for="centroCusto">
        <g:message code="lancamento.centroCusto.label" default="Centro Custo"/>
        
    </label>
    <g:select class="form-control" id="centroCusto" name="centroCusto.id" from="${com.acception.cadastro.CentroCusto.list()}" optionKey="id" value="${lancamentoInstance?.centroCusto?.id}" class="form-control" noSelection="['null': '']"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: lancamentoInstance, field: 'dataEmissao', 'error')} ">
    <label for="dataEmissao">
        <g:message code="lancamento.dataEmissao.label" default="Data Emissao"/>
        
    </label>
    <g:datePicker name="dataEmissao" precision="day"  value="${lancamentoInstance?.dataEmissao}" default="none" noSelection="['': '']" />

</div>

<div class="form-group fieldcontain ${hasErrors(bean: lancamentoInstance, field: 'papel', 'error')} ">
    <label for="papel">
        <g:message code="lancamento.papel.label" default="Papel"/>
        
    </label>
    <g:select class="form-control" id="papel" name="papel.id" from="${com.acception.cadastro.Papel.list()}" optionKey="id" value="${lancamentoInstance?.papel?.id}" class="form-control" noSelection="['null': '']"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: lancamentoInstance, field: 'statusLancamento', 'error')} ">
    <label for="statusLancamento">
        <g:message code="lancamento.statusLancamento.label" default="Status Lancamento"/>
        
    </label>
    <g:select name="statusLancamento" from="${com.acception.cadastro.enums.StatusLancamento?.values()}" class="form-control" keys="${com.acception.cadastro.enums.StatusLancamento.values()*.name()}" value="${lancamentoInstance?.statusLancamento?.name()}"  noSelection="['': '']"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: lancamentoInstance, field: 'tipoLancamento', 'error')} ">
    <label for="tipoLancamento">
        <g:message code="lancamento.tipoLancamento.label" default="Tipo Lancamento"/>
        
    </label>
    <g:select name="tipoLancamento" from="${com.acception.cadastro.enums.TipoLancamento?.values()}" class="form-control" keys="${com.acception.cadastro.enums.TipoLancamento.values()*.name()}" value="${lancamentoInstance?.tipoLancamento?.name()}"  noSelection="['': '']"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: lancamentoInstance, field: 'valor', 'error')} ">
    <label for="valor">
        <g:message code="lancamento.valor.label" default="Valor"/>
        
    </label>
    <g:field class="form-control" id="valor" name="valor" value="${fieldValue(bean: lancamentoInstance, field: 'valor')}"/>

</div>


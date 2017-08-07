<%@ page import="com.acception.cadastro.LinhaAcao" %>

<div class="row">
    <div class="col-md-3">
        <div class="form-group fieldcontain ${hasErrors(bean: linhaAcaoInstance, field: 'codigo', 'error')} ">
            <label for="codigo">
                <g:message code="linhaAcao.codigo.label" default="Código"/>

            </label>
            <g:textField class="form-control" name="codigo" value="${linhaAcaoInstance?.codigo}"/>

        </div>
    </div>

    <div class="col-md-9">
        <div class="form-group fieldcontain ${hasErrors(bean: linhaAcaoInstance, field: 'nome', 'error')} ">
            <label for="nome">
                <g:message code="linhaAcao.nome.label" default="Nome"/>

            </label>
            <g:textField class="form-control" name="nome" maxlength="100" value="${linhaAcaoInstance?.nome}"/>

        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12">

        <div class="form-group fieldcontain ${hasErrors(bean: linhaAcaoInstance, field: 'descricao', 'error')} ">
            <label for="descricao">
                <g:message code="linhaAcao.descricao.label" default="Descrição"/>

            </label>
            <g:textArea class="form-control" name="descricao" value="${linhaAcaoInstance?.descricao}"/>

        </div>
    </div>
</div>




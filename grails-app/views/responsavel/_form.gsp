<%@ page import="com.acception.cadastro.Responsavel" %>



<div class="form-group fieldcontain ${hasErrors(bean: responsavelInstance, field: 'codigo', 'error')} ">
    <label for="codigo">
        <g:message code="responsavel.codigo.label" default="Codigo"/>
        
    </label>
    <g:textField class="form-control"  name="codigo" maxlength="20" value="${responsavelInstance?.codigo}"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: responsavelInstance, field: 'financiador', 'error')} ">
    <label for="financiador">
        <g:message code="responsavel.financiador.label" default="Financiador"/>
        
    </label>
    <g:select class="form-control" id="financiador" name="financiador.id" from="${com.acception.cadastro.Financiador.list()}" optionKey="id" value="${responsavelInstance?.financiador?.id}" class="form-control" noSelection="['null': '']"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: responsavelInstance, field: 'participante', 'error')} ">
    <label for="participante">
        <g:message code="responsavel.participante.label" default="Participante"/>
        
    </label>
    <g:select class="form-control" id="participante" name="participante.id" from="${com.acception.cadastro.Participante.list()}" optionKey="id" value="${responsavelInstance?.participante?.id}" class="form-control" noSelection="['null': '']"/>

</div>


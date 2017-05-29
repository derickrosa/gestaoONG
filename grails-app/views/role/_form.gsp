<%@ page import="com.acception.security.Role" %>



<div class="form-group fieldcontain ${hasErrors(bean: roleInstance, field: 'authority', 'error')} ">
    <label for="authority">
        <g:message code="role.authority.label" default="Authority"/>
        
    </label>
    <g:textField class="form-control"  name="authority" value="${roleInstance?.authority}"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: roleInstance, field: 'nome', 'error')} ">
    <label for="nome">
        <g:message code="role.nome.label" default="Nome"/>
        
    </label>
    <g:textField class="form-control"  name="nome" value="${roleInstance?.nome}"/>

</div>


<%@ page import="com.acception.security.Role" %>



<div class="fieldcontain ${hasErrors(bean: roleInstance, field: 'authority', 'error')} ">
	<label for="authority">
		<g:message code="role.authority.label" default="Authority" />
		
	</label>
	<g:textField name="authority" value="${roleInstance?.authority}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: roleInstance, field: 'nome', 'error')} ">
	<label for="nome">
		<g:message code="role.nome.label" default="Nome" />
		
	</label>
	<g:textField name="nome" value="${roleInstance?.nome}"/>

</div>


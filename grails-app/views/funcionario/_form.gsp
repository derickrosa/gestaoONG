<%@ page import="com.acception.cadastro.Funcionario" %>



<div class="form-group fieldcontain ${hasErrors(bean: funcionarioInstance, field: 'nome', 'error')} ">
    <label for="nome">
        <g:message code="funcionario.nome.label" default="Nome"/>
        
    </label>
    <g:textField class="form-control"  name="nome" required="required" maxlength="100" value="${funcionarioInstance?.nome}"/>

</div>

<div class="row">
    <div class="col-md-4">
        <div class="form-group fieldcontain ${hasErrors(bean: funcionarioInstance, field: 'telefone', 'error')} ">
            <label for="telefone">
                <g:message code="funcionario.telefone.label" default="Telefone"/>

            </label>
            <g:textField class="form-control phone" id="telefoneRaw" name="telefoneRaw" value="${funcionarioInstance?.telefone}" required="required"/>

        </div>
    </div>

    <div class="col-md-4">
        <div class="form-group fieldcontain ${hasErrors(bean: funcionarioInstance, field: 'telefoneAdicional', 'error')} ">
            <label for="telefoneAdicional">
                <g:message code="funcionario.telefoneAdicional.label" default="Telefone Adicional"/>

            </label>

            <g:textField class="form-control phone" id="telefoneAdicionalRaw" name="telefoneAdicionalRaw" value="${funcionarioInstance?.telefoneAdicional}"/>

        </div>
    </div>

    <div class="col-md-4">
        <div class="form-group fieldcontain ${hasErrors(bean: funcionarioInstance, field: 'cpf', 'error')} ">
            <label for="cpf">
                <g:message code="funcionario.cpf.label" default="CPF"/>

            </label>
            <g:textField class="form-control cpf" name="cpf" value="${funcionarioInstance?.cpf}"/>

        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-6">
        <div class="form-group fieldcontain ${hasErrors(bean: funcionarioInstance, field: 'email', 'error')}">
            <label for="email">
                <g:message code="funcionario.email.label" default="Email"/>

            </label>
            <g:field type="email" required="required" class="form-control" placeholder="exemplo@mail.com"  name="email" value="${funcionarioInstance?.email}"/>

        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group fieldcontain ${hasErrors(bean: funcionarioInstance, field: 'emailAdicional', 'error')}">
            <label for="emailAdicional">
                <g:message code="funcionario.emailAdicional.label" default="Email Adicional"/>

            </label>
            <g:field type="email" class="form-control" placeholder="exemplo@mail.com"  name="emailAdicional" value="${funcionarioInstance?.emailAdicional}"/>

        </div>
    </div>
</div>


<div class="form-group fieldcontain ${hasErrors(bean: funcionarioInstance, field: 'cargo', 'error')} ">
    <label for="cargo">
        <g:message code="funcionario.cargo.label" default="Cargo"/>
        
    </label>
    <g:textField class="form-control" required="required" name="cargo" value="${funcionarioInstance?.cargo}"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: funcionarioInstance, field: 'funcao', 'error')} ">
    <label for="funcao">
        <g:message code="funcionario.funcao.label" default="Função"/>
        
    </label>
    <g:textField class="form-control" required="required" name="funcao" value="${funcionarioInstance?.funcao}"/>

</div>


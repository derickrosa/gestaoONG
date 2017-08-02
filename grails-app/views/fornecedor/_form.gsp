<%@ page import="com.acception.cadastro.Fornecedor" %>


<div class="row">
    <div class="col-md-6">
        <div class="form-group fieldcontain ${hasErrors(bean: funcionarioInstance, field: 'tipoPessoa', 'error')} ">
            <label for="tipoPessoa">
                <g:message code="fornecedor.tipoPessoa.label" default="Tipo de Fornecedor"/>
            </label>
            <br>

            <div class="radio-inline">
                <input type="radio" name="tipoPessoa" value="${true}" required checked>Pessoa Física
            </div>

            <div class="radio-inline">
                <input type="radio" name="tipoPessoa" value="${false}" required>Pessoa Jurídica
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-2">
        <div class="form-group fieldcontain ${hasErrors(bean: fornecedorInstance, field: 'codigo', 'error')} ">
            <label for="codigo">
                <g:message code="fornecedor.codigo.label" default="Codigo"/>
            </label>
            <g:textField class="form-control" name="codigo" maxlength="20" value="${fornecedorInstance?.codigo}"/>

        </div>
    </div>

    <div class="col-md-5">
        <div class="form-group fieldcontain ${hasErrors(bean: fornecedorInstance, field: 'nome', 'error')} ">
            <label for="nome">
                <g:message code="fornecedor.participante.nome.label" default="Nome"/>

            </label>
            <g:textField class="form-control" name="participante.nome" maxlength="100"
                         value="${fornecedorInstance?.participante?.nome}"/>

        </div>
    </div>

    <div class="col-md-5">
        <div id="razaoSocial"
             class="form-group fieldcontain ${hasErrors(bean: fornecedorInstance, field: 'razaoSocial', 'error')} ">
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-4">
        <div id="cpfOuCnpj">

        </div>
    </div>

    <div class="col-md-6">
        <div class="form-group fieldcontain ${hasErrors(bean: fornecedorInstance, field: 'ramo', 'error')} ">
            <label for="ramo">
                <g:message code="fornecedor.ramo.label" default="Ramo"/>

            </label>
            <g:textField class="form-control" name="ramo" maxlength="20" value="${fornecedorInstance?.ramo}"/>

        </div>
    </div>

    <div class="col-md-2">
        <div class="form-group fieldcontain ${hasErrors(bean: fornecedorInstance, field: 'setor', 'error')} ">
            <label for="setor">
                <g:message code="fornecedor.setor.label" default="Setor"/>

            </label>
            <g:select name="setor" from="${com.acception.cadastro.enums.Setor?.values()}" class="form-control"
                      keys="${com.acception.cadastro.enums.Setor.values()*.name()}"
                      value="${fornecedorInstance?.setor?.name()}" noSelection="['': '']"/>

        </div>
    </div>

</div>


<div class="row">
    <div class="col-md-3">
        <div class="form-group fieldcontain ${hasErrors(bean: fornecedorInstance, field: 'telefone', 'error')} ">
            <label for="telefone">
                <g:message code="fornecedor.telefone.participante.label" default="Telefone"/>

            </label>
            <g:textField class="form-control phone" id="telefoneRaw" name="telefoneRaw"
                         value="${fornecedorInstance?.participante?.telefone}" required="required"/>

        </div>
    </div>

    <div class="col-md-3">
        <div class="form-group fieldcontain ${hasErrors(bean: fornecedorInstance, field: 'telefoneAdicional', 'error')} ">
            <label for="telefoneAdicional">
                <g:message code="fornecedor.participante.telefoneAdicional.label" default="Telefone Adicional"/>

            </label>

            <g:textField class="form-control phone" id="telefoneAdicionalRaw" name="telefoneAdicionalRaw"
                         value="${fornecedorInstance?.participante?.telefoneAdicional}"/>

        </div>
    </div>

    <div class="col-md-3">
        <div class="form-group fieldcontain ${hasErrors(bean: fornecedorInstance, field: 'email', 'error')}">
            <label for="email">
                <g:message code="fornecedor.participante.email.label" default="Email"/>

            </label>
            <g:field type="email" required="required" class="form-control" placeholder="exemplo@mail.com"
                     name="participante.email" value="${fornecedorInstance?.participante?.email}"/>

        </div>
    </div>

    <div class="col-md-3">
        <div class="form-group fieldcontain ${hasErrors(bean: fornecedorInstance, field: 'emailAdicional', 'error')}">
            <label for="emailAdicional">
                <g:message code="fornecedor.participante.emailAdicional.label" default="Email Adicional"/>

            </label>
            <g:field type="email" class="form-control" placeholder="exemplo@mail.com" name="participante.emailAdicional"
                     value="${fornecedorInstance?.participante?.emailAdicional}"/>

        </div>
    </div>
</div>




<script>
    function inicial() {
        var newSelectField = ""
        var razao = ""
        <g:if test="${fornecedorInstance?.participante}">
        document.getElementsByName("tipoPessoa")[0].setAttribute("disabled", "true");
        document.getElementsByName("tipoPessoa")[1].setAttribute("disabled", "true");
        </g:if>

        <g:if test="${fornecedorInstance?.participante instanceof com.acception.cadastro.PessoaFisica || !fornecedorInstance.participante}">
        newSelectField = '<div class="variavel"><div class="form-group fieldcontain ${hasErrors(bean: fornecedorInstance, field: 'cpf', 'error')} "><label for="cpf"> <g:message code="fornecedor.participante.cpf.label" default="CPF"/> </label> <g:textField class="form-control cpf" required='required' name="participante.cpf" value="${fornecedorInstance?.participante?.cpf}"/></div></div>';
        </g:if>
        <g:else>
        newSelectField = '<div class="variavel"><div class="form-group fieldcontain ${hasErrors(bean: fornecedorInstance, field: 'cnpj', 'error')} "><label for="cnpj"> <g:message code="fornecedor.participante.cnpj.label" default="CNPJ"/> </label> <g:textField class="form-control cnpj" required='required' name="participante.cnpj" maxlength="14" value="${fornecedorInstance?.participante?.cnpj}"/></div></div>'
        razao = '<div class="variavel"><div class="form-group fieldcontain ${hasErrors(bean: financiadorInstance, field: 'razaoSocial', 'error')} "> <label for="razaoSocial"> <g:message code="financiador.razaoSocial.label" default="Razão Social"/> </label> <g:textField class="form-control" name="participante.razaoSocial" maxlength="100" value="${fornecedorInstance?.participante?.razaoSocial}"/> </div></div>'
        </g:else>
        $("#cpfOuCnpj").append(newSelectField);
        $("#razaoSocial").append(razao);
    }
    $(function () {

        inicial();

        $('input[type="radio"]').click(function () {
            if ($(this).is(':checked')) {
                var newSelectField = ""
                var razao = ""


                if ($(this).val() == "true") {
                    <g:if test="${fornecedorInstance.participante instanceof com.acception.cadastro.PessoaFisica || !fornecedorInstance.participante}">
                    newSelectField = '<div class="variavel"><div class="form-group fieldcontain ${hasErrors(bean: fornecedorInstance, field: 'cpf', 'error')} "><label for="cpf"> <g:message code="fornecedor.participante.cpf.label" default="CPF"/> </label> <g:textField class="form-control cpf" required='required' name="participante.cpf" value="${fornecedorInstance?.participante?.cpf}"/></div></div>';
                    </g:if>
                } else {
                    <g:if test="${fornecedorInstance?.participante instanceof com.acception.cadastro.PessoaJuridica || !fornecedorInstance.participante}">
                    newSelectField = '<div class="variavel"><div class="form-group fieldcontain ${hasErrors(bean: fornecedorInstance, field: 'cnpj', 'error')} "><label for="cnpj"> <g:message code="fornecedor.participante.cnpj.label" default="CNPJ"/> </label> <g:textField class="form-control cnpj" required='required' name="participante.cnpj" maxlength="14" value="${fornecedorInstance?.participante?.cnpj}"/></div></div>'
                    razao = '<div class="variavel"><div class="form-group fieldcontain ${hasErrors(bean: financiadorInstance, field: 'razaoSocial', 'error')} "> <label for="razaoSocial"> <g:message code="financiador.razaoSocial.label" default="Razão Social"/> </label> <g:textField class="form-control" name="participante.razaoSocial" maxlength="100" value="${fornecedorInstance?.participante?.razaoSocial}"/> </div></div>'
                    </g:if>

                }

                var elem = document.getElementsByClassName('variavel');
                var total = elem.length
                if (elem) {
                    for (i = 0; i < total; i++) {
                        console.log(elem[0] + " " + i + " length: " + elem.length);
                        elem[0].parentNode.removeChild(elem[0]);
                    }
                }
                $("#razaoSocial").append(razao);
                $("#cpfOuCnpj").append(newSelectField);
            }
        });
    });
</script>
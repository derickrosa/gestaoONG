<%@ page import="com.acception.cadastro.enums.Setor; com.acception.cadastro.PessoaFisica; com.acception.cadastro.PessoaJuridica; com.acception.cadastro.Fornecedor" %>

<script>
    function mudarCadastroFornecedorParaPessoaFisica() {
        $("#razaoSocialDiv").hide('slow');

        $("#cpfOuCnpj label").text('CPF');
        $("#cpfOuCnpj input").removeClass('cnpj').addClass('cpf').attr("name", "participante.cpf");
    }

    function mudarCadastroFornecedorParaPessoaJuridica() {
        $("#razaoSocialDiv").show('slow');

        $("#cpfOuCnpj label").text('CNPJ');
        $("#cpfOuCnpj input").removeClass('cpf').addClass('cnpj').attr("name", "participante.cnpj");
    }

    $(function () {
        <g:if test="${fornecedorInstance?.participante instanceof PessoaFisica}">
        $("input[value='FISICA']").trigger("click");
        </g:if>
        <g:elseif test="${fornecedorInstance?.participante instanceof PessoaJuridica}">
        $("input[value='JURIDICA']").trigger("click");
        </g:elseif>
    });

</script>

<div class="row">
    <div class="col-md-6 col-md-offset-3 text-center">
        <div class="form-group fieldcontain">
            <label for="tipoPessoa">
                <g:message code="fornecedor.tipoPessoa.label" default="Tipo de Fornecedor"/>
            </label>
            <br>

            <div class="radio-inline">
                <label>
                    <input type="radio" name="tipoPessoa" value="FISICA"
                           onclick="mudarCadastroFornecedorParaPessoaFisica()" required checked>
                    Pessoa Física
                </label>
            </div>

            <div class="radio-inline">
                <label>
                    <input type="radio" name="tipoPessoa" value="JURIDICA"
                           onclick="mudarCadastroFornecedorParaPessoaJuridica()"
                           required>Pessoa Jurídica
                </label>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-2">
        <div class="form-group fieldcontain">
            <label for="codigo">
                <g:message code="fornecedor.codigo.label" default="Código"/>
            </label>
            <g:textField class="form-control" name="codigo" maxlength="20" required="required" value="${fornecedorInstance?.codigo}"/>
        </div>
    </div>

    <div class="col-md-10">
        <div class="form-group fieldcontain">
            <label for="nome">
                <g:message code="fornecedor.participante.nome.label" default="Nome"/>

            </label>
            <g:textField class="form-control" name="participante.nome" maxlength="100"
                         required="required" value="${fornecedorInstance?.participante?.nome}"/>

        </div>
    </div>
</div>

<div class="row" id="razaoSocialDiv" style="display: none;">
    <div class="col-md-12">
        <div class="form-group fieldcontain">
            <label for="participante.razaoSocial">
                Razão Social
            </label>

            <g:textField class="form-control" name="participante.razaoSocial" maxlength="100"
                         value="${fornecedorInstance?.participante instanceof PessoaJuridica ? fornecedorInstance?.participante?.razaoSocial : null}"/>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-4">
        <div id="cpfOuCnpj">
            <div class="form-group fieldcontain">
                <label for="cpf">
                    <g:message code="fornecedor.participante.cpf.label" default="CPF"/>
                </label>

                <g:textField class="form-control cpf" required='required' name="participante.cpf"
                             value="${fornecedorInstance?.participante instanceof PessoaFisica ? fornecedorInstance?.participante?.cpf : null}"/>
            </div>
        </div>
    </div>

    <div class="col-md-8">
        <div class="form-group fieldcontain ${hasErrors(bean: fornecedorInstance, field: 'ramo', 'error')} ">
            <label for="ramo">
                <g:message code="fornecedor.ramo.label" default="Ramo"/>

            </label>
            <g:textField class="form-control" name="ramo" maxlength="20"
                         value="${fornecedorInstance?.ramo}"/>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-4">
        <div class="form-group fieldcontain">
            <label for="setor">
                <g:message code="fornecedor.setor.label" default="Setor"/>

            </label>
            <g:select name="setor" from="${Setor.values()}"
                      class="form-control"
                      keys="${Setor.values()*.name()}"
                      noSelection="['': '']" required="required" value="${fornecedorInstance?.setor?.key}"/>

        </div>
    </div>

    <div class="col-md-4">
        <div class="form-group fieldcontain">
            <label for="telefone">
                <g:message code="fornecedor.telefone.participante.label" default="Telefone"/>

            </label>
            <g:textField class="form-control phone" id="telefoneRaw" name="telefoneRaw"
                         value="${fornecedorInstance?.participante?.telefone}"/>

        </div>
    </div>

    <div class="col-md-4">
        <div class="form-group fieldcontain ${hasErrors(bean: fornecedorInstance, field: 'telefoneAdicional', 'error')} ">
            <label for="telefoneAdicional">
                <g:message code="fornecedor.participante.telefoneAdicional.label"
                           default="Telefone Adicional"/>

            </label>

            <g:textField class="form-control phone" id="telefoneAdicionalRaw"
                         name="telefoneAdicionalRaw"
                         value="${fornecedorInstance?.participante?.telefoneAdicional}"/>

        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-6">
        <div class="form-group fieldcontain">
            <label for="email">
                <g:message code="fornecedor.participante.email.label" default="Email"/>

            </label>
            <g:field type="email" class="form-control" placeholder="exemplo@mail.com"
                     name="participante.email" value="${fornecedorInstance?.participante?.email}"/>

        </div>
    </div>

    <div class="col-md-6">
        <div class="form-group fieldcontain ${hasErrors(bean: fornecedorInstance, field: 'emailAdicional', 'error')}">
            <label for="emailAdicional">
                <g:message code="fornecedor.participante.emailAdicional.label"
                           default="Email Adicional"/>

            </label>
            <g:field type="email" class="form-control" placeholder="exemplo@mail.com"
                     name="participante.emailAdicional" value="${fornecedorInstance?.participante?.emailAdicional}"/>

        </div>
    </div>
</div>


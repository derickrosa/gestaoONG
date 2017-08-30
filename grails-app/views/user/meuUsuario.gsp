<%@ page import="com.acception.security.User" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title>Meu Usuário</title>

    <script type="text/javascript">
        $(function () {
            $('#alterarSenhaDialog').dialog({closeOnEscape: false, resizable: false, autoOpen: false});
        });

        function updatePassword() {
            var senhaNova = $('#senhaNova').val();
            var senhaConfirmacao = $('#senhaConfirmacao').val();
            if (senhaNova != senhaConfirmacao) {
                alert("Confirmação da senha não confere com a senha");
            } else {
                $.ajax({
                    type: 'POST',
                    url: '${resource(dir:'user',file:'changePassword')}/${userInstance?.id}',
                    data: {
                        password: senhaNova,
                        confirmPassword: senhaConfirmacao,
                        changePassword: '${params.changePassword}',
                        random: Math.random() * 99999
                    },
                    dataType: 'json',
                    success: function (data) {
                        alert('Senha alterada com sucesso');
                        $('#modal-alterar-senha').modal('hide');
                        $('#senhaNova').val("");
                        $('#senhaConfirmacao').val("");
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        var err = xhr.responseText;
                        alert('Um problema aconteceu no momento de alterar a senha, favor comunicar o suporte ou verificar a sua conexão com a Internet.');
                        $('#senhaNova').val("");
                        $('#senhaConfirmacao').val("");
                    }
                });
            }
        }
        ;

    </script>
</head>

<body>

<p>
    <g:link class="btn btn-default" controller="home" action="index">
        <span class="glyphicon glyphicon-home"></span>
        <g:message code="default.home.label" default="Início"/>
    </g:link>

    <g:link class="btn btn-default" action="index">
        <span class="glyphicon glyphicon-list"></span>
        <g:message code="default.list.label" args="[entityName]"/>
    </g:link>
</p>






<table class="table table-bordered user">

    <g:if test="${userInstance?.nome}">
        <tr>
            <th id="nome-label" class="property-label"><g:message code="user.nome.label" default="Nome" /></th>

            <td  aria-labelledby="nome-label"><g:fieldValue bean="${userInstance}" field="nome"/></td>

        </tr>
    </g:if>


    <g:if test="${userInstance?.username}">
        <tr>
            <th id="username-label" class="property-label"><g:message code="user.username.label" default="Login" /></th>

            <td  aria-labelledby="username-label"><g:fieldValue bean="${userInstance}" field="username"/></td>

        </tr>
    </g:if>

    <g:if test="${userInstance?.email}">
        <tr>
            <th id="email-label" class="property-label"><g:message code="user.email.label" default="E-mail" /></th>

            <td  aria-labelledby="email-label"><g:fieldValue bean="${userInstance}" field="email"/></td>

        </tr>
    </g:if>


    <tr>
        <th id="passwordExpired-label" class="property-label"><g:message code="user.passwordExpired.label" default="Papéis" /></th>

        <td  aria-labelledby="passwordExpired-label">${userInstance?.authorities?.nome?.join(', ')}</td>

    </tr>

</table>

<g:hiddenField name="id" value="${userInstance?.id}"/>
<button type="button" class="btn btn-danger" data-toggle="modal"
        data-target="#modal-alterar-senha"
        value="Alterar Senha">
    <span class="glyphicon glyphicon-lock"></span> <g:message
        code="default.button.alterarSenha.label" default="Alterar Senha"/>
</button>

<div class="modal fade" id="modal-alterar-senha">
    <div class="modal-dialog modal-sm" style="z-index: 3000">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Alterar Senha</h4>
            </div>
            <g:form name="form-portador">
                <div class="modal-body">
                    <h5 style="font-family: monospace;">USUÁRIO: ${userInstance?.username}</h5>


  <div class="form-group">
                        <label>Nova Senha:</label>
                        <input type="password" name="password" id="senhaNova" class="form-control"/>
                    </div>

                    <div class="form-group">
                        <label>Confirmar Nova Senha:</label>
                        <input type="password" name="confirmPassword" id="senhaConfirmacao" class="form-control"/>
                    </div>
                </div>
                <g:hiddenField name="id" value="${userInstance?.id}"></g:hiddenField>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                    <input type="button" class="btn btn-primary" name="portador" formtarget="form-portador"
                           value="Prosseguir" onclick="javascript:updatePassword();"/>
                </div>
            </g:form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->



<script>
    <%if(params.changePassword){%>
    $('#modal-alterar-senha').modal('show');
    <%}%>
</script>
</body>
</html>

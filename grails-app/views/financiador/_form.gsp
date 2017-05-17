<%@ page import="com.acception.cadastro.Financiador" %>
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading control-label">
                Dados Básicos
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">


<div class="form-group fieldcontain ${hasErrors(bean: financiadorInstance, field: 'codigo', 'error')} ">
    <label for="codigo">
        <g:message code="financiador.codigo.label" default="Codigo"/>
        
    </label>
    <g:textField class="form-control"  name="codigo" maxlength="20" value="${financiadorInstance?.codigo}"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: financiadorInstance, field: 'nomeFantasia', 'error')} ">
    <label for="nomeFantasia">
        <g:message code="financiador.nomeFantasia.label" default="Nome Fantasia"/>
        
    </label>
    <g:textField class="form-control"  name="nomeFantasia" maxlength="100" value="${financiadorInstance?.nomeFantasia}"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: financiadorInstance, field: 'sigla', 'error')} ">
    <label for="sigla">
        <g:message code="financiador.sigla.label" default="Sigla"/>
        
    </label>
    <g:textField class="form-control"  name="sigla" maxlength="10" value="${financiadorInstance?.sigla}"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: financiadorInstance, field: 'participante', 'error')} ">
    <label for="participante">
        <g:message code="financiador.participante.label" default="Participante"/>
        
    </label>
    <g:select class="form-control" id="participante" name="participante.id" from="${com.acception.cadastro.Participante.list()}" optionKey="id" value="${financiadorInstance?.participante?.id}" class="form-control" noSelection="['null': '']"/>

</div>

%{--<div class="form-group fieldcontain ${hasErrors(bean: financiadorInstance, field: 'responsaveis', 'error')} ">
    <label for="responsaveis">
        <g:message code="financiador.responsaveis.label" default="Responsaveis"/>
        
    </label>
    
<ul class="list-group">
<g:each in="${financiadorInstance?.responsaveis?}" var="r">
    <li class="list-group"><g:link controller="responsavel" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="list-group active">
<g:link controller="responsavel" action="create" params="['financiador.id': financiadorInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'responsavel.label', default: 'Responsavel')])}</g:link>
</li>
</ul>


</div>--}%

<div class="form-group fieldcontain ${hasErrors(bean: financiadorInstance, field: 'setor', 'error')} ">
    <label for="setor">
        <g:message code="financiador.setor.label" default="Setor"/>
        
    </label>
    <g:select name="setor" from="${com.acception.cadastro.enums.Setor?.values()}" class="form-control" keys="${com.acception.cadastro.enums.Setor.values()*.name()}" value="${financiadorInstance?.setor?.name()}"  noSelection="['': '']"/>

</div>

        </div>
        </div>
        <!-- /.panel -->
    </div>
</div>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading control-label">
                Responsáveis
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">
                <div id="edittableResponsaveis"></div>
            </div>
        </div>
        <!-- /.panel -->
    </div>
</div>

<script>
    var table = $("#edittableResponsaveis").editTable({
        field_templates: {
            'nome': {
                html: '<input type="text" class="form-control" name="responsavel.nome"/>',
                getValue: function (input) {
                    return $(input).val();
                },
                setValue: function (input, value) {
                    return $(input).text(value);
                }
            }, 'email': {
                html: '<input type="text" class="form-control"   name="responsavel.email" />',
                getValue: function (input) {
                    return $(input).val();
                },
                setValue: function (input, value) {
                    return $(input).text(value);
                }
            }, 'telefone': {
                html: '<input type="text" class="form-control"   name="responsavel.telefone" />',
                getValue: function (input) {
                    return $(input).val();
                },
                setValue: function (input, value) {
                    return $(input).text(value);
                }
            }
        },
        row_template: ['nome', 'email', 'telefone'],
        names: ['responsavel.nome', 'responsavel.email', 'responsavel.telefone'],
        first_row: true,
        parcelas: false,
        financiador: true,
        headerCols: [
            'Nome',
            'Email',
            'Telefone'
        ]
    });

    $( document ).ready(function() {
        $.ajax({
            url: '${createLink(action: 'findSolicitacoes',controller:'financiador')}',
            type: 	'POST',
            data: 	{
                ajax: true,
                idFinanciador: '${financiadorInstance.id}'
            },
            complete: function (result) {
                if(result.responseText == '[]')
                    table.loadJsonData('[["",""]]');
                else table.loadJsonData(result.responseText);
            }
        });
    });

</script>


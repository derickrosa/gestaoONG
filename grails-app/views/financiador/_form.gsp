<%@ page import="com.acception.cadastro.Financiador" %>
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-primary">
            <div class="panel-heading control-label">
                Informações  Básicas
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">

<div class="row">
<div class="col-md-2">
<div class="form-group fieldcontain ${hasErrors(bean: financiadorInstance, field: 'codigo', 'error')} ">
    <label for="codigo">
        <g:message code="financiador.codigo.label" default="Codigo"/>
        
    </label>
    <g:textField class="form-control"  name="codigo" maxlength="20" value="${financiadorInstance?.codigo}"/>

</div>
</div>
    <div class="col-md-10">
<div class="form-group fieldcontain ${hasErrors(bean: financiadorInstance, field: 'nome', 'error')} ">
    <label for="nome">
        <g:message code="financiador.participante.nome.label" default="Nome Fantasia"/>

    </label>
    <g:textField class="form-control"  name="participante.nome" maxlength="100" value="${financiadorInstance?.participante?.nome}"/>

</div>
        </div>
</div>

<div class="row">
<div class="col-md-10">
<div class="form-group fieldcontain ${hasErrors(bean: financiadorInstance, field: 'razaoSocial', 'error')} ">
    <label for="razaoSocial">
        <g:message code="financiador.razaoSocial.label" default="Razão Social"/>
        
    </label>
    <g:textField class="form-control"  name="participante.razaoSocial" maxlength="100" value="${financiadorInstance?.participante?.razaoSocial}"/>

</div>
</div>
    <div class="col-md-2">
<div class="form-group fieldcontain ${hasErrors(bean: financiadorInstance, field: 'sigla', 'error')} ">
    <label for="sigla">
        <g:message code="financiador.sigla.label" default="Sigla"/>
        
    </label>
    <g:textField class="form-control"  name="sigla" maxlength="10" value="${financiadorInstance?.sigla}"/>

</div>
</div>

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
<div class="row">
<div class="col-md-10">
    <div class="form-group fieldcontain ${hasErrors(bean: financiadorInstance, field: 'cnpj', 'error')} ">
        <label for="cnpj">
            <g:message code="financiador.participante.cnpj.label" default="Cnpj"/>

        </label>
        <g:textField class="form-control cnpj"  name="participante.cnpj" maxlength="18" value="${financiadorInstance?.participante?.cnpj}"/>

    </div>
</div>
    <div class="col-md-2">
<div class="form-group fieldcontain ${hasErrors(bean: financiadorInstance, field: 'setor', 'error')} ">
    <label for="setor">
        <g:message code="financiador.setor.label" default="Setor"/>
        
    </label>
    <g:select name="setor" from="${com.acception.cadastro.enums.Setor?.values()}" class="form-control" keys="${com.acception.cadastro.enums.Setor.values()*.name()}" value="${financiadorInstance?.setor?.name()}"  noSelection="['': 'Selecione...']"/>

</div>
        </div>
    </div>

        </div>
        </div>
        <!-- /.panel -->
    </div>
</div>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-primary">
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
                html: '<input type="text" class="form-control" name="listaResponsaveis.nome" required/>',
                getValue: function (input) {
                    return $(input).val();
                },
                setValue: function (input, value) {
                    return $(input).text(value);
                }
            }, 'email': {
                html: '<input type="text" class="form-control"   name="listaResponsaveis.email" placeholder="exemplo@mail.com" required/>',
                getValue: function (input) {
                    return $(input).val();
                },
                setValue: function (input, value) {
                    return $(input).text(value);
                }
            }, 'telefone': {
                html: '<input type="text" class="form-control phone"  id="telefoneRaw" name="listaResponsaveis.telefone" required/>',
                getValue: function (input) {
                    return $(input).val();
                },
                setValue: function (input, value) {
                    return $(input).text(value);
                }
            }
        },
        row_template: ['nome', 'email', 'telefone'],
        names: ['listaResponsaveis.nome', 'listaResponsaveis.email', 'listaResponsaveis.telefone'],
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


<%@ page import="com.acception.cadastro.enums.StatusProjeto; com.acception.cadastro.CentroCusto" %>

<asset:stylesheet src="bootstrap-datepicker.css"/>
<asset:javascript src="plugins/bootstrap/bootstrap-datepicker.min.js"/>
<asset:javascript src="plugins/bootstrap/bootstrap-datepicker.pt-BR.js"/>

<asset:stylesheet src="fileinput.min.css"/>
<asset:javascript src="plugins/fileinput/fileinput.min.js"/>
<asset:javascript src="plugins/fileinput/locales/pt-BR.js"/>

<div class="row">
    <div class="col-md-2">
        <div class="form-group ${hasErrors(bean: centroCustoInstance, field: 'codigo', 'has-error')}">
            <label for="codigo">
                <g:message code="centroCusto.codigo.label" default="Código"/>

            </label>
            <g:textField class="form-control" required="required" name="codigo" value="${centroCustoInstance?.codigo}"/>

        </div>
    </div>

    <div class="col-md-10">
        <div class="form-group fieldcontain ${hasErrors(bean: centroCustoInstance, field: 'nome', 'error')} ">
            <label for="nome">
                <g:message code="centroCusto.nome.label" default="Nome"/>

            </label>
            <g:textField class="form-control" required="required" name="nome" value="${centroCustoInstance?.nome}"/>

        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <div class="form-group fieldcontain ${hasErrors(bean: centroCustoInstance, field: 'descricao', 'error')} ">
            <label for="descricao">
                <g:message code="centroCusto.descricao.label" default="Descrição"/>

            </label>
            <g:textField class="form-control" required="required" name="descricao"
                         value="${centroCustoInstance?.descricao}"/>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-4">
        <div class="form-group fieldcontain ${hasErrors(bean: centroCustoInstance, field: 'ano', 'error')} ">
            <label for="ano">
                <g:message code="centroCusto.ano.label" default="Ano"/>

            </label>
            <g:field class="form-control" id="ano" equired="required" name="ano" type="number" min="0"
                     value="${centroCustoInstance.ano}"/>
        </div>
    </div>

    <div class="col-md-8">
        <div class="form-group fieldcontain ${hasErrors(bean: centroCustoInstance, field: 'statusProjeto', 'error')} ">
            <label for="statusProjeto">
                <g:message code="centroCusto.statusProjeto.label" default="Status Projeto"/>

            </label>
            <g:select name="statusProjeto" required="required" from="${StatusProjeto?.values()}" class="form-control"
                      keys="${StatusProjeto.values()*.name()}" value="${centroCustoInstance?.statusProjeto?.name()}"
                      noSelection="['': 'Selecione um status...']"/>

        </div>
    </div>
</div>

<div class="row">
    <div class="form-group fieldcontain ${hasErrors(bean: centroCustoInstance, field: 'dataInicio', 'error')} col-md-6">
        <label class="control-label" for="dataInicio">
            <g:message code="centroCusto.dataInicio.label" default="Data Início"/>
        </label>
        <input required="required" name="dataInicio" format="dd/MM/yyyy"
               value="${formatDate(format: "dd/MM/yyyy", date: centroCustoInstance?.dataInicio)}"
               class="form-control datepicker"/>

    </div>

    <div class="form-group fieldcontain ${hasErrors(bean: centroCustoInstance, field: 'dataFinal', 'error')} col-md-6">
        <label class="control-label" for="dataFinal">
            <g:message code="centroCusto.dataFinal.label" default="Data Término"/>

        </label>
        <input required="required" name="dataFinal" format="dd/MM/yyyy"
               value="${formatDate(format: "dd/MM/yyyy", date: centroCustoInstance?.dataFinal)}"
               class="form-control datepicker"/>

    </div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: centroCustoInstance, field: 'planoDeTrabalho', 'error')} ">
    <label for="planoDeTrabalho">
        <g:message code="centroCusto.planoDeTrabalho.label" default="Plano De Trabalho"/>
    </label>

    <input type="file" id="planoDeTrabalho" name="planoDeTrabalho">
</div>

%{--<div class="form-group fieldcontain ${hasErrors(bean: centroCustoInstance, field: 'orcamento', 'error')} ">--}%
%{--<label for="orcamento">--}%
%{--<g:message code="centroCusto.orcamento.label" default="Orcamento"/>--}%
%{----}%
%{--</label>--}%
%{--<g:select class="form-control" id="orcamento" name="orcamento.id" from="${com.acception.cadastro.Orcamento.list()}" optionKey="id" value="${centroCustoInstance?.orcamento?.id}" class="form-control" noSelection="['null': '']"/>--}%

%{--</div>--}%

<script>
    $(function () {
        $('.datepicker').datepicker({
            format: 'dd/mm/yyyy',
            language: 'pt-BR',
            autoclose: true
        });

        $('#planoDeTrabalho').fileinput({
            language: 'pt-BR',
            showUpload: false,
            maxFileCount: 1,
            overwriteInitial: true,
            previewFileType: 'text',
            <g:if test="${centroCustoInstance?.planoDeTrabalho}">
                initialPreview: [
                    "${createLink(controller: 'anexo', action: 'download', id: "${centroCustoInstance?.planoDeTrabalho?.id}")}"
                ],
                initialPreviewAsData: true,
                initialPreviewConfig: [
                    {
                        type: "object",
                        caption: "${centroCustoInstance?.planoDeTrabalho?.nome}"
                    }
                ],
                initialPreviewShowDelete: false
            </g:if>
        });
    });



</script>
<%@ page import="com.acception.cadastro.CentroCusto" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'centroCusto.label', default: 'Centro de Custo')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
    <asset:stylesheet src="uploadfile.css"/>
    <asset:javascript src="jquery.uploadfile.min.js"/>
    <g:set var="df" value="${new java.text.DecimalFormat('###,##0.00')}"/>
</head>

<body>
<div id="content">
    <div class="inner" style="min-height: 700px;">
        <div class="row">
            <div class="col-lg-12">
                <h1><g:message code="default.show.label" args="[entityName]"/></h1>
            </div>
        </div>
        <hr/>
        <!--BLOCK SECTION -->
        <div class="nav" role="navigation">
            <p>
                <g:link class="btn btn-default" action="index"><span class="glyphicon glyphicon-list"></span> <g:message
                        code="default.list.label" args="[entityName]"/></g:link>
                <g:link class="btn btn-default" action="create"><span
                        class="glyphicon glyphicon-plus"></span> <g:message code="default.new.label"
                                                                            args="[entityName]"/></g:link>
            </p>
        </div>

        <div id="show-centroCusto" class="content scaffold-show" role="main">
            <g:if test="${flash.message}">
                <div class="alert alert-info">
                    ${flash.message}
                </div>
            </g:if>

            <ul class="nav nav-tabs">
                <li class="active"><a href="#dadosBasicos" data-toggle="tab" aria-expanded="false">Dados Básicos</a>
                </li>

                <li><a href="#orcamento" data-toggle="tab" aria-expanded="true">Orçamento</a>
                </li>

                <li><a href="#pessoal" data-toggle="tab" aria-expanded="true">Pessoal</a>
                </li>

                <li><a href="#contaBancaria" data-toggle="tab" aria-expanded="true">Conta Bancária</a>
                </li>

                <li><a href="#despesas" data-toggle="tab" aria-expanded="true">Despesas</a>
                </li>

            </ul>

            <div class="tab-content">
                <div class="tab-pane fade in active" id="dadosBasicos">
                    <g:render template="showDadosBasicos" model="[centroCustoInstance: centroCustoInstance]"/>
                </div>

                <div class="tab-pane fade in" id="orcamento">
                    <g:if test="${centroCustoInstance.orcamentos?.size() > 1}">
                        <ul class="nav nav-pills">
                            <li class="active"><a href="#orcamentoAtual" data-toggle="tab" aria-expanded="true">Orçamento Atual</a></li>
                            <li><a href="#orcamentoOriginal" data-toggle="tab" aria-expanded="true">Orçamento Original</a></li>
                            <li><a href="#historicoOrcamentos" data-toggle="tab" aria-expanded="true">Histórico de Orçamentos</a></li>
                        </ul>

                        <div class="tab-content">
                            <div class="tab-pane fade in active" id="orcamentoAtual">
                                <g:render template="showOrcamento" model="[orcamento: centroCustoInstance.orcamentoAtual, isOrcamentoAtual: true]"/>
                            </div>

                            <div class="tab-pane fade in" id="orcamentoOriginal">
                                <g:render template="showOrcamento" model="[orcamento: centroCustoInstance.orcamentoOriginal]"/>
                            </div>

                            <div class="tab-pane fade in" id="historicoOrcamentos">
                                <g:render template="historicoOrcamentos" model="[listaOrcamentos: centroCustoInstance.orcamentos]"/>
                            </div>
                        </div>
                    </g:if>
                    <g:else>
                        <g:render template="showOrcamento" model="[orcamento: centroCustoInstance.orcamentoAtual, isOrcamentoAtual: true]"/>
                    </g:else>

                </div>

                <div class="tab-pane fade in" id="pessoal">
                    <g:render template="showPessoal" model="[centroCustoInstance: centroCustoInstance]"/>
                </div>

                <div class="tab-pane fade in" id="contaBancaria">
                    <g:render template="showContaBancaria" model="[centroCustoInstance: centroCustoInstance]"/>
                </div>

                <div class="tab-pane fade in" id="despesas">
                    <g:render template="showDespesas" model="[centroCustoInstance: centroCustoInstance]"/>
                </div>
            </div>

            <br>


            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">

                        <div class="panel-heading">
                            <g:message code="projeto.informacoesGerais.label" default="Arquivos"/>
                        </div>

                        <div class="panel-body">
                            <div id="fileuploader">Upload</div>
                        </div>

                    </div>
                </div>
            </div>

            <g:form url="[resource: centroCustoInstance, action: 'delete']" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="btn btn-default" action="edit" resource="${centroCustoInstance}">
                        <span class="glyphicon glyphicon-edit"></span>
                        <g:message code="default.button.edit.label" default="Edit"/>
                    </g:link>
                    <button type="submit" class="btn btn-default"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
                        <span class="glyphicon glyphicon-floppy-remove"></span>
                        <g:message code="default.button.delete.label"/>
                    </button>
                </fieldset>
            </g:form>
        </div>
    </div>
</div>
<script>
    $(document).ready(function()
    {
        $("#fileuploader").uploadFile({
            url:"${createLink(action: 'carregarArquivo', controller: 'centroCusto',id: "${centroCustoInstance.id}")}",
            fileName:"file",
            showDelete: true,
            showDownload:true,
            showPreview:true,
            previewHeight: "200px",
            previewWidth: "200px",
            statusBarWidth:'250px',
            onLoad:function(obj)
            {
                $.ajax({
                    cache: false,
                    url: "${createLink(action:'getFiles',id: "${centroCustoInstance.id}")}",
                    dataType: "json",
                    success: function(data)
                    {
                        for(var i=0;i<data.length;i++)
                        {
                            obj.createProgress(data[i].name,data[i].path,data[i].size,data[i].id);
                        }
                    }
                });
            },
            downloadCallback:function(id,pd)
            {
                location.href = "${createLink(action: 'baixarArquivo', controller: 'centroCusto')}?idArquivo=" + id
            },
            deleteCallback: function (id, pd) {
                $.ajax({
                    url: "${createLink(action:'deletarArquivo',id: "${centroCustoInstance.id}")}",
                    dataType: "json",
                    data: {idArquivo:id},
                    success: function(data)
                    {
                        console.log('Documento removido...')
                    }
                });
            },
        });

        var showHistorico = ${params.showOrcamento ?: false};

        if (showHistorico) {
            $('a[href="#orcamento"]').tab('show')
        }
    });
</script>
</body>
</html>

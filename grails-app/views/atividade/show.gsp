<%@ page import="com.acception.cadastro.Atividade" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'atividade.label', default: 'Atividade')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
    <asset:stylesheet src="jquery.uploadfile.css"/>
    <asset:javascript src="jquery.uploadfile.min.js"/>
</head>

<body>
<p>
    <g:link class="btn btn-default" action="index"><span class="glyphicon glyphicon-list"></span> <g:message
            code="default.list.label" args="[entityName]"/></g:link>
</p>

<ul class="nav nav-tabs">
    <li class="active"><a href="#dadosBasicos" data-toggle="tab" aria-expanded="false">Dados Básicos</a>
    </li>

    <g:if test="${!atividadeInstance.isSubatividade()}">

        <li><a href="#subatividades " data-toggle="tab" aria-expanded="true">Subatividades / Módulos</a>
        </li>
    </g:if>

    <li><a href="#relatorios" data-toggle="tab" aria-expanded="true">Relatórios</a>
    </li>

    <li><a href="#despesas" data-toggle="tab" aria-expanded="true">Despesas</a></li>
</ul>

<div class="tab-content">
    <div class="tab-pane fade in active" id="dadosBasicos">
        <g:render template="showAtividade" model="[atividadeInstance: atividadeInstance]"/>
    </div>
    <g:if test="${!atividadeInstance.isSubatividade()}">
        <div class="tab-pane fade in" id="subatividades">
            <g:render template="showSubatividades" model="[atividadeInstance: atividadeInstance]"/>
        </div>
    </g:if>

    <div class="tab-pane fade in" id="relatorios">
        <g:render template="showRelatorios" model="[atividadeInstance: atividadeInstance]"/>
    </div>

    <div class="tab-pane fade in" id="despesas">
        <g:render template="showDespesas" model="[atividadeInstance: atividadeInstance]"/>
    </div>

</div><br/>

<script>
    $(document).ready(function () {
        $("#fileuploader").uploadFile({
            url: "${createLink(action: 'carregarArquivo', controller: 'atividade',id: "${atividadeInstance.id}")}",
            fileName: "file",
            showDelete: true,
            showDownload: true,
            showPreview: true,
            previewHeight: "200px",
            previewWidth: "200px",
            statusBarWidth: '250px',
            onLoad: function (obj) {
                $.ajax({
                    cache: false,
                    url: "${createLink(action:'getFiles',id: "${atividadeInstance.id}")}",
                    dataType: "json",
                    success: function (data) {
                        for (var i = 0; i < data.length; i++) {
                            obj.createProgress(data[i].name, data[i].path, data[i].size, data[i].id);
                        }
                    }
                });
            },
            downloadCallback: function (id, pd) {
                location.href = "${createLink(action: 'baixarArquivo', controller: 'atividade')}?idArquivo=" + id
            },
            deleteCallback: function (id, pd) {
                $.ajax({
                    url: "${createLink(action:'deletarArquivo',id: "${atividadeInstance.id}")}",
                    dataType: "json",
                    data: {idArquivo: id},
                    success: function (data) {
                        console.log('Documento removido...')
                    }
                });
            }
        });
    });
</script>
</body>
</html>

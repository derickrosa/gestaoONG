<asset:javascript src="jquery.uploadfile.min.js"/>
<asset:stylesheet src="jquery.uploadfile.css"/>

<script type="application/javascript">
    $(document).ready(function(){
        $("#fileuploader").uploadFile({
            url:"${createLink(action: 'carregarArquivo', controller: 'centroCusto',id: "${centroCustoInstance.id}")}",
            fileName:"file",
            showDelete: true,
            showDownload:true,
            showPreview:true,
            previewHeight: "200px",
            previewWidth: "200px",
            statusBarWidth:'320px',
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
            }
        });
    });
</script>


<table class="table table-bordered centroCusto">
    <g:if test="${centroCustoInstance?.codigo}">
        <tr>
            <th id="codigo-label" class="property-label"><g:message code="centroCusto.codigo.label"
                                                                    default="Código"/></th>

            <td aria-labelledby="codigo-label"><g:fieldValue bean="${centroCustoInstance}"
                                                             field="codigo"/></td>

        </tr>
    </g:if>

    <g:if test="${centroCustoInstance?.nome}">
        <tr>
            <th id="nome-label" class="property-label"><g:message code="centroCusto.nome.label"
                                                                  default="Nome"/></th>

            <td aria-labelledby="nome-label"><g:fieldValue bean="${centroCustoInstance}" field="nome"/></td>

        </tr>
    </g:if>

    <g:if test="${centroCustoInstance?.ano}">
        <tr>
            <th id="ano-label" class="property-label"><g:message code="centroCusto.ano.label"
                                                                 default="Ano"/></th>

            <td aria-labelledby="ano-label">${centroCustoInstance.ano}</td>

        </tr>
    </g:if>

    <g:if test="${centroCustoInstance?.descricao}">
        <tr>
            <th id="descricao-label" class="property-label"><g:message code="centroCusto.descricao.label"
                                                                       default="Descrição"/></th>

            <td aria-labelledby="descricao-label"><g:fieldValue bean="${centroCustoInstance}"
                                                                field="descricao"/></td>

        </tr>
    </g:if>

    <g:if test="${centroCustoInstance?.dataInicio}">
        <tr>
            <th id="dataInicio-label" class="property-label"><g:message code="centroCusto.dataInicio.label"
                                                                        default="Data Início"/></th>

            <td aria-labelledby="dataInicio-label"><g:formatDate
                    date="${centroCustoInstance?.dataInicio}" format="dd/MM/yyyy"/></td>

        </tr>
    </g:if>

    <g:if test="${centroCustoInstance?.dataFinal}">
        <tr>
            <th id="dataFinal-label" class="property-label"><g:message code="centroCusto.dataFinal.label"
                                                                       default="Data Final"/></th>

            <td aria-labelledby="dataFinal-label"><g:formatDate
                    date="${centroCustoInstance?.dataFinal}" format="dd/MM/yyyy"/></td>

        </tr>
    </g:if>

    %{--<g:if test="${centroCustoInstance?.planoDeTrabalho}">
        <tr>
            <th id="planoDeTrabalho-label" class="property-label"><g:message
                    code="centroCusto.planoDeTrabalho.label" default="Plano De Trabalho"/></th>




            <td aria-labelledby="planoDeTrabalho-label">
                <a href="${createLink(controller: 'anexo', action: 'download', id: "${centroCustoInstance?.planoDeTrabalho?.id}")}">${centroCustoInstance?.planoDeTrabalho?.nome}</a>
            </td>

        </tr>
    </g:if>--}%

    <g:if test="${centroCustoInstance?.statusProjeto}">
        <tr>
            <th id="statusProjeto-label" class="property-label"><g:message
                    code="centroCusto.statusProjeto.label" default="Status do Projeto"/></th>

            <td aria-labelledby="statusProjeto-label"><g:fieldValue bean="${centroCustoInstance}"
                                                                    field="statusProjeto"/></td>

        </tr>
    </g:if>

    <g:if test="${centroCustoInstance?.financiador}">
        <tr>
            <th id="financiador-label" class="property-label">Financiador</th>

            <td aria-labelledby="financiador-label">
                <a href="${createLink(action: 'show', controller: 'financiador',
                        id: centroCustoInstance.financiador.id)}">${centroCustoInstance.financiador}</a>
            </td>
        </tr>
    </g:if>

    <g:if test="${centroCustoInstance?.responsavel}">
        <tr>
            <th id="responsavel-label" class="property-label">Responsável</th>

            <td aria-labelledby="responsavel-label">
                <a href="${createLink(action: 'show', controller: 'responsavel',
                        id: centroCustoInstance.responsavel.id)}">${centroCustoInstance.responsavel}</a>
            </td>
        </tr>
    </g:if>
</table>

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
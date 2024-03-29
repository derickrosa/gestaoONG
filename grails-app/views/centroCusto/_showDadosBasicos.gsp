<table class="table table-bordered centroCusto">
    <g:if test="${centroCustoInstance?.codigo}">
        <tr>
            <th id="codigo-label" class="property-label"><g:message code="centroCusto.codigo.label" default="Código"/></th>
            <td aria-labelledby="codigo-label"><g:fieldValue bean="${centroCustoInstance}" field="codigo"/></td>
        </tr>
    </g:if>

    <g:if test="${centroCustoInstance?.nome}">
        <tr>
            <th id="nome-label" class="property-label"><g:message code="centroCusto.nome.label" default="Nome"/></th>
            <td aria-labelledby="nome-label"><g:fieldValue bean="${centroCustoInstance}" field="nome"/></td>
        </tr>
    </g:if>

    <g:if test="${centroCustoInstance?.ano}">
        <tr>
            <th id="ano-label" class="property-label"><g:message code="centroCusto.ano.label" default="Ano"/></th>
            <td aria-labelledby="ano-label">${centroCustoInstance.ano}</td>
        </tr>
    </g:if>

    <g:if test="${centroCustoInstance?.descricao}">
        <tr>
            <th id="descricao-label" class="property-label"><g:message code="centroCusto.descricao.label" default="Descrição"/></th>
            <td aria-labelledby="descricao-label"><g:fieldValue bean="${centroCustoInstance}" field="descricao"/></td>
        </tr>
    </g:if>

    <g:if test="${centroCustoInstance?.dataInicio}">
        <tr>
            <th id="dataInicio-label" class="property-label"><g:message code="centroCusto.dataInicio.label" default="Data Início"/></th>
            <td aria-labelledby="dataInicio-label"><g:formatDate date="${centroCustoInstance?.dataInicio}" format="dd/MM/yyyy"/></td>
        </tr>
    </g:if>

    <g:if test="${centroCustoInstance?.dataFinal}">
        <tr>
            <th id="dataFinal-label" class="property-label"><g:message code="centroCusto.dataFinal.label" default="Data Final"/></th>
            <td aria-labelledby="dataFinal-label"><g:formatDate date="${centroCustoInstance?.dataFinal}" format="dd/MM/yyyy"/></td>
        </tr>
    </g:if>

    <g:if test="${centroCustoInstance?.statusProjeto}">
        <tr>
            <th id="statusProjeto-label" class="property-label"><g:message code="centroCusto.statusProjeto.label" default="Status do Projeto"/></th>
            <td aria-labelledby="statusProjeto-label"><g:fieldValue bean="${centroCustoInstance}" field="statusProjeto"/></td>
        </tr>
    </g:if>

    <g:if test="${centroCustoInstance?.financiador}">
        <tr>
            <th id="financiador-label" class="property-label">Financiador</th>
            <td aria-labelledby="financiador-label">
                <g:link controller="financiador" action="show" id="${centroCustoInstance.financiador.id}">${centroCustoInstance.financiador}</g:link>
            </td>
        </tr>
    </g:if>

    <g:if test="${centroCustoInstance?.responsavel}">
        <tr>
            <th id="responsavel-label" class="property-label">Responsável</th>
            <td aria-labelledby="responsavel-label">
                <g:link controller="responsavel" action="show" id="${centroCustoInstance.responsavel.id}">${centroCustoInstance.responsavel}</g:link>
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
                <div class="fileuploader"
                     data-load-url="${createLink(controller: 'arquivo', action: 'find.json', params: ['centroCusto.id': centroCustoInstance.id])}"
                     data-upload-url="${createLink(controller: 'arquivo', action: 'create.json', params: ['centroCusto.id': centroCustoInstance.id])}"
                     data-download-url="${createLink(controller: 'arquivo', action: 'download')}"
                     data-delete-url="${createLink(controller: 'arquivo', action: 'delete')}">Upload</div>
            </div>
        </div>
    </div>
</div>
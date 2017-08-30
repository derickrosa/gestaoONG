<%@ page import="com.acception.cadastro.RelatorioAtividade" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'relatorioAtividade.label', default: 'RelatorioAtividade')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
    <export:resource/>
</head>

<body>

    <p>
        <g:link class="btn btn-default" action="create">
            <span class="glyphicon glyphicon-plus"></span>
            <g:message code="default.new.label" args="[entityName]"/>
        </g:link>
    </p>

    <pesquisa:painel>
        <div class="form-group col-md-4">
            <label class="control-label" for="searchFinanciador">Atividade:</label>
            <g:select class="form-control select" from="${com.acception.cadastro.Atividade.list()}" optionKey="id"
                      name="searchAtividade" value="${searchAtividade}" noSelection="['': 'Todos']"/>
        </div>

        <div class="form-group col-md-4">
            <label class="control-label" for="searchFinanciador">Financiador:</label>
            <g:select class="form-control select" from="${com.acception.cadastro.Financiador.list()}" optionKey="id"
                      name="searchFinanciador" value="${searchFinanciador}" noSelection="['': 'Todos']"/>
        </div>

        <div class="form-group col-md-4">
            <label class="control-label" for="searchFinanciador">Centro de Custo:</label>
            <g:select class="form-control select" from="${com.acception.cadastro.CentroCusto.list()}" optionKey="id"
                      name="searchCentroCusto" value="${searchCentroCusto}" noSelection="['': 'Todos']"/>
        </div>
    </pesquisa:painel>


    <table class="table table-bordered table-striped">
    <thead>
    <tr>

        <g:sortableColumn property="atividade"
                          title="${message(code: 'relatorioAtividade.comunidadesEnvolvidas.label', default: 'Atividade')}"/>
        <g:sortableColumn property="atividade"
                          title="${message(code: 'relatorioAtividade.comunidadesEnvolvidas.label', default: 'Data de Criação do Relatório')}"/>

        %{--  <g:sortableColumn property="municipiosAtendidos"
                            title="${message(code: 'relatorioAtividade.totalComunidadesEnvolvidas.label', default: 'Municípios Envolvidas')}"/>

          <g:sortableColumn property="comunidadesEnvolvidas"
                            title="${message(code: 'relatorioAtividade.totalComunidadesEnvolvidas.label', default: 'Comunidades Atendidos')}"/>

          <g:sortableColumn property="numeroParticipantes"
                            title="${message(code: 'relatorioAtividade.totalComunidadesEnvolvidas.label', default: 'Total de Participantes')}"/>
--}%
        <g:sortableColumn property="financiador"
                          title="${message(code: 'relatorioAtividade.municipiosAtendidos.label', default: 'Financiador')}"/>

        <g:sortableColumn property="centroCusto"
                          title="${message(code: 'relatorioAtividade.totalMunicipiosAtendidos.label', default: 'Centro de Custo')}"/>

    </tr>
    </thead>
    <tbody>
    <g:if test="${relatorioAtividadeInstanceList.size() > 0}">
        <g:each in="${relatorioAtividadeInstanceList}" status="i" var="relatorioAtividadeInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${relatorioAtividadeInstance.id}">${fieldValue(bean: relatorioAtividadeInstance, field: "atividade")}</g:link></td>
                <td><g:formatDate value="${relatorioAtividadeInstance.dateCreated}"
                                  format="dd/MM/yyyy"/></td>

                %{--                        <td>${fieldValue(bean: relatorioAtividadeInstance, field: "municipiosAtendidos")}</td>

                                        <td>${fieldValue(bean: relatorioAtividadeInstance, field: "comunidadesEnvolvidas")}</td>

                                        <td>${fieldValue(bean: relatorioAtividadeInstance, field: "numeroParticipantes")}</td>--}%

                <td>${relatorioAtividadeInstance.financiador ?: 'Não informado.'}</td>

                <td>${relatorioAtividadeInstance.centroCusto ?: 'Não informado.'}</td>

            </tr>
        </g:each>
    </g:if>
    <g:else>
        <tr><td colspan="4" class="text-center nao-ha-registros">Não há registros de ${entityName}.</td>
        </tr>
    </g:else>
    </tbody>
</table>

    <blockquote class="relatorio">
        <p>Geração de Relatórios</p>
        <export:formats formats="['excel', 'pdf']" params="${params}"/>
    </blockquote>

    <div class="row">
        <div class="col-sm-6">
            <div class="dataTables_info" id="dataTables-example_info" role="alert" aria-live="polite"
                 aria-relevant="all">Exibindo 1 a 20 de ${relatorioAtividadeInstanceCount == 1 ? relatorioAtividadeInstanceCount + ' relatório cadastrado' : relatorioAtividadeInstanceCount + ' relatórios cadastrados'}.</div>
        </div>

        <div class="col-sm-6">
            <div class="pagination">
                <g:paginate total="${relatorioAtividadeInstanceCount ?: 0}"/>
            </div>
        </div>
    </div>
</body>
</html>

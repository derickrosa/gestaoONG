<%@ page import="com.acception.cadastro.Atividade" %>
<%@ page import="com.acception.cadastro.Financiador" %>
<%@ page import="com.acception.cadastro.CentroCusto" %>


<div class="row">

    <div class="col-md-4 formField">
        <label class="control-label" for="searchFinanciador">Atividade:</label>
        <g:select class="form-control" from="${com.acception.cadastro.Atividade.list()}" optionKey="id"
                  name="searchAtividade" value="${searchAtividade}" noSelection="['': 'Todos']"/>
    </div>

    <div class="col-md-4 formField">
        <label class="control-label" for="searchFinanciador">Financiador:</label>
        <g:select class="form-control" from="${com.acception.cadastro.Financiador.list()}" optionKey="id"
                  name="searchFinanciador" value="${searchFinanciador}" noSelection="['': 'Todos']"/>
    </div>

    <div class="col-md-4 formField">
        <label class="control-label" for="searchFinanciador">Centro de Custo:</label>
        <g:select class="form-control" from="${com.acception.cadastro.CentroCusto.list()}" optionKey="id"
                  name="searchCentroCusto" value="${searchCentroCusto}" noSelection="['': 'Todos']"/>
    </div>
</div>


<script>
    $(document).ready(function () {
        $("#searchAtividade").chosen();
        $("#searchFinanciador").chosen();
        $("#searchCentroCusto").chosen();
    });
</script>
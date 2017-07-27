<div id="list-atividade" class="body" role="main">
    <g:if test="${centroCustoInstance.atividades}">
        <div class="panel panel-success">
            <div class="panel-heading">

            </div>

            <div class="panel-body">
                <table class="table table-hover text-center" style="width: 100%">
                    <thead>
                    <tr>
                        <th></th>
                        <th class="text-center">Codigo</th>
                        <th class="text-center">Nome</th>
                        <th class="text-center">Tipo</th>
                        <th class="text-center">Status</th>
                    </tr>
                    </thead>

                    <tbody>
                    <g:each in="${centroCustoInstance.atividades}" var="atividadeInstance">
                        <g:if test="${!atividadeInstance.isSubatividade()}">


                        <tr>
                          <td>
                        <g:if test="${atividadeInstance.subAtividades}">
                                <a class="expanse" style="cursor:pointer;" data-toggle="collapse" data-target="#funcionarios_${atividadeInstance.id}">
                                    <span class="glyphicon glyphicon-plus"></span>
                                </a>
                        </g:if>
                        <g:else>
                        </g:else>
                            </td>
                    </td>
                            <td style="text-align: center; vertical-align: middle;">
                                <g:link controller="atividade" action="show"
                                    id="${atividadeInstance.id}">
                                    ${atividadeInstance.codigo}
                                </g:link>
                            </td>
                            <td style="text-align: center; vertical-align: middle;">${atividadeInstance.nome}</td>
                            <td style="text-align: center; vertical-align: middle;">${atividadeInstance.tipo}</td>
                            <td style="text-align: center; vertical-align: middle;">${atividadeInstance.status}</td>

                        </tr>

                        <tr id="funcionarios_${atividadeInstance.id}" class="collapse">
                            <td colspan="5">

                                <g:if test="${atividadeInstance.subAtividades}">
                                    <table class="table table-hover table-bordered text-center">
                                        <thead>
                                        <tr>
                                            <th class="text-center" width="50%">Código</th>
                                            <th class="text-center" width="50%">Nome</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <g:each in="${atividadeInstance.subAtividades}" var="s">
                                            <tr>
                                                <td>
                                                    <g:link controller="atividade" action="show" id="${s.id}">
                                                            ${s.codigo}
                                                    </g:link>
                                                </td>
                                                <td>${s.nome} ${s.modulo?' [ Módulo '+s.modulo+']':''}</td>
                                            </tr>
                                        </g:each>


                                        </tbody>
                                    </table>
                                </g:if>
                                <g:else>
                                    Não existem subatividades registradas.
                                </g:else>

                            </td>

                        </tr>
                    </g:if>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </div>
    </g:if>
    <g:else>
        <div class="well text-center">Sem registros!</div>
    </g:else>

    <br>

    <div class="row text-center">
        <g:link controller="atividade" action="create" params="${[centroCustoInstance:centroCustoInstance?.id]}" class="btn btn-default btn-sm">
            <span class="glyphicon glyphicon-plus"></span>
            Cadastrar Atividade
        </g:link>
    </div>

    <div class="pagination">
        <g:paginate total="${atividadeInstanceCount ?: 0}"/>
    </div>
</div>

<script>
    $(document).ready(function () {
   // $('.expanse').attr('disabled', 'disabled');



    $('.expanse').click(function() {
        if($(this).children('span').hasClass( "glyphicon-plus" )){
            $(this).children('span').removeClass('glyphicon-plus');
            $(this).children('span').addClass('glyphicon-minus');
        } else {
            $(this).children('span').removeClass('glyphicon-minus');
            $(this).children('span').addClass('glyphicon-plus');
        }

      //  this.attr('disabled', 'disabled');
    //$('select').removeAttr('disabled');
    });
    });
</script>
<%@ page import="com.acception.cadastro.Atividade" %>

<asset:stylesheet src="bootstrap-datepicker.css"/>
<asset:javascript src="plugins/bootstrap/bootstrap-datepicker.min.js"/>
<asset:javascript src="plugins/bootstrap/bootstrap-datepicker.pt-BR.js"/>

<asset:stylesheet src="fileinput.min.css"/>
<asset:javascript src="plugins/fileinput/fileinput.min.js"/>
<asset:javascript src="plugins/fileinput/locales/pt-BR.js"/>

<asset:javascript src="plugins/jquery/jquery.maskMoney.min.js"/>
<asset:javascript src="plugins/jquery/jquery.validate.js"/>

<style>
#itensOrcamentarios td {
    padding: 5px
}

.inputtable.wh td:nth-child(1) {
    width: 15%;
}

.inputtable.wh td:nth-child(3) {
    width: 15%;
}

.inputtable.wh td:nth-child(4) {
    width: 15%;
}

/* First body row cells & input on table without columns header */
table.inputtable.wh tbody tr:nth-child(1), table.inputtable.wh tbody tr:nth-child(1) input {
    font-weight: normal;
}

.wizard .content {
    min-height: 100px;
}
.wizard .content > .body {
    width: 100%;
    height: auto;
    padding: 15px;
    position: relative;
}

.error {
    font-size: small;
}
#searchUl{
    height: auto !important;
    width: auto !important;
}
.droprev li {
    display: block !important;
}
#dropdownMenu1 {
    text-align: left !important;
}
#caret {
    float: right !important;


}
</style>
<section>
    <g:hiddenField name="centroCusto.id" value="${1}" />
    <div class="row">
        <div class="col-md-8">
            <div class="form-group fieldcontain ${hasErrors(bean: atividadeInstance, field: 'nome', 'error')} ">
                <label for="nome">
                    <g:message code="atividade.nome.label" default="Nome"/>

                </label>
                <g:textField class="form-control"  name="nome" maxlength="100" value="${atividadeInstance?.nome}"/>

            </div>
        </div>

        <div class="col-md-4">
            <div class="form-group fieldcontain ${hasErrors(bean: atividadeInstance, field: 'linhas', 'error')} ">
            <label for="linhas">
                <g:message code="atividade.linhas.label" default="Linhas de Ação"/>
            </label>
            <div class="field" style="">
                <div class="dropdown">
                    <button class="btn btn-default dropdown-toggle form-control" style="width: 100%" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                        Selecione a linha de ação...
                        <span id="caret" class="caret"></span>
                    </button>

                    <ul class="dropdown-menu droprev " aria-labelledby="dropdownMenu1" id="searchUl">
                        <g:set var="linhaAcaoIds" value="${atividadeInstance?.linhas?.id}" />
                        <g:each in="${com.acception.cadastro.LinhaAcao.list(sort: 'codigo')}" var="status" status="i" >
                            <li>
                                <a href="#" class="small" data-value="option1" tabIndex="-1">
                                    <g:checkBox name="linhaAcao" checked="${linhaAcaoIds?.find { it == status.id } }" value="${status.id}"></g:checkBox> ${status} <br/>
                                </a>
                            </li>
                        </g:each>
                    </ul>


                </div>
            </div>
                </div>
        </div>
        %{--<div class="col-md-4">
            <div class="form-group fieldcontain ${hasErrors(bean: atividadeInstance, field: 'linhas', 'error')} ">
                <label for="linhas">
                    <g:message code="atividade.linhas.label" default="Linhas de Ação"/>
                </label>
                <g:select class="form-control" id="linhas" name="linhas.id" from="${com.acception.cadastro.LinhaAcao.list()}" optionKey="id" value="${atividadeInstance?.linhas?.id}" class="form-control" noSelection="['null': 'Selecione a linha de ação...']"/>

            </div>
        </div>--}%


    </div>
    <div class="row">
        <div class="col-md-6">
            <div class="form-group fieldcontain ${hasErrors(bean: atividadeInstance, field: 'tipo', 'error')} ">
                <label for="tipo">
                    <g:message code="atividade.tipo.label" default="Tipo"/>

                </label>
                <g:select name="tipo" from="${com.acception.cadastro.enums.TipoAtividade?.values()}" class="form-control" keys="${com.acception.cadastro.enums.TipoAtividade.values()*.name()}" value="${atividadeInstance?.tipo?.name()}"  noSelection="['null': 'Selecione o tipo de atividade...']"/>

            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group fieldcontain ${hasErrors(bean: atividadeInstance, field: 'status', 'error')} ">
                <label for="status">
                    <g:message code="atividade.status.label" default="Status"/>

                </label>
                <g:select name="status" from="${com.acception.cadastro.enums.StatusAtividade?.values()}" class="form-control" keys="${com.acception.cadastro.enums.StatusAtividade.values()*.name()}" value="${atividadeInstance?.status?.name()}"  noSelection="['': '']"/>

            </div>
        </div>
    </div>

%{--<div class="form-group fieldcontain ${hasErrors(bean: atividadeInstance, field: 'anexos', 'error')} ">
    <label for="anexos">
        <g:message code="atividade.anexos.label" default="Anexos"/>
        
    </label>
    <g:select name="anexos" from="${com.acception.cadastro.Anexo.list()}" multiple="multiple" optionKey="id" size="5" value="${atividadeInstance?.anexos*.id}" class="form-control"/>

</div>--}%
    <div class="row">
        <div class="col-md-6">

<div class="form-group fieldcontain ${hasErrors(bean: atividadeInstance, field: 'descricao', 'error')} ">
    <label for="descricao">
        <g:message code="atividade.descricao.label" default="Descrição"/>
        
    </label>
    <g:textArea class="form-control"  name="descricao" value="${atividadeInstance?.descricao}"/>

</div>
</div>
    <div class="col-md-6">
        <div class="form-group fieldcontain ${hasErrors(bean: atividadeInstance, field: 'objetivo', 'error')} ">
            <label for="objetivo">
                <g:message code="atividade.objetivo.label" default="Objetivo (s)"/>

            </label>
            <g:textArea class="form-control"  name="objetivo" value="${atividadeInstance?.objetivo}"/>

        </div>
        </div>
    </div>
%{--<div class="form-group fieldcontain ${hasErrors(bean: atividadeInstance, field: 'despesas', 'error')} ">
    <label for="despesas">
        <g:message code="atividade.despesas.label" default="Despesas"/>
        
    </label>
    <g:select name="despesas" from="${com.acception.cadastro.Despesa.list()}" multiple="multiple" optionKey="id" size="5" value="${atividadeInstance?.despesas*.id}" class="form-control"/>

</div>--}%

%{--<div class="form-group fieldcontain ${hasErrors(bean: atividadeInstance, field: 'atividade', 'error')} ">
    <label for="atividade">
        <g:message code="atividade.atividade.label" default="Atividade"/>
        
    </label>
    <g:select class="form-control" id="atividade" name="atividade.id" from="${com.acception.cadastro.Atividade.list()}" optionKey="id" value="${atividadeInstance?.atividade?.id}" class="form-control" noSelection="['null': '']"/>

</div>--}%

%{--<div class="form-group fieldcontain ${hasErrors(bean: atividadeInstance, field: 'centroCusto', 'error')} ">
    <label for="centroCusto">
        <g:message code="atividade.centroCusto.label" default="Centro Custo"/>
        
    </label>
    <g:select class="form-control" id="centroCusto" name="centroCusto.id" from="${com.acception.cadastro.CentroCusto.list()}" optionKey="id" value="${atividadeInstance?.centroCusto?.id}" class="form-control" noSelection="['null': '']"/>

</div>--}%

    <div class="row">
        <div class="form-group fieldcontain ${hasErrors(bean: atividadeInstance, field: 'inicio', 'error')} col-md-4">
            <label class="control-label" for="inicio">
                <g:message code="atividade.inicio.label" default="Data Início"/>
            </label>
            <input required="required" name="inicio" format="dd/MM/yyyy"
                   value="${formatDate(format: "dd/MM/yyyy", date: atividadeInstance?.inicio)}"
                   class="form-control datepicker"/>

        </div>

        <div class="form-group fieldcontain ${hasErrors(bean: atividadeInstance, field: 'termino', 'error')} col-md-4">
            <label class="control-label" for="final">
                <g:message code="atividade.termino.label" default="Data Término"/>

            </label>
            <input required="required" name="final" format="dd/MM/yyyy"
                   value="${formatDate(format: "dd/MM/yyyy", date: atividadeInstance?.termino)}"
                   class="form-control datepicker"/>

        </div>

        <div class="col-md-4">
            <div class="form-group fieldcontain ${hasErrors(bean: atividadeInstance, field: 'periodo', 'error')} ">
                <label for="periodo">
                    <g:message code="atividade.periodo.label" default="Periodo"/>

                </label>
                <g:textField class="form-control"  name="periodo" value="${atividadeInstance?.periodo}"/>

            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-4">
            <div class="form-group fieldcontain ${hasErrors(bean: atividadeInstance, field: 'estado', 'error')} ">
                <label for="estado">
                    <g:message code="atividade.estado.label" default="Estado"/>
                </label>
                <g:select class="form-control" id="estado" name="estado.id" from="${com.acception.cadastro.Estado.list()}" optionKey="id" value="${atividadeInstance?.estado?.id}" noSelection="['null': 'Selecione um estado...']"/>

            </div>
        </div>
        <div class="col-md-4">
            <div class="form-group ${hasErrors(bean: atividadeInstance, field: 'municipio', 'has-error')} ">
                <label class="control-label" for="municipio">
                    <g:message code="atividade.municipio.label" default="Município"/>

                </label>

                <g:select class="form-control" id="municipio" name="municipio.id"
                          from=""
                          optionKey="id"
                          value="${atividadeInstance?.municipio?.id}"
                          noSelection="['null': 'Selecione um município...']"/>

            </div>
        </div>
        <div class="col-md-4">
            <div class="form-group fieldcontain ${hasErrors(bean: atividadeInstance, field: 'local', 'error')} ">
                <label for="local">
                    <g:message code="atividade.local.label" default="Local"/>

                </label>
                <g:textField class="form-control"  name="local" value="${atividadeInstance?.local}"/>

            </div>
        </div>
    </div>







<div class="form-group fieldcontain ${hasErrors(bean: atividadeInstance, field: 'anexos', 'error')} ">
    <label for="planoDeTrabalho">
        <g:message code="centroCusto.planoDeTrabalho.label" default="Anexar Documentos"/>
    </label>

    <input type="hidden" id="previousPlanoDeTrabalho" name="previousPlanoDeTrabalho"
           value="${atividadeInstance?.anexos}">
    <input type="hidden" id="numFilesUploaded" name="numFilesUploaded"
           value="${atividadeInstance?.anexos}">
    <input type="file" id="planoDeTrabalho" name="planoDeTrabalho">
</div>
</section>
<script src="${assetPath(src: 'jquery.cookie-1.3.1.js')}"></script>
<script src="${assetPath(src: 'jquery.steps.js')}"></script>
<script src="${assetPath(src: 'WizardInitCentroCusto.js')}"></script>
<script>


    var initializeMoneyMask = function () {
        $(".currency").maskMoney({
            prefix: 'R$ ',
            allowNegative: true,
            thousands: '.',
            decimal: ',',
            affixesStay: false
        });
    };

    var initializeDatepicker = function () {
        $('.datepicker').datepicker({
            format: 'dd/mm/yyyy',
            language: 'pt-BR',
            autoclose: true
        });
    };

    var initializeFileInput = function () {
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
                    caption: "${centroCustoInstance?.planoDeTrabalho?.nome}",
                }
            ],
            initialPreviewShowDelete: false,
            </g:if>
        });

        $('#planoDeTrabalho').on('change', function (event) {
            var numFilesUploaded = $('#numFilesUploaded');

            numFilesUploaded.val(1);
        });

        $('.fileinput-remove-button').on('click', function () {
            var numFilesUploaded = $('#numFilesUploaded');

            numFilesUploaded.val(0);
        });
    };

    var atualizarValoresItensOrcamentarios = function() {
        $.each($('#itensOrcamentarios .currency'), function(index, element){
            $(element).maskMoney({
                prefix: 'R$ ',
                allowNegative: true,
                thousands: '.',
                decimal: ',',
                affixesStay: false
            });

            $(element).maskMoney('mask', Number($(element)[0].defaultValue))
        });
    };

    var initializeTableItensOrcamentarios = function () {
        var html = `<g:select class='form-control' from='${com.acception.cadastro.enums.TipoCusto.values()}'
                    name='itensOrcamento.tipoCusto' keys="${com.acception.cadastro.enums.TipoCusto.values()*.name()}"/>`

        var table = $("#itensOrcamentarios").editTable({
            field_templates: {
                'codigo': {
                    html: '<input type="number" class="form-control text-center" name="itensOrcamento.codigo">',
                    getValue: function (input) {
                        return $(input).val();
                    },
                    setValue: function (input, value) {
                        return $(input).text(value);
                    }
                },

                'nome': {
                    html: '<input type="text" class="form-control text-center" name="itensOrcamento.nome">',
//                    html: '<textarea class="form-control" rows="2">',
                    getValue: function (input) {
                        return $(input).val();
                    },
                    setValue: function (input, value) {
                        return $(input).text(value);
                    }
                },

                'currency': {
                    html: '<input type="text" class="form-control currency text-center" name="itensOrcamento.valor">',
                    getValue: function (input) {
                        return $(input).val();
                    },
                    setValue: function (input, value) {
                        console.log(value);

                        return $(input).text(value);
                    }
                },

                'select_tipo_custo': {
                    html: html,
                    getValue: function (input) {
                        return $(input).val();
                    },
                    setValue: function (input, value) {
                        var select = $(input);
                        select.find('option').filter(function () {
                            return $(this).val() == value;
                        }).attr('selected', true);
                        return select;
                    }
                }
            },

            row_template: ['codigo', 'nome', 'currency', 'select_tipo_custo'],

            headerCols: [
                'Código',
                'Nome',
                'Valor',
                'Tipo Custo'
            ],

            itemOrcamentario: true
        });

        $("#itensOrcamentarios").on("focusin", "td:nth-child(3) input", function () {
            $(this).maskMoney({prefix: 'R$ ', allowNegative: true, thousands: '.', decimal: ',', affixesStay: false});
        });


    };

    var atualizarSelectResponsaveis = function (dados) {
        var selectResponsaveis = $("#responsavel");
        selectResponsaveis.empty(); // remove old options

        $.each(dados, function (index, value) {
            selectResponsaveis.append($("<option></option>")
                    .attr("value", value.id).text(value.nome));
        });
    };

    $(function () {
        //initializeMoneyMask();

        initializeDatepicker();

        initializeFileInput();

        //initializeTableItensOrcamentarios();

        //atualizarValorTotalOrcamento();

        var options = [];
        console.log("Aqui");

        var options = [];

        $( '.dropdown-menu a' ).on( 'click', function( event ) {

            var $target = $( event.currentTarget ),
                    val = $target.attr( 'data-value' ),
                    $inp = $target.find( 'input' ),
                    idx;

            if ( ( idx = options.indexOf( val ) ) > -1 ) {
                options.splice( idx, 1 );
                setTimeout( function() { $inp.prop( 'checked', false ) }, 0);
            } else {
                options.push( val );
                setTimeout( function() { $inp.prop( 'checked', true ) }, 0);
            }

            $( event.target ).blur();

            console.log( options );
            return false;
        });


        document.getElementById("estado").onchange = function(){
            var idUf = $('#estado option:selected').val();
            //console.log("Loggggggg "+idUf);
            if(idUf=="null"){
                $("#municipio").empty()
            }
            $.ajax({
                url: '${createLink(action: 'cidadePorEstado',controller:'cidade')}',
                type: 	'POST',
                data: 	{
                    ajax: true,
                    id: idUf
                },
                success: function (result) {
                    console.log(result);
                    //console.log($("#municipio"));
                    $("#municipio").empty()
                    $("#municipio").append(result);

                }
            });

        }



        $("#financiador").change(function () {
            var financiadorID_selected = $(this).find("option:selected")[0].value;

            $.ajax({
                type: 'GET',
                dataType: 'json',
                url: '${createLink(action: 'getResponsaveis',controller:'financiador')}',
                data: {
                    idFinanciador: financiadorID_selected
                },
                complete: function (response) {
                    if (response.status == 200) {
                        atualizarSelectResponsaveis(response.responseJSON)
                    }
                }
            })
        });




    });
</script>
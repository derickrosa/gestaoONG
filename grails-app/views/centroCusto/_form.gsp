<%@ page import="com.acception.cadastro.enums.TipoCusto; com.acception.cadastro.enums.Moeda; com.acception.cadastro.Responsavel; com.acception.cadastro.Financiador; com.acception.cadastro.enums.StatusProjeto; com.acception.cadastro.CentroCusto" %>

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
</style>

<div id="wizard">
    <h2>Dados Básicos</h2>
    <section>
        <div class="row">
            <div class="col-md-4">
                <div class="form-group ${hasErrors(bean: centroCustoInstance, field: 'codigo', 'has-error')}">
                    <label for="codigo">
                        <g:message code="centroCusto.codigo.label" default="Código"/>

                    </label>
                    <g:textField class="form-control required" required="required" name="codigo" value="${centroCustoInstance?.codigo}"/>

                </div>
            </div>

            <div class="col-md-8">
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
            <div class="col-md-6">
                <div class="form-group">
                    <label for="financiador">Financiador</label>

                    <g:select class="form-control" required="required" name="financiador" from="${Financiador.list()}"
                              optionKey="id" value="${centroCustoInstance.financiador?.id}"
                              noSelection="['': 'Selecione um financiador...']"/>
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <label for="responsavel">Responsável</label>

                    <g:if test="${centroCustoInstance.financiador}">
                        <g:select name="responsavel" class="form-control"
                                  from="${Responsavel.findAllByFinanciador(centroCustoInstance.financiador)}"
                                  optionKey="id" noSelection="['': 'Selecione um responsável...']"
                                  value="${centroCustoInstance.responsavel.id}"/>
                    </g:if>
                    <g:else>
                        <select id="responsavel" required="required" name="responsavel" class="form-control">
                            <option disabled>Selecione um responsável...</option>
                        </select>
                    </g:else>

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

            <input type="hidden" id="previousPlanoDeTrabalho" name="previousPlanoDeTrabalho"
                   value="${centroCustoInstance.planoDeTrabalho?.id}">
            <input type="hidden" id="numFilesUploaded" name="numFilesUploaded"
                   value="${centroCustoInstance.planoDeTrabalho ? 1 : 0}">
            <input type="file" id="planoDeTrabalho" name="planoDeTrabalho">
        </div>
    </section>
    <h2>Orçamento</h2>
    <section>
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-primary">
                    <div class="panel-heading control-label">
                        Orçamento
                    </div>

                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-4 form-group">
                                <label for="orcamento.ano">Ano</label>

                                <input type="number" min="0" id="orcamento.ano" name="orcamento.ano" class="form-control"
                                       value="${centroCustoInstance.orcamento?.ano}" required>
                            </div>

                            <div class="col-md-4 form-group">
                                <label for="valorTotalOrcamento">Valor Total</label>

                                <input type="text" id="valorTotalOrcamento" name="valorTotalOrcamento"
                                       class="form-control currency"
                                       required>
                            </div>

                            <div class="col-md-4 form-group">
                                <label for="orcamento.moeda">Moeda</label>

                                <g:select class="form-control" name="orcamento.moeda" from="${Moeda.values()}"
                                          keys="${Moeda.values()*.name()}"
                                          value="${centroCustoInstance.orcamento?.moeda?.name()}" required="required"/>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-primary">
                    <div class="panel-heading control-label">
                        Itens Orçamentários
                    </div>

                    <div class="panel-body">
                        <div id="itensOrcamentarios"></div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<!-- PAGE LEVEL SCRIPTS -->
<script src="${assetPath(src: 'jquery.cookie-1.3.1.js')}"></script>
<script src="${assetPath(src: 'jquery.steps.js')}"></script>
<script src="${assetPath(src: 'WizardInitCentroCusto.js')}"></script>

<script>
    var atualizarValorTotalOrcamento = function () {
        var valorTotalOrcamento = ${centroCustoInstance.orcamento?.valorTotal ?: 0};

        if (valorTotalOrcamento) {
            $("[name='valorTotalOrcamento']").maskMoney('mask', valorTotalOrcamento)
        }
    };

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

        $.ajax({
            url: '${createLink(action: 'getItensOrcamentarios',controller:'centroCusto')}',
            type: 'POST',
            data: {
                idOrcamento: '${centroCustoInstance.orcamento?.id}'
            },
            complete: function (result) {
                if (result.responseText !== '{}') {
                    if (result.responseText == '[]') {
                        table.loadJsonData('[["",""]]');
                    }
                    else {
                        table.loadJsonData(result.responseText);
                    }

                    atualizarValoresItensOrcamentarios();
                }

                var select_tipo_custo = $('[name="itensOrcamento.tipoCusto"]');

                <g:applyCodec encodeAs="none">
                var dados = ${raw(TipoCusto.getDadosJSON())};
                </g:applyCodec>

                $.each(select_tipo_custo, function(index, element) {
                    $.each(dados, function (index, value) {
                        $(element).append($("<option></option>")
                                .attr("value", value.key).text(value.descricao));
                    });
                })
            }
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
        initializeMoneyMask();

        initializeDatepicker();

        initializeFileInput();

        initializeTableItensOrcamentarios();

        atualizarValorTotalOrcamento();

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

<!-- END PAGE LEVEL SCRIPTS -->
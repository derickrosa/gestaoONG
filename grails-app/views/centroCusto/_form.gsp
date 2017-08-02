<%@ page import="com.acception.cadastro.enums.TipoContaBancaria; com.acception.cadastro.enums.TipoCusto; com.acception.cadastro.enums.Moeda; com.acception.cadastro.Responsavel; com.acception.cadastro.Financiador; com.acception.cadastro.enums.StatusProjeto; com.acception.cadastro.CentroCusto" %>

<asset:stylesheet src="bootstrap-datepicker.css"/>
<asset:javascript src="plugins/bootstrap/bootstrap-datepicker.min.js"/>
<asset:javascript src="plugins/bootstrap/bootstrap-datepicker.pt-BR.js"/>

<asset:stylesheet src="fileinput.min.css"/>
<asset:javascript src="plugins/fileinput/fileinput.min.js"/>
<asset:javascript src="plugins/fileinput/locales/pt-BR.js"/>

<asset:javascript src="plugins/jquery/jquery.maskMoney.min.js"/>
<asset:javascript src="plugins/jquery/jquery.validate.js"/>

<asset:javascript src="jquery.edittable2.js"/>

<style>
    .addFuncionarios {
        position: relative;
        top: 2px;
    }

    #itensOrcamentarios td {
        padding: 5px
    }

    #itensOrcamentarios td:nth-child(1), #itensOrcamentarios td:nth-child(3){
        width: 15%;
    }

    #itensOrcamentarios td:nth-child(4) {
        width: 20%;
    }

    #itensOrcamentarios td:last-child {
        width: 10%;
    }

    #listaFuncionariosTable td:first-child {
        width: 50%;
    }

    #listaFuncionariosTable .addFuncionarios {
        display: none;
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
                    <g:field type="number" class="form-control required" maxlength="4" required="required" name="codigo" value="${centroCustoInstance?.codigo}"/>

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
                    <g:field class="form-control" id="ano" required="required" name="ano" type="number" min="0"
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
                            <div class="col-md-3 form-group">
                                <label for="orcamento.ano">Ano</label>

                                <input type="number" min="0" id="orcamento.ano" name="orcamento.ano" class="form-control"
                                       value="${centroCustoInstance.orcamentoAtual?.ano}" required>
                            </div>

                            <div class="col-md-3 form-group">
                                <label for="valorTotalOrcamento">Valor Total</label>

                                <input type="text" id="valorTotalOrcamento" name="valorTotalOrcamento"
                                       class="form-control currency"
                                       required value="${centroCustoInstance.orcamentoAtual?.valorTotal}">
                            </div>

                            <div class="col-md-3 form-group">
                                <label for="orcamento.moeda">Moeda</label>

                                <g:select class="form-control" name="orcamento.moeda" from="${Moeda.values()}"
                                          keys="${Moeda.values()*.name()}"
                                          value="${centroCustoInstance.orcamentoAtual?.moeda?.name()}" required="required"/>

                            </div>

                            <div class="col-md-3 form-group">
                                <label for="valorCambialOrcamento">Valor Cambial</label>

                                <input type="text" id="valorCambialOrcamento" name="valorCambialOrcamento"
                                       class="form-control currency"
                                       required value="${centroCustoInstance.orcamentoAtual?.valorCambial}
                                ">
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

    <h2>Conta Bancária</h2>
    <section>
        <div class="row">
            <div class="col-md-6 form-group">
                <label>Banco</label>
                <g:select class="form-control" name="contaBancaria.banco.id" from="${com.acception.cadastro.Banco.list()}"
                          required="required" noSelection="['': 'Selecione um banco...']" optionKey="id" value="${centroCustoInstance.contaBancaria?.banco?.id}"/>
            </div>

            <div class="col-md-6 form-group">
                <label>Tipo Conta</label>
                <g:select class="form-control" name="contaBancaria.tipoConta" from="${TipoContaBancaria.values()}"
                          required="required" noSelection="['': 'Selecione um tipo...']" keys="${TipoContaBancaria.values()*.name()}"
                          optionValue="nome" value="${centroCustoInstance.contaBancaria?.tipoConta?.name()}"/>
            </div>
        </div>

        <div class="row">
            <div class="col-md-4 form-group">
                <label>Agência</label>
                <g:field type="number" name="contaBancaria.agencia" class="form-control" required="required" value="${centroCustoInstance.contaBancaria?.agencia}"/>
            </div>

            <div class="col-md-2 form-group">
                <label>Dígito Agência</label>
                <g:field type="text" maxlength="2" name="contaBancaria.dvAgencia" class="form-control" required="required" value="${centroCustoInstance.contaBancaria?.dvAgencia}"/>
            </div>

            <div class="col-md-4 form-group">
                <label>Conta</label>
                <g:field type="number" name="contaBancaria.conta" class="form-control" required="required" value="${centroCustoInstance.contaBancaria?.conta}"/>
            </div>

            <div class="col-md-2 form-group">
                <label>Dígito Conta</label>
                <g:field type="text" maxlength="2" name="contaBancaria.dvConta" class="form-control" required="required" value="${centroCustoInstance.contaBancaria?.dvConta}"/>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6 form-group">
                <label>Saldo</label>
                <g:textField name="contaBancaria.saldo" class="form-control currency" required="required" value="${centroCustoInstance.contaBancaria?.saldo}" data-allow-zero="true"/>
            </div>
        </div>
    </section>
</div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Adicionar Funcionários</h4>
            </div>
            <div class="modal-body">
                <div id="listaFuncionariosTable"></div>

                <input type="hidden" id="id-inputListaFuncionarios">
                <input type="hidden" id="id-inputListaFuncionariosSalario">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="salvarAlteracoesListaFuncionariosItemOrcamentario()">Salvar Alterações</button>
            </div>
        </div>
    </div>
</div>

<script>
    var form = $("#form");
    form.validate({
        errorPlacement: function errorPlacement(error, element) { element.before(error); },
        rules: {
            codigo: {
                minlength: 4
            }
        }
    });
</script>

<!-- PAGE LEVEL SCRIPTS -->
<script src="${assetPath(src: 'jquery.cookie-1.3.1.js')}"></script>
<script src="${assetPath(src: 'jquery.steps.js')}"></script>
<script src="${assetPath(src: 'WizardInitCentroCusto.js')}"></script>

<script>
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
        var id = 0;

        var html = `<g:select class='form-control' from='${com.acception.cadastro.enums.TipoCusto.values()}'
                    name='itensOrcamento.tipoCusto' keys="${com.acception.cadastro.enums.TipoCusto.values()*.name()}"/>`

        var table = $("#itensOrcamentarios").editTable({
            field_templates: {
                'id': {
                    type: 'hidden',
                    _class: '',
                    getValue: function (input) {
                        return $(input).val();
                    },
                    setValue: function (input, value) {
                        return $('<input type="' +  this.type + '" name="itensOrcamento.id" class="' + this._class + '" ' +
                                'value="' + id + '">');
                    }
                },

                'codigo': {
                    type: 'text',
                    name: 'itensOrcamento.codigo',
                    _class: 'form-control',
                    getValue: function (input) {
                        return $(input).val();
                    },
                    setValue: function (input, value) {
                        return $('<input type="' +  this.type + '" name="' + this.name +'" class="' + this._class + ' " value="' + value + '">');
                    }
                },

                'nome': {
                    type: 'text',
                    name: 'itensOrcamento.nome',
                    _class: 'form-control',
                    getValue: function (input) {
                        return $(input).val();
                    },
                    setValue: function (input, value) {
                        return $('<input type="' +  this.type + '" name="' + this.name +'" class="' + this._class + ' " value="' + value + '">');
                    }
                },

                'currency': {
                    type: 'text',
                    name: 'itensOrcamento.valor',
                    _class: 'form-control currency text-center',
                    getValue: function (input) {
                        return $(input).val();
                    },
                    setValue: function (input, value) {
                        return $('<input type="' +  this.type + '" name="' + this.name +'" class="' + this._class + ' " value="' + value + '">');
                    }
                },

                'tipoCusto': {
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
                },

                'listaFuncionarios': {
                    type: 'hidden',
                    name: 'itensOrcamento.listaFuncionarios',
                    _class: 'itensOrcamento.listaFuncionarios',
                    getValue: function (input) {
                        return $(input).val();
                    },
                    setValue: function (input, value) {
                        id += 1;

                        return $('<input type="' +  this.type + '" name="' + this.name + '_' + id +'" class="' + this._class + '" ' +
                                'value="' + value + '" id="listaFuncionarios_' + id +'">');
                    }
                },

                'listaFuncionariosSalario': {
                    type: 'hidden',
                    name: 'itensOrcamento.listaFuncionariosSalario',
                    _class: 'itensOrcamento.listaFuncionariosSalario',
                    getValue: function (input) {
                        return $(input).val();
                    },
                    setValue: function (input, value) {
                        return $('<input type="' +  this.type + '" name="' + this.name + '_' + id +'" class="' + this._class + '" ' +
                                'value="' + value + '" id="listaFuncionariosSalario_' + id +'">');
                    }
                },
            },
            row_template: ['codigo', 'nome', 'currency', 'tipoCusto', 'listaFuncionarios', 'listaFuncionariosSalario', 'id'],
            headerCols: ['Código', 'Nome', 'Valor', 'Tipo Custo'],
            first_row: false,
        });

        $("#itensOrcamentarios").on("focusin", "td:nth-child(3) input", function () {
            $(this).maskMoney({prefix: 'R$ ', allowNegative: true, thousands: '.', decimal: ',', affixesStay: false});
        });

        $.ajax({
            url: '${createLink(action: 'getItensOrcamentarios',controller:'centroCusto')}',
            type: 'POST',
            data: {
                idOrcamento: '${centroCustoInstance.orcamentoAtual?.id}'
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

    var openModalFuncionarios = function (element) {
        var tableRow = $(element).parent().parent();

        var tipoCusto = tableRow.find("[name='itensOrcamento.tipoCusto']").val();

        if (tipoCusto !== 'PESSOAL') {
            swal(
                    'Oops...',
                    'Para adicionar funcionários, selecione o tipo de custo como "Pessoal" primeiramente.',
                    'error'
            );
            return;
        }

        var listaFuncionariosInput = tableRow.find("[class='itensOrcamento.listaFuncionarios']");
        var listaFuncionariosSalarioInput = tableRow.find("[class='itensOrcamento.listaFuncionariosSalario']");

        var listaFuncionarios = listaFuncionariosInput.val().split(',');
        var listaFuncionariosSalario = listaFuncionariosSalarioInput.val().split('-');

        var tableData = [];

        for (var i = 0; i < listaFuncionarios.length; i++){
            tableData.push([listaFuncionarios[i], listaFuncionariosSalario[i]])
        }

        $('#id-inputListaFuncionarios').val(listaFuncionariosInput[0].id);
        $('#id-inputListaFuncionariosSalario').val(listaFuncionariosSalarioInput[0].id);

        $('#myModal').modal('show');

        tableFuncionarios.loadData(tableData);

        $('[name=funcionario]').chosen();
    };

    var salvarAlteracoesListaFuncionariosItemOrcamentario = function() {
        var funcionarios = $('select[name="funcionario"]');
        var salarios = $('input[name="valor"]');

        var listaIDsFuncionarios = [];

        for (var i = 0; i < funcionarios.length; i++) {
            listaIDsFuncionarios.push($(funcionarios[i]).val())
        }

        var listaSalarios = [];

        for (var i = 0; i < salarios.length; i++) {
            listaSalarios.push($(salarios[i]).val());
        }

        var idInputListaFuncionarios = $('#id-inputListaFuncionarios').val();
        var idInputListaFuncionariosSalario = $('#id-inputListaFuncionariosSalario').val();

        $('#' + idInputListaFuncionarios).val(listaIDsFuncionarios.join(','));
        $('#' + idInputListaFuncionariosSalario).val(listaSalarios.join('-'));
    };

    var tableFuncionarios;

    var initializeTableFuncionarios = function () {
        var html = `<g:select class='form-control' from='${com.acception.cadastro.Funcionario.list()}'
                    name='funcionario' optionKey="id" data-placeholder='Selecione um funcionário...' noSelection="['': '']"/>`

        var tableElement = $("#listaFuncionariosTable");

        tableFuncionarios = tableElement.editTable({
            field_templates: {
                'currency': {
                    type: 'text',
                    name: 'valor',
                    _class: 'form-control currency text-center',
                    getValue: function (input) {
                        return $(input).val();
                    },
                    setValue: function (input, value) {
                        return $('<input type="' +  this.type + '" name="' + this.name +'" class="' + this._class + ' " value="' + value + '">');
                    }
                },

                'funcionario': {
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
                },
            },
            row_template: ['funcionario', 'currency'],
            headerCols: ['Funcionário', 'Valor'],
            first_row: false,
        });

        tableElement.on("focusin", "td:nth-child(2) input", function () {
            $(this).maskMoney({prefix: 'R$ ', allowNegative: true, thousands: '.', decimal: ',', affixesStay: false});
        });

        $.ajax({
            url: '${createLink(action: 'getItensOrcamentarios',controller:'centroCusto')}',
            type: 'POST',
            data: {
                idOrcamento: '${centroCustoInstance.orcamentoAtual?.id}'
            },
            complete: function (result) {
                if (result.responseText !== '{}') {
                    if (result.responseText == '[]') {
                        tableFuncionarios.loadJsonData('[["",""]]');
                    }
                    else {
                        tableFuncionarios.loadJsonData(result.responseText);
                    }

                    atualizarValoresItensOrcamentarios();
                }
            }
        });
    };

    $(function () {
        initializeDatepicker();

        initializeFileInput();

        initializeTableItensOrcamentarios();

        initializeTableFuncionarios();

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

        $("#orcamento\\.moeda").change(function () {
            if ($(this).val() === "REAL") {
                $("#valorCambialOrcamento").prop("disabled", true)
                                            .maskMoney('mask', 1)
            } else {
                $("#valorCambialOrcamento").prop("disabled", false)
            }
        });

        $("#orcamento\\.moeda").change();

        $("#contaBancaria\\.saldo").maskMoney({
            prefix: 'R$ ',
            decimal: ',',
            thousands: '.',
            affixesStay: false,
            allowZero: true
        });
    });
</script>

<!-- END PAGE LEVEL SCRIPTS -->
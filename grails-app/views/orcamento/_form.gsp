<%@ page import="com.acception.cadastro.enums.Moeda; com.acception.cadastro.Orcamento" %>

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
</style>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-primary">
            <div class="panel-heading control-label">
                Orçamento
            </div>

            <div class="panel-body">
                <div class="row">
                    <g:if test="${params?.orcamentoAnterior}">
                        <input type="hidden" name="orcamentoAnterior" value="${params?.orcamentoAnterior}">
                    </g:if>


                    <div class="col-md-3 form-group">
                        <label for="orcamento.ano">Ano</label>

                        <input type="number" min="0" id="orcamento.ano" name="orcamento.ano" class="form-control"
                               value="${orcamentoInstance?.ano}" required>
                    </div>

                    <div class="col-md-3 form-group">
                        <label for="valorTotalOrcamento">Valor Total</label>

                        <input type="text" id="valorTotalOrcamento" name="valorTotalOrcamento"
                               class="form-control currency"
                               required value="${orcamentoInstance.valorTotal}">
                    </div>

                    <div class="col-md-3 form-group">
                        <label for="orcamento.moeda">Moeda</label>

                        <g:select class="form-control" name="orcamento.moeda" from="${Moeda.values()}"
                                  keys="${com.acception.cadastro.enums.Moeda.values()*.name()}"
                                  value="${orcamentoInstance?.moeda?.name()}" required="required"/>

                    </div>

                    <div class="col-md-3 form-group">
                        <label for="valorCambialOrcamento">Valor Cambial</label>

                        <input type="text" id="valorCambialOrcamento" name="valorCambialOrcamento"
                               class="form-control currency"
                               required value="${orcamentoInstance.valorCambial}">
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

        var idOrcamento = "${params?.orcamentoAnterior ?: orcamentoInstance.id}";

        var isEditForm = ${orcamentoInstance.id ? true : false};

        if (idOrcamento){
            $.ajax({
                url: '${createLink(action: 'getItensOrcamentarios', controller: 'orcamento')}',
                type: 'POST',
                data: {
                    idOrcamento: idOrcamento
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
        }
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
    };

    $(function () {
        initializeTableItensOrcamentarios();

        initializeTableFuncionarios();
    });
</script>

%{--




<div class="form-group fieldcontain ${hasErrors(bean: orcamentoInstance, field: 'orcamentoReplanejado', 'error')} ">
    <label for="orcamentoReplanejado">
        <g:message code="orcamento.orcamentoReplanejado.label" default="Orcamento Replanejado"/>
        
    </label>
    <g:select class="form-control" id="orcamentoReplanejado" name="orcamentoReplanejado.id" from="${com.acception.cadastro.Orcamento.list()}" optionKey="id" value="${orcamentoInstance?.orcamentoReplanejado?.id}" class="form-control" noSelection="['null': '']"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: orcamentoInstance, field: 'ano', 'error')} ">
    <label for="ano">
        <g:message code="orcamento.ano.label" default="Ano"/>
        
    </label>
    <g:field class="form-control" id="ano" name="ano" type="number" value="${orcamentoInstance.ano}"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: orcamentoInstance, field: 'centroCusto', 'error')} ">
    <label for="centroCusto">
        <g:message code="orcamento.centroCusto.label" default="Centro Custo"/>
        
    </label>
    <g:select class="form-control" id="centroCusto" name="centroCusto.id" from="${com.acception.cadastro.CentroCusto.list()}" optionKey="id" value="${orcamentoInstance?.centroCusto?.id}" class="form-control" noSelection="['null': '']"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: orcamentoInstance, field: 'itensOrcamentarios', 'error')} ">
    <label for="itensOrcamentarios">
        <g:message code="orcamento.itensOrcamentarios.label" default="Itens Orcamentarios"/>
        
    </label>
    
<ul class="list-group">
<g:each in="${orcamentoInstance?.itensOrcamentarios?}" var="i">
    <li class="list-group"><g:link controller="itemOrcamentario" action="show" id="${i.id}">${i?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="list-group active">
<g:link controller="itemOrcamentario" action="create" params="['orcamento.id': orcamentoInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'itemOrcamentario.label', default: 'ItemOrcamentario')])}</g:link>
</li>
</ul>


</div>

<div class="form-group fieldcontain ${hasErrors(bean: orcamentoInstance, field: 'moeda', 'error')} ">
    <label for="moeda">
        <g:message code="orcamento.moeda.label" default="Moeda"/>
        
    </label>
    <g:select name="moeda" from="${com.acception.cadastro.enums.Moeda?.values()}" class="form-control" keys="${com.acception.cadastro.enums.Moeda.values()*.name()}" value="${orcamentoInstance?.moeda?.name()}"  noSelection="['': '']"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: orcamentoInstance, field: 'valorCambial', 'error')} ">
    <label for="valorCambial">
        <g:message code="orcamento.valorCambial.label" default="Valor Cambial"/>
        
    </label>
    <g:field class="form-control" id="valorCambial" name="valorCambial" value="${fieldValue(bean: orcamentoInstance, field: 'valorCambial')}"/>

</div>

<div class="form-group fieldcontain ${hasErrors(bean: orcamentoInstance, field: 'valorTotal', 'error')} ">
    <label for="valorTotal">
        <g:message code="orcamento.valorTotal.label" default="Valor Total"/>
        
    </label>
    <g:field class="form-control" id="valorTotal" name="valorTotal" value="${fieldValue(bean: orcamentoInstance, field: 'valorTotal')}"/>

</div>

--}%

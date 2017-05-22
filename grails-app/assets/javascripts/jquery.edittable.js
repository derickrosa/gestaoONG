/*! editTable v0.2.0 by Alessandro Benoit */
(function ($, window, i) {

    'use strict';

    $.fn.editTable = function (options) {

        // Settings
        var s = $.extend({
                data: [['']],
                tableClass: 'inputtable',
                jsonData: false,
                headerCols: false,
                maxRows: 999,
                first_row: true,
                parcelas: false,
                financiador: false,
                responsaveisLegaisOrganizacaoProponente: false,
                responsaveisLegaisOrganizacaoParceiraJuridica: false,
                emailsOrganizacaoProponente: false,
                telefonesOrganizacaoProponente: false,
                emailsOrganizacaoParceiraJuridica: false,
                tableDatasPrevistas: false,
                telefonesOrganizacaoParceiraJuridica: false,
                visitasMonitoramento: false,
                organizacao: false,
                row_template: false,
                names: false,
                deleteParcelaViaAjax: false,
                planejamentoOrcamentoarioId: false,
                field_templates: false,
                validate_field: function (col_id, value, col_type, $element) {
                    return true;
                }
            }, options),
            $el = $(this),
            defaultTableContent = '<thead><tr></tr></thead><tbody></tbody>',
            $table = $('<table class="table table-striped table-bordered table-hover"/>', {
                class: s.tableClass + ((s.first_row) ? ' wh' : ''),
                html: defaultTableContent
            }),
            defaultth = '<th><a class="addcol glyphicon glyphicon-plus" href="#">+</a> <a class="delcol glyphicon glyphicon-trash" href="#">-</a></th>',
            colnumber,
            rownumber,
            reset,
            is_validated = true;

        // Increment for IDs
        i = i + 1;

        // Build cell
        function buildCell(content, type) {

            content = (content === 0) ? "0" : (content || '');
            // Custom type
            if (type && 'text' !== type) {
                var field = s.field_templates[type];

                return '<td>' + field.setValue(field.html, content)[0].outerHTML + '</td>';
            }
            // Default
            return '<td><input type="text" class="form-control" value="' + content.toString().replace(/"/g, "&quot;") + '" /></td>';
        }

        // Build cell
        function buildCellUpdated(content, type, i) {

            var name = s.names[i]
            content = (content === 0) ? "0" : (content || '');
            // Custom type
            if (type && 'text' !== type) {
                var field = s.field_templates[type];
                return '<td>' + field.setValue(field.html, content)[0].outerHTML + '</td>';
            }
            // Default
            var htmlDefined = '<td><input type="text" name="' + name + '" class="form-control" value="' + content + '" /></td>';

            return htmlDefined
        }

        // Build cell
        function buildCellAjax(content, type, i) {
            var name = s.names[i]
            content = (content === 0) ? "0" : (content || '');
            // Custom type
            if (type && 'text' !== type) {
                var field = s.field_templates[type];
                if (name == 'parcelasOrcamento.numeroParcela')
                    return '<td>' + '<input type="text" style="text-align:center;" name="' + name + '" class="form-control" value="' + content + '" />' + '</td>';
                else if (name == 'parcelasOrcamento.valorRepassado') {
                    var valorRepassado = content.toLocaleString('pt-BR', {minimumFractionDigits: 2});
                    return '<td>' + '<input type="text" name="' + name + '" class="form-control currency text-center" value="' + valorRepassado + '" />' + '</td>';
                } else if (name == 'parcelasOrcamento.dataRepasseExecutada') {
                    return '<td>' + '<input type="text" name="' + name + '" class="form-control datepicker text-center" value="' + content + '" />' + '</td>';
                } else if (name == 'listaResponsaveis.nome') {
                    return '<td>' + '<input type="text" name="' + name + '" class="form-control" required value="' + content + '" />' + '</td>';
                } else if (name == 'listaResponsaveis.email') {
                    return '<td>' + '<input type="text" name="' + name + '" class="form-control" placeholder="exemplo@mail.com" required value="' + content + '" />' + '</td>';
                } else if (name == 'listaResponsaveis.id') {
                    return '' + '<input type="hidden" name="' + name + '" value="' + content + '" />' + '';
                } else if (name == 'listaResponsaveis.telefone') {
                return '<td>' + '<input type="text" name="' + name + '" class="form-control phone" id="telefoneRaw" required value="' + content + '" />' + '</td>';
                } else if (name == 'parcelasOrcamento.dataMaximaPrestacaoContas') {
                    return '<td>' + '<input type="text" name="' + name + '" class="form-control datepicker text-center" value="' + content + '" />' + '</td>';
                } else if (name == 'dataPrevistaTerminoProjeto') {
                    return '<td>' + '<input type="text" style="text-align:center;" name="' + name + '" class="form-control" value="' + content + '" />' + '</td>';
                } else if (name == 'solicitacoes.ano') {
                    return '<td >' + '<input type="text"  name="' + name + '" class="form-control" value="' + content + '" />' + '</td>';
                } else if (name == 'solicitacoes.descricao') {
                    return '<td>' + '<input type="text"name="' + name + '" class="form-control" value="' + content + '" />' + '</td>';
                } else if (name == 'responsaveisLegaisOrganizacaoProponente.cpfResponsavelLegal') {
                    return '<td style="width: 25%">' + '<input type="text"name="' + name + '" class="form-control cpf" value="' + content + '" />' + '</td>';
                } else if (name == 'responsaveisLegaisOrganizacaoProponente.nomeResponsavelLegal') {
                    return '<td style="width: 70%">' + '<input type="text"name="' + name + '" class="form-control" value="' + content + '" />' + '</td>';
                } else if (name == 'coordenadoresProjetoOrganizacaoProponente.cpfCoordenadorProjeto') {
                    return '<td style="width: 25%">' + '<input type="text"name="' + name + '" class="form-control cpf" value="' + content + '" />' + '</td>';
                } else if (name == 'coordenadoresProjetoOrganizacaoProponente.nomeCoordenadorProjeto') {
                    return '<td style="width: 70%">' + '<input type="text"name="' + name + '" class="form-control" value="' + content + '" />' + '</td>';
                } else if (name == 'responsaveisLegaisOrganizacaoParceiraJuridica.cpfResponsavelLegal') {
                    return '<td style="width: 25%">' + '<input type="text"name="' + name + '" class="form-control cpf" value="' + content + '" />' + '</td>';
                } else if (name == 'responsaveisLegaisOrganizacaoParceiraJuridica.nomeResponsavelLegal') {
                    return '<td style="width: 70%">' + '<input type="text"name="' + name + '" class="form-control" value="' + content + '" />' + '</td>';
                } else if (name == 'emailsOrganizacaoProponente.email') {
                    return '<td>' + '<input type="text"name="' + name + '" class="form-control" value="' + content + '" />' + '</td>';
                } else if (name == 'telefonesOrganizacaoProponente.ddd') {
                    return '<td style="width: 25%">' + '<input type="text"name="' + name + '" class="form-control" value="' + content + '" />' + '</td>';
                } else if (name == 'telefonesOrganizacaoProponente.telefone') {
                    return '<td style="width: 60%">' + '<input type="text"name="' + name + '" class="form-control" value="' + content + '" />' + '</td>';
                } else if (name == 'emailsOrganizacaoParceiraJuridica.email') {
                    return '<td>' + '<input type="text"name="' + name + '" class="form-control" value="' + content + '" />' + '</td>';
                } else if (name == 'telefonesOrganizacaoParceiraJuridica.ddd') {
                    return '<td style="width: 25%">' + '<input type="text"name="' + name + '" class="form-control" value="' + content + '" />' + '</td>';
                } else if (name == 'telefonesOrganizacaoParceiraJuridica.telefone') {
                    return '<td style="width: 60%">' + '<input type="text"name="' + name + '" class="form-control" value="' + content + '" />' + '</td>';
                } else if (name == 'dataPrevistaTerminoProjeto') {
                    return '<td>' + '<input type="text"name="' + name + '" class="form-control  datepicker text-center" value="' + content + '" />' + '</td>';
                } else if (name == 'visitaMonitoramento.data') {
                    return '<td>' + '<input type="text"name="' + name + '" class="form-control datepicker" value="' + content + '" />' + '</td>';
                }else if (name == 'visitaMonitoramento.filedata') {
                    return '<td>' + '<input type="file" name="' + name + '" id="' + name + '" class="form-control" value="' + content + '" />' + '</td>';
                } else if (name == 'visitaMonitoramento.responsavel') {
                    return '<td>' + '<input type="text"name="' + name + '" class="form-control" value="' + content + '" />' + '</td>';
                } else if (name == 'visitaMonitoramento.observacao') {
                    return '<td>' + '<textarea type="text"name="' + name + '" class="form-control" value="' + content + '">' + content + '</textarea>' + '</td>';
                }
                else return '' + '<input type="hidden" name="listaResponsaveis.id" value="' + content + '" />' + '';
            }
            // Default
            var htmlDefined = '<input type="hidden" name="listaResponsaveis.id" value="' + content + '" />';
            return htmlDefined
        }

        // Build row
        function buildRow(data, len) {

            var rowcontent = '', b;

            data = data || '';

            if (!s.row_template) {
                // Without row template
                for (b = 0; b < (len || data.length); b += 1) {

                    rowcontent += buildCell(data[b]);
                }
            } else {
                // With row template
                for (b = 0; b < s.row_template.length; b += 1) {

                    // For each field in the row
                    rowcontent += buildCellUpdated(data[b], s.row_template[b], b);
                }
            }

            return $('<tr/>', {
                html: rowcontent + '<td class="text-center" style="font-size: large;">' +
                '<a class="addrow glyphicon glyphicon-plus" href="#" style=" color: green; ">' +
                '<i class="fa fa-plus-square fa-5" aria-hidden="true"></i>' +
                '</a> ' +
                '<a class="delrow glyphicon glyphicon-trash fa-5" href="#">' +
                '<i class="fa fa-trash" aria-hidden="true"></i>' +
                '</a>' +
                '</td>'
            });

        }

        // Build row
        function buildRowAjax(data, len) {

            var rowcontent = '', b;

            data = data || '';

            if (!s.row_template) {
                // Without row template
                console.log("Entrou data length")
                for (b = 0; b < (len || data.length); b += 1) {

                    rowcontent += buildCellAjax(data[b]);
                }
            } else {
                console.log("Entrou row template")
                // With row template
                for (b = 0; b < s.row_template.length + 1; b += 1) {

                    // For each field in the row
                    rowcontent += buildCellAjax(data[b], s.row_template[b], b);
                }
            }


            return $('<tr/>', {
                html: rowcontent + '<td class="text-center" style="font-size: large;">' +
                '<a class="addrow glyphicon glyphicon-plus" href="#" style=" color: green; ">' +
                '<i class="fa fa-plus-square fa-5" aria-hidden="true"></i>' +
                '</a> ' +
                '<a class="delrow glyphicon glyphicon-trash fa-5" href="#">' +
                '<i class="fa fa-trash" aria-hidden="true"></i>' +
                '</a>' +
                '</td>'
            });

        }

        // Check button status (enable/disabled)
        function checkButtons() {
            if (colnumber < 2) {
                $table.find('.delcol').addClass('disabled');
            }
            if (rownumber < 2) {
                $table.find('.delrow').addClass('disabled');
            }
            if (s.maxRows && rownumber === s.maxRows) {
                $table.find('.addrow').addClass('disabled');
            }
        }

        // Fill table with data
        function fillTableData(data) {

            var a, crow = Math.min(s.maxRows, data.length);

            // Clear table
            $table.html(defaultTableContent);

            // If headers or row_template are set
            if (s.headerCols || s.row_template) {

                // Fixed columns
                var col = s.headerCols || s.row_template;

                // Table headers
                for (a = 0; a < col.length; a += 1) {
                    var col_title = s.headerCols[a] || '';
                    $table.find('thead tr').append('<th class="text-center" >' + col_title + '</th>');

                }

                // Table content
                for (a = 0; a < crow; a += 1) {

                    // For each row in data
                    buildRowAjax(data[a], col.length).appendTo($table.find('tbody'));
                }

            } else if (data[0]) {

                // Variable columns
                for (a = 0; a < data[0].length; a += 1) {
                    $table.find('thead tr').append(defaultth);
                }

                for (a = 0; a < crow; a += 1) {
                    buildRowAjax(data[a]).appendTo($table.find('tbody'));
                }

            }

            // Append missing th
            $table.find('thead tr').append('<th></th>');

            // Count rows and columns
            colnumber = $table.find('thead th').length - 1;
            rownumber = $table.find('tbody tr').length;

            checkButtons();
        }

        // Fill table with data
        function fillTableDataAjax(data) {

            var a, crow = Math.min(s.maxRows, data.length);

            // Clear table
            $table.html(defaultTableContent);

            // If headers or row_template are set
            if (s.headerCols || s.row_template) {

                // Fixed columns
                var col = s.headerCols || s.row_template;

                // Table headers
                for (a = 0; a < col.length; a += 1) {
                    var col_title = s.headerCols[a] || '';
                    if (col_title[0] == 'N' && s.parcelas) {
                        $table.find('thead tr').append('<th class="text-center" style="width:80px;">' + col_title + '</th>');
                    } else {
                        $table.find('thead tr').append('<th class="text-center" >' + col_title + '</th>');
                    }

                }

                // Table content
                for (a = 0; a < crow; a += 1) {

                    // For each row in data
                    buildRowAjax(data[a], col.length).appendTo($table.find('tbody'));
                }

            } else if (data[0]) {

                // Variable columns
                for (a = 0; a < data[0].length; a += 1) {
                    $table.find('thead tr').append(defaultth);
                }

                for (a = 0; a < crow; a += 1) {
                    buildRowAjax(data[a]).appendTo($table.find('tbody'));
                }

            }

            // Append missing th
            $table.find('thead tr').append('<th></th>');

            // Count rows and columns
            colnumber = $table.find('thead th').length - 1;
            rownumber = $table.find('tbody tr').length;

            checkButtons();
        }

        // Export data
        function exportData() {
            var row = 0, data = [], value;

            is_validated = true;

            $table.find('tbody tr').each(function () {

                row += 1;
                data[row] = [];

                $(this).find('td:not(:last-child)').each(function (i, v) {
                    if (s.row_template && 'text' !== s.row_template[i]) {
                        var field = s.field_templates[s.row_template[i]],
                            el = $(this).find($(field.html).prop('tagName'));

                        value = field.getValue(el);
                        if (!s.validate_field(i, value, s.row_template[i], el)) {
                            is_validated = false;
                        }
                        data[row].push(value);
                    } else {
                        value = $(this).find('input[type="text"]').val();
                        if (!s.validate_field(i, value, 'text', v)) {
                            is_validated = false;
                        }
                        data[row].push(value);
                    }
                });

            });

            // Remove undefined
            data.splice(0, 1);

            return data;
        }

        // Fill the table with data from textarea or given properties
        if ($el.is('textarea')) {

            try {
                reset = JSON.parse($el.val());
            } catch (e) {
                reset = s.data;
            }

            $el.after($table);

            // If inside a form set the textarea content on submit
            if ($table.parents('form').length > 0) {
                $table.parents('form').submit(function () {
                    $el.val(JSON.stringify(exportData()));
                });
            }

        } else {
            reset = (JSON.parse(s.jsonData) || s.data);
            $el.append($table);
        }

        fillTableData(reset);

        // Add column
        $table.on('click', '.addcol', function () {

            var colid = parseInt($(this).closest('tr').children().index($(this).parent('th')), 10);

            colnumber += 1;

            $table.find('thead tr').find('th:eq(' + colid + ')').after(defaultth);

            $table.find('tbody tr').each(function () {
                $(this).find('td:eq(' + colid + ')').after(buildCell());
            });

            $table.find('.delcol').removeClass('disabled');

            return false;
        });

        // Remove column
        $table.on('click', '.delcol', function () {

            if ($(this).hasClass('disabled')) {
                return false;
            }

            var colid = parseInt($(this).closest('tr').children().index($(this).parent('th')), 10);

            colnumber -= 1;

            checkButtons();

            $(this).parent('th').remove();

            $table.find('tbody tr').each(function () {
                $(this).find('td:eq(' + colid + ')').remove();
            });

            return false;
        });

        // Add row
        $table.on('click', '.addrow', function () {

            if ($(this).hasClass('disabled')) {
                return false;
            }

            rownumber += 1;


            $(this).closest('tr').after(buildRow(0, colnumber));

            $table.find('.delrow').removeClass('disabled');

            checkButtons();

            return false;
        });

        // Delete row
        $table.on('click', '.delrow', function () {
            var click = $(this);
            if (s.parcelas == true) {
                swal({
                    title: "Você tem certeza?",
                    text: "Os relatórios e resultados cadastrados para essa parcela também serão removidos.",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "Sim, remover!",
                    cancelButtonText: "Cancelar",
                    imageSize: "80x80",
                    closeOnConfirm: false
                }, function () {
                    var parcela = click.closest('tr').find("input[name*='numeroParcela']")[0].value;

                    //Se o ID do Planejamento Orçamentário é diferente de vazio isso significa que ele já está cadastrado no sistema,
                    //logo, podemos tentar remover a parcela pois o objetivo Planejamento Orçamentário existe.

                    if (s.planejamentoOrcamentoarioId) {
                        $.ajax({
                            url: s.deleteParcelaViaAjax,
                            data: {
                                format: "json",
                                planejamentoOrcamentarioId: s.planejamentoOrcamentoarioId,
                                numeroParcela: parcela
                            },
                            dataType: 'json',
                            type: 'POST',
                            success: function (data) {
                                console.log(data[0].success);
                            },
                            error: function (request, status, error) {
                                console.log(error);
                            }
                        });
                    }

                    rownumber -= 1;

                    checkButtons();

                    click.closest('tr').remove();

                    $table.find('.addrow').removeClass('disabled');

                    swal("Removido!", "A parcela foi removida.", "success");

                    if (rownumber == 0) {
                        var rowcontent =
                                '<td>' +
                                '<input type="text" style="text-align:center;" name="parcelasOrcamento.numeroParcela" class="form-control" value="" />' +
                                '</td>' +
                                '<td>' +
                                '<input type="text" name="parcelasOrcamento.valorRepassado" class="form-control currency text-center" value="" />' +
                                '</td>' +
                                '<td>' +
                                '<input type="text" name="parcelasOrcamento.dataRepasseExecutada" class="form-control text-center" value="" />' +
                                '</td>' +
                                '<td>' +
                                '<input type="text" name="parcelasOrcamento.dataMaximaPrestacaoContas" class="form-control text-center" value="" />' +
                                '</td>'
                            ;
                        $('<tr/>', {
                            html: rowcontent + '<td class="text-center" style="font-size: large;text-align: center;">' +
                            '<a class="addrow glyphicon glyphicon-plus" href="#" style=" color: green; ">' +
                            '<i class="fa fa-plus-square fa-5" aria-hidden="true"></i>' +
                            '</a> ' +
                            '<a class="delrow glyphicon glyphicon-trash fa-5" href="#">' +
                            '<i class="fa fa-trash" aria-hidden="true"></i>' +
                            '</a>' +
                            '</td>'
                        }).appendTo($table.find('tbody'));
                    }
                    return false;

                });
            } else if (s.financiador) {
                swal({
                    title: "Você tem certeza?",
                    text: "O responsável selecionado será removido.",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#f44242",
                    confirmButtonText: "Sim, remover!",
                    cancelButtonText: "Cancelar",
                    imageSize: "80x80",
                    closeOnConfirm: true
                }, function () {
                    rownumber -= 1;
                    if (rownumber < 0)
                        rownumber = 1;
                    if (rownumber == 0) {
                        checkButtons();

                        click.closest('tr').remove();

                        $table.find('.addrow').removeClass('disabled');
                        var rowcontent =
                            '<td>' +
                            '<input type="text" name="listaResponsaveis.nome" class="form-control" value="" />' +
                            '</td>' +
                            '<td>' +
                            '<input type="text" name="listaResponsaveis.email" class="form-control" value="" />' +
                            '</td>' +
                            '<td>' +
                            '<input type="text" name="listaResponsaveis.telefone" class="form-control phone" id="telefoneRaw" value="" />' +
                            '</td>';

                        $('<tr/>', {
                            html: rowcontent +
                            '<td style="font-size: large;text-align: center;">' +
                            '<a class="addrow glyphicon glyphicon-plus" href="#" style=" color: green; ">' +
                            '<i class="fa fa-plus-square fa-5" aria-hidden="true"></i>' +
                            '</a> ' +
                            '<a class="delrow glyphicon glyphicon-trash fa-5" href="#">' +
                            '<i class="fa fa-trash" aria-hidden="true"></i>' +
                            '</a>' +
                            '</td>'
                        }).appendTo($table.find('tbody'));
                        rownumber = 1
                    } else if (rownumber > 0) {
                        checkButtons();

                        click.closest('tr').remove();

                        $table.find('.addrow').removeClass('disabled');
                    }
                    return false;
                });
            } else if (s.responsaveisLegaisOrganizacaoProponente) {
                swal({
                    title: "Você tem certeza?",
                    text: "O responsável legal será removido.",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#f44242",
                    confirmButtonText: "Sim, remover!",
                    cancelButtonText: "Cancelar",
                    imageSize: "80x80",
                    closeOnConfirm: true
                }, function () {
                    rownumber -= 1;
                    if (rownumber < 0)
                        rownumber = 1;
                    console.log(rownumber);
                    if (rownumber == 0) {
                        checkButtons();

                        click.closest('tr').remove();

                        $table.find('.addrow').removeClass('disabled');
                        var rowcontent =
                            '<td style="width:70%">' +
                            '<input type="text" name="responsaveisLegaisOrganizacaoProponente.nomeResponsavelLegal" class="form-control" value="" />' +
                            '</td>' +
                            '<td style="width:25%">' +
                            '<input type="text" name="responsaveisLegaisOrganizacaoProponente.cpfResponsavelLegal" class="form-control cpf" value="" />' +
                            '</td>';

                        $('<tr/>', {
                            html: rowcontent +
                            '<td style="font-size: large;text-align: center;">' +
                            '<a class="addrow glyphicon glyphicon-plus" href="#" style=" color: green; ">' +
                            '<i class="fa fa-plus-square fa-5" aria-hidden="true"></i>' +
                            '</a> ' +
                            '<a class="delrow glyphicon glyphicon-trash fa-5" href="#">' +
                            '<i class="fa fa-trash" aria-hidden="true"></i>' +
                            '</a>' +
                            '</td>'
                        }).appendTo($table.find('tbody'));
                        rownumber = 1
                    } else if (rownumber > 0) {
                        checkButtons();

                        click.closest('tr').remove();

                        $table.find('.addrow').removeClass('disabled');
                    }
                    return false;
                });
            } else if (s.coordenadoresProjetoOrganizacaoProponente) {
                swal({
                    title: "Você tem certeza?",
                    text: "O responsável legal será removido.",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#f44242",
                    confirmButtonText: "Sim, remover!",
                    cancelButtonText: "Cancelar",
                    imageSize: "80x80",
                    closeOnConfirm: true
                }, function () {
                    rownumber -= 1;
                    if (rownumber < 0)
                        rownumber = 1;
                    console.log(rownumber);
                    if (rownumber == 0) {
                        checkButtons();

                        click.closest('tr').remove();

                        $table.find('.addrow').removeClass('disabled');
                        var rowcontent =
                            '<td style="width:70%">' +
                            '<input type="text" name="coordenadoresProjetoOrganizacaoProponente.nomeCoordenadorProjeto" class="form-control" value="" />' +
                            '</td>' +
                            '<td style="width:25%">' +
                            '<input type="text" name="coordenadoresProjetoOrganizacaoProponente.cpfCoordenadorProjeto" class="form-control cpf" value="" />' +
                            '</td>';

                        $('<tr/>', {
                            html: rowcontent +
                            '<td style="font-size: large;text-align: center;">' +
                            '<a class="addrow glyphicon glyphicon-plus" href="#" style=" color: green; ">' +
                            '<i class="fa fa-plus-square fa-5" aria-hidden="true"></i>' +
                            '</a> ' +
                            '<a class="delrow glyphicon glyphicon-trash fa-5" href="#">' +
                            '<i class="fa fa-trash" aria-hidden="true"></i>' +
                            '</a>' +
                            '</td>'
                        }).appendTo($table.find('tbody'));
                        rownumber = 1
                    } else if (rownumber > 0) {
                        checkButtons();

                        click.closest('tr').remove();

                        $table.find('.addrow').removeClass('disabled');
                    }
                    return false;
                });
            } else if (s.responsaveisLegaisOrganizacaoParceiraJuridica) {
                swal({
                    title: "Você tem certeza?",
                    text: "O responsável legal será removido.",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "Sim, remover!",
                    cancelButtonText: "Cancelar",
                    imageSize: "80x80",
                    closeOnConfirm: true
                }, function () {
                    rownumber -= 1;
                    if (rownumber < 0)
                        rownumber = 1;
                    console.log(rownumber);
                    if (rownumber == 0) {
                        checkButtons();

                        click.closest('tr').remove();

                        $table.find('.addrow').removeClass('disabled');
                        var rowcontent =
                            '<td style="width:70%">' +
                            '<input type="text" name="responsaveisLegaisOrganizacaoParceiraJuridica.nomeResponsavelLegal" class="form-control" value="" />' +
                            '</td>' +
                            '<td style="width:25%">' +
                            '<input type="text" name="responsaveisLegaisOrganizacaoParceiraJuridica.cpfResponsavelLegal" class="form-control cpf" value="" />' +
                            '</td>';

                        $('<tr/>', {
                            html: rowcontent +
                            '<td style="font-size: large;text-align: center;">' +
                            '<a class="addrow glyphicon glyphicon-plus" href="#" style=" color: green; ">' +
                            '<i class="fa fa-plus-square fa-5" aria-hidden="true"></i>' +
                            '</a> ' +
                            '<a class="delrow glyphicon glyphicon-trash fa-5" href="#">' +
                            '<i class="fa fa-trash" aria-hidden="true"></i>' +
                            '</a>' +
                            '</td>'
                        }).appendTo($table.find('tbody'));
                        rownumber = 1
                    } else if (rownumber > 0) {
                        checkButtons();

                        click.closest('tr').remove();

                        $table.find('.addrow').removeClass('disabled');
                    }
                    return false;
                });
            } else if (s.emailsOrganizacaoProponente) {
                swal({
                    title: "Você tem certeza?",
                    text: "O e-mail será removido.",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "Sim, remover!",
                    cancelButtonText: "Cancelar",
                    imageSize: "80x80",
                    closeOnConfirm: true
                }, function () {
                    rownumber -= 1;
                    if (rownumber < 0)
                        rownumber = 1;
                    console.log(rownumber);
                    if (rownumber == 0) {
                        checkButtons();

                        click.closest('tr').remove();

                        $table.find('.addrow').removeClass('disabled');
                        var rowcontent =
                            '<td>' +
                            '<input type="text" name="emailsOrganizacaoProponente.email" class="form-control" value="" />' +
                            '</td>';

                        $('<tr/>', {
                            html: rowcontent +
                            '<td style="font-size: large;text-align: center;"">' +
                            '<a class="addrow glyphicon glyphicon-plus" href="#" style=" color: green; ">' +
                            '<i class="fa fa-plus-square fa-5" aria-hidden="true"></i>' +
                            '</a> ' +
                            '<a class="delrow glyphicon glyphicon-trash fa-5" href="#">' +
                            '<i class="fa fa-trash" aria-hidden="true"></i>' +
                            '</a>' +
                            '</td>'
                        }).appendTo($table.find('tbody'));
                        rownumber = 1
                    } else if (rownumber > 0) {
                        checkButtons();

                        click.closest('tr').remove();

                        $table.find('.addrow').removeClass('disabled');
                    }
                    return false;
                });
            } else if (s.emailsOrganizacaoParceiraJuridica) {
                swal({
                    title: "Você tem certeza?",
                    text: "O e-mail será removido.",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "Sim, remover!",
                    cancelButtonText: "Cancelar",
                    imageSize: "80x80",
                    closeOnConfirm: true
                }, function () {
                    rownumber -= 1;
                    if (rownumber < 0)
                        rownumber = 1;
                    console.log(rownumber);
                    if (rownumber == 0) {
                        checkButtons();

                        click.closest('tr').remove();

                        $table.find('.addrow').removeClass('disabled');
                        var rowcontent =
                            '<td>' +
                            '<input type="text" name="emailsOrganizacaoParceiraJuridica.email" class="form-control" value="" />' +
                            '</td>';

                        $('<tr/>', {
                            html: rowcontent +
                            '<td style="font-size: large;text-align: center;">' +
                            '<a class="addrow glyphicon glyphicon-plus" href="#" style=" color: green; ">' +
                            '<i class="fa fa-plus-square fa-5" aria-hidden="true"></i>' +
                            '</a> ' +
                            '<a class="delrow glyphicon glyphicon-trash fa-5" href="#">' +
                            '<i class="fa fa-trash" aria-hidden="true"></i>' +
                            '</a>' +
                            '</td>'
                        }).appendTo($table.find('tbody'));
                        rownumber = 1
                    } else if (rownumber > 0) {
                        checkButtons();

                        click.closest('tr').remove();

                        $table.find('.addrow').removeClass('disabled');
                    }
                    return false;
                });
            } else if (s.telefonesOrganizacaoProponente) {
                swal({
                    title: "Você tem certeza?",
                    text: "O telefone será removido.",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "Sim, remover!",
                    cancelButtonText: "Cancelar",
                    imageSize: "80x80",
                    closeOnConfirm: true
                }, function () {
                    rownumber -= 1;
                    if (rownumber < 0)
                        rownumber = 1;
                    console.log(rownumber);
                    if (rownumber == 0) {
                        checkButtons();

                        click.closest('tr').remove();

                        $table.find('.addrow').removeClass('disabled');
                        var rowcontent =
                            '<td>' +
                            '<input type="text" name="telefonesOrganizacaoProponente.ddd" class="form-control" value="" />' +
                            '</td>' +
                            '<td>' +
                            '<input type="text" name="telefonesOrganizacaoProponente.telefone" class="form-control" value="" />' +
                            '</td>';

                        $('<tr/>', {
                            html: rowcontent +
                            '<td style="font-size: large;text-align: center;">' +
                            '<a class="addrow glyphicon glyphicon-plus" href="#" style=" color: green; ">' +
                            '<i class="fa fa-plus-square fa-5" aria-hidden="true"></i>' +
                            '</a> ' +
                            '<a class="delrow glyphicon glyphicon-trash fa-5" href="#">' +
                            '<i class="fa fa-trash" aria-hidden="true"></i>' +
                            '</a>' +
                            '</td>'
                        }).appendTo($table.find('tbody'));
                        rownumber = 1
                    } else if (rownumber > 0) {
                        checkButtons();

                        click.closest('tr').remove();

                        $table.find('.addrow').removeClass('disabled');
                    }
                    return false;
                });
            } else if (s.telefonesOrganizacaoParceiraJuridica) {
                swal({
                    title: "Você tem certeza?",
                    text: "O telefone será removido.",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "Sim, remover!",
                    cancelButtonText: "Cancelar",
                    imageSize: "80x80",
                    closeOnConfirm: true
                }, function () {
                    rownumber -= 1;
                    if (rownumber < 0)
                        rownumber = 1;
                    console.log(rownumber);
                    if (rownumber == 0) {
                        checkButtons();

                        click.closest('tr').remove();

                        $table.find('.addrow').removeClass('disabled');
                        var rowcontent =
                            '<td>' +
                            '<input type="text" name="telefonesOrganizacaoParceiraJuridica.ddd" class="form-control" value="" />' +
                            '</td>' +
                            '<td>' +
                            '<input type="text" name="telefonesOrganizacaoParceiraJuridica.telefone" class="form-control" value="" />' +
                            '</td>';

                        $('<tr/>', {
                            html: rowcontent +
                            '<td style="font-size: large;text-align: center;">' +
                            '<a class="addrow glyphicon glyphicon-plus" href="#" style=" color: green; ">' +
                            '<i class="fa fa-plus-square fa-5" aria-hidden="true"></i>' +
                            '</a> ' +
                            '<a class="delrow glyphicon glyphicon-trash fa-5" href="#">' +
                            '<i class="fa fa-trash" aria-hidden="true"></i>' +
                            '</a>' +
                            '</td>'
                        }).appendTo($table.find('tbody'));
                        rownumber = 1
                    } else if (rownumber > 0) {
                        checkButtons();

                        click.closest('tr').remove();

                        $table.find('.addrow').removeClass('disabled');
                    }
                    return false;
                });
            } else if (s.visitasMonitoramento) {
                swal({
                    title: "Você tem certeza?",
                    text: "A viagem de monitoramento será removida.",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "Sim, remover!",
                    cancelButtonText: "Cancelar",
                    imageSize: "80x80",
                    closeOnConfirm: true
                }, function () {
                    rownumber -= 1;
                    if (rownumber < 0)
                        rownumber = 1;
                    console.log(rownumber);
                    if (rownumber == 0) {
                        checkButtons();

                        click.closest('tr').remove();

                        $table.find('.addrow').removeClass('disabled');
                        var rowcontent =
                            '<td>' +
                            '<input type="text" name="visitaMonitoramento.data" class="form-control datepicker" value="" />' +
                            '</td>' +
                            '<td>' +
                            '<input type="text" name="visitaMonitoramento.responsavel" class="form-control" value="" />' +
                            '</td>' +
                            '<td>' +
                            '<textarea type="text" name="visitaMonitoramento.observacao" class="form-control" value="" />' +
                            '</td>' +
                            '<td>' +
                            '<textarea type="file" id="visitaMonitoramento.filedata" name="visitaMonitoramento.filedata" class="form-control" value="" />' +
                            '</td>';

                        $('<tr/>', {
                            html: rowcontent +
                            '<td style="font-size: large;text-align: center;">' +
                            '<a class="addrow glyphicon glyphicon-plus" href="#" style=" color: green; ">' +
                            '<i class="fa fa-plus-square fa-5" aria-hidden="true"></i>' +
                            '</a> ' +
                            '<a class="delrow glyphicon glyphicon-trash fa-5" href="#">' +
                            '<i class="fa fa-trash" aria-hidden="true"></i>' +
                            '</a>' +
                            '</td>'
                        }).appendTo($table.find('tbody'));
                        rownumber = 1
                    } else if (rownumber > 0) {
                        checkButtons();

                        click.closest('tr').remove();

                        $table.find('.addrow').removeClass('disabled');
                    }
                    return false;
                });
            } else if (s.tableDatasPrevistas) {
                swal({
                    title: "Você tem certeza?",
                    text: "A data será removida.",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "Sim, remover!",
                    cancelButtonText: "Cancelar",
                    imageSize: "80x80",
                    closeOnConfirm: true
                }, function () {
                    rownumber -= 1;
                    if (rownumber < 0)
                        rownumber = 1;
                    console.log(rownumber);
                    if (rownumber == 0) {
                        checkButtons();

                        click.closest('tr').remove();

                        $table.find('.addrow').removeClass('disabled');
                        var rowcontent =
                            '<td>' +
                            '<input type="text" name="dataPrevistaTerminoProjeto" class="form-control datepicker text-center" value="" />' +
                            '</td>';

                        $('<tr/>', {
                            html: rowcontent +
                            '<td style="font-size: large;text-align: center;">' +
                            '<a class="addrow glyphicon glyphicon-plus" href="#" style=" color: green; ">' +
                            '<i class="fa fa-plus-square fa-5" aria-hidden="true"></i>' +
                            '</a> ' +
                            '<a class="delrow glyphicon glyphicon-trash fa-5" href="#">' +
                            '<i class="fa fa-trash" aria-hidden="true"></i>' +
                            '</a>' +
                            '</td>'
                        }).appendTo($table.find('tbody'));
                        rownumber = 1
                    } else if (rownumber > 0) {
                        checkButtons();

                        click.closest('tr').remove();

                        $table.find('.addrow').removeClass('disabled');
                    }
                    return false;
                });
            } else {

                rownumber -= 1;

                checkButtons();

                click.closest('tr').remove();

                $table.find('.addrow').removeClass('disabled');

                if (rownumber == 0) {
                    var rowcontent =
                        '<td>' +
                        '<input type="text" name="dataPrevistaTerminoProjeto" class="form-control" value="" />' +
                        '</td>';

                    $('<tr/>', {
                        html: rowcontent + '<td style="font-size: large;">' +
                        '<a class="addrow glyphicon glyphicon-plus" href="#" style=" color: green; ">' +
                        '<i class="fa fa-plus-square fa-5" aria-hidden="true"></i>' +
                        '</a> ' +
                        '<a class="delrow glyphicon glyphicon-trash fa-5" href="#">' +
                        '<i class="fa fa-trash" aria-hidden="true"></i>' +
                        '</a>' +
                        '</td>'
                    }).appendTo($table.find('tbody'));
                }
                return false;
            }
        });

        // Select all content on click
        $table.on('click', 'input', function () {
            $(this).select();
        });

        // Return functions
        return {
            // Get an array of data
            getData: function () {
                return exportData();
            },
            // Get the JSON rappresentation of data
            getJsonData: function () {
                return JSON.stringify(exportData());
            },
            // Load an array of data
            loadData: function (data) {
                fillTableData(data);
            },
            // Load a JSON rappresentation of data
            loadJsonData: function (data) {
                fillTableDataAjax(JSON.parse(data));
            },
            // Reset data to the first instance
            reset: function () {
                fillTableData(reset);
            },
            isValidated: function () {
                return is_validated;
            }
        };
    };

})(jQuery, this, 0);
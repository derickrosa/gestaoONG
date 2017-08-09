/**
 * Created by acception on 09/08/17.
 */

function getAttributesNecessaryToUpdateTable(idTabela) {
    var attributes = [];

    if (idTabela) {
        var fields = $(idTabela + " th");

        for (var i = 0; i < fields.length; i++) {
            attributes.push($(fields[i]).data('attribute'))
        }
    }

    return attributes;
}

function addNewRowToTable(tableID, rowData) {
    var table = $(tableID + " > tbody");

    var newTableRow = $("<tr>");

    var tableFields = $(tableID + " th");

    var fieldsData = tableFields.map(function(index, element) {
        return { value: $(element).data('attribute'), render: $(element).data('render')}
    });

    for (var i = 0; i < fieldsData.length; i++) {
        if (fieldsData[i].render === undefined) {
            newTableRow.append($("<td>").text(rowData[fieldsData[i].value]));
        } else {
            var textRendered = fieldsData[i].render.replace(/\{(\w+)}/g, function (element, p1) { return rowData[p1] });

            newTableRow.append($("<td>").html(textRendered));
        }
    }

    newTableRow.addClass('success');
    table.append(newTableRow);
}
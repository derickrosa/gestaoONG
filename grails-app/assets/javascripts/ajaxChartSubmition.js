/**
 * Created by hyago on 08/09/17.
 */

function submitChartByAjax(form, onSuccess) {
    if (!isScriptCarregado("ajaxFormSubmition.js")) {
        console.error("Script ajaxFormSubmition.js não foi carregado!");
        return;
    }
    else if (!isScriptCarregado("chart.min.js")) {
        console.error("Script chart.min.js não foi carregado!");
        return;
    }

    submitFormByAjax(form, 0, 'json', onSuccess, null, false, false);
}
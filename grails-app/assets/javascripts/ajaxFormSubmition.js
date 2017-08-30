/**
 * Created by hyago on 10/08/17.
 */

/**
 * Essa função cria uma submissão AJAX ao formulário disponibilizado e
 * deve ser chamada no onready da página. Desabilita todos os inputs do
 * tipo submit e coloca uma animação (carregando) dentro do botão de submit do
 * formulário.
 *
 * ATENÇÃO: alertas do tipo success e error são criados dentro do formulário
 * para serem renderizados de acordo com a resposta do servidor.
 *
 * @param {DOM Form} form formulário que será enviado via AJAX
 * @param {int delay} tempo de espera (em segundos) antes da submissão ser enviada. defaults 1
 * @param {string dataType} tipo de dado que será enviado e recebido do servidor. defaults 'json'
 * @param {function onSuccess} função que será executada caso os dados sejam enviados com sucesso ao servidor.
 *                              Os dados retornados pelo servidor e o formulário são repassados a essa função.
 * @param {function onError} semelhante a onSuccess, porém executada quando há um erro no servidor.
 */
function submitFormByAjax(form, delay, dataType, onSuccess, onError) {
    if (form === undefined) {
        console.error("Formulário não encontrado.");
        return;
    }

    var delay = delay ? delay * 1000 : 1000;
    var succesAlertComponent = form.find("div.alert-success");
    var erroAlertComponent = form.find("div.alert-danger");

    var criarAlertContainer = function () {
        var alertsContainer = $('<div id="alertsContainer"></div>');
        form.prepend(alertsContainer);

        return alertsContainer;
    };

    if (succesAlertComponent.length === 0) {
        succesAlertComponent = $('<div class="alert alert-success" role="alert"></div>');
        criarAlertContainer().prepend(succesAlertComponent);
    }
    if (erroAlertComponent.length === 0) {
        var alertsContainer = form.find("div#alertsContainer");
        if (alertsContainer.length == 0) var alertsContainer = criarAlertContainer();

        erroAlertComponent = $('<div class="alert alert-danger" role="alert"></div>');
        alertsContainer.prepend(erroAlertComponent);
    }

    succesAlertComponent.hide();
    erroAlertComponent.hide();

    form.submit(function (event) {
        event.preventDefault();
        succesAlertComponent.hide();
        erroAlertComponent.hide();
        disableSubmits();

        var method = form.attr('method');
        var dataType = dataType ? dataType : 'json';
        var url = form.attr('action');

        if (dataType == 'json') url += '.json';
        else if (dataType == 'xml') url += '.xml';

        if (url == undefined) {
            console.error("Formulário não contem endereço.");
            return;
        }

        var callAJAX = function () {
            $.ajax({
                type: method !== undefined ? method : "POST",
                url: url,
                data: form.serialize(),
                dataType: dataType,
                success: function (data) {
                    form[0].reset();
                    if (data.msg) {
                        succesAlertComponent.html(data.msg);
                        succesAlertComponent.show();
                    }
                    if (onSuccess && typeof onSuccess == 'function') {
                        onSuccess(data, form)
                    }
                },
                error: function (request) {
                    console.error(request);

                    if (request.responseJSON.error) {
                        erroAlertComponent.html(request.responseJSON.error);
                        erroAlertComponent.show();
                    }

                    if (onError && typeof onError == 'function') {
                        onError(request, form)
                    }
                },
                complete: function () {
                    enableSubmits();
                }
            });
        };

        setTimeout(function () {
            callAJAX();
        }, delay);
    });
}

function disableSubmits() {
    var submits = $('button:submit,input:submit');
    submits.append($('<i class="fa fa-cog fa-spin fa-fw"></i>'));
    submits.attr('disabled', 'disabled');
}

function enableSubmits() {
    var submits = $('button:submit,input:submit');
    submits.removeAttr('disabled');
    submits.find("i.fa-spin").remove();
}
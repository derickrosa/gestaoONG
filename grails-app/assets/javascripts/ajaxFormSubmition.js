/**
 * Created by hyago on 10/08/17.
 */

/**
 * Essa função cria uma submissão AJAX ao formulário disponibilizado e
 * deve ser chamada no onready da página. Desabilita todos os inputs do
 * tipo submit (além do próprio form) e coloca uma animação (carregando)
 * dentro do botão de submit do formulário.
 *
 * ATENÇÃO: alertas do tipo success e error são criados dentro do formulário por
 * default para serem renderizados de acordo com a resposta do servidor.
 * Caso não queira esse comportamento, altere o parametro 'createAlerts' para false.
 *
 * @param {DOM Form} form formulário que será enviado via AJAX
 * @param {int delay} tempo de espera (em segundos) antes da submissão ser enviada. defaults 1
 * @param {string dataType} tipo de dado que será enviado e recebido do servidor. defaults 'json'
 * @param {function onSuccess} função que será executada caso os dados sejam enviados com sucesso ao servidor. Os dados retornados pelo servidor e o formulário são repassados a essa função.
 * @param {function onError} semelhante a onSuccess, porém executada quando há um erro no servidor.
 * @param {boolean} alertas devem ser criados? defaults true
 * @param {boolean} resetForm form deve ser resetado ao final da submissão de sucesso? defaults true
 */
function submitFormByAjax(form, delay, dataType, onSuccess, onError, createAlerts, resetForm) {
    if (form === undefined) {
        console.error("Formulário não encontrado.");
        return;
    }

    delay = delay !== undefined ? delay * 1000 : 1000;
    createAlerts = createAlerts === undefined ? true : createAlerts === true;
    resetForm = resetForm === undefined ? true : resetForm === true;
    var succesAlertComponent;
    var erroAlertComponent;

    if (createAlerts) {
        succesAlertComponent = form.find("div.alert-success");
        erroAlertComponent = form.find("div.alert-danger");

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
    }

    form.submit(function (event) {
        event.preventDefault();
        if (succesAlertComponent) succesAlertComponent.hide();
        if (erroAlertComponent) erroAlertComponent.hide();
        disableForm(form);

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
                    if (resetForm) form[0].reset();
                    if (data.msg && succesAlertComponent) {
                        succesAlertComponent.html(data.msg);
                        succesAlertComponent.show();
                    }
                    if (onSuccess && typeof onSuccess == 'function') {
                        onSuccess(data, form)
                    }
                },
                error: function (request) {
                    console.error(request);
                    if (erroAlertComponent) {
                        if (dataType == 'json' && request.responseJSON.error) {
                            erroAlertComponent.html(request.responseJSON.error);
                            erroAlertComponent.show();
                        }
                        else if (request.responseText) {
                            erroAlertComponent.html(request.responseText);
                            erroAlertComponent.show();
                        }
                    }
                    if (onError && typeof onError == 'function') {
                        onError(request, form)
                    }
                },
                complete: function () {
                    enableForm(form);
                }
            });
        };

        setTimeout(function () {
            callAJAX();
        }, delay);
    });
}

function disableForm(form) {
    var submits = $('button:submit,input:submit');
    submits.append($('<i class="fa fa-cog fa-spin fa-fw"></i>'));
    submits.attr('disabled', 'disabled');
    form.attr('disabled', 'disabled');
}

function enableForm(form) {
    var submits = $('button:submit,input:submit');
    submits.removeAttr('disabled');
    submits.find("i.fa-spin").remove();
    form.removeAttr('disabled');
}
/**
 * Created by hyago on 25/08/17.
 */

function configurarMascaras() {
    $('.date').mask("99/99/9999", {placeholder: '__/__/____'});
    $('.cpf').mask("999.999.999-99", {placeholder: '___.___.___-__'});
    $('.cep').mask("99999-999", {placeholder: '_____-___'});
    $('.home-number').mask("99999-999");
    $('.ddd').mask("99");
    $('.phone').mask("(99) 99999-9999", {placeholder: '(__) _____-____'});
    $(".cnpj").mask("99.999.999/9999-99", {placeholder: '__.___.___/____-__'});
    $(".cnpj-filial").mask("9999-99", {placeholder: '____-__'});
    $(".digito").mask("99", {placeholder: '__'});
    $(".agencia").mask("9999999999");
    $(".conta").mask("999999999999");
    $(".number").mask("9999999999999999999");
    $(".decimalmask").mask("99.9");
    $('.decimal').mask('#.##0,00', {reverse: true});
    $('.percentual').mask('000.00 %');
    $('.text').mask('');
    $('.money').maskMoney({prefix: 'R$ ', decimal: ',', thousands: '.', affixesStay: false});
}

function configurarDatas() {
    var config = {language: 'pt-BR', autoclose: true};

    $('input.datepicker').datepicker(config);
    $('div.input-daterange').datepicker(config);
}

function configurarSelects() {
    $('select.select').select2({
        language: 'pt-BR'
    });
}

function configurarWizards() {
    var wizard = $("#wizard");
    if (wizard) {
        var form = wizard.closest("#form");
        if (form == null || form === undefined || form.length == 0) form = wizard.find("#form");

        form.validate({
            errorPlacement: function errorPlacement(error, element) {
                element.before(error);
            }
        });

        wizard.steps({
            headerTag: "h2",
            bodyTag: "section",
            transitionEffect: "slideLeft",
            onStepChanging: function (event, currentIndex, newIndex) {
                form.validate().settings.ignore = ":disabled,:hidden";
                return form.valid();
            },
            onFinishing: function (event, currentIndex) {
                form.validate().settings.ignore = ":disabled";
                return form.valid();
            }
        });
    }
}

function configurarFileUpload() {
    var files = $("div.fileuploader");
    var defaultFormat = "json";
    var loadedFiles;

    function getSelectedId(files) {
        var selection = loadedFiles.filter(function (f) {
            return f.name == files[0]
        });

        return selection[0].id;
    }

    files.each(function (i, e) {
        var div = $(e);
        var uploadUrl = div.data("upload-url");
        var loadUrl = div.data("load-url");
        var downloadUrl = div.data("download-url");
        var deleteUrl = div.data("delete-url");

        if (uploadUrl == null) {
            console.error("Attribute 'Url' not found in: ");
            console.error(e);
            return;
        }
        else if (loadUrl == null) {
            console.error("Attribute 'Load Url' not found in: ");
            console.error(e);
            return;
        }
        else if (downloadUrl == null) {
            console.error("Attribute 'Download Url' not found in: ");
            console.error(e);
            return;
        }
        else if (deleteUrl == null) {
            console.error("Attribute 'Delete Url' not found in: ");
            console.error(e);
            return;
        }

        function checkUrlFormat(url) {
            if (!url.contains(".json") && !url.contains(".xml")) console.error("Format not found in " + url);
        }

        checkUrlFormat(loadUrl);
        checkUrlFormat(uploadUrl);
        //checkUrlFormat(deleteUrl);

        div.uploadFile({
            url: uploadUrl,
            fileName: "file",
            showDelete: true,
            showDownload: true,
            showPreview: true,
            previewWidth: "50%",
            dragDropStr: "<span><b>Arraste e solte arquivos aqui...</b></span>",
            cancelStr: "Cancele",
            uploadStr: "Enviar",
            onLoad: function (obj) {
                $.ajax({
                    cache: false,
                    url: loadUrl,
                    dataType: defaultFormat,
                    success: function (data) {
                        loadedFiles = data;
                        for (var i = 0; i < data.length; i++) {
                            obj.createProgress(data[i].name, data[i].icon, data[i].size);
                        }
                    }
                });
            },
            downloadCallback: function (files) {
                var id = getSelectedId(files);
                location.href = downloadUrl + "/" + id;
            },
            deleteCallback: function (files) {
                var id = getSelectedId(files);
                $.ajax({
                    url: deleteUrl + "/" + id,
                    dataType: defaultFormat,
                    method: "DELETE"
                });
            }
        });
    });
}

function isScriptCarregado(script) {
    if (!script.contains(".js")) script += ".js";
    var scripts = $('script[type="text/javascript"]');
    for (var i = 0; i < scripts.length; i++) {
        var splitedScript = scripts[i].src.split("/");
        var name = splitedScript.length > 1 ? splitedScript[splitedScript.length - 1] : "";
        var splitedName = name.split("?");
        var id = splitedName.length > 0 ? splitedName[0] : "";
        if (id == script) return true;
    }

    return false;
}
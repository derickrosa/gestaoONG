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
    $('input.datepicker').datepicker({
        language: 'pt-BR'
    });
}

function configurarSelects() {
    $('select.select').select2({
        language: 'pt-BR'
    });
}
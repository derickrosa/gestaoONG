/**
 * Created by hyago on 08/07/15.
 */

jQuery(function () {
    /*

     */
    $.fn.datepicker.dates['pt-BR'] = {
        days: ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sabado"],
        daysShort: ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sab"],
        daysMin: ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sab"],
        months: ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"],
        monthsShort: ["Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Otu", "Nov", "Dez"],
        today: "Hoje",
        clear: "Limpar",
        format: "dd/mm/yyyy",
        titleFormat: "MM yyyy",
        weekStart: 0
    };
    $('.datepicker').datepicker({
        language: 'pt-BR'
    });
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

    //$(".tag").tagit({allowSpaces: true});
});
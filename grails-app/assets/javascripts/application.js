//= require /plugins/jquery/jquery-2.0.3.min.js
//= require /plugins/jquery/jquery.mask.min.js
//= require /plugins/jquery/jquery.maskMoney.min.js

//= require /plugins/bootstrap/bootstrap.min.js
//= require /plugins/bootstrap/bootstrap-datepicker.min.js
//= require /plugins/bootstrap/locales/bootstrap-datepicker.pt-BR.min.js


//= require /plugins/jquery/jquery.validate.js

//= require /plugins/select2/select2.min.js
//= require /plugins/select2/locales/pt-BR.min.js

//= require sweet-alert.js
//= require ajaxFormSubmition.js
//= require metisMenu.min.js
//= require sb-admin-2.min.js
//= require jquery.steps.min.js
//= require jquery.edittable2.js
//= require configuracao-inputs.js

/**
 * Aqui os métodos de configurações dos inputs provindos
 * do script configuracao-inputs.js devem ser invocados
 */
$(document).ready(function(){
	configurarMascaras();
	configurarDatas();
	configurarSelects();
	configurarWizards();
});
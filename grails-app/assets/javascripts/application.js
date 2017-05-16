// This is a manifest file that'll be compiled into application.js.
//
// Any JavaScript file within this directory can be referenced here using a relative path.
//
// You're free to add application-wide JavaScript to this file, but it's generally better 
// to create separate JavaScript files as needed.
//
//= require /plugins/jquery-2.0.3.min.js
//= require /plugins/bootstrap/bootstrap.min.js
//= require /plugins/modernizr-2.6.2-respond-1.1.0.min.js
//= require jquery.edittable.js


if (typeof jQuery !== 'undefined') {
	(function($) {
		$('#spinner').ajaxStart(function() {
			$(this).fadeIn();
		}).ajaxStop(function() {
			$(this).fadeOut();
		});
	})(jQuery);
}

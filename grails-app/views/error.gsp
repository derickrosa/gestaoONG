<!DOCTYPE html>
<html>
<head>
	<title><g:if env="development">Grails Runtime Exception</g:if><g:else>Error</g:else></title>
	<meta name="layout" content="layout-restrito">
	<g:if env="development"><asset:stylesheet src="errors.css"/></g:if>
	<!-- GLOBAL STYLES -->
	<!-- GLOBAL STYLES -->
	<link href="${assetPath(src: 'bootstrap/css/bootstrap.min.css')}" rel="stylesheet"/>
	<link href="${assetPath(src: 'Font-Awesome/css/font-awesome.css')}" rel="stylesheet"/>
	<!--END GLOBAL STYLES -->

	<!-- PAGE LEVEL STYLES -->
	<link href="${assetPath(src: 'error.css')}" rel="stylesheet"/>
	<link href="${assetPath(src: 'magic.css')}" rel="stylesheet"/>
	<!--END PAGE LEVEL STYLES -->
	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

</head>

<body>

<!--  PAGE CONTENT -->
<div class="container">



	<div class="col-lg-8 col-lg-offset-2 text-center">
		<div class="logo">
			<g:if env="development">
				<g:renderException exception="${exception}" />
			</g:if>
			<g:else>

				<h1>Um erro ocorreu!</h1>
			</g:else>

		</div>
		<p class="lead text-muted">Comunique o suporte sobre este erro para que ele seja solucionado.</p>
		<div class="clearfix"></div>
		<div class="clearfix"></div>
		<br />
		<div class="col-lg-6  col-lg-offset-3">
			<div class="btn-group btn-group-justified">
				<a href="${createLink(action: 'painelInicial',controller: 'home')}" class="btn btn-primary">Voltar ao Painel Inicial</a>
			</div>

		</div>
	</div>


</div>
<!-- END PAGE CONTENT -->


</body>
</html>

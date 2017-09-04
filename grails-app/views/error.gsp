<!DOCTYPE html>
<html>
<head>
	<title><g:if env="development">Grails Runtime Exception</g:if><g:else>Error</g:else></title>
	<meta name="layout" content="layout-restrito">
	<style type="text/css">
	h1, h2 {
		margin: 10px 25px 5px;
	}

	h2 {
		font-size: 1.1em;
	}

	.filename {
		font-style: italic;
	}

	.exceptionMessage {
		margin: 10px;
		border: 1px solid #000;
		padding: 5px;
		background-color: #E9E9E9;
	}

	.stack,
	.snippet {
		margin: 0 25px 10px;
	}

	.stack,
	.snippet {
		border: 1px solid #ccc;
		-mox-box-shadow: 0 0 2px rgba(0,0,0,0.2);
		-webkit-box-shadow: 0 0 2px rgba(0,0,0,0.2);
		box-shadow: 0 0 2px rgba(0,0,0,0.2);
	}

	/* error details */
	.error-details {
		border-top: 1px solid #FFAAAA;
		-mox-box-shadow: 0 0 2px rgba(0,0,0,0.2);
		-webkit-box-shadow: 0 0 2px rgba(0,0,0,0.2);
		box-shadow: 0 0 2px rgba(0,0,0,0.2);
		border-bottom: 1px solid #FFAAAA;
		-mox-box-shadow: 0 0 2px rgba(0,0,0,0.2);
		-webkit-box-shadow: 0 0 2px rgba(0,0,0,0.2);
		box-shadow: 0 0 2px rgba(0,0,0,0.2);
		background-color:#FFF3F3;
		line-height: 1.5;
		overflow: hidden;
		padding: 5px;
		padding-left:25px;
	}

	.error-details dt {
		clear: left;
		float: left;
		font-weight: bold;
		margin-right: 5px;
	}

	.error-details dt:after {
		content: ":";
	}

	.error-details dd {
		display: block;
	}

	/* stack trace */
	.stack {
		padding: 5px;
		overflow: auto;
		height: 150px;
	}

	/* code snippet */
	.snippet {
		background-color: #fff;
		font-family: monospace;
	}

	.snippet .line {
		display: block;
	}

	.snippet .lineNumber {
		background-color: #ddd;
		color: #999;
		display: inline-block;
		margin-right: 5px;
		padding: 0 3px;
		text-align: right;
		width: 3em;
	}

	.snippet .error {
		background-color: #fff3f3;
		font-weight: bold;
	}

	.snippet .error .lineNumber {
		background-color: #faa;
		color: #333;
		font-weight: bold;
	}

	.snippet .line:first-child .lineNumber {
		padding-top: 5px;
	}

	.snippet .line:last-child .lineNumber {
		padding-bottom: 5px;
	}
	</style>
</head>

<body>
<g:if env="development">
	<g:renderException exception="${exception}" />
</g:if>
<g:else>
	<div class="alert alert-danger" role="alert">
		<strong>Um erro ocorreu!</strong>
		Por favor comunique o suporte sobre este erro para que ele seja solucionado.
	</div>

	<g:link controller="home" action="index" class="btn btn-primary btn-lg">Voltar a Home</g:link>
</g:else>
</body>
</html>

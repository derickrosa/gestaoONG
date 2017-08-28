<%--
  Created by IntelliJ IDEA.
  User: hyago
  Date: 25/08/17
  Time: 10:06
--%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="shortcut icon" href="${assetPath(src: 'fase/fase-icon.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${assetPath(src: 'fase/fase-icon.ico')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${assetPath(src: 'fase/fase-icon.ico')}">

    <asset:stylesheet src="bootstrap/css/bootstrap.min.css"/>
    <asset:stylesheet src="Font-Awesome/css/font-awesome.min.css"/>

    <asset:javascript src="plugins/jquery/jquery-2.0.3.min.js"/>
    <asset:javascript src="plugins/bootstrap/bootstrap2.min.js"/>

    <style type="text/css">
        %{--TODO: SUBSTITUIR PARA UMA IMAAGEM DE BACKGROUND--}%
        body {
            background: white; /* For browsers that do not support gradients */
            background: -webkit-linear-gradient(white, #525252); /* For Safari 5.1 to 6.0 */
            background: -o-linear-gradient(white, #525252); /* For Opera 11.1 to 12.0 */
            background: -moz-linear-gradient(white, #525252); /* For Firefox 3.6 to 15 */
            background: linear-gradient(white, #525252); /* Standard syntax (must be last) */
        }
    </style>

    <title><g:layoutTitle default="FASE"/></title>
    <g:layoutHead/>
</head>

<body>

<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">Gestão Fundo Dema - FASE</a>
        </div>
    </div>
</nav>

<div id="page-wrapper" class="container">
    <div class="row">
        <g:layoutBody/>
    </div>
</div>
</body>
</html>
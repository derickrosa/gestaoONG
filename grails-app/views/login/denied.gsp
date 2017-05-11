<head>
    <title><g:message code="springSecurity.denied.title" /></title>

    <!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
    <!-- GLOBAL STYLES -->
    <!-- GLOBAL STYLES -->
    <link href="${assetPath(src: 'bootstrap/css/bootstrap.css')}" rel="stylesheet"/>
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
            <h1 style="font-size: 50px !important;"><g:message code="springSecurity.denied.message" /></h1></div>
        <p class="lead text-muted">Não, o que você está procurando não está aqui.</p>
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

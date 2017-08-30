<!DOCTYPE html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">


    <link rel="shortcut icon" href="${assetPath(src: 'fase/fase.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${assetPath(src: 'fase/fase.ico')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${assetPath(src: 'fase/fase.ico')}">

    <link rel="stylesheet/less" type="text/css" href="${assetPath(src: 'variables.less')}">
    <asset:stylesheet src="application.css"/>
    <asset:javascript src="application.js"/>

    <title><g:layoutTitle default="Sistem de Gerência (Fase Amazonia)"/></title>
    <g:layoutHead/>
</head>

<body>
<div id="wrapper">
    <g:render template="/layouts/navbar"/>

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header"><g:layoutTitle/></h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>

        <g:if test="${flash.error}">
            <div class="alert alert-danger" role="status">${flash.error}</div>
        </g:if>
        <g:if test="${flash.message}">
            <div class="alert alert-info" role="status">${flash.message}</div>
        </g:if>


        <g:layoutBody/>

        <sec:ifSwitched>
            <div style="position: fixed; bottom: 1em; right: 1em">
                <a style="border-radius: 0" class="btn btn-danger btn-lg"
                   href='${request.contextPath}/j_spring_security_exit_user'>
                    <i class="fa fa-arrow-left fa-fw"></i>
                    Voltar para <sec:switchedUserOriginalUsername/>
                </a>
            </div>
        </sec:ifSwitched>

    </div>
</div>
</body>

</html>
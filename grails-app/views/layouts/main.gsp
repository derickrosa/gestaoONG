<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="Sistem de Gerência (Fase Amazonia)"/></title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="${assetPath(src: 'fase-icon.ico')}" type="image/x-icon">
<link rel="apple-touch-icon" href="${assetPath(src: 'apple-touch-icon.png')}">
<link rel="apple-touch-icon" sizes="114x114" href="${assetPath(src: 'apple-touch-icon-retina.png')}">
<asset:stylesheet src="application.css"/>
<asset:stylesheet src="sweet-alert.css"/>
<asset:javascript src="application.js"/>
<asset:javascript src="sweet-alert.js"/>
<link href="${assetPath(src: 'layout2.css')}" rel="stylesheet"/>
<link href="${assetPath(src: 'flot/examples/examples.css')}" rel="stylesheet"/>
<link href="${assetPath(src: 'timeline/timeline.css')}" rel="stylesheet"/>
<!-- END PAGE LEVEL  STYLES -->
 <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
  <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
<![endif]-->
</head>
<g:layoutHead/>
</head>
<!-- END HEAD -->

<!-- BEGIN BODY -->
<body class="padTop53 ">

<!-- MAIN WRAPPER -->
<div id="wrap">

    <!-- HEADER SECTION -->
    <div id="top">

        <nav class="navbar navbar-inverse navbar-fixed-top " style="padding-top: 10px;">
            <a data-original-title="Show/Hide Menu" data-placement="bottom" data-tooltip="tooltip"
               class="accordion-toggle btn btn-primary btn-sm visible-xs" data-toggle="collapse" href="#menu"
               id="menu-toggle">
                <i class="icon-align-justify"></i>
            </a>
            <!-- LOGO SECTION -->
            <header class="navbar-header" style="position: absolute;top: 30%;">
            <sec:ifLoggedIn>

                <p>&nbsp;&nbsp;&nbsp;Olá,    <sec:username/>.</p>
            </sec:ifLoggedIn>
            </header>
            <!-- END LOGO SECTION -->
            <ul class="nav navbar-top-links navbar-right">

                <!-- MESSAGES SECTION -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <span class="label label-success">2</span>    <i class="icon-envelope-alt"></i>&nbsp; <i
                            class="icon-chevron-down"></i>
                    </a>

                    <ul class="dropdown-menu dropdown-messages">
                        <li>
                            <a href="#">
                                <div>
                                    <strong>John Smith</strong>
                                    <span class="pull-right text-muted">
                                        <em>Today</em>
                                    </span>
                                </div>

                                <div>Lorem ipsum dolor sit amet, consectetur adipiscing.
                                    <br/>
                                    <span class="label label-primary">Important</span>

                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <strong>Raphel Jonson</strong>
                                    <span class="pull-right text-muted">
                                        <em>Yesterday</em>
                                    </span>
                                </div>

                                <div>Lorem ipsum dolor sit amet, consectetur adipiscing.
                                    <br/>
                                    <span class="label label-success">Moderate</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <strong>Chi Ley Suk</strong>
                                    <span class="pull-right text-muted">
                                        <em>26 Jan 2014</em>
                                    </span>
                                </div>

                                <div>Lorem ipsum dolor sit amet, consectetur adipiscing.
                                    <br/>
                                    <span class="label label-danger">Low</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a class="text-center" href="#">
                                <strong>Read All Messages</strong>
                                <i class="icon-angle-right"></i>
                            </a>
                        </li>
                    </ul>

                </li>
                <!--END MESSAGES SECTION -->

                <!--TASK SECTION -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <span class="label label-danger">5</span>   <i class="icon-tasks"></i>&nbsp; <i
                            class="icon-chevron-down"></i>
                    </a>

                    <ul class="dropdown-menu dropdown-tasks">
                        <li>
                            <a href="#">
                                <div>
                                    <p>
                                        <strong>Profile</strong>
                                        <span class="pull-right text-muted">40% Complete</span>
                                    </p>

                                    <div class="progress progress-striped active">
                                        <div class="progress-bar progress-bar-success" role="progressbar"
                                             aria-valuenow="40" aria-valuemin="0" aria-valuemax="100"
                                             style="width: 40%">
                                            <span class="sr-only">40% Complete (success)</span>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <p>
                                        <strong>Pending Tasks</strong>
                                        <span class="pull-right text-muted">20% Complete</span>
                                    </p>

                                    <div class="progress progress-striped active">
                                        <div class="progress-bar progress-bar-info" role="progressbar"
                                             aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"
                                             style="width: 20%">
                                            <span class="sr-only">20% Complete</span>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <p>
                                        <strong>Work Completed</strong>
                                        <span class="pull-right text-muted">60% Complete</span>
                                    </p>

                                    <div class="progress progress-striped active">
                                        <div class="progress-bar progress-bar-warning" role="progressbar"
                                             aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"
                                             style="width: 60%">
                                            <span class="sr-only">60% Complete (warning)</span>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <p>
                                        <strong>Summary</strong>
                                        <span class="pull-right text-muted">80% Complete</span>
                                    </p>

                                    <div class="progress progress-striped active">
                                        <div class="progress-bar progress-bar-danger" role="progressbar"
                                             aria-valuenow="80" aria-valuemin="0" aria-valuemax="100"
                                             style="width: 80%">
                                            <span class="sr-only">80% Complete (danger)</span>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a class="text-center" href="#">
                                <strong>See All Tasks</strong>
                                <i class="icon-angle-right"></i>
                            </a>
                        </li>
                    </ul>

                </li>
                <!--END TASK SECTION -->

                <!--ALERTS SECTION -->
                <li class="chat-panel dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <span class="label label-info">8</span>   <i class="icon-comments"></i>&nbsp; <i
                            class="icon-chevron-down"></i>
                    </a>

                    <ul class="dropdown-menu dropdown-alerts">

                        <li>
                            <a href="#">
                                <div>
                                    <i class="icon-comment"></i> New Comment
                                    <span class="pull-right text-muted small">4 minutes ago</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <i class="icon-twitter info"></i> 3 New Follower
                                    <span class="pull-right text-muted small">9 minutes ago</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <i class="icon-envelope"></i> Message Sent
                                    <span class="pull-right text-muted small">20 minutes ago</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <i class="icon-tasks"></i> New Task
                                    <span class="pull-right text-muted small">1 Hour ago</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">
                                <div>
                                    <i class="icon-upload"></i> Server Rebooted
                                    <span class="pull-right text-muted small">2 Hour ago</span>
                                </div>
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a class="text-center" href="#">
                                <strong>See All Alerts</strong>
                                <i class="icon-angle-right"></i>
                            </a>
                        </li>
                    </ul>

                </li>
                <!-- END ALERTS SECTION -->

                <!--ADMIN SETTINGS SECTIONS -->

                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="icon-user "></i>&nbsp; <i class="icon-chevron-down "></i>
                    </a>

                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="${createLink(action: 'meuUsuario',controller: 'user')}"><i class="icon-user"></i> Perfil do Usuário</a>
                        </li>
                        <li class="divider"></li>
                        <li><g:link controller="logout" class="usuario-logado"><i
                                class="icon-signout"></i> Sair</g:link>
                        </li>
                    </ul>

                </li>
                <!--END ADMIN SETTINGS -->
            </ul>

        </nav>

    </div>
    <!-- END HEADER SECTION -->



    <!-- MENU SECTION -->
    <div id="left">
        <div class="media user-media well-small">
            <a  href="#">
            <g:link controller="home" action="painelInicial" class="user-link">
                <img class="media-object img-thumbnail user-img" alt="User Picture"
                    style="width: 180px; height: 100%; margin-right: 50px" src="${assetPath(src: 'logo-fundodema.png')}/"/>
            </g:link>
            <br/>

            %{--  <div class="media-body">
                  <h5 class="media-heading">Joe Romlin</h5>
                  <ul class="list-unstyled user-info">

                      <li>
                          <a class="btn btn-success btn-xs btn-circle" style="width: 10px;height: 12px;"></a> Online

                      </li>

                  </ul>
              </div>--}%
            <br/>
        </div>

        <ul id="menu" class="collapse">

            <li class="panel active">
                <a href="index.html">
                    <i class="icon-table"></i> Painel Inicial

                </a>
            </li>



            <li class="panel ">
                <a href="#" data-parent="#menu" data-toggle="collapse" class="accordion-toggle"
                   data-target="#component-nav">
                    <i class="icon-tasks"></i> Cadastros

                    <span class="pull-right">
                        <i class="icon-angle-left"></i>
                    </span>
                </a>
                <ul class="collapse" id="component-nav">

                    <li class=""><g:link controller="linhaAcao" action="index">Linha de Ação</g:link></li>
                    <li class=""><g:link controller="atividade" action="index">Atividade</g:link></li>
                    <li class=""><g:link controller="relatorioAtividade" action="index">Relatório de Atividade</g:link></li>
                    <li class=""><g:link controller="financiador" action="index">Financiador</g:link></li>
                    <li class=""><g:link controller="centroCusto" action="index">Centro de Custo</g:link></li>
                    <li class=""><a href="tabs_panels.html">Orçamento</a></li>
                    <li class=""><a href="notifications.html">Item do Orçamento</a></li>
                    <li class=""><a href="more_notifications.html">Lançamento</a></li>
                    <li class=""><g:link controller="funcionario" action="index">Funcionário</g:link></a></li>
                    <li class=""><g:link controller="fornecedor" action="index">Fornecedor</g:link></a></li>
                    %{--<li class=""><g:link controller="responsavel" action="index">Responsável</g:link></li>--}%
                </ul>
            </li>

            <sec:ifAnyGranted roles="ROLE_SUPORTE">
                <li class="panel ">
                    <a href="#" data-parent="#menu" data-toggle="collapse" class="accordion-toggle"
                       data-target="#component-sistema">
                        <i class="icon-tasks"></i> Sistema

                        <span class="pull-right">
                            <i class="icon-angle-left"></i>
                        </span>
                    </a>
                    <ul class="collapse"  id="component-sistema">

                        <li class=""><g:link controller="console" target="Console">Console</g:link></li>
                    </ul>
                </li>
            </sec:ifAnyGranted>
            <li class="panel ">
                <a href="#" data-parent="#menu" data-toggle="collapse" class="accordion-toggle collapsed"
                   data-target="#form-nav">
                    <i class="icon-shield"></i> Segurança

                    <span class="pull-right">
                        <i class="icon-angle-left"></i>
                    </span>
                </a>
                <ul class="collapse" id="form-nav">

                    <li>
                        <g:link controller="user" class="submenu-logado" action="meuUsuario">Meu Usuário</g:link>
                    </li>
                    <sec:ifAnyGranted roles="ROLE_SUPORTE,ROLE_ADMINISTRADOR_SISTEMA">
                        <li>
                            <g:link controller="user" action="index" class="submenu-logado"
                                    >Cadastro de Usuários</g:link>
                        </li>
                        <li>
                            <g:link controller="role" class="submenu-logado" action="index">Perfis de Acesso</g:link>
                        </li>
                    </sec:ifAnyGranted>

                </ul>
            </li>

            <li class="panel">
                <a href="#" data-parent="#menu" data-toggle="collapse" class="accordion-toggle"
                   data-target="#pagesr-nav">
                    <i class="icon-question"></i> Ajuda

                    <span class="pull-right">
                        <i class="icon-angle-left"></i>
                    </span>
                </a>
            </li>

        </ul>

    </div>
    <!--END MENU SECTION -->



    <!--PAGE CONTENT -->
    <g:layoutBody/>
    <!--END PAGE CONTENT -->

</div>

<!--END MAIN WRAPPER -->
<sec:ifSwitched>
    <div style="position: fixed; bottom: 1em; right: 1em">
        <a style="border-radius: 0" class="btn btn-danger btn-lg"
           href='${request.contextPath}/j_spring_security_exit_user'>
            <i class="fa fa-arrow-left fa-fw"></i>
            Voltar para <sec:switchedUserOriginalUsername/>
        </a>
    </div>
</sec:ifSwitched>

<!-- FOOTER -->
<div id="footer">
    <p>&copy;  Acception Tecnologia &nbsp;2017 &nbsp;</p>
</div>
<!--END FOOTER -->

<script>
    $(function () {
        $(".datepicker").datepicker({
            format: 'dd/mm/yyyy',
            language: 'pt-BR',
            autoclose: true
        }).on('changeDate', function (ev) {
            $(this).datepicker('hide');
        });

        $(".currency").maskMoney({
            prefix: 'R$ ',
            allowNegative: true,
            thousands: '.',
            decimal: ',',
            affixesStay: false
        });

        $(".currency").each(function(){ // function to apply mask on load!
            $(this).maskMoney('mask', Number($(this).val() || 0));
        });

        $('.percent').mask('##0,00%', {reverse: true});
    });
</script>

</body>

<!-- END BODY -->
</html>

</html>

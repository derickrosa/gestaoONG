<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="Gerência Fase"/></title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="${assetPath(src: 'fase-icon.ico')}" type="image/x-icon">
<link rel="apple-touch-icon" href="${assetPath(src: 'apple-touch-icon.png')}">
<link rel="apple-touch-icon" sizes="114x114" href="${assetPath(src: 'apple-touch-icon-retina.png')}">
<asset:stylesheet src="application.css"/>
<asset:javascript src="application.js"/>
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
            <header class="navbar-header">

             %{--   <a href="index.html" class="navbar-brand">
                    <img src="${assetPath(src: 'logo-fase.png')}" alt=""/>

                </a>--}%
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
                        <li><a href="#"><i class="icon-user"></i> User Profile</a>
                        </li>
                        <li><a href="#"><i class="icon-gear"></i> Settings</a>
                        </li>
                        <li class="divider"></li>
                        <li><a href="login.html"><i class="icon-signout"></i> Logout</a>
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
            <a class="user-link" href="#">
                <img class="media-object img-thumbnail user-img" alt="User Picture" src="${assetPath(src: 'logo-fase.png')}/"/>
            </a>
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

                    <li class=""><a href="button.html"><i class="icon-angle-right"></i> Linha de Ação</a></li>
                    <li class=""><a href="icon.html"><i class="icon-angle-right"></i> Atividade</a></li>
                    <li class=""><a href="progress.html"><i class="icon-angle-right"></i> Centro de Custo</a></li>
                    <li class=""><a href="tabs_panels.html"><i class="icon-angle-right"></i> Orçamento</a></li>
                    <li class=""><a href="notifications.html"><i class="icon-angle-right"></i> Item do Orçamento</a></li>
                    <li class=""><a href="more_notifications.html"><i class="icon-angle-right"></i> Lançamento
                    </a></li>
                    <li class=""><a href="modals.html"><i class="icon-angle-right"></i> Funcionário</a></li>
                    <li class=""><a href="wizard.html"><i class="icon-angle-right"></i> Financiador</a></li>
                </ul>
            </li>
            <li class="panel ">
                <a href="#" data-parent="#menu" data-toggle="collapse" class="accordion-toggle collapsed"
                   data-target="#form-nav">
                    <i class="icon-shield"></i> Segurança

                    <span class="pull-right">
                        <i class="icon-angle-left"></i>
                    </span>
                </a>
                <ul class="collapse" id="form-nav">
                    <li class=""><a href="forms_general.html"><i class="icon-angle-right"></i> Meu Usuário</a></li>
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

    <!-- RIGHT STRIP  SECTION -->
    <div id="right">

        <div class="well well-small">
            <ul class="list-unstyled">
                <li>Visitor &nbsp; : <span>23,000</span></li>
                <li>Users &nbsp; : <span>53,000</span></li>
                <li>Registrations &nbsp; : <span>3,000</span></li>
            </ul>
        </div>

        <div class="well well-small">
            <button class="btn btn-block">Help</button>
            <button class="btn btn-primary btn-block">Tickets</button>
            <button class="btn btn-info btn-block">New</button>
            <button class="btn btn-success btn-block">Users</button>
            <button class="btn btn-danger btn-block">Profit</button>
            <button class="btn btn-warning btn-block">Sales</button>
            <button class="btn btn-inverse btn-block">Stock</button>
        </div>

        <div class="well well-small">
            <span>Profit</span><span class="pull-right"><small>20%</small></span>

            <div class="progress mini">
                <div class="progress-bar progress-bar-info" style="width: 20%"></div>
            </div>
            <span>Sales</span><span class="pull-right"><small>40%</small></span>

            <div class="progress mini">
                <div class="progress-bar progress-bar-success" style="width: 40%"></div>
            </div>
            <span>Pending</span><span class="pull-right"><small>60%</small></span>

            <div class="progress mini">
                <div class="progress-bar progress-bar-warning" style="width: 60%"></div>
            </div>
            <span>Summary</span><span class="pull-right"><small>80%</small></span>

            <div class="progress mini">
                <div class="progress-bar progress-bar-danger" style="width: 80%"></div>
            </div>
        </div>

    </div>
    <!-- END RIGHT STRIP  SECTION -->
</div>

<!--END MAIN WRAPPER -->

<!-- FOOTER -->
<div id="footer">
    <p>&copy;  binarytheme &nbsp;2014 &nbsp;</p>
</div>
<!--END FOOTER -->
</body>

<!-- END BODY -->
</html>

</html>

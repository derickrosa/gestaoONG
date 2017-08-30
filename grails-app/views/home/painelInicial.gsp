<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito"/>
    <title>Painel Inicial - Gerência Fase</title>
</head>

<body>

<div class="row">
    <div class="col-lg-3 col-md-6">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-9 text-left">
                        <div class="huge">${contagem?.funcionarios}</div>
                        <div>Funcionários</div>
                    </div>

                    <div class="col-xs-3">
                        <i class="fa fa-users fa-5x"></i>
                    </div>
                </div>
            </div>
            <g:link controller="funcionario" action="index">
                <div class="panel-footer">
                    <span class="pull-left">Detalhes</span>
                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                    <div class="clearfix"></div>
                </div>
            </g:link>
        </div>
    </div>

    <div class="col-lg-3 col-md-6">
        <div class="panel panel-green">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-8 text-left">
                        <div class="huge">${contagem.financiadores}</div>
                        <div>Financiadores</div>
                    </div>
                    <div class="col-xs-3">
                        <i class="fa fa-handshake-o fa-5x"></i>
                    </div>
                </div>
            </div>
            <g:link controller="financiador" action="index">
                <div class="panel-footer">
                    <span class="pull-left">Detalhes</span>
                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                    <div class="clearfix"></div>
                </div>
            </g:link>
        </div>
    </div>

    <div class="col-lg-3 col-md-6">
        <div class="panel panel-yellow">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-9 text-left">
                        <div class="huge">${contagem.fornecedores}</div>
                        <div>Fornecedores</div>
                    </div>
                    <div class="col-xs-3">
                        <i class="fa fa-shopping-cart fa-5x"></i>
                    </div>
                </div>
            </div>
            <g:link controller="fornecedor" action="index">
                <div class="panel-footer">
                    <span class="pull-left">Detalhes</span>
                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                    <div class="clearfix"></div>
                </div>
            </g:link>
        </div>
    </div>

    <div class="col-lg-3 col-md-6">
        <div class="panel panel-red">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-9 text-left">
                        <div class="huge">${contagem.centroCustos}</div>
                        <div>Centro de Custos</div>
                    </div>
                    <div class="col-xs-3">
                        <i class="fa fa-support fa-5x"></i>
                    </div>
                </div>
            </div>
            <g:link controller="centroCusto" action="index">
                <div class="panel-footer">
                    <span class="pull-left">Detalhes</span>
                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                    <div class="clearfix"></div>
                </div>
            </g:link>
        </div>
    </div>
</div>

<!-- Icon Cards -->
%{--<div class="row">--}%


    %{--<div class="col-xl-3 col-sm-6 mb-3">--}%
        %{--<div class="card text-white bg-warning o-hidden h-100">--}%
            %{--<div class="card-body">--}%
                %{--<div class="card-body-icon">--}%
                    %{--<i class="fa fa-fw fa-list"></i>--}%
                %{--</div>--}%

                %{--<div class="mr-5">--}%
                    %{--11 New Tasks!--}%
                %{--</div>--}%
            %{--</div>--}%
            %{--<a href="#" class="card-footer text-white clearfix small z-1">--}%
                %{--<span class="float-left">Detalhes</span>--}%
                %{--<span class="float-right">--}%
                    %{--<i class="fa fa-angle-right"></i>--}%
                %{--</span>--}%
            %{--</a>--}%
        %{--</div>--}%
    %{--</div>--}%

    %{--<div class="col-xl-3 col-sm-6 mb-3">--}%
        %{--<div class="card text-white bg-success o-hidden h-100">--}%
            %{--<div class="card-body">--}%
                %{--<div class="card-body-icon">--}%
                    %{--<i class="fa fa-fw fa-shopping-cart"></i>--}%
                %{--</div>--}%

                %{--<div class="mr-5">--}%
                    %{--123 New Orders!--}%
                %{--</div>--}%
            %{--</div>--}%
            %{--<a href="#" class="card-footer text-white clearfix small z-1">--}%
                %{--<span class="float-left">Detalhes</span>--}%
                %{--<span class="float-right">--}%
                    %{--<i class="fa fa-angle-right"></i>--}%
                %{--</span>--}%
            %{--</a>--}%
        %{--</div>--}%
    %{--</div>--}%

    %{--<div class="col-xl-3 col-sm-6 mb-3">--}%
        %{--<div class="card text-white bg-danger o-hidden h-100">--}%
            %{--<div class="card-body">--}%
                %{--<div class="card-body-icon">--}%
                    %{--<i class="fa fa-fw fa-support"></i>--}%
                %{--</div>--}%

                %{--<div class="mr-5">--}%
                    %{--13 New Tickets!--}%
                %{--</div>--}%
            %{--</div>--}%
            %{--<a href="#" class="card-footer text-white clearfix small z-1">--}%
                %{--<span class="float-left">Detalhes</span>--}%
                %{--<span class="float-right">--}%
                    %{--<i class="fa fa-angle-right"></i>--}%
                %{--</span>--}%
            %{--</a>--}%
        %{--</div>--}%
    %{--</div>--}%
%{--</div>--}%

</body>
</html>

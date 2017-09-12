<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito"/>
    <title>Painel Inicial - Gerência Fase</title>
    <asset:javascript src="chart.min.js"/>
    <asset:javascript src="ajaxChartSubmition.js"/>

    <script type="application/javascript">
        $(document).ready(function () {
            // OTIMIZAÇÃO: carrega inicialmente um array de cores randomicas contendo o número
            // máximo possivel de cores a serem renderizadas pelo grafico em barra
            var quantidadeTotalAnos = $("input[type='hidden']#quantidade-total-anos").val();
            var randomColorArray = getRandonColorArray(quantidadeTotalAnos);

            var centosCustoBarChartCtx = $("canvas#centrosCustoBarChart");
            var centosCustoBarChart = new Chart(centosCustoBarChartCtx, {
                type: 'bar',
                data: {
                    labels: [],
                    datasets: [{
                        label: 'Centros de Custo nesse ano',
                        data: [],
                        backgroundColor: randomColorArray,
                        borderWidth: 2
                    }]
                },
                options: {
                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero: true
                            }
                        }]
                    }
                }
            });

            //Essa função faz a configuração de submissão do form de intervalos centro de custo via ajax
            var formFiltrarCentroCusto = $("form#filtrar-centro-custo");
            submitChartByAjax(formFiltrarCentroCusto, function (data) {
                if (data.pesquisa) {
                    centosCustoBarChart.config.data.labels = [];
                    var anoInicial = parseInt(data.pesquisa.anoInicial);
                    var anoFinal = parseInt(data.pesquisa.anoFinal);

                    for (var i = anoInicial; i <= anoFinal; i++) {
                        centosCustoBarChart.config.data.labels.push(i);
                    }
                }

                if (data.centroCustoInstanceList) {
                    centosCustoBarChart.config.data.datasets[0].data = [];
                    centosCustoBarChart.config.data.labels.forEach(function (ano) {
                        var centroCustoNesseAno = data.centroCustoInstanceList.filter(function (centroCusto) {
                            return centroCusto.ano == ano;
                        }).length;
                        centosCustoBarChart.config.data.datasets[0].data.push(centroCustoNesseAno);
                    });
                }

                centosCustoBarChart.update();
            });
            //envia o form para se obter um valor inicialmente
            formFiltrarCentroCusto.find("input[type='submit']").submit();
        });

        function getRandonColorArray(size, alpha) {
            alpha = alpha == undefined ? '0.2' : alpha;
            var colorArray = [];
            for (var i = 0; i < size; i++) {
                colorArray.push('rgba({0}, {1}, {2}, {3})'
                        .format(getRandomNumber(255), getRandomNumber(255), getRandomNumber(255), alpha));
            }

            return colorArray
        }

        function getRandomNumber(max, min) {
            max = max == undefined ? 10 : max;
            min = min == undefined ? 0 : min;
            return Math.floor((Math.random() * max) + min);
        }

        function updateBarChart(element) {
            var submitButton = $(element).closest("form").find("input[type='submit']");
            submitButton.submit();
        }
    </script>
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

<div class="row">
    <div class="col-lg-12 col-md-12">
        <div class="panel panel-primary">
            <div class="panel-heading container-fluid">
                <div class="row">
                    <div class="col-md-8"><h3 class="panel-title" style="padding-top: 8px">Centros de Custo por Ano</h3>
                    </div>

                    <div class="col-md-4">
                        <g:set var="anoAtual" value="${Calendar.getInstance().get(Calendar.YEAR)}"/>
                        <g:set var="intervaloAnual" value="${2000..anoAtual}"/>
                        <g:hiddenField name="quantidade-total-anos" value="${intervaloAnual.size()}"/>

                        <g:form controller="centroCusto" action="index" name="filtrar-centro-custo">
                            <div class="input-group">
                                <span class="input-group-addon" id="basic-addon1">Filtrar no Intervalo</span>
                                <g:select name="pesquisa.anoInicial" from="${intervaloAnual}" value="${anoAtual - 5}"
                                          class="form-control" onchange="updateBarChart(this)"/>
                                <div class="input-group-addon">até</div>
                                <g:select name="pesquisa.anoFinal" from="${intervaloAnual}" value="${anoAtual}"
                                          class="form-control" onchange="updateBarChart(this)"/>
                                <input class="hidden" type="submit"/>
                            </div>
                        </g:form>
                    </div>
                </div>
            </div>

            <div class="panel-body">
                <canvas id="centrosCustoBarChart" height="80"></canvas>
            </div>
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

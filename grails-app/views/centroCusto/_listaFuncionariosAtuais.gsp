<%@ page import="com.acception.cadastro.enums.TipoCusto; com.acception.cadastro.enums.RamoFuncionario" %>

<h4 class="text-center">Funcionários Atuais do Centro de Custo</h4>

<g:if test="${listaFuncionarios}">
    <table class="table table-hover text-center" id="table">
        <thead>
        <tr>
            <th class="text-center" width="25%">Nome</th>
            <th class="text-center" width="25%">Setor</th>
            <th class="text-center" width="25%">Salário Centro Custo (R$)</th>
            <th class="text-center" width="25%">Salário Anual (R$)</th>
        </tr>
        </thead>

        <tbody>
        <g:each in="${listaFuncionarios}" var="f">
            <tr>
                <td>${f.funcionario}</td>
                <td>${f.funcionario.setor}</td>
                <td>R$ ${df.format(f.valor)}</td>
                <td>R$ ${df.format(f.funcionario.salario)}</td>
            </tr>
        </g:each>
        </tbody>
    </table>
</g:if>
<g:else>
    <div class="well text-center">Sem registros!</div>
</g:else>

<br>

<div class="row text-center">
    <button class="btn btn-default btn-sm" data-toggle="modal" data-target="#modalCriacaoFuncionario">
        <span class="glyphicon glyphicon-floppy-remove"></span>
        Criar Novo Funcionário
    </button>
</div>

<div class="modal fade" tabindex="-1" role="dialog" id="modalCriacaoFuncionario">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Criar Novo Funcionário</h4>
            </div>

            <div class="modal-body">

                <form id="form" name="form" onsubmit="return false;">
                    <div id="wizard">
                        <h2>Dados Básicos</h2>
                        <section>
                            <div class="row">
                                <div class="col-md-8 form-group">
                                    <label for="nome">
                                        <g:message code="funcionario.nome.label" default="Nome"/>

                                    </label>
                                    <g:textField class="form-control"  name="participante.nome" required="required" maxlength="100"/>

                                </div>

                                <div class="col-md-4">
                                    <div class="form-group fieldcontain">
                                        <label for="salario">
                                            <g:message code="funcionario.telefone.label" default="Salário Anual"/>

                                        </label>
                                        <g:textField class="form-control currency" id="valorSalario" name="valorSalario" required="required"/>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group fieldcontain">
                                        <label for="telefone">
                                            <g:message code="funcionario.telefone.label" default="Telefone"/>

                                        </label>
                                        <g:textField class="form-control phone" id="telefoneRaw" name="telefoneRaw" required="required"/>

                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-group fieldcontain ">
                                        <label for="telefoneAdicional">
                                            <g:message code="funcionario.telefoneAdicional.label" default="Telefone Adicional"/>

                                        </label>

                                        <g:textField class="form-control phone" id="telefoneAdicionalRaw" name="telefoneAdicionalRaw"/>

                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group fieldcontain">
                                        <label for="email">
                                            <g:message code="funcionario.email.label" default="Email"/>

                                        </label>
                                        <g:field type="email" required="required" class="form-control" placeholder="exemplo@mail.com"  name="participante.email"/>

                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-group fieldcontain">
                                        <label for="emailAdicional">
                                            <g:message code="funcionario.emailAdicional.label" default="Email Adicional"/>

                                        </label>
                                        <g:field type="email" class="form-control" placeholder="exemplo@mail.com"  name="participante.emailAdicional"/>

                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 form-group fieldcontain ">
                                    <label for="cargo">
                                        <g:message code="funcionario.cargo.label" default="Cargo"/>

                                    </label>
                                    <g:textField class="form-control" required="required" name="cargo"/>

                                </div>

                                <div class="col-md-6 form-group">
                                    <label>Setor</label>
                                    <g:select class="form-control" name="setor" from="${RamoFuncionario.values()}"
                                              keys="${RamoFuncionario.values()*.name()}"
                                              noSelection="['': '']" required="required"/>
                                </div>
                            </div>

                            <div class="form-group fieldcontain ">
                                <label for="funcao">
                                    <g:message code="funcionario.funcao.label" default="Função"/>

                                </label>
                                <g:textField class="form-control" required="required" name="funcao"/>

                            </div>
                        </section>

                        <h2>Item Orçamentário</h2>
                        <section>
                            <div class="row">
                                <div class="col-md-12">
                                    <small>A fim de cadastrar o funcionário neste centro de custo, é necessário relacioná-lo à um item de orçamento.</small>

                                    <small>Selecione abaixo o item orçamentário desejado e informe o salário destinado ao funcionário.</small>

                                </div>
                            </div>

                            <br>

                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label for="itemOrcamentario">Item Orçamentário</label>
                                    <g:select class="form-control" from="${centroCustoInstance.orcamentoAtual?.itensOrcamentarios?.findAll { it.tipoCusto == TipoCusto.PESSOAL}}" optionKey="id" name="itemOrcamentario" required="required" noSelection="['': 'Selecione um item orçamentário...']"/>
                                </div>

                                <div class="form-group col-md-6">
                                    <label for="salarioFuncionarioItemOrcamentario">Salário (R$)</label>
                                    <g:textField class="form-control currency" id="salarioFuncionarioItemOrcamentario" name="salarioFuncionarioItemOrcamentario" required="required"/>
                                </div>
                            </div>

                        </section>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>

<asset:javascript src="plugins/jquery/jquery.validate.js"/>
<script src="${assetPath(src: 'jquery.cookie-1.3.1.js')}"></script>
<script src="${assetPath(src: 'jquery.steps.js')}"></script>

<script>

    $(function () {
        var table = $('#table').DataTable({
            paging: false
        });

        var form = $("#form");
        form.validate({
            errorPlacement: function errorPlacement(error, element) { element.before(error); }
        });

        $("#wizard").steps({
            headerTag: "h2",
            bodyTag: "section",
            transitionEffect: "slideLeft",
            onStepChanging: function (event, currentIndex, newIndex)
            {
                // Allways allow previous action even if the current form is not valid!
                if (currentIndex > newIndex)
                {
                    return true;
                }

                // Needed in some cases if the user went back (clean up)
                if (currentIndex < newIndex)
                {
                    // To remove error styles
                    form.find(".body:eq(" + newIndex + ") label.error").remove();
                    form.find(".body:eq(" + newIndex + ") .error").removeClass("error");
                }


                form.validate().settings.ignore = ":disabled,:hidden";
                return form.valid();
            },
            onFinishing: function (event, currentIndex)
            {
                form.validate().settings.ignore = ":disabled";
                return form.valid();
            }, onFinished: function (event, currentIndex)
            {
                $.ajax({
                    url: "${createLink(controller: 'funcionario', action: 'criarFuncionario')}",
                    method: 'POST',
                    data: form.serialize(),
                    success: function(response) {
                        $('#modalCriacaoFuncionario').modal('hide');

                        resetForm();

                        openSuccessMessage(response.funcionario.nome);

                        addRowToTabelaFuncionarios(table, response.funcionario);
                    },
                    error: function(response) {
                        openFailureMessage();
                    }
                });
            }
        });

        var resetForm = function () {
            $('#form').find("input, select").val("");

            // Setar wizard que contém o form para o primeiro passo
            $('#wizard').steps('previous');
        };

        var openSuccessMessage = function(nome) {
            swal({
                title: 'Cadastro realizado!',
                text: 'Funcionário ' + nome + ' foi criado com sucesso!',
                type: 'success'
            });
        };

        var openFailureMessage = function() {
            $('#modalCriacaoFuncionario').modal('hide');

            swal({
                title: 'Ops!',
                text: 'Ocorreu um erro no cadastro do usuário. Contate o suporte caso o problema persista.',
                type: 'error'
            });
        };

        var addRowToTabelaFuncionarios = function(table, funcionario) {
            var rowNode = table
                    .row.add([ funcionario.nome, funcionario.setor, funcionario.salarioTotal, funcionario.salarioCentroCusto])
                    .draw()
                    .node();

            $(rowNode)
                    .css( 'color', 'green' )
                    .animate( { color: 'black' } );
        }
    });
</script>
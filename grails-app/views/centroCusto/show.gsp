<%@ page import="com.acception.cadastro.CentroCusto" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'centroCusto.label', default: 'Centro de Custo')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<div id="content">
    <div class="inner" style="min-height: 700px;">
        <div class="row">
            <div class="col-lg-12">
                <h1><g:message code="default.show.label" args="[entityName]"/></h1>
            </div>
        </div>
        <hr/>
        <!--BLOCK SECTION -->
        <div class="nav" role="navigation">
            <p>
                <g:link class="btn btn-default" action="index"><span class="glyphicon glyphicon-list"></span> <g:message
                        code="default.list.label" args="[entityName]"/></g:link>
                <g:link class="btn btn-default" action="create"><span
                        class="glyphicon glyphicon-plus"></span> <g:message code="default.new.label"
                                                                            args="[entityName]"/></g:link>
            </p>
        </div>

        <div id="show-centroCusto" class="content scaffold-show" role="main">
            <g:if test="${flash.message}">
                <div class="alert alert-info">
                    ${flash.message}
                </div>
            </g:if>

            <ul class="nav nav-tabs">
                <li class="active"><a href="#dadosBasicos" data-toggle="tab" aria-expanded="false">Dados Básicos</a>
                </li>

                <li><a href="#orcamento" data-toggle="tab" aria-expanded="true">Orçamento</a>
                </li>

                <li><a href="#pessoal" data-toggle="tab" aria-expanded="true">Pessoal</a>
                </li>

            </ul>

            <div class="tab-content">
                <div class="tab-pane fade in active" id="dadosBasicos">
                    <g:render template="showDadosBasicos" model="[centroCustoInstance: centroCustoInstance]"/>
                </div>

                <div class="tab-pane fade in" id="orcamento">
                    <g:render template="showOrcamento" model="[centroCustoInstance: centroCustoInstance]"/>
                </div>

                <div class="tab-pane fade in" id="pessoal">
                    <g:render template="showPessoal" model="[centroCustoInstance: centroCustoInstance]"/>
                </div>
            </div>

            <br>

            <g:form url="[resource: centroCustoInstance, action: 'delete']" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="btn btn-default" action="edit" resource="${centroCustoInstance}">
                        <span class="glyphicon glyphicon-edit"></span>
                        <g:message code="default.button.edit.label" default="Edit"/>
                    </g:link>
                    <button type="submit" class="btn btn-default"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
                        <span class="glyphicon glyphicon-floppy-remove"></span>
                        <g:message code="default.button.delete.label"/>
                    </button>
                </fieldset>
            </g:form>
        </div>
    </div>
</div>
</body>
</html>

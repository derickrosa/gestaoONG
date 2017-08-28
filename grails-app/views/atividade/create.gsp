<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'atividade.label', default: 'Atividade')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
    <asset:stylesheet src="normalize.css"/>
    <asset:stylesheet src="wizardMain.css"/>
    <asset:stylesheet src="jquery.steps.css"/>
</head>

<body>

<div id="content">
    <div class="inner" style="min-height: 700px;">
        %{--<div class="row">
            <div class="col-lg-12">
                <h1><g:message code="default.create.label" args="[entityName]"/></h1>
            </div>
        </div>--}%
        <hr/>
        <!--BLOCK SECTION -->

        <div class="nav" role="navigation">
            <p>
                <g:if test="${atividadeInstance.isSubatividade()}">
                    <g:link class="btn btn-default" controller="atividade" action="show" id="${atividadeInstance?.atividade?.id}"><span class="glyphicon glyphicon-arrow-left"></span> <g:message
                                        code="default.list.label.voltar" default="Voltar"></g:message></g:link>
                </g:if>
                <g:else>
                    <g:link class="btn btn-default" controller="centroCusto" action="show" id="${centroCustoInstance.id}"><span class="glyphicon glyphicon-arrow-left"></span> <g:message
                            code="default.list.label.voltar" default="Voltar"></g:message></g:link>
                </g:else>
                <g:link class="btn btn-default" action="index"><span class="glyphicon glyphicon-list"></span> <g:message
                        code="default.list.label" args="[entityName]"/></g:link>
            </p>
        </div>

        <div class="panel-body">
            <div class="row">
                <div class="col-lg-12">
                    <div id="create-atividade" class="content scaffold-create" role="main">
                        <g:if test="${flash.message}">
                            <div class="alert alert-danger" role="status">${flash.message}</div>
                        </g:if>
                        <g:hasErrors bean="${atividadeInstance}">
                            <div class="alert alert-danger">
                                <ul role="alert">
                                    <g:eachError bean="${atividadeInstance}" var="error">
                                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                                error="${error}"/></li>
                                    </g:eachError>
                                </ul>
                            </div>
                        </g:hasErrors>
                        <g:form url="[resource:atividadeInstance, action:'save']" enctype="multipart/form-data" >
                        <g:render template="form"/>
                            <g:submitButton name="create" class="btn btn-default"
                                            value="${message(code: 'default.button.create.label', default: 'Create')}"/>
                        </g:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
</body>
</html>

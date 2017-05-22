<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'centroCusto.label', default: 'Centro de Custo')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>

<div id="content">
    <div class="inner" style="min-height: 700px;">
        <div class="row">
            <div class="col-lg-12">
                <h1><g:message code="default.create.label" args="[entityName]"/></h1>
            </div>
        </div>
        <hr/>
        <!--BLOCK SECTION -->

        <div class="nav" role="navigation">
            <p>
                <g:link class="btn btn-default" action="index"><span class="glyphicon glyphicon-list"></span> <g:message
                        code="default.list.label" args="[entityName]"/></g:link>
            </p>
        </div>

        <div class="panel-body">
            <div class="row">
                <div class="col-lg-12">
                    <div id="create-centroCusto" class="content scaffold-create" role="main">
                        <g:if test="${flash.message}">
                            <div class="message" role="status">${flash.message}</div>
                        </g:if>
                        <g:hasErrors bean="${centroCustoInstance}">
                            <div class="alert alert-danger">
                                <ul role="alert">
                                    <g:eachError bean="${centroCustoInstance}" var="error">
                                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                                error="${error}"/></li>
                                    </g:eachError>
                                </ul>
                            </div>
                        </g:hasErrors>
                        <g:form url="[resource:centroCustoInstance, action:'save']" enctype="multipart/form-data">
                        <g:render template="form"/>
                            <g:submitButton name="create" class="btn btn-default"
                                            value="${message(code: 'default.button.create.label', default: 'Create')}"/>
                        </g:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

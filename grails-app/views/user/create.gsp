<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
    <asset:stylesheet src="normalize.css"/>

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
                    <div id="create-user" class="content scaffold-create" role="main">
                        <g:if test="${flash.message}">
                            <div class="alert alert-danger" role="status">${flash.message}</div>
                        </g:if>
                        <g:hasErrors bean="${userInstance}">
                            <div class="alert alert-danger">
                                <ul role="alert">
                                    <g:eachError bean="${userInstance}" var="error">
                                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                                error="${error}"/></li>
                                    </g:eachError>
                                </ul>
                            </div>
                        </g:hasErrors>
                        <g:form url="[resource: userInstance, action: 'save']" id="form">
                            <g:render template="form"/>
                        </g:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- PAGE LEVEL SCRIPTS -->
<script src="${assetPath(src: 'jquery.cookie-1.3.1.js')}"></script>

<!-- END PAGE LEVEL SCRIPTS -->
</body>
</html>

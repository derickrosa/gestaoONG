<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
    <div class="nav" role="navigation">
        <p>
            <g:link class="btn btn-default" controller="home" action="index">
                <span class="glyphicon glyphicon-home"></span>
                <g:message code="default.home.label" default="Início"/>
            </g:link>

            <g:link class="btn btn-default" action="index">
                <span class="glyphicon glyphicon-list"></span>
                <g:message code="default.list.label" args="[entityName]"/>
            </g:link>
        </p>
    </div>

        <div class="row">
            <div class="col-lg-12">
                <div id="create-${domainClass.propertyName}" class="content scaffold-create" role="main">
                    <g:if test="\${flash.message}">
                        <div class="alert alert-danger" role="status">\${flash.message}</div>
                    </g:if>
                    <g:hasErrors bean="\${${propertyName}}">
                        <div class="alert alert-danger">
                            <ul role="alert">
                                <g:eachError bean="\${${propertyName}}" var="error">
                                    <li <g:if test="\${error in org.springframework.validation.FieldError}">data-field-id="\${error.field}"</g:if>><g:message
                                            error="\${error}"/></li>
                                </g:eachError>
                            </ul>
                        </div>
                    </g:hasErrors>
                    <g:form url="[resource:${propertyName}, action:'save']" <%= multiPart ? ' enctype="multipart/form-data"' : '' %>>
                    <g:render template="form"/>
                        <g:submitButton name="create" class="btn btn-default"
                                        value="\${message(code: 'default.button.create.label', default: 'Create')}"/>
                    </g:form>
                </div>
            </div>
        </div>
</body>
</html>

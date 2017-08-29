<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
    <p>
        <g:link class="btn btn-default" action="index">
            <span class="glyphicon glyphicon-list"></span>
            <g:message code="default.list.label" args="[entityName]"/>
        </g:link>
    </p>

    <div class="row">
        <div class="col-lg-12">
            <g:form url="[resource:${propertyName}, action:'save']" <%= multiPart ? ' enctype="multipart/form-data"' : '' %>>
                <g:render template="form"/>

                <button type="submit" class="btn btn-primary">
                    <span class="glyphicon glyphicon-plus"></span>
                    <g:message code="default.button.create.label" default="Criar"/>
                </button>
            </g:form>
        </div>
    </div>
</body>
</html>

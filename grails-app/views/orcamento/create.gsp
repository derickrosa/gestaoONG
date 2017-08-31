<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'orcamento.label', default: 'Orcamento')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
<g:form url="[resource:orcamentoInstance, action:'save']" >
    <g:render template="form"/>
    <g:submitButton name="create" class="btn btn-default"
                    value="${message(code: 'default.button.create.label', default: 'Create')}"/>
</g:form>
</body>
</html>

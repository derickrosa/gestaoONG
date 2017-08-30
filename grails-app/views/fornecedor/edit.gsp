<%@ page import="com.acception.cadastro.Fornecedor" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="${message(code: 'fornecedor.label', default: 'Fornecedor')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>

<div id="content">
    <div class="inner" style="min-height: 700px;">
        <div class="row">
            <div class="col-lg-12">
                <h1><g:message code="default.edit.label" args="[entityName]"/></h1>
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

        <div class="panel-body">
            <div class="row">
                <div class="col-lg-12">
                    <div id="edit-fornecedor" class="content scaffold-edit" role="main">
                        <g:if test="${flash.message}">
                            <div class="alert alert-danger" role="status">${flash.message}</div>
                        </g:if>
                        <g:hasErrors bean="${fornecedorInstance}">
                            <div class="alert alert-danger">
                                <ul role="alert">
                                    <g:eachError bean="${fornecedorInstance}" var="error">
                                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                                error="${error}"/></li>
                                    </g:eachError>
                                </ul>
                            </div>
                        </g:hasErrors>
                        <g:form url="[resource:fornecedorInstance, action:'update']" method="PUT" >

                        <g:hiddenField name="version" value="${fornecedorInstance?.version}"/>
                        <g:render template="form"/>
                        <button type="submit" class="btn btn-default">
                            <span class="glyphicon glyphicon-edit"></span>
                            <g:message code="default.button.update.label" default="Update"/></button>
                        </g:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
</body>
</html>

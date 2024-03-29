<% import grails.persistence.Event %>
<%=packageName%>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layout-restrito">
    <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
    <p>
        <g:link class="btn btn-default" action="create">
            <span class="glyphicon glyphicon-plus"></span>
            <g:message code="default.new.label" args="[entityName]" />
        </g:link>
    </p>

    <g:if test="\${${propertyName}Count > 0}">
    <table class="table table-bordered table-striped">
            <thead>
            <tr>
                <% excludedProps = Event.allEvents.toList() << 'id' << 'version'
                allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
                props = domainClass.properties.findAll {
                    allowedNames.contains(it.name) && !excludedProps.contains(it.name) && it.type != null && !Collection.isAssignableFrom(it.type) && (domainClass.constrainedProperties[it.name] ? domainClass.constrainedProperties[it.name].display : true)
                }
                Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                props.eachWithIndex { p, i ->
                    if (i < 6) {
                        if (p.isAssociation()) { %>
                <th><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}"/></th>
                <% } else { %>
                <g:sortableColumn property="${p.name}"
                                  title="\${message(code: '${domainClass.propertyName}.${
                                          p.name}.label', default: '${
                                          p.naturalName}')}"/>
                <% }
                }
                } %>
            </tr>
            </thead>
            <tbody>
            <g:each in="\${${propertyName}List}" var="${propertyName}">
                <tr>
                    <% props.eachWithIndex { p, i ->
                        if (i == 0) { %>
                    <td><g:link action="show"
                                id="\${${propertyName}.id}">\${fieldValue(bean: ${propertyName}, field: "${
                                p.name}")}</g:link></td>
                    <% } else if (i < 6) {
                        if (p.type == Boolean || p.type == boolean) { %>
                    <td><g:formatBoolean boolean="\${${propertyName}.${p.name}}"/></td>
                    <%
                        } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { %>
                    <td><g:formatDate date="\${${propertyName}.${p.name}}"/></td>
                    <% } else { %>
                    <td>\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</td>
                    <% }
                    }
                    } %>
                </tr>
            </g:each>
            </tbody>
        </table>

        <div class="pagination">
            <g:paginate total="\${${propertyName}Count ?: 0}"/>
        </div>
    </g:if>
    <g:else>
        <pesquisa:dadosNaoEncontrados/>
    </g:else>
</body>
</html>

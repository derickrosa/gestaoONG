<% import grails.persistence.Event %>
<%=packageName%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
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
					<g:link class="btn btn-default" action="index"><span class="glyphicon glyphicon-list"></span> <g:message code="default.list.label" args="[entityName]" /></g:link>
					<g:link class="btn btn-default" action="create"><span class="glyphicon glyphicon-plus"></span> <g:message code="default.new.label" args="[entityName]" /></g:link>
				</p>
			</div>

				<div id="show-${domainClass.propertyName}" class="content scaffold-show" role="main">
					<g:if test="\${flash.message}">
					<div class="alert alert-info" role="status">\${flash.message}</div>
					</g:if>

					<table class="table table-bordered ${domainClass.propertyName}">
						<%  excludedProps = Event.allEvents.toList() << 'id' << 'version'
						allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
						props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && (domainClass.constrainedProperties[it.name] ? domainClass.constrainedProperties[it.name].display : true) }
						Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
						props.each { p -> %>
						<g:if test="\${${propertyName}?.${p.name}}">
							<tr>
								<th id="${p.name}-label" class="property-label"><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></th>
								<%  if (p.isEnum()) { %>
								<td aria-labelledby="${p.name}-label"><g:fieldValue bean="\${${propertyName}}" field="${p.name}"/></td>
								<%  } else if (p.oneToMany || p.manyToMany) { %>
								<g:each in="\${${propertyName}.${p.name}}" var="${p.name[0]}">
									<td aria-labelledby="${p.name}-label"><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${p.name[0]}.id}">\${${p.name[0]}?.encodeAsHTML()}</g:link></td>
								</g:each>
								<%  } else if (p.manyToOne || p.oneToOne) { %>
								<td  aria-labelledby="${p.name}-label"><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}?.${p.name}?.id}">\${${propertyName}?.${p.name}?.encodeAsHTML()}</g:link></td>
								<%  } else if (p.type == Boolean || p.type == boolean) { %>
								<td  aria-labelledby="${p.name}-label"><g:formatBoolean boolean="\${${propertyName}?.${p.name}}" /></td>
								<%  } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { %>
								<td  aria-labelledby="${p.name}-label"><g:formatDate date="\${${propertyName}?.${p.name}}" /></td>
								<%  } else if (!p.type.isArray()) { %>
								<td  aria-labelledby="${p.name}-label"><g:fieldValue bean="\${${propertyName}}" field="${p.name}"/></td>
								<%  } %>
							</tr>
						</g:if>
						<%  } %>
					</table>

					<g:form url="[resource:${propertyName}, action:'delete']" method="DELETE">
						<fieldset class="buttons">
							<g:link class="btn btn-default" action="edit" resource="\${${propertyName}}">
								<span class="glyphicon glyphicon-edit"></span>
								<g:message code="default.button.edit.label" default="Edit" />
							</g:link>
							<button type="submit" class="btn btn-default" onclick="return confirm('\${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
								<span class="glyphicon glyphicon-floppy-remove"></span>
								<g:message code="default.button.delete.label"/>
							</button>
						</fieldset>
					</g:form>
					<br/>
				</div>
			</div>
		</div>
	</body>
</html>

<%@ page import="com.acception.security.User" %>
<%
    def linha = 'cinza-claro'
%>

<style>
.cinza-claro table {
    border-style: solid;
    border-width: 1px;
    border-color: #454545;
    width: 100%;
}

.cinza-claro table thead tr th {
    background: #454545;
    font-family: Arial;
    color: #fff;
    font-size: 10px;
    text-align: center;
    text-transform: uppercase;
}

.cinza-claro table tr:nth-child(odd) {
    background-color: #f1f1f1;
    text-align: center;
}

.cinza-claro table tr:nth-child(even) {
    background-color: #f1f1f1;
    text-align: center;
}
</style>
<g:set var="i" value="${1}"/>


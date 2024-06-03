<%-- 
    Document   : mealshoplist
    Created on : Jun 2, 2024, 9:45:14 AM
    Author     : VQN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/common/web/add_css_js.jsp"%>  
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <c:forEach var="product" items="${requestScope.products}">


        </c:forEach>   
    </body>
</html>

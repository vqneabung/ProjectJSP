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
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>
        <form action="MealShopServlet">
            <input type="text" name="find" value="${requestScope.find}"/>
            <input type="submit" value="Find"/>
        </form>
        <c:forEach items="${requestScope.productList}" var="product">
            <div style="float: left; margin: 5%">
                <img src="" style="width: 100px; height: 100px">
                <p>
                    ID: ${product.productID}</br>
                    Name: ${product.getProductName()}</br>
                    Price: ${product.productPrice}</br>
                    <a href="AddToCartServlet?productID=${product.productID}">Buy</a>
                </p>
            </div>
        </c:forEach>
    </h3>
</body>
</html>

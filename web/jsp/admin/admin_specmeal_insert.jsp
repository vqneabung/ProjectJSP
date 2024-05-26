<%-- 
    Document   : admin_specmeal_insert
    Created on : May 26, 2024, 4:16:29 PM
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
        <h1> Insert ${requestScope.specMeal.specPlanName} </h1>
        <form action="/ProjectJSP/InsertProductServlet" method="post">
            <p>
                <select name="insert_productID" >
                    <c:forEach items="${requestScope.productList}" var="product">
                        <option value="${product.productID}">${product.productID}.${product.productName}</option>
                    </c:forEach>
                </select>
            </p>

            <p>
                <select name="insert_dishID" >
                    <c:forEach items="${requestScope.dishList}" var="dish">
                        <option value="${dish.dishID}">${dish.dishID}.${dish.dishName}</option>
                    </c:forEach>
                </select>
            </p>

            <p>
                <select name="insert_dayNum" >
                    <c:forEach items="${requestScope.dayList}" var="day">
                        <option value="${day.dayNum}">${day.dayNum}.${day.dayText}</option>
                    </c:forEach>
                </select>
            </p>

            <input hidden name="insert_specMeal" value="${requestScope.specMeal}">
            <p><input type="submit" name="btn_insert" value="Insert"/></p>
        </form>
    </body>
</html>

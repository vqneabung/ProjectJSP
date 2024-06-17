<%-- 
    Document   : admin_specmeal_update
    Created on : May 28, 2024, 4:26:58 PM
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
        <form action="/ProjectJSP/UpdateSpecMealServlet" method="get">
            <p>Điền nguyên liệu
                <select name="update_productID" >
                    <c:forEach items="${requestScope.productList}" var="product">
                        <option value="${product.productID}" ${requestScope.productID == product.productID ? "selected" : "" }>${product.productID}.${product.productName}</option>
                    </c:forEach>
                </select>
            </p>

            <p> Điền buổi 
                <select name="update_dishID" >
                    <c:forEach items="${requestScope.dishList}" var="dish">
                        <option value="${dish.dishID} ${requestScope.dishID == dish.dishID ? "selected" : "" }">${dish.dishID}.${dish.dishName}</option>
                    </c:forEach>
                </select>
            </p>

            <p> Điền thứ trong tuần
                <select name="update_dayNum" >
                    <c:forEach items="${requestScope.dayList}" var="day">
                        <option value="${day.dayNum}" ${requestScope.dayNum == day.dayNum ? "selected" : "" }>${day.dayNum}.${day.dayText}</option>
                    </c:forEach>
                </select>
            </p>

            <input hidden name="update_specMealDetailID" value="${requestScope.specMealDetailID}">
            <h1>${requestScope.specMealDetailID}</h1>
            <p><input type="submit" name="btn_update" value="Update"/></p>
        </form>
    </body>
</html>

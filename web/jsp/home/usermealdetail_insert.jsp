<%-- 
    Document   : usermealdetail_insert
    Created on : Jun 3, 2024, 5:07:16 PM
    Author     : VQN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container">
    <h1> Thêm kế hoạch vào ${requestScope.userMeal.userMealName} </h1>
    <form action="/ProjectJSP/InsertUserMealDetailServlet" method="post" class="form-group">
        <p>
            <select name="insert_productID" class="form-control">
                <c:forEach items="${requestScope.productList}" var="product">
                    <option value="${product.productID}">${product.productID}.${product.productName}</option>
                </c:forEach>
            </select>
        </p>

        <p>
            <select name="insert_dishID" class="form-control">
                <c:forEach items="${requestScope.dishList}" var="dish">
                    <option value="${dish.dishID}">${dish.dishID}.${dish.dishName}</option>
                </c:forEach>
            </select>
        </p>

        <p>
            <select name="insert_dayNum" class="form-control">
                <c:forEach items="${requestScope.dayList}" var="day">
                    <option value="${day.dayNum}">${day.dayNum}.${day.dayText}</option>
                </c:forEach>
            </select>
        </p>

        <input hidden name="insert_userMealID" value="${requestScope.userMeal.userMealID}">
        <p><input type="submit" name="btn_insert" class="btn btn-primary" value="Insert"/></p>
    </form>
</div>

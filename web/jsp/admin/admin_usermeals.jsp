<%-- 
    Document   : admin_usermeals
    Created on : May 25, 2024, 9:28:22 AM
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
        <h1>Manage User Meal</h1>
        <p><a href="jsp/admin/admin_home.jsp"><--Back to homepage</a></p> 
        <p><a href="" ></a></p>
            <c:forEach items="${requestScope.userMealList}" var="userMeal">
            <h1>${userMeal.userMealName}</h1>
            <table border = "1">
                <tr>
                    <th>Product Name</th>
                    <th>Dish</th>
                    <th>Day</th>
                    <th>Product Describe</th>
                    <th>Status</th>
                </tr>
                <c:forEach var="userMealDetail" items="${requestScope.userMealDetailList}">
                    <c:if test= "${userMealDetail.isStatus != 0 && userMealDetail.userMeal.userMealID == userMeal.userMealID}" >
                        <tr>
                            <th>${userMealDetail.product.productName}</th>
                            <th>${userMealDetail.dish.dishName}</th>
                            <th>${userMealDetail.day.dayText}</th>
                            <th>${userMealDetail.product.productDescribe}</th>
                            <th>${userMealDetail.isStatus != 0 ? "Active" : "Deactive"}</th>
                        </tr>
                    </c:if>
                    <c:if test="${requestScope.update_status} != null">
                        <p>Update successful</p>
                    </c:if>
                </c:forEach>   
            </table>
        </c:forEach>
    </body>
</html>

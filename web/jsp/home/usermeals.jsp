<%-- 
    Document   : usermeal
    Created on : Jun 2, 2024, 9:48:07 AM
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
        <h1>Manage User Meal</h1>
        <p><a href="/ProjectJSP/InsertUserMealServlet?userID=${sessionScope.User.userID}&insert">Insert User Meal</a></p>
        <p><a href="jsp/home/home.jsp"><--Back to homepage</a></p> 
        <c:forEach items="${requestScope.userMealList}" var="userMeal">
            <c:if test="${userMeal.isStatus == 1}">
                <h1>${userMeal.userMealName}  <a href="/ProjectJSP/RemoveUserMealServlet?userMealID=${userMeal.userMealID}">Remove</a></h1>
                <p><a href="/ProjectJSP/InsertUserMealDetailServlet?userMealID=${userMeal.userMealID}">Insert User Meal Detail</a></p>
                <table class="table table-hover">
                    <tr>
                        <th>Product Name</th>
                        <th>Dish</th>
                        <th>Day</th>
                        <th>Product Describe</th>
                        <th>Status</th>
                        <th>Remove</th>
                        <th>Update</th>
                    </tr>
                    <c:forEach var="userMealDetail" items="${requestScope.userMealDetailList}">
                        <c:if test= "${userMealDetail.isStatus != 0 && userMealDetail.userMeal.userMealID == userMeal.userMealID}" >
                            <tr>
                                <th>${userMealDetail.product.productName}</th>
                                <th>${userMealDetail.dish.dishName}</th>
                                <th>${userMealDetail.day.dayText}</th>
                                <th>${userMealDetail.product.productDescribe}</th>
                                <th>${userMealDetail.isStatus != 0 ? "Active" : "Deactive"}</th>

                                <th><a href="RemoveUserMealDetailServlet?userMealDetailID=${userMealDetail.userMealDetailID}">remove</a></th>
                                <th><a href="UpdateUserMealDetailServlet?userMealDetailID=${userMealDetail.userMealDetailID}">update</a></th>
                            </tr>
                        </c:if>
                        <c:if test="${requestScope.update_status} != null">
                            <p>Update successful</p>
                        </c:if>
                    </c:forEach>   
                </table>
            </c:if>
        </c:forEach>

    </body>
</html>

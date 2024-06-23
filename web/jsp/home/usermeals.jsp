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
        <div class="container" style="margin-top: 1rem">
            <h1>Kế hoạch của bạn</h1>
            <p><a  href="/ProjectJSP/InsertUserMealServlet?userID=${sessionScope.User.userID}&insert" class="btn btn-primary">Thêm kế hoạch</a> <a href="jsp/home/home.jsp" class="btn btn-primary"><--Back to homepage</a></p>
            <p></p> 
            <c:forEach items="${requestScope.userMealList}" var="userMeal">
                <c:if test="${userMeal.isStatus == 1}">
                    <h1>${userMeal.userMealName}</h1>
                    <p><a class="btn btn-secondary" href="/ProjectJSP/InsertUserMealDetailServlet?userMealID=${userMeal.userMealID}"> + Thêm bữa ăn</a>   <a class="btn btn-primary"    href="/ProjectJSP/RemoveUserMealServlet?userMealID=${userMeal.userMealID}">Remove</a></p>
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
        </div>
    </body>
</html>

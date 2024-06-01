<%-- 
    Document   : admin_specmeals
    Created on : May 25, 2024, 5:27:44 PM
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
        <h1>Manage SpecMeal</h1>
        <p><a href="jsp/admin/admin_home.jsp"><--Back to homepage</a></p> 
        <c:forEach items="${requestScope.specMealList}" var="specMeal">
            <h1>${specMeal.specMealName}</h1>
            <p><a href="/ProjectJSP/InsertSpecMealServlet?specMealID=${specMeal.specMealID}">Insert</a></p>
            <table border = "1">
                <tr>
                    <th>Product Name</th>
                    <th>Dish</th>
                    <th>Day</th>
                    <th>Product Describe</th>
                    <th>Status</th>
                    <th>Remove</th>
                    <th>Update</th>
                </tr>
                <c:forEach var="specMealDetail" items="${requestScope.specMealDetailList}">
                    <c:if test= "${specMealDetail.isStatus != 0 && specMealDetail.specMeal.specMealID == specMeal.specMealID}" >
                        <tr>
                            <th>${specMealDetail.product.productName}</th>
                            <th>${specMealDetail.dish.dishName}</th>
                            <th>${specMealDetail.day.dayText}</th>
                            <th>${specMealDetail.product.productDescribe}</th>
                            <th>${specMealDetail.isStatus != 0 ? "Active" : "Deactive"}</th>

                            <th><a href="RemoveSpecMealServlet?specMealDetailID=${specMealDetail.specMealDetailID}">remove</a></th>
                            <th><a href="UpdateSpecMealServlet?specMealDetailID=${specMealDetail.specMealDetailID}">update</a></th>
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

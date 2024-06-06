<%-- 
    Document   : usermealdetail_insert
    Created on : Jun 3, 2024, 5:07:16 PM
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
    <%@include file="../../common/web/footer.jsp" %>
    <body>
        <h1> Insert ${requestScope.userMeal.userMealName} </h1>
        <form action="/ProjectJSP/InsertUserMealDetailServlet" method="post">
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

            <input hidden name="insert_userMealID" value="${requestScope.userMeal.userMealID}">
            <p><input type="submit" name="btn_insert" value="Insert"/></p>
        </form>
        <c:forEach items="${requestScope.specMealList}" var="specMeal">
            <a href="AddToUserMeal?specMealID=${specMeal.specMealID}&userID=${requestScope.userMeal.userID.userID}">Add this plan to your plan</a>
            <h1>${specMeal.specMealName}</h1>
            <table border = "1">
                <tr>
                    <th>Product Name</th>
                    <th>Dish</th>
                    <th>Day</th>
                    <th>Product Describe</th>
                    <th>Status</th>
                    <th>Add to your plan's </th>
                </tr>
                <c:forEach var="specMealDetail" items="${requestScope.specMealDetailList}">
                    <c:if test= "${specMealDetail.isStatus != 0 && specMealDetail.specMeal.specMealID == specMeal.specMealID}" >
                        <tr>
                            <th>${specMealDetail.product.productName}</th>
                            <th>${specMealDetail.dish.dishName}</th>
                            <th>${specMealDetail.day.dayText}</th>
                            <th>${specMealDetail.product.productDescribe}</th>
                            <th>${specMealDetail.isStatus != 0 ? "Active" : "Deactive"}</th>
                            <th><a href="AddToUserMeal?specMealDetailID=${specMealDetail.specMealDetailID}&userMealID=${requestScope.userMeal.userMealID}">Add</a></th>
                        </tr>
                    </c:if>
                </c:forEach>   
            </table>
        </c:forEach>
    </body>
</html>

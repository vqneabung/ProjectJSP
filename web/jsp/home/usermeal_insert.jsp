<%-- 
    Document   : usermeal_insert
    Created on : Jun 3, 2024, 5:03:13 PM
    Author     : VQN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="../../common/web/footer.jsp" %>
        <h1> Add a plan </h1>
        <form action="/ProjectJSP/InsertUserMealServlet" method="post">
            <p> 
                <label>Dien ten ke hoach</label>
                <input type="text" name="insert_userMealName" value =""/>            
            </p>

            <input hidden name="insert_userMealID" value="${sessionScope.User.userID}">
            <h1>${sessionScope.User.userID}</h1>
            <p><input type="submit" name="btn_insert" value="Insert"/></p>
        </form>
        <c:forEach items="${requestScope.specMealList}" var="specMeal">
            <a href="AddToUserMeal?specMealID=${specMeal.specMealID}&userID=${sessionScope.User.userID}">Add this plan to your plan</a>
            <h1>${specMeal.specMealName}</h1>
            <table class="table table-hover">
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

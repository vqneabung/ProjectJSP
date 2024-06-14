<%-- 
    Document   : admin_recipe
    Created on : Jun 9, 2024, 5:00:12 PM
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
    <h1>Manage Recipe</h1>
    <p><a href="jsp/admin/admin_home.jsp"><--Back to homepage</a></p> 
    <c:forEach items="${requestScope.foodList}" var="food">
        <h1>${food.productName}</h1>
        <p><a href="/ProjectJSP/InsertRecipeDetailServlet?foodID=${food.productID}">Insert</a></p>
        <table border = "1">
            <tr>
                <th>Ingredient</th>
                <th>Remove</th>
            </tr>
            <c:forEach var="recipeDetail" items="${requestScope.recipeDetailList}">
                <c:if test= "${recipeDetail.status != 0 && recipeDetail.food.productName == food.productName}" >
                    <tr>
                        <th>${recipeDetail.food.productName}</th>
                        <th><a href="RemoveRecipeDetailServlet?recipeDetailID=${recipeDetail.recipeDetailID}">remove</a></th>
                    </tr>
                </c:if>
            </c:forEach>   
        </table>
    </c:forEach> 
</body>
</html>

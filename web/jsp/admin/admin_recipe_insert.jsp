<%-- 
    Document   : admin_recipe_insert
    Created on : Jun 10, 2024, 9:58:02 AM
    Author     : VQN
--%>

<%@page import="model.ProductDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="/common/web/add_css_js.jsp"%>  
    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>
        <h1>Insert Recipe</h1>
        <p><a href="jsp/admin/admin_home.jsp"><--Back to homepage</a></p> 
        <h1>${food.productName}</h1>
        <c:if test="${requestScope.msg != null}">
            <h2>${requestScope.msg}</h2>
        </c:if>
        <form action="/ProjectJSP/InsertRecipeDetailServlet" method="get">
            <div> Điền nguyên liệu
                <select name="insert_ingredientID" id="insert_ingredientID">
                    <c:forEach items="${requestScope.ingredientList}" var="ingredient">
                        <option id="${ingredient.productID}" value="${ingredient.productID}">${ingredient.productID}.${ingredient.productName}</option>
                    </c:forEach> 
                </select>
            </div>
            <input hidden name="insert_foodID" value="${food.productID}">
            <p><input type="submit" name="btn_insert" value="Insert"/></p>
        </form>
        <table class="table table-hover">
            <tr>
                <th>Ingredient</th>
                <th>Remove</th>
            </tr>
            <c:forEach var="recipeDetail" items="${requestScope.recipeDetailList}">
                <c:if test= "${recipeDetail.food.productName == food.productName}" >
                    <tr>
                        <th>${recipeDetail.ingredient.productName}</th>
                        <th><a href="RemoveRecipeDetailServlet?recipeDetailID=${recipeDetail.recipeDetailID}">remove</a></th>
                    </tr>
                </c:if>
            </c:forEach>   
        </table>
    </body>
</html>



































<!--                <script>
                                    $(document).ready(function () {
                                        $('#add_ingredientID').click(function () {
                                            var x = $('#insert_ingredientID').find(":selected").text();
                                            console.log(x);
                                        }); 
                                    });
                                </script>-->


<!-- Test -->
<!-- <button type="button" id="test" >Test</button>
<!--            <script type="text/javascript">
                var test = [
                ];
//                function displayArray() {
//                    document.getElementById("demo").innerHTML = test;
//                }
                $(document).ready(function a() {
                    $('#test').click(function () {
                        var content = "<table class=\"table table-hover\">";
                        for (i = 0; i < test.length; i++) {
                            content += "<tr><th>" + test[i] + "</th></tr>";
                            console.log(test[i]);
                        }
                        content += "</table>";

                        $("#demo").append(content);
                    });
                });
            </script>
            <p id="demo"></p>-->
<!-- test -->
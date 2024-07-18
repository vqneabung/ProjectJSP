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
        <title>Thêm kế hoạch</title>
        <%@include file="/common/web/add_css_js.jsp"%>  
    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>
        <%@include file="../../common/admin/sidebar.jsp" %>
        <div class="main">
            <div class="card">
                <div class="card-body">
                    <h1>Chèn thành phần: ${food.productName}</h1>
                    <c:if test="${msg != null}">
                        <h2>${msg}</h2>
                    </c:if>
                    <form action="/ProjectJSP/InsertRecipeDetailServlet" method="post">
                        <div> Điền nguyên liệu
                            <select name="insert_ingredientID" id="insert_ingredientID" class="form-control">
                                <c:forEach items="${requestScope.ingredientList}" var="ingredient">
                                    <option id="${ingredient.productID}" value="${ingredient.productID}">${ingredient.productID}.${ingredient.productName}</option>
                                </c:forEach> 
                            </select>
                        </div>
                        Thêm khối lượng (Gram): <input name="insert_weight" type="number" class="form-control" id="insert_weight" value="0">
                        <input hidden name="insert_foodID" value="${food.productID}">
                        <br>
                        <p><input type="submit" name="btn_insert" class="btn btn-primary" value="Insert"/></p>
                    </form>
                    <table class="styled-table" style="width: 100%">
                        <tr>
                            <th>Nguyên liệu</th>
                            <th>Trọng lượng(Gram)</th>
                            <th>Xóa</th>
                        </tr>
                        <c:forEach var="recipeDetail" items="${requestScope.recipeDetailList}">
                            <c:if test= "${recipeDetail.food.productName == food.productName}" >
                                <tr>
                                    <th>${recipeDetail.ingredient.productName}</th>
                                    <th >${recipeDetail.weight}</th>
                                    <th><a class="btn btn-primary" href="RemoveRecipeDetailServlet?recipeDetailID=${recipeDetail.recipeDetailID}">Xoá</a></th>
                                </tr>
                            </c:if>
                        </c:forEach>   
                    </table>
                </div>
            </div>
            <script>
                var weight = document.getElementById("insert_weight");

                weight.addEventListener("change", () => {
                    if (!weight.value) {
                        weight.value = 0;
                    }
                });

            </script>
        </div>
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
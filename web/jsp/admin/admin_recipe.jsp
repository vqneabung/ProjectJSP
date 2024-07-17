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
        <title>Thành phẩm</title>
    </head>
    <%@include file="../../common/web/header.jsp" %>
    <%@include file="../../common/admin/sidebar.jsp" %>
    <script>
        $(document).ready(function () {
            $('#searchRecipe').submit(function (event) {
                event.preventDefault(); // Ngăn chặn form submit mặc định
                var searchFood = $('#search_food').val();
                console.log("Searching for: " + searchFood);
                // Kiểm tra nếu ô tìm kiếm không rỗng
                // Gửi yêu cầu AJAX
                $.ajax({
                    url: '/ProjectJSP/SearchRecipeDetailServlet', // URL của API hoặc action trên máy chủ để tìm kiếm
                    method: 'GET', // hoặc 'POST' tùy thuộc vào yêu cầu của bạn
                    data: {
                        searchFood: searchFood
                    },
                    success: function (data) {
                        var html = '';
                        var foodList = data.foodList;
                        $.each(foodList, function (index, food) {
                            html += '<div class="card" style="width: 30%">';
                            html += '<div class="card-body">';
                            html += '<h2>' + food.productName + '</h2>';
                            html += '<table class="styled-table">';
                            html += '<tr><th>Ingredient</th><th>Weight</th><th>Remove</th></tr>';
                            $.each(data.recipeDetailList, function (index, recipeDetail) {
                                if (recipeDetail.status !== 0 && recipeDetail.food.productName === food.productName) {
                                    html += '<tr>';
                                    html += '<td>' + recipeDetail.ingredient.productName + '</td>';
                                    html += '<td>' + recipeDetail.weight + '</td>';
                                    html += '<td><a class="btn btn-primary" href="RemoveRecipeDetailServlet?recipeDetailID=' + recipeDetail.recipeDetailID + '">Xóa</a></td>';
                                    html += '</tr>';
                                }
                            });

                            html += '</table><br>';
                            html += '<a class="btn btn-primary" href="/ProjectJSP/InsertRecipeDetailServlet?foodID=' + food.productID + '">Chèn thêm thành phần</a>';
                            html += '</div></div><br>';
                        });
                        $('#productList').html(html);
                    },
                    error: function (error) {
                        // Xử lý lỗi
                        console.error("Có lỗi xảy ra:", error);
                    }
                });
            });
        });
    </script>
    <div class="main">
        <h1>Quản lí thành phần</h1>
        <div class="card" style="width: 30%"    >
            <div class="card-body">
                <form id="searchRecipe">
                    <label>Tìm thức ăn</label>
                    <input class="form-control" type="text" id="search_food">
                    <br>
                    <input type="submit" class="btn btn-primary" value="Tìm">
                </form>
            </div>
        </div>

        <br>
        <div id="productList">
            <c:forEach items="${requestScope.foodList}" var="food">
                <div class="card"  style="width: 4   0%">
                    <div class="card-body" >
                        <h2>${food.productName} </h2>
                        <table class="styled-table">
                            <tr class="text-center">
                                <th>Nguyên liệu</th>
                                <th>Trọng lượng (Gram)</th>
                                <th colspan="2">Hành động</th>
                            </tr>
                            <c:forEach var="recipeDetail" items="${requestScope.recipeDetailList}">
                                <c:if test= "${recipeDetail.status != 0 && recipeDetail.food.productName == food.productName}" >
                                    <tr class="text-center">
                                        <td>${recipeDetail.ingredient.productName}</td>
                                        <td><input type="number" class=form-control id="weightRecipeDetail" value="${recipeDetail.weight}"></td>
                                        <td><a class="btn btn-primary" href="RemoveRecipeDetailServlet?recipeDetailID=${recipeDetail.recipeDetailID}">Xóa</a></td>
                                        <td><a class="btn btn-secondary" id="updateWeight" data-recipe-detail-id="${recipeDetail.recipeDetailID}">Cập nhật trọng lượng</a></td>
                                    </tr>
                                </c:if>
                            </c:forEach>   
                        </table>
                        <br>
                        <a class="btn btn-primary"href="/ProjectJSP/InsertRecipeDetailServlet?foodID=${food.productID}">Chèn thêm thành phần</a>
                    </div>
                </div>
                <br>
            </c:forEach> 
            <script>
                $(document).ready(function () {
                    $('#updateWeight').on('click', function (event) {
                        // Ngăn chặn hành động mặc định của form (tải lại trang)
                        event.preventDefault();
                        // Gửi yêu cầu Ajax
                        var weight = $('#weightRecipeDetail').val();
                        var recipeDetailID = $('#updateWeight').data('recipe-detail-id');
                        console.log(weight + ' ' + recipeDetailID);
                        $.ajax({
                            type: 'GET',
                            url: '/ProjectJSP/UpdateRecipeDetailServlet',
                            data: {
                                weight: weight,
                                recipeDetailID: recipeDetailID
                            },
                            success: function (data) {
                                alert('Đã cập nhật thành công!');
                            },
                            error: function () {
                                alert('Đã xảy ra lỗi!');
                            }
                        });
                    });
                });


            </script>
        </div>
    </div>
</body>
</html>

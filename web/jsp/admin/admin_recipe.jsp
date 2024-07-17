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
//        $(document).ready(function () {
//            $('#searchRecipe').submit(function (event) {
//                event.preventDefault(); // Ngăn chặn form submit mặc định
//                var searchFood = $('#search_food').val();
//                console.log("Searching for: " + searchFood);
//                // Kiểm tra nếu ô tìm kiếm không rỗng
//                // Gửi yêu cầu AJAX
//                $.ajax({
//                    url: '/ProjectJSP/SearchRecipeDetailServlet', // URL của API hoặc action trên máy chủ để tìm kiếm
//                    method: 'GET', // hoặc 'POST' tùy thuộc vào yêu cầu của bạn
//                    data: {
//                        searchFood: searchFood
//                    },
//                    success: function (data) {
//                        var html = '';
//                        var foodList = data.foodList;
//                        $.each(foodList, function (index, food) {
//                            html += '<div class="card" style="width: 30%">';
//                            html += '<div class="card-body">';
//                            html += '<h2>' + food.productName + '</h2>';
//                            html += '<table class="styled-table">';
//                            html += '<tr><th>Ingredient</th><th>Weight</th><th>Remove</th></tr>';
//                            $.each(data.recipeDetailList, function (index, recipeDetail) {
//                                if (recipeDetail.status !== 0 && recipeDetail.food.productName === food.productName) {
//                                    html += '<tr>';
//                                    html += '<td>' + recipeDetail.ingredient.productName + '</td>';
//                                    html += '<td>' + recipeDetail.weight + '</td>';
//                                    html += '<td><a class="btn btn-primary" href="RemoveRecipeDetailServlet?recipeDetailID=' + recipeDetail.recipeDetailID + '">Xóa</a></td>';
//                                    html += '</tr>';
//                                }
//                            });
//
//                            html += '</table><br>';
//                            html += '<a class="btn btn-primary" href="/ProjectJSP/InsertRecipeDetailServlet?foodID=' + food.productID + '">Chèn thêm thành phần</a>';
//                            html += '</div></div><br>';
//                        });
//                        $('#productList').html(html);
//                    },
//                    error: function (error) {
//                        // Xử lý lỗi
//                        console.error("Có lỗi xảy ra:", error);
//                    }
//                });
//            });
//        });
    </script>
    <div class="main">
        <h1>Quản lí thành phần</h1>
        <div class="card searchRecipe" style="width: 30%"    >
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
                <div class="card food" id="${food.productName}" style="width: 40%; margin-bottom: 1rem">
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
            </c:forEach> 
            <c:if test="${msg != null}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">

                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                    <symbol id="check-circle-fill" fill="currentColor" viewBox="0 0 16 16">
                        <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
                    </symbol>
                    <symbol id="info-fill" fill="currentColor" viewBox="0 0 16 16">
                        <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm.93-9.412-1 4.705c-.07.34.029.533.304.533.194 0 .487-.07.686-.246l-.088.416c-.287.346-.92.598-1.465.598-.703 0-1.002-.422-.808-1.319l.738-3.468c.064-.293.006-.399-.287-.47l-.451-.081.082-.381 2.29-.287zM8 5.5a1 1 0 1 1 0-2 1 1 0 0 1 0 2z"/>
                    </symbol>
                    <symbol id="exclamation-triangle-fill" fill="currentColor" viewBox="0 0 16 16">
                        <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                    </symbol>
                    </svg>

                    <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Success:"><use xlink:href="#check-circle-fill"/></svg>
                    <c:if test="${msg == 'insertSuccessfully'}">
                        Chèn thành công
                    </c:if>
                    <c:if test="${msg == 'insertFailed'}">
                        Chèn thất bại
                    </c:if>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <script>

                document.getElementById("searchRecipe").addEventListener("submit", (event) => {
                    event.preventDefault(); // Ngăn form submit mặc định
                    let searchValue = document.getElementById("search_food").value.toLowerCase();
                    let foodElements = document.querySelectorAll(".food");

                    foodElements.forEach(foodElement => {
                        let address = foodElement.id.toLowerCase();
                        if (address.includes(searchValue)) {
                            foodElement.style.display = "";
                        } else {
                            foodElement.style.display = "none";
                        }
                    });
                });

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

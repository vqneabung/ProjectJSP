<%-- 
    Document   : mealshoplist
    Created on : Jun 2, 2024, 9:45:14 AM
    Author     : VQN
--%>

<%@page import="model.CategoryDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.CategoryDAO"%>
<%@page import="dao.ProductDAO"%>
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
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">Cửa hàng thực phẩm</h1>
                </div>
            </div>
        </header>
        <section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row">
                    <div class="col-3">
                        <div class="card">
                            <div class="card-body">
                                <div>
                                    <div>
                                        <input type="text" name="find" id="find" value="${requestScope.find}"/>
                                        <input type="submit" class="btn btn-primary" value="Find" id="findProduct"/>
                                    </div>
                                    <div>
                                        <h4>+ Thể loại</h4>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" value="" id="allTypeCheck" name="typeCheck" checked>
                                            <label class="form-check-label" for="allTypeCheck">
                                                Tất cả
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" value="1" id="foodCheck" name="typeCheck">
                                            <label class="form-check-label" for="foodCheck">
                                                Thức ăn
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" value="2" id="ingredientCheck" name="typeCheck">
                                            <label class="form-check-label" for="ingredientCheck">
                                                Nguyên liệu
                                            </label>
                                        </div>
                                    </div>
                                    <div>
                                        <h4>+ Dành cho</h4>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" value="" id="allCheck" name="peopleCheck" checked>
                                            <label class="form-check-label" for="allCheck">
                                                Tất cả
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" value="1" id="vegetarianCheck" name="peopleCheck">
                                            <label class="form-check-label" for="vegetarianCheck">
                                                Ăn chay
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" value="2" id="veganCheck" name="peopleCheck">
                                            <label class="form-check-label" for="veganCheck">
                                                Ăn chay trường 
                                            </label>
                                        </div>
                                    </div>
                                    <div>
                                        <h4>+ Dạng</h4>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkBox" value="" id="allCategory" name="categoryCheck" checked=""> 
                                            <label class="form-check-label" for="veganCheck">
                                                Tất cả
                                            </label>
                                        </div>
                                        <%
                                            CategoryDAO c = new CategoryDAO();
                                            ArrayList<CategoryDTO> categoryList = c.getAllCategory();
                                        %>
                                        <c:forEach items="<%=categoryList%>" var="category">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value="${category.categoryID}" id="${category.categoryID}" name="categoryCheck">
                                                <label class="form-check-label" for="veganCheck">
                                                    ${category.categoryName}
                                                </label>
                                            </div>
                                        </c:forEach>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-8">
                        <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 justify-content-center" id="productList">
                            <c:forEach items="${requestScope.productList}" var="product">
                                <div class="col mb-5">
                                    <div class="card h-100">
                                        <!-- Product image-->
                                        <img class="card-img-top" src="${product.productImage[0]}" alt="..." width="100%" height="150px"/>
                                        <!-- Product details-->
                                        <div class="card-body p-4">
                                            <div class="text-center">
                                                <!-- Product name-->
                                                <h5 class="fw-bolder">${product.productName}</h5>
                                                <!-- Product Type-->
                                                <h5 class="fw-bolder">Loại: ${product.type.typeName}</h5>
                                                <!-- Product price-->
                                                Giá: <del>${product.productPrice}Đ</del> -${product.discount}%
                                                <br>
                                                Giá còn: ${product.productPrice - product.discount*product.productPrice/100}Đ
                                            </div>
                                        </div>
                                        <!-- Product actions-->
                                        <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                            <div class="text-center"><button class="btn btn-outline-dark mt-auto addToCard" onclick="console.log('text')" data-product-id="${product.productID}" >Mua</button> <a class="btn btn-primary mt-auto" href="SingleMealShopServlet?productID=${product.productID}&categoryID=${product.category.categoryID   }">Chi tiết</a></div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <%@include file="../../common/web/footer.jsp" %>   
    </body>

    <script>

        $(document).ready(function () {
        <c:if test="${requestScope.categorySearch != null}">
            $('#${requestScope.categorySearch}').prop('checked', true);
            $('#allCategory').prop('checked', false);
            $(document).ready(function () {

                var typeCheck = $("input[name='typeCheck']:checked").val();
                var peopleCheck = $("input[name='peopleCheck']:checked").val();
                var categoryCheck = [];
                $("input[name='categoryCheck']:checked").each(function () {
                    categoryCheck.push($(this).val());
                });
                ;
                var find = $("#find").val();
                searchMealShop(typeCheck, peopleCheck, find);

                function searchMealShop(typeCheck, peopleCheck, find) {
                    $.ajax({
                        type: 'POST',
                        url: '/ProjectJSP/MealShopSearchServlet',
                        data: {
                            typeCheck: typeCheck,
                            peopleCheck: peopleCheck,
                            categoryCheck: categoryCheck,
                            find: find
                        },
                        success: function (data) {
                            var productList = data; // Danh sách sản phẩm từ server
                            var html = '';
                            $.each(productList, function (index, product) {
                                // Tạo HTML cho mỗi sản phẩm
                                html += '<div class="col mb-5">';
                                html += '<div class="card h-100">';
                                html += '<img class="card-img-top" src="' + product.productImage[0] + '" alt="..." width="100%" height="150px"/>';
                                html += '<div class="card-body p-4">';
                                html += '<div class="text-center">';
                                html += '<h5 class="fw-bolder">' + product.productName + '</h5>';
                                html += '<h5 class="fw-bolder">Loại: ' + product.type.typeName + '</h5>';
                                html += 'Giá: ' + product.productPrice + 'Đ';
                                html += '</div></div>';
                                html += '<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">';
                                html += '<div class="text-center">';
                                html += '<button class="btn btn-outline-dark mt-auto addToCard" data-product-id="' + product.productID + '">Mua</button>';
                                html += '<a class="btn btn-primary mt-auto" href="SingleMealShopServlet?productID=' + product.productID + '&categoryID=' + product.category.categoryID + '">Chi tiết</a>';
                                html += '</div></div></div></div>';
                            });
                            $('#productList').html(html);
                        },
                        error: function () {
                            alert('Error updating order status');
                        }
                    });
                }
            });
        </c:if>

            $('input[name="categoryCheck"]').change(function () {
                if ($(this).next('label').text().trim() === 'Tất cả') {
                    if (this.checked) {
                        $('input[name="categoryCheck"]').not(this).prop('checked', false);
                    }
                } else {
                    if (this.checked) {
                        $('input[name="categoryCheck"]').each(function () {
                            if ($(this).next('label').text().trim() === 'Tất cả') {
                                $(this).prop('checked', false);
                            }
                        });
                    }
                }
            });
        });

        $(document).on('click', '.addToCard', function () {
            var productID = $(this).data('product-id');
            addToCart(productID);

            function addToCart(productID) {
                $.ajax({
                    type: 'POST',
                    url: '/ProjectJSP/AddToCartServlet',
                    data: {
                        productID: productID,
                        quantity: 1
                    },
                    success: function (data) {
                        var cartCount = data;
                        $("#cartCount").text(parseInt(cartCount));

                    },
                    error: function () {
                        alert('Error updating order status');
                    }
                });
            }

        });

        $(document).on('click', '#findProduct', function () {

            var typeCheck = $("input[name='typeCheck']:checked").val();
            var peopleCheck = $("input[name='peopleCheck']:checked").val();
            var categoryCheck = [];
            $("input[name='categoryCheck']:checked").each(function () {
                categoryCheck.push($(this).val());
            });
            ;
            var find = $("#find").val();
            searchMealShop(typeCheck, peopleCheck, find);

            function searchMealShop(typeCheck, peopleCheck, find) {
                $.ajax({
                    type: 'POST',
                    url: '/ProjectJSP/MealShopSearchServlet',
                    data: {
                        typeCheck: typeCheck,
                        peopleCheck: peopleCheck,
                        categoryCheck: categoryCheck,
                        find: find
                    },
                    success: function (data) {
                        var productList = data; // Danh sách sản phẩm từ server
                        var html = '';
                        $.each(productList, function (index, product) {
                            // Tạo HTML cho mỗi sản phẩm
                            html += '<div class="col mb-5">';
                            html += '<div class="card h-100">';
                            html += '<img class="card-img-top" src="' + product.productImage[0] + '" alt="..." width="100%" height="150px"/>';
                            html += '<div class="card-body p-4">';
                            html += '<div class="text-center">';
                            html += '<h5 class="fw-bolder">' + product.productName + '</h5>';
                            html += '<h5 class="fw-bolder">Loại: ' + product.type.typeName + '</h5>';
                            html += 'Giá: ' + product.productPrice + 'Đ';
                            html += '</div></div>';
                            html += '<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">';
                            html += '<div class="text-center">';
                            html += '<button class="btn btn-outline-dark mt-auto addToCard" data-product-id="' + product.productID + '">Mua</button>';
                            html += '<a class="btn btn-primary mt-auto" href="SingleMealShopServlet?productID=' + product.productID + '&categoryID=' + product.category.categoryID + '">Chi tiết</a>';
                            html += '</div></div></div></div>';
                        });
                        $('#productList').html(html);
                    },
                    error: function () {
                        alert('Error updating order status');
                    }
                });
            }
        });

    </script>
</html>

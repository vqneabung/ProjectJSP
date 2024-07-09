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
        <title>Cửa hàng thực phẩm</title>
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
            <div class="px-4 px-lg-5 mt-5">
                <div class="row" style="margin: 0 4rem">
                    <div class="col-3">
                        <div class="card">
                            <div class="card-body">
                                <div>
                                    <div class="row">                
                                        <div class="col-9" ><input type="text"  name="find" id="find" class="form-control" value="${requestScope.find}"/></div>
                                        <div class="col-3" ><input type="submit" class="btn btn-primary" value="Find" id="findProduct"/></div>
                                    </div>
                                    <br>
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
                                                <input class="form-check-input" type="checkbox" value="${category.categoryID}" id="${category.categoryID}" name="categoryCheck"/>
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
                    <div class="col-9">
                        <div class="row justify-content-center" id="productList">
                            <script>
                                var productListSearch = [];
                            </script>
                            <c:forEach items="${requestScope.productList}" var="product">
                                <script>
                                    productListSearch.push('${product.productName}');
                                </script>
                                <div class="col-4" style="margin-bottom: 1rem">
                                    <div class="card p-4 bg-white">
                                        <div class="about-product text-center mt-2"><img src="${product.productImage[0]}" style="width: 100%; height: 150px; margin-bottom: 1rem">
                                            <div>
                                                <h4>${product.productName}</h4>
                                                <h6 class="mt-0 text-black-50">Loại: ${product.type.typeName}</h6>
                                            </div>
                                        </div>
                                        <div class="stats mt-2">
                                            <div class="d-flex justify-content-between p-price"><span>Giá gốc</span><span><del>${product.productPrice}Đ</del></span></div>
                                            <div class="d-flex justify-content-between p-price"><span>Giảm đến: </span><span>$999</span></div>
                                            <div class="d-flex justify-content-between p-price"><span>Giảm: </span><span>${product.discount*product.productPrice/100}199</span></div>
                                        </div>
                                        <div class="d-flex justify-content-between total font-weight-bold mt-2"><span>Total</span><span>${product.productPrice - product.discount*product.productPrice/100}Đ</span>
                                        </div>
                                        <div class="text-center" style=" padding-top: 1rem;">
                                            <button class="btn btn-outline-dark addToCard" onclick="console.log('text')" data-product-id="${product.productID}" >Mua</button> <a class="btn btn-primary mt-auto" href="SingleMealShopServlet?productID=${product.productID}&categoryID=${product.category.categoryID}">Chi tiết</a>
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

        $(() => {
            $('#find').autocomplete({
                source: productListSearch
            });
        });
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
                                html += '<div class="col-4" style="margin-bottom: 1rem">';
                                html += '<div class="card p-4 bg-white">';
                                html += '<div class="about-product text-center mt-2"><img src="' + product.productImage[0] + '" style="width: 100%; height: 150px; margin-bottom: 1rem">';
                                html += '<div>';
                                html += '<h4>' + product.productName + '</h4>';
                                html += '<h6 class="mt-0 text-black-50">Loại: ' + product.type.typeName + '</h6>';
                                html += '</div>';
                                html += '</div>';
                                html += '<div class="stats mt-2">';
                                html += '<div class="d-flex justify-content-between p-price"><span>Giá gốc</span><span><del>' + product.productPrice + 'Đ</del></span></div>';
                                html += '<div class="d-flex justify-content-between p-price"><span>Giảm đến: </span><span>' + product.discount + '%</span></div>';
                                html += '<div class="d-flex justify-content-between p-price"><span>Giảm: </span><span>' + product.discount * product.productPrice / 100 + 'Đ</span></div>';
                                html += '</div>';
                                html += '<div class="d-flex justify-content-between total font-weight-bold mt-2"><span>Total</span><span>' + (product.productPrice - (product.discount * product.productPrice / 100)) + 'Đ</span>';
                                html += '</div>';
                                html += '<div class="text-center" style="padding-top: 1rem;">';
                                html += '<button class="btn btn-outline-dark addToCard" onclick="console.log("text")" data-product-id="' + product.productID + '">Mua</button> <a class="btn btn-primary mt-auto" href="SingleMealShopServlet?productID=' + product.productID + '&categoryID=' + product.category.categoryID + '">Chi tiết</a>';
                                html += '</div>';
                                html += '</div>';
                                html += '</div>';
                            });
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
                            html += '<div class="col-4" style="margin-bottom: 1rem">';
                            html += '<div class="card p-4 bg-white">';
                            html += '<div class="about-product text-center mt-2"><img src="' + product.productImage[0] + '" style="width: 100%; height: 150px; margin-bottom: 1rem">';
                            html += '<div>';
                            html += '<h4>' + product.productName + '</h4>';
                            html += '<h6 class="mt-0 text-black-50">Loại: ' + product.type.typeName + '</h6>';
                            html += '</div>';
                            html += '</div>';
                            html += '<div class="stats mt-2">';
                            html += '<div class="d-flex justify-content-between p-price"><span>Giá gốc</span><span><del>' + product.productPrice + 'Đ</del></span></div>';
                            html += '<div class="d-flex justify-content-between p-price"><span>Giảm đến: </span><span>' + product.discount + '%</span></div>';
                            html += '<div class="d-flex justify-content-between p-price"><span>Giảm: </span><span>' + product.discount * product.productPrice / 100 + 'Đ</span></div>';
                            html += '</div>';
                            html += '<div class="d-flex justify-content-between total font-weight-bold mt-2"><span>Total</span><span>' + (product.productPrice - (product.discount * product.productPrice / 100)) + 'Đ</span>';
                            html += '</div>';
                            html += '<div class="text-center" style="padding-top: 1rem;">';
                            html += '<button class="btn btn-outline-dark addToCard" onclick="console.log("text")" data-product-id="' + product.productID + '">Mua</button> <a class="btn btn-primary mt-auto" href="SingleMealShopServlet?productID=' + product.productID + '&categoryID=' + product.category.categoryID + '">Chi tiết</a>';
                            html += '</div>';
                            html += '</div>';
                            html += '</div>';
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

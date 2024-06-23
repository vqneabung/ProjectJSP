<%-- 
    Document   : mealshoplist
    Created on : Jun 2, 2024, 9:45:14 AM
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
                                <form action="MealShopSearchServlet" >
                                    <div>
                                        <input type="text" name="find" value="${requestScope.find}"/>
                                        <input type="submit" class="btn btn-primary" value="Find"/>
                                    </div>
                                    <div>
                                        <h4>+ Thể loại</h4>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" value="" id="allTypeCheck" name="typeCheck" checked>
                                            <label class="form-check-label" for="foodCheck">
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
                                            <label class="form-check-label" for="foodCheck">
                                                Tất cả
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" value="1" id="vegetarianCheck" name="peopleCheck">
                                            <label class="form-check-label" for="foodCheck">
                                                Ăn chay
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" value="2" id="veganCheck" name="peopleCheck">
                                            <label class="form-check-label" for="ingredientCheck">
                                                Ăn chay trường 
                                            </label>
                                        </div>
                                    </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-8">
                        <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 justify-content-center">
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
                                                Giá: ${product.productPrice}Đ
                                            </div>
                                        </div>
                                        <!-- Product actions-->
                                        <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                            <div class="text-center"><button class="btn btn-outline-dark mt-auto addToCard" data-product-id="${product.productID}" >Mua</button> <a class="btn btn-primary mt-auto" href="SingleMealShopServlet?productID=${product.productID}">Chi tiết</a></div>
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
            $('input[type=radio][name=typeCheck]').change(function () {
                var productID = $(this).data('product-id');
                addToCart(productID);
            });


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
    </script>
</html>

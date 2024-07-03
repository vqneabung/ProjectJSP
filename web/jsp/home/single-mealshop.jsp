<%-- 
    Document   : single-mealshop
    Created on : Jun 2, 2024, 9:47:41 AM
    Author     : VQN
--%>

<%@page import="dao.RecipeDetailDAO"%>
<%@page import="model.RecipeDetailDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>
        <div class="container">
            <div class="row">
                <div class="col-9">
                    <div class="container">
                        <section class="py-5">
                            <div class="container px-4 px-lg-5 my-5">
                                <div class="row gx-4 gx-lg-5 align-items-center">
                                    <div class="col-md-6"><img class="card-img-top mb-5 mb-md-0" src="${requestScope.product.productImage[0]}" alt="..." /></div>
                                    <div class="col-md-6">
                                        <div class="small mb-1">ProductID: ${requestScope.product.productID} </div>
                                        <h1 class="display-5 fw-bolder">${requestScope.product.productName}</h1>
                                        <h4>Thể loại: ${requestScope.product.category.categoryName}</h4>
                                        <div class="fs-5 mb-5">
                                            <p>+ Dành cho người ăn chay: ${requestScope.product.isVegetarian == 1 ? "Có" : "Không"}</p>
                                            <p>+ Dành cho người ăn chay trường: ${requestScope.product.isVegan  == 1 ? "Có" : "Không"}</p>
                                            <span>Giá: ${requestScope.product.productPrice} Đ</span>
                                        </div>
                                        <div class="d-flex">
                                            <input class="form-control text-center me-3" id="inputQuantity" type="number" value="1" style="max-width: 3rem">
                                            <button class="btn btn-outline-dark flex-shrink-0 addToCart" type="button" id="addToCart" data-product-id="${requestScope.product.productID}">
                                                <i class="bi-cart-fill me-1"></i>
                                                Add to cart
                                            </button>
                                        </div>
                                        <h5 style="margin-top: 1rem">Còn lại: ${requestScope.product.productStock} </h5>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </div>
                    <!-- Related items section-->
                    <div class="container">
                        <section class="py-5 bg-light">
                            <div class="container">
                                <div class="row">
                                    <div class="col-6">
                                        <h2 class="fw-bolder mb-4 text-center">Mô tả sản phẩm</h2>
                                        <div>
                                            <p>${requestScope.product.productDescribe}</p>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <h2 class="fw-bolder mb-4 text-center">Thành phần</h2>
                                        <div>
                                            <table class="styled-table" style="width: 100%">
                                                <tr class="text-center">
                                                    <th>Nguyên liệu</th>
                                                    <th>Trọng lượng (Gram)</th>
                                                </tr>
                                                <c:forEach var="recipeDetail" items="${requestScope.recipeDetailListByFoodID}">
                                                    <c:if test= "${recipeDetail.status != 0}" >
                                                        <tr class="text-center">
                                                            <td>${recipeDetail.ingredient.productName}</td>
                                                            <td>${recipeDetail.weight}</td>
                                                        </tr>
                                                    </c:if>
                                                </c:forEach>         
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <h2 class="fw-bolder mb-4 text-center">Hình ảnh</h2>
                                <div>
                                    <c:forEach items="${requestScope.product.productImage}" var="image">
                                        <div>
                                            <img src="${image}" width='100%' style="vertical-align: baseline;">
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </section>
                        <br>
                        <div class="rơw">
                            <h2 class="fw-bolder mb-4 text-center">Sản phẩm cùng loại</h2>
                            <div class="row" id="productList">
                                <c:forEach items="${requestScope.productByCategoryID}" var="product">
                                    <div class="col-4" style="margin: 2rem 1rem 1rem 0rem">
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
                                                <div class="text-center"><a class="btn btn-primary mt-auto" href="SingleMealShopServlet?productID=${product.productID}">Chi tiết</a></div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-3" style="margin-top: 4em">
                    <h2 class="fw-bolder mb-4 text-center">Sản phẩm mà bạn có thể quan tâm</h2>
                    <div class="row gx-4 gx-lg-5 justify-content-center" id="productList">
                        <c:forEach items="${requestScope.productRamdom}" var="product">
                            <div class="col-12" style="margin: 2rem 1rem 1rem 2rem">
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
                                        <div class="text-center"><a class="btn btn-primary mt-auto" href="SingleMealShopServlet?productID=${product.productID}">Chi tiết</a></div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            $("#addToCart").click(function () {
                var productID = $(this).data('product-id');
                var quantity = $('#inputQuantity').val();
                addToCart(productID, quantity);
            });

            $('#inputQuantity').on('change', function () {
                var quantity = $('#inputQuantity').val();
                if (quantity > ${requestScope.product.productStock}) {
                    quantity = ${requestScope.product.productStock};
                }
                $('#inputQuantity').val(quantity);
            });


            function addToCart(productID, quantity) {
                $.ajax({
                    type: 'POST',
                    url: '/ProjectJSP/AddToCartServlet',
                    data: {
                        productID: productID,
                        quantity: quantity
                    },
                    success: function (data) {
                        $("#cartCount").text(data);
                    },
                    error: function () {
                        alert('Error updating order status');
                    }
                });
            }
        });
    </script>
    <%@include file="../../common/web/footer.jsp" %>   
</body>
</html>

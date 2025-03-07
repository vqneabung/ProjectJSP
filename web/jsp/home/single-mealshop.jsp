<%-- 
    Document   : single-mealshop
    Created on : Jun 2, 2024, 9:47:41 AM
    Author     : VQN
--%>

<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="model.ProductDTO"%>
<%@page import="dao.RecipeDetailDAO"%>
<%@page import="model.RecipeDetailDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${requestScope.product.productName} - Cửa hàng thực phẩm</title>
    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>
        <%
            HashMap<ProductDTO, Integer> cart = (HashMap<ProductDTO, Integer>) session.getAttribute("cart");
            System.out.println("Is cart null = " + cart);
            ProductDTO product = (ProductDTO) request.getAttribute("product");
            System.out.println("product " + product);
            int quantityFromCart = 1;
            if (cart != null) {
                for (Map.Entry<ProductDTO, Integer> productMap : cart.entrySet()) {
                    if (productMap.getKey().getProductID() == product.getProductID()) {
                        quantityFromCart = productMap.getValue();
                        System.out.println(productMap.getValue());
                        break;
                    }
                }
            }
        %>
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
                                            <c:if test="${requestScope.product.productStock != 0}">
                                                <input class="form-control text-center me-3" id="inputQuantity" type="number" value="1" min="1" max="${requestScope.product.productStock}" style="max-width: 5rem">
                                                <button class="btn btn-outline-dark flex-shrink-0 addToCart" type="button" id="addToCart" data-product-id="${requestScope.product.productID}">
                                                    <i class="bi-cart-fill me-1"></i>
                                                    Add to cart
                                                </button>
                                            </c:if>
                                            <c:if test="${requestScope.product.productStock == 0}">
                                                <input class="form-control text-center me-3" id="inputQuantity" type="number" value="0" disabled="" style="max-width: 5rem">
                                                <button class="btn btn-outline-dark flex-shrink-0 addToCart" type="button" id="addToCart" data-product-id="${requestScope.product.productID}" disabled="">
                                                    <i class="bi-cart-fill me-1"></i>
                                                    Add to cart
                                                </button>
                                            </c:if>
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
                                    <div class="col-4" style="margin-bottom: 1rem">
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
            if (!!window.performance && window.performance.navigation.type === 2)
            {
                window.location.reload();
            }
                
            
            $("#addToCart").click(function () {
                var productID = $(this).data('product-id');
                var quantity = $('#inputQuantity').val();
                var productIDCart = [];
        <c:forEach items="${sessionScope.cart}" var="cart">
                productIDCart.push(${cart.key.productID});
        </c:forEach>
                if (!productIDCart.includes(productID)) {
                    addToCart(productID, quantity);
                    editToCart(productID, quantity);
                } else {
                    editToCart(productID, quantity);
                }
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

            function editToCart(productID, quantity) {
                $.ajax({
                    type: 'POST',
                    url: '/ProjectJSP/EditCartServlet',
                    data: {
                        edit_productID: productID,
                        edit_quantity: parseInt(quantity) + parseInt(<%= quantityFromCart%>),
                        btn_action: "update"
                    },
                    success: function (data) {

                    },
                    error: function () {
                        alert('Error updating order status');
                    }
                });
            }
        });
    </script>
    <%
    %>
    <%@include file="../../common/web/footer.jsp" %>   
</body>
</html>

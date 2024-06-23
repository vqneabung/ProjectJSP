<%-- 
    Document   : single-mealshop
    Created on : Jun 2, 2024, 9:47:41 AM
    Author     : VQN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>
        <section class="py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="row gx-4 gx-lg-5 align-items-center">
                    <div class="col-md-6"><img class="card-img-top mb-5 mb-md-0" src="${requestScope.product.productImage[0]}" alt="..." /></div>
                    <div class="col-md-6">
                        <div class="small mb-1">ProductID: ${requestScope.product.productID} </div>
                        <h1 class="display-5 fw-bolder">${requestScope.product.productName}</h1>
                        <div class="fs-5 mb-5">
                            <p>+ Dành cho người ăn chay: ${requestScope.product.isVegetarian == 1 ? "Có" : "Không"}</p>
                            <p>+ Dành cho người ăn chay trường: ${requestScope.product.isVegan  == 1 ? "Có" : "Không"}</p>
                            <span>Giá: ${requestScope.product.productPrice} Đ</span>
                        </div>
                        <div class="d-flex">
                            <input class="form-control text-center me-3" id="inputQuantity" type="number" value="1" style="max-width: 3rem" />
                            <button class="btn btn-outline-dark flex-shrink-0 addToCart" type="button" id="addToCart" data-product-id="${requestScope.product.productID}">
                                <i class="bi-cart-fill me-1"></i>
                                Add to cart
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Related items section-->
        <section class="py-5 bg-light">
            <div class="container">
                <h2 class="fw-bolder mb-4">Mô tả sản phẩm</h2>
                <div>
                    <p>${requestScope.product.productDescribe}</p>
                </div>
                <h2 class="fw-bolder mb-4">Hình ảnh</h2>
                <div>
                    <c:forEach items="${requestScope.product.productImage}" var="image">
                        <div>
                            <img src="${image}" width='100%' style="vertical-align: baseline;">
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>

        <script>
            $(document).ready(function () {
                $("#addToCart").click(function () {
                    var productID = $(this).data('product-id');
                    var quantity = $('#inputQuantity').val();
                    addToCart(productID, quantity);
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

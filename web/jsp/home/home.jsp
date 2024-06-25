<%-- 
    Document   : home
    Created on : May 17, 2024, 10:37:50 PM
    Author     : VQN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Home</title>

    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>  
        <header class="py-5 bg-light border-bottom mb-4">
            <div class="container">
                <div class="text-center my-5">
                    <h1 class="fw-bolder">Welcome to Weakly Meal and The Shop!</h1>
                    <p class="lead mb-0">Where you can create your weakly meal plan and buy some food</p>
                </div>
            </div>
        </header>
        <div class="container" style="margin-top: 5rem">
            <div class="row">
                <!-- Blog entries-->
                <div class="col-lg-8">
                    <!-- Featured blog post-->
                    <div class="card mb-4">
                        <a href="#!"><img class="card-img-top" src="https://dummyimage.com/850x350/dee2e6/6c757d.jpg" alt="..." /></a>
                        <div class="card-body">
                            <div class="small text-muted">January 1, 2025</div>
                            <h2 class="card-title">Kế hoạch hàng tuần</h2>
                            <p class="card-text">Bạn cần kế hoạch, chúng tôi sẵn lòng giúp bạn!</p>
                            <a class="btn btn-primary" href="StartServlet?action=specmeal">Read more →</a>
                        </div>
                    </div>
                    <!-- Nested row for non-featured blog posts-->
                    <div class="row">
                        <!-- Blog post-->
                        <div class="col-12">
                            <h1 class="text-center" style="margin-bottom: 1rem">Best Seller</h1>
                            <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 justify-content-center" id="productList">
                                <c:forEach items="${requestScope.bestSellerProductList}" begin="1" end="3" var="product">
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
                                                <div class="text-center"><button class="btn btn-outline-dark mt-auto addToCard" onclick="console.log('text')" data-product-id="${product.productID}" >Mua</button> <a class="btn btn-primary mt-auto" href="SingleMealShopServlet?productID=${product.productID}">Chi tiết</a></div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <!-- Pagination-->
                </div>
                <!-- Side widgets-->
                <div class="col-lg-4">
                    <!-- Search widget-->
                    <div class="card mb-4">
                        <div class="card-header">Search</div>
                        <div class="card-body">
                            <div class="input-group">
                                <input class="form-control" type="text" placeholder="Enter search term..." aria-label="Enter search term..." aria-describedby="button-search" />
                                <button class="btn btn-primary" id="button-search" type="button">Go!</button>
                            </div>
                        </div>
                    </div>
                    <!-- Categories widget-->
                    <div class="card mb-4">
                        <div class="card-header">Categories</div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-6">
                                    <ul class="list-unstyled mb-0">
                                        <li><a href="#!">Web Design</a></li>
                                        <li><a href="#!">HTML</a></li>
                                        <li><a href="#!">Freebies</a></li>
                                    </ul>
                                </div>
                                <div class="col-sm-6">
                                    <ul class="list-unstyled mb-0">
                                        <li><a href="#!">JavaScript</a></li>
                                        <li><a href="#!">CSS</a></li>
                                        <li><a href="#!">Tutorials</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Side widget-->
                    <div class="card mb-4">
                        <div class="card-header">Side Widget</div>
                        <div class="card-body">You can put anything you want inside of these side widgets. They are easy to use, and feature the Bootstrap 5 card component!</div>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="../../common/web/footer.jsp" %>   
    </body>
</html>

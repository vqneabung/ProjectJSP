<%-- 
    Document   : home
    Created on : May 17, 2024, 10:37:50 PM
    Author     : VQN
--%>

<%@page import="model.CategoryDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.CategoryDAO"%>
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
                    <div class="card mb-4">
                        <a href="#!"><img class="card-img-top" src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg/800px-Good_Food_Display_-_NCI_Visuals_Online.jpg" alt="..." /></a>
                        <div class="card-body">
                            <div class="small text-muted">January 1, 2025</div>
                            <h2 class="card-title">Kế hoạch hàng tuần</h2>
                            <p class="card-text">Bạn cần kế hoạch, chúng tôi sẵn lòng giúp bạn!</p>
                            <a class="btn btn-primary" href="StartServlet?action=specmeal">Read more →</a>
                        </div>
                    </div>
                    <div class="row">
                        <!-- Blog post-->
                        <div class="col-12">
                            <h1 class="text-center" style="margin-bottom: 1rem">Best Seller</h1>
                            <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 justify-content-center" id="productList">
                                <c:forEach items="${requestScope.bestSellerProductList}" begin="1" end="3" var="product">
                                    <div class="col-4" style="margin-bottom: 1rem">
                                        <div class="card p-4 bg-white">
                                            <div class="about-product text-center mt-2"><a href="SingleMealShopServlet?productID=${product.productID}&categoryID=${product.category.categoryID}"><img src="${product.productImage[0]}" style="width: 100%; height: 150px; margin-bottom: 1rem"></a> 
                                                <div>
                                                    <h4>${product.productName}</h4>
                                                    <h6 class="mt-0 text-black-50">Loại: ${product.type.typeName}</h6>
                                                </div>
                                            </div>
                                            <div class="stats mt-2">
                                                <div class="d-flex justify-content-between p-price"><span>Giá gốc</span><span>${product.productPrice}VND</span></div>
                                                <div class="d-flex justify-content-between p-price"><span>Giảm đến: </span><span>${product.discount}%`</span></div>
                                                <div class="d-flex justify-content-between p-price"><span>Giảm: </span><span>${product.discount*product.productPrice/100} Đ</span></div>
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
                    <!-- Pagination-->
                </div>
                <!-- Side widgets-->
                <%
                    CategoryDAO c = new CategoryDAO();
                    ArrayList<CategoryDTO> categoryList = c.getAllCategory();
                %>
                <div class="col-lg-4">
                    <div class="card mb-4">
                        <div class="card-header">Thể loại</div>
                        <div class="card-body">
                            <div class="row">
                                <%
                                    for (int i = 0; i < Math.ceil(categoryList.size() / 3); i++) {
                                %>
                                <div class="col-sm-6">
                                    <ul class="list-unstyled mb-0">
                                        <li><a href="/ProjectJSP/MealShopServlet?categoryID=<%= categoryList.get(i * 3).getCategoryID()%>">+ <%= categoryList.get(i * 3).getCategoryName()%></a></li>
                                        <li><a href="/ProjectJSP/MealShopServlet?categoryID=<%= categoryList.get(i * 3 + 1).getCategoryID()%>">+ <%= categoryList.get(i * 3 + 1).getCategoryName()%></a></li>
                                        <li><a href="/ProjectJSP/MealShopServlet?categoryID=<%= categoryList.get(i * 3 + 2).getCategoryID()%>">+ <%= categoryList.get(i * 3 + 2).getCategoryName()%></a></li>
                                    </ul>
                                    <br>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                    <div>
                        <img src="https://cdn.britannica.com/36/123536-050-95CB0C6E/Variety-fruits-vegetables.jpg" width="100%">
                    </div>
                    <br>
                    <div>
                        <img src="https://media.cnn.com/api/v1/images/stellar/prod/140430115517-06-comfort-foods.jpg?q=w_1110,c_fill" width="100%">
                    </div>
                    <br>
                    <div>
                        <img src="https://www.eatright.org/-/media/images/eatright-landing-pages/foodgroupslp_804x482.jpg?as=0&w=967&rev=d0d1ce321d944bbe82024fff81c938e7&hash=E6474C8EFC5BE5F0DA9C32D4A797D10D" width="100%">
                    </div>
                    <br>
                </div>
            </div>
        </div>
        <%@include file="../../common/web/footer.jsp" %>   
    </body>
</html>

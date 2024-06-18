<%-- 
    Document   : admin_products
    Created on : May 22, 2024, 1:52:38 PM
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
        <%@include file="../../common/admin/sidebar.jsp" %>
        <div class="main">
            <h1>Quản lí sản phẩm</h1>
            <p><a class="btn btn-primary btn-lg active" href="jsp/admin/admin_home.jsp"><--Back to homepage</a> <a class="btn btn-secondary btn-lg active" href="/ProjectJSP/InsertProductServlet" >Insert Product</a></p> 
            <table class="table table-hover">
                <tr>
                    <th>Product ID</th>
                    <th>Product Name</th>
                    <th>Category</th>
                    <th>Type</th>
                    <th>Is Vegetarian</th>
                    <th>Is Vegan</th>
                    <th>Has Special Dietary Requirements</th>
                    <th>Product Size</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th>Unit sold</th>
                    <th>Status</th>
                    <th>Remove</th>
                    <th>Update</th>
                </tr>
                <c:forEach var="product" items="${requestScope.products}">
                    <c:if test= "${product.isStatus != 0}" >
                        <tr>
                            <th>${product.productID}</th>
                            <th>${product.productName}</th>
                            <th>${product.category.categoryName}</th>
                            <th>${product.type.typeName}</th>
                            <th>${product.isVegetarian == 1 ? "True" : "False"}</th>
                            <th>${product.isVegan == 1 ? "True" : "False"}</th>
                            <th>${product.hasSpecialDietaryRequirements == 1 ? "True" : "False"}</th>
                            <th><c:forEach items="${product.productSize}" var="size" varStatus="loop">
                                    ${size}<c:if test="${not loop.last}">,</c:if>
                                </c:forEach></th>
                            <th>${product.productPrice}</th>
                            <th>${product.productStock}</th>
                            <th>${product.productUnitSold}</th>
                            <th>${product.isStatus == 1 ? "Activate" : "Deactivate"}</th>
                            <th><a href="RemoveProduceServlet?productID=${product.productID}">remove</a></th>
                            <th><a href="UpdateProductServlet?productID=${product.productID}">update</a></th>
                        </tr>   
                        <tr>
                            <td colspan="15">
                                <h2>Mô tả</h2>
                                ${product.productDescribe}
                                <c:forEach items="${product.productImage}" var="image">
                                    <div >
                                        <div>
                                            <img src="${image}" width='100%' style="vertical-align: baseline;">
                                        </div>
                                    </div>
                                </c:forEach>
                            </td>
                        </tr>
                    </c:if>
                    <c:if test="${requestScope.update_status} != null">
                        <p>Update successful</p>
                    </c:if>
                </c:forEach>   
            </table>
        </div>
    </body>
</html>

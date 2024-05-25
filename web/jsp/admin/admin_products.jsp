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
        <h1>Manage User</h1>
        <h1>Activate</h1>
        <p><a href="jsp/admin/admin_home.jsp"><--Back to homepage</a></p> 
        <table border = "1">
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
                <th>Describe</th>
                <th>Image</th>
                <th>Status</th>
                <th>Remove</th>
                <th>Update</th>
            </tr>
            <c:forEach var="product" items="${requestScope.products}">
                <c:if test= "${product.isStatus != 0}" >
                    <tr>
                        <th>${product.productID}</th>
                        <th>${product.productName}</th>
                        <th>${product.category.categoryID}</th>
                        <th>${product.type.typeID}</th>
                        <th>${product.isVegetarian}</th>
                        <th>${product.isVegan}</th>
                        <th>${product.hasSpecialDietaryRequirements}</th>
                        <th><c:forEach items="${product.productSize}" var="size" varStatus="loop">
                                ${size}<c:if test="${not loop.last}">,</c:if>
                            </c:forEach></th>
                        <th>${product.productPrice}</th>
                        <th>${product.productStock}</th>
                        <th>${product.productUnitSold}</th>
                        <th>${product.productDescribe}</th>
                        <th>${product.productImage}</th>
                        <th>${product.isStatus == 1 ? "Activate" : "Deactivate"}</th>
                        <th><a href="RemoveProduceServlet?productID=${product.productID}">remove</a></th>
                        <th><a href="UpdateProductServlet?productID=${product.productID}">update</a></th>
                    </tr>
                </c:if>
                <c:if test="${requestScope.update_status} != null">
                    <p>Update successful</p>
                </c:if>
            </c:forEach>   
        </table>
        <h1>Deactivate</h1>       
        <br>
        <table border = "1">
            <tr>
                <th>Product ID</th>
                <th>Product Name</th>
                <th>Category</th>
                <th>Type</th>
                <th>Is Vegetarian</th>
                <th>Is Vegan</th>
                <th>Has Special Dietary Requirements</th>
                <th>Product Size</th>
                <th>Stock</th>
                <th>Unit sold</th>
                <th>Describe</th>
                <th>Status</th>
                <th>Update</th>
            </tr>
            <c:forEach var="product" items="${requestScope.products}">
                <c:if test= "${product.isStatus == 0}" >
                    <tr>
                        <th>${product.productID}</th>
                        <th>${product.productName}</th>
                        <th>${product.category.categoryName}</th>
                        <th>${product.type.typeName}</th>
                        <th>${product.isVegetarian}</th>
                        <th>${product.isVegan}</th>
                        <th>${product.hasSpecialDietaryRequirements}</th>
                        <th>${product.productSize}</th>
                        <th>${product.productPrice}</th>
                        <th>${product.productStock}</th>
                        <th>${product.productUnitSold}</th>
                        <th>${product.productDescribe}</th>
                        <th>${product.isStatus == 1 ? "Activate" : "Deactivate"}</th>
                        <th><a href="UpdateProductServlet?productID=${product.productID}">update</a></th>
                    </tr>
                </c:if>
                <c:if test="${requestScope.update_status} != null">
                    <p>Update successful</p>
                </c:if>
            </c:forEach>
        </table> 
    </body>
</html>

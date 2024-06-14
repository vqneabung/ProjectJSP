<%-- 
    Document   : admin_product_update
    Created on : May 23, 2024, 10:03:40 PM
    Author     : VQN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Update Product</h1>
        <h1>Update</h1>
        <form action="/ProjectJSP/UpdateProductServlet">
            <p><input type="text" name="update_productName" placeholder="Enter Produce Name" value="${requestScope.productName}" required=""/>*</p>
            <p>
                <select name="update_categoryID" >
                    <c:forEach items="${requestScope.categoryList}" var="category">
                        <option value="${category.categoryID}">${category.categoryID}.${category.categoryName}</option>
                    </c:forEach>
                </select>
            </p>
            <p>
                <select name="update_typeID">
                    <option value="1">Thức ăn</option>
                    <option value="2">Nguyên liệu</option>
                </select>
            </p>
            <p>
                <select name="update_isVegetarian">
                    <option value="1">Có</option>
                    <option value="0" ${requestScope.isVegetarian == 0 ? "selected" : ""}>Không</option>
                </select>
            </p>
            <p>
                <select name="update_isVegan">
                    <option value="1">Có</option>
                    <option value="0" ${requestScope.isVegan == 0 ? "selected" : ""} >Không</option>
                </select>
            </p>
            <p>
                <select name="update_hasSpecialDietaryRequirements">
                    <option value="1">Có</option>
                    <option value="0" ${requestScope.hasSpecialDietaryRequirements == 0 ? "selected" : ""}>Không</option>
                </select>
            </p>
            <p><input type="text" name="update_size" value="${requestScope.size}" placeholder="Enter Size" />*</p>
            <p><input type="number" name="update_price" value="${requestScope.price}" placeholder="Enter Price" required=""/>*</p>
            <p><input type="number" name="update_stock" value="${requestScope.stock}" placeholder="Enter Stock" required=""/>*</p>
            <p><input type="number" name="update_unitSold" value="${requestScope.unitSold}" placeholder="Enter Unit Sold" required=""/>*</p>
            <p>
                <select name="update_status">
                    <option value="1">Có</option>
                    <option value="0" ${requestScope.status == 0 ? "selected" : ""}>Không</option>
                </select>
            </p>
            <textarea id="text_describe" rol="30" col="30" name="update_describe" placeholder="Write Describe">${requestScope.describe}</textarea>
            <input hidden name="productID" value="${requestScope.productID}"/>
            <p><input type="submit" name="update_click" value="Insert"/></p>
        </form>
    </body>
</html>

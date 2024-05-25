<%-- 
    Document   : admin_product_insert
    Created on : May 21, 2024, 9:39:10 PM
    Author     : VQN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/common/web/add_css_js.jsp"%>  
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Insert Product</h1>
        <h1>Insert</h1>
        <form action="/ProjectJSP/InsertProductServlet" method="post">
            <p><input type="text" name="insert_productName" placeholder="Enter Produce Name" required=""/>*</p>
            <p>
                <select name="insert_categoryID" >
                    <c:forEach items="${requestScope.categoryList}" var="category">
                        <option value="${category.categoryID}">${category.categoryID}.${category.categoryName}</option>
                    </c:forEach>
                </select>
            </p>

            <p>
                <select name="insert_typeID">
                    <option value="1">Thức ăn</option>
                    <option value="2">Nguyên liệu</option>
                </select>
            </p>
            <p>
                <select name="insert_isVegetarian">
                    <option value="1">Có</option>
                    <option value="0">Không</option>
                </select>
            </p>
            <p>
                <select name="insert_isVegan">
                    <option value="1">Có</option>
                    <option value="0">Không</option>
                </select>
            </p>
            <p>
                <select name="insert_hasSpecialDietaryRequirements">
                    <option value="1">Có</option>
                    <option value="0">Không</option>
                </select>
            </p>
            <p><input type="text" name="insert_size" placeholder="Enter Size"/>*</p>
            <p><input type="number" name="insert_price" placeholder="Enter Price" required=""/>*</p>
            <p><input type="number" name="insert_stock" placeholder="Enter Stock" required=""/>*</p>
            <p><input type="number" name="insert_unitSold" placeholder="Enter Unit Sold" required=""/>*</p>
            <textarea id="text_describe" rol="5" col="5" name="insert_describe" placeholder="Write Describe"></textarea>
            <p><input type="submit" name="btn_insert" value="Insert"/></p>
        </form>
    </body>
</html>

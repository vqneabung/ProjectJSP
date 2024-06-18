<%-- 
    Document   : admin_specmeal_insert
    Created on : May 26, 2024, 4:16:29 PM
    Author     : VQN
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <title>JSP Page</title>
        <%@include file="/common/web/add_css_js.jsp"%>  
    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>
        <%@include file="../../common/admin/sidebar.jsp" %>
        <div class="main">
            <h1>Thêm kế hoạch ${requestScope.specMeal.specMealName} </h1>
            <form action="/ProjectJSP/InsertSpecMealServlet" method="post">
                <p> Chọn sản phẩm
                    <select name="insert_productID" >
                        <c:forEach items="${requestScope.productList}" var="product">
                            <option value="${product.productID}">${product.productID}.${product.productName}</option>
                        </c:forEach>
                    </select>
                </p>

                <p> Chọn buổi 
                    <select name="insert_dishID" >
                        <c:forEach items="${requestScope.dishList}" var="dish">
                            <option value="${dish.dishID}">${dish.dishID}.${dish.dishName}</option>
                        </c:forEach>
                    </select>
                </p>

                <p> Chọn ngày
                    <select name="insert_dayNum" >
                        <c:forEach items="${requestScope.dayList}" var="day">
                            <option value="${day.dayNum}">${day.dayNum}.${day.dayText}</option>
                        </c:forEach>
                    </select>
                </p>

                <input hidden name="insert_specMealID" value="${requestScope.specMeal.specMealID}">
                <p><input type="submit" name="btn_insert" value="Insert"/></p>
            </form>
        </div>
    </body>
</html>

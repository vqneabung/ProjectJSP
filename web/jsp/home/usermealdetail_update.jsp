<%-- 
    Document   : usermeal_update
    Created on : Jun 4, 2024, 5:48:48 PM
    Author     : VQN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cập nhật kế hoạch</title>
    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>  
        <div class="container" style="margin-top: 1rem" >
            <h1> Câp nhật bữa ăn của bạn </h1>
            <div class="card" style="margin: 1rem 0">
                <div class="card-body">
                    <form action="/ProjectJSP/UpdateUserMealDetailServlet" method="post">
                        <p> 
                            <label>Chọn thức ăn</label>
                            <select class="form-control" name="update_productID" >
                                <c:forEach items="${requestScope.productList}" var="product">
                                    <option value="${product.productID}" ${product.productID == requestScope.userMealDetail.product.productID ? "selected" : ""}>${product.productID}.${product.productName}</option>
                                </c:forEach>
                            </select>
                        </p>

                        <p>
                            <label>Chọn buổi</label>
                            <select class="form-control" name="update_dishID" >
                                <c:forEach items="${requestScope.dishList}" var="dish">
                                    <option value="${dish.dishID}" ${dish.dishID == requestScope.userMealDetail.dish.dishID ? "selected" : ""}>${dish.dishID}.${dish.dishName}</option>
                                </c:forEach>
                            </select>
                        </p>

                        <p>
                            <label>Chọn ngày</label>
                            <select class="form-control" name="update_dayNum" >
                                <c:forEach items="${requestScope.dayList}" var="day">
                                    <option value="${day.dayNum}" ${day.dayNum == requestScope.userMealDetail.day.dayNum ? "selected" : ""}>${day.dayNum}.${day.dayText}</option>
                                </c:forEach>
                            </select>
                        </p>

                        <input hidden name="update_userMealDetailID" value="${requestScope.userMealDetailID}">
                        <p><input type="submit" name="btn_update" value="Update"/></p>
                    </form>
                </div>
            </div>
        </div>
        <%@include file="../../common/web/footer.jsp" %>  
    </body>
</html>

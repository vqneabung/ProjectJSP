<%-- 
    Document   : admin_order_detail
    Created on : Jun 19, 2024, 4:12:18 PM
    Author     : VQN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết đơn hàng</title>
    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>
        <%@include file="../../common/admin/sidebar.jsp" %>
        <div class="main">
            <h1>Đơn hàng chi tiết của mã đơn hàng ${requestScope.orderID}</h1>
            <table class="table table-hover text-center">
                <tr>
                    <th>Mã</th>
                    <th>Tên sản phẩm</th>
                    <th>Số lượng</th>
                    <th>Hình ảnh</th>

                </tr>
                <c:forEach var="orderDetail" items="${requestScope.orderDetailList}">
                    <tr style="font-size: medium">               
                        <th>${orderDetail.orderDetailID}</th>
                        <th>${orderDetail.product.productName}</th>
                        <th>${orderDetail.quantity}</th>
                        <th><img src="${orderDetail.product.productImage[0]}" alt="${orderDetail.product.productImage[0]}" weight="100" height="100" image"/></th>
                    </tr>
                </c:forEach>
            </table> 
        </div>
    </body>
</html>

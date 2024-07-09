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
                    <th>Giá</th>
                    <th>Tổng</th>
                    <th>Hình ảnh</th>
                </tr>
                <c:forEach var="orderDetail" items="${requestScope.orderDetailList}">
                    <c:set var="total" value="${total + (orderDetail.product.productPrice * orderDetail.quantity)}" />
                    <tr style="font-size: medium">               
                        <td>${orderDetail.orderDetailID}</td>
                        <td>${orderDetail.product.productName}</td>
                        <td>${orderDetail.quantity}</td>
                        <td>${orderDetail.product.productPrice}</td>
                        <td>${orderDetail.product.productPrice * orderDetail.quantity}</td>
                        <td><img src="${orderDetail.product.productImage[0]}" alt="${orderDetail.product.productImage[0]}" weight="100" height="100" image"/></td>
                    </tr>
                </c:forEach>
                <tr>
                    <th colspan="3">
                    </th>
                    <th>
                        <h5>Tổng:</h5>
                    </th>
                    <th>
                        <span id="totalCartValue">${total} VND</span>
                    </th>
                    <th>
                    </th>
                </tr>
            </table> 
        </div>
    </body>
</html>

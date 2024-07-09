<%-- 
    Document   : admin_statistic
    Created on : Jun 20, 2024, 3:34:42 PM
    Author     : VQN
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thống kê</title>
    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>
        <%@include file="../../common/admin/sidebar.jsp" %>
        <%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
        <div class="main">
            <h1>Thống kê</h1>
            <div class="row" style="margin-left: 5px">
                <div class="card col-5">
                    <div class="card-body">
                        <div>
                            <h5>Số lượng nhân viên: ${requestScope.products.size()}</h5>
                        </div>
                    </div>
                </div>
                <div class="col-1"></div>
                <div class="card col-5">
                    <div class="card-body">
                        <div>
                            <h5>Số lượng nguời dùng: ${requestScope.users.size()}</h5>
                        </div>
                    </div>
                </div>
            </div>
                        <table class="styled-table" style="width: 100%">
                <tr>
                    <th>Order ID</th>
                    <th>User</th>
                    <th>Total Price</th>
                    <th>Payment Method</th>
                    <th>Order Date</th>
                    <th>Status</th>
                </tr>
                <br>
                <c:forEach var="order" items="${requestScope.orders}">
                    <tr>
                        <td>${order.orderID}</td>
                        <td>${order.user.userName}</td> <!-- Assuming UserDTO has a username field -->
                        <td>${order.totalPrice}</td>
                        <td>${order.payment.paymentName}</td> <!-- Assuming PaymentDTO has a paymentMethod field -->
                        <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy"/></td> <!-- You need to include fmt taglib for this -->
                        <td id="status_id_${order.orderID}">
                            ${order.orderStatus == 1 ? "Pending" : order.orderStatus == 2 ? "Confirmed" : "Cancelled"}
                        </td> <!-- Example status representation -->
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>
</body>
</html>

<%-- 
    Document   : admin_orders
    Created on : Jun 17, 2024, 10:05:22 PM
    Author     : VQN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lí đơn hàng</title>
    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>
        <%@include file="../../common/admin/sidebar.jsp" %>
        <%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
        <div class="main">
            <h1>Quản lí Đơn hàng</h1>
            <a class="btn btn-primary" type="button" title="In" onclick="myApp.printTable()">
                <i class="fas fa-print"></i> In dữ liệu</a>
            <a class="btn btn-primary" type="button" title="In" href="/ProjectJSP/ManageOrderServlet?function=orderByAddress" >
                <i class="fas fa-print"></i>Chế độ phân loại theo địa chỉ</a>
            <table class="styled-table" id="orderList">
                <thead>
                    <tr class="order-head">
                        <th class='text-center'>Order ID</th>
                        <th>User</th>
                        <th>Total Price</th>
                        <th>Payment Method</th>
                        <th>Order Date</th>
                        <th>Order Address</th>
                        <th>Status</th>
                        <th>Actions</th>
                        <th>Detail</th>
                    </tr>
                <thead>
                <tbody>
                    <c:forEach var="order" items="${requestScope.orders}">
                        <tr class="order-body">
                            <td>${order.orderID}</td>
                            <td>${order.user.userName}</td>
                            <td>${order.totalPrice}</td>
                            <td>${order.payment.paymentName}</td> 
                            <td><fmt:formatDate value="${order.orderDate}" type = "both"/></td>
                            <td>${order.user.address}</td>
                            <td id="status_id_${order.orderID}">
                                ${order.orderStatus == 1 ? "Pending" : order.orderStatus == 2 ? "Confirmed" : "Cancelled"}
                            </td> 
                            <td id="action_id_${order.orderID}">
                                <c:if test="${order.orderStatus != 2 && order.orderStatus != 3}">
                                    <button class="btn btn-primary btn-confirm" data-order-id="${order.orderID}" id="confirm_order">Confirm</button>
                                    <button class="btn btn-outline-primary btn-cancel" data-order-id="${order.orderID}" id="cancel_order">Cancel</button>
                                </c:if>
                            </td>
                            <td>                           
                                <a class="btn btn-secondary btn-detail" data-order-id="${order.orderID}" id="detail_order" href="/ProjectJSP/ManageOrderDetailServlet?orderID=${order.orderID}">Detail</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <script>

                var myApp = new function () {
                    this.printTable = function () {
                        var tab = document.getElementById('orderList');
                        var win = window.open('', '', 'height=700,width=700');
                        win.document.write(tab.outerHTML);
                        win.document.close();
                        win.print();
                    };
                };


                $(document).ready(function () {
                    // Xử lý khi click vào nút Confirm

                    $('#orderList').DataTable({
                        "language": {
                            "lengthMenu": "Hiển thị _MENU_ mục mỗi trang"
                        },
                        "columnDefs": [
                            {"type": "date", "targets": 4} // Cột chứa ngày là cột thứ 3 (chỉ số 2)
                        ],
                        "order": [[4, "desc"]] // Sắp xếp cột thứ 3 theo thứ tự giảm dần
                    });

                    $('.btn-confirm').click(function () {
                        var orderID = $(this).data('order-id');
                        updateOrderStatus(orderID, 2);
                    });

                    // Xử lý khi click vào nút Cancel
                    $('.btn-cancel').click(function () {
                        var orderID = $(this).data('order-id');
                        updateOrderStatus(orderID, 3);
                    });


                    // Hàm gửi yêu cầu AJAX để cập nhật trạng thái đơn hàng
                    function updateOrderStatus(orderID, newStatus) {
                        $.ajax({
                            type: 'POST',
                            url: '/ProjectJSP/UpdateOrderServlet', // Đường dẫn API hoặc servlet để xử lý yêu cầu cập nhật trạng thái
                            data: {
                                orderID: orderID,
                                newStatus: newStatus
                            },
                            success: function (response) {
                                // Xử lý phản hồi từ máy chủ nếu cần thiết
                                if (response.success) {
                                    // Cập nhật giao diện người dùng nếu muốn
                                    // Ví dụ: thay đổi văn bản "Pending" thành "Confirmed" hoặc "Cancelled"
                                    // Đây là phần bạn có thể thay đổi giao diện người dùng mà không cần tải lại trang
                                    if (newStatus === 2) {
                                        // Cập nhật status cell
                                        $('#action_id_' + orderID).find('button').hide();
                                        $('#status_id_' + orderID).text("Confirmed");
                                    } else if (newStatus === 3) {
                                        // Cập nhật status cell
                                        $('#action_id_' + orderID).find('button').hide();
                                        $('#status_id_' + orderID).text("Cancelled");
                                    }
                                } else {
                                    alert('Update failed');
                                }
                            },
                            error: function () {
                                alert('Error updating order status');
                            }
                        });
                    }
                });
            </script>
        </div>
    </body>
</html>

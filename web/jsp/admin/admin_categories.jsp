<%-- 
    Document   : admin_categories
    Created on : Jul 4, 2024, 8:05:33 AM
    Author     : VQN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lí thể loại</title>
    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>
        <%@include file="../../common/admin/sidebar.jsp" %>
        <%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
        <div class="main">
            <h1>Quản lí Thể loại</h1>
            <a class="btn btn-primary" type="button" title="In" onclick="myApp.printTable()">
                <i class="fas fa-print"></i> In dữ liệu</a>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#insertCategory">Chèn thể loại</button>
            <table class="styled-table" id="categoryList">
                <thead>
                    <tr class="category-head">
                        <th class='text-center'>Order ID</th>
                        <th>CategoryID</th>
                        <th>Tên thể loại</th>
                        <th>Hành động</th>
                    </tr>
                <thead>
                <tbody>
                    <c:forEach var="category" items="${requestScope.categories}">
                        <tr class="category-body">
                            <td>${category.categoryID}</td>
                            <td>${category.categoryName}</td>
                            <td>${category.type.typeName}</td>
                            <td><a class="btn btn-primary" href="RemoveCategoryServlet?categoryID=${category.categoryID}">Xóa</a></td>                
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="modal fade" id="insertCategory" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="staticBackdropLabel">Chèn thể loại</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="InsertCategoryServlet" method="get">
                                Nhập tên thể loại<input type="text" name="insert_categoryName" value="" class="form-control">
                                Nhập dạng 
                                <select class="form-control" name="insert_typeID" onchange="">
                                    <option value="1">Thức ăn</option>
                                    <option value="2">Nguyên liệu</option>
                                </select>
                                <br>
                                <input type="submit" name="btn_insert" value="Chèn" class="form-control">
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
            <script>

                var myApp = new function () {
                    this.printTable = function () {
                        var tab = document.getElementById('categoryList');
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
                        }
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

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Deactivate Users</title>
    </head>
    <body>
        <%@ include file="../../common/web/header.jsp" %>
        <%@ include file="../../common/admin/sidebar.jsp" %>
        <div class="main card">
            <div class="card-body">
                <h1>Quản lí người dùng không hoạt động</h1>
                <div>
                    <a class="btn btn-secondary btn-lg active" href="${pageContext.request.contextPath}/InsertUserServlet">Chèn người dùng</a> 
                    <a class="btn btn-third btn-lg active" href="${pageContext.request.contextPath}/ManageUserServlet?action=activateUser">Người dùng đang hoạt động</a> 
                    <a class="btn btn-primary btn-lg active" type="button" onclick="searchAdvance()"> <i class="fas fa-print"></i> Tìm nâng cao</a> 
                </div>
                <br>
                <div id="searchAdvance" hidden="hidden">
                    <div class="card">
                        <div class="card-body">
                            <div class="card-title">
                                <h6>Tìm người dùng</h6>
                            </div>
                            <div>
                                <form id="searchForm">
                                    <div class="row">
                                        <div class="col-4">
                                            <label for="search_username">Username:</label>
                                            <input class="form-control" type="text" id="search_username" name="search_username">
                                        </div>
                                        <br>
                                        <div class="col-4">
                                            <label for="search_fullName">Tên đầy đủ:</label>
                                            <input class="form-control" type="text" id="search_fullName" name="search_username">
                                        </div>
                                        <br>
                                        <div class="col-4">
                                            <label for="search_email">Email:</label>
                                            <input class="form-control" type="email" id="search_email" name="search_username">
                                        </div>
                                    </div>
                                    <br>
                                    <div class="row">
                                        <div class="col-4">
                                            <label for="search_phone">Phone:</label>
                                            <input class="form-control" type="tel" id="search_phone" name="search_phone">
                                        </div>
                                        <br>
                                        <div class="col-4">
                                            <label for="search_role">Vai trò:</label>
                                            <select class="form-control" id="search_role" name="search_role">
                                                <option value="">-- Chọn vai trò --</option>
                                                <option value="0">Admin</option>
                                                <option value="1">Người dùng</option>
                                            </select>
                                        </div>
                                        <br>
                                        <div class="col-4">
                                            <label for="search_address">Địa chỉ:</label>
                                            <input class="form-control" type="text" id="search_address" name="search_address">
                                        </div>

                                        <div class="col-4" style="margin-top: 1rem">
                                            <label for="search_dateCreate">Thời gian</label>
                                            <input id="search_dateCreate" class="form-control" type="date" />
                                        </div>
                                    </div>
                                    <br>
                                    <button class="btn btn-primary" type="submit">Tìm kiếm</button>
                                    <a class="btn btn-primary" id="reset" onclick="reset()">Xóa tất cả</a>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <c:if test="${not empty error}">
                    <p style="color: red;">${error}</p>
                </c:if>
                <style>
                    #head th{
                        text-align: center;
                    }
                </style>
                <div id="userList">
                    <table class="styled-table" id="userListTable">
                        <thead>
                            <tr class="text-center" id="head">
                                <th>Avatar</th>
                                <th>Username</th>
                                <th>Tên đầy đủ</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Vai trò</th>
                                <th>Địa chỉ</th>
                                <th>Hành động</th>
                                <th>Lịch sử hoạt đông</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${requestScope.users}">
                                <c:if test="${user.status == 0}">
                                    <tr style="font-size: medium; text-align: center">
                                        <td><img src="${user.avatar}" alt="${user.userID}" width="100" height="100"/></td>
                                        <td>${user.userName}</td>
                                        <td>${user.fullName}</td>
                                        <td>${user.email}</td>
                                        <td>${user.phone}</td>
                                        <td>${user.roleID == 1 ? "Người dùng" : "Admin"}</td>
                                        <td>${user.address}</td>
                                        <td>
                                            <a class="btn btn-primary text-center" style="" href="${pageContext.request.contextPath}/RemoveUserServlet?userID=${user.userID}">Xóa</a>
                                            <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/UpdateUserServlet?userID=${user.userID}">Cập nhật</a>
                                        </td>
                                        <td>
                                            <a class="btn btn-outline-primary" href="/ProjectJSP/ManageUserActivityServlet?userID=${user.userID}">Chi tiết</a>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
    <script>

        var myApp = new function () {
            this.printTable = function () {
                var tab = document.getElementById('userListTable');
                var win = window.open('', '', 'height=700,width=700');
                win.document.write(tab.outerHTML);
                win.document.close();
                win.print();
            };
        };

        function searchAdvance() {
            var searchAdvance = document.getElementById("searchAdvance");

            if (searchAdvance.getAttribute("hidden") === "hidden") {
                searchAdvance.removeAttribute("hidden");
            } else {
                searchAdvance.setAttribute("hidden", "hidden");
                reset();
            }
        }

        function reset() {
            var searchForm = document.getElementById("searchForm");
            searchForm.reset();
            search(event);
        }

        function search(event) {
            // Ngăn chặn hành động mặc định của form (tải lại trang)
            event.preventDefault();
            $.ajax({
                type: 'POST',
                url: '/ProjectJSP/SearchUserServlet',
                data: {
                    userName: $('#search_username').val().trim(),
                    fullName: $('#search_fullName').val().trim(),
                    email: $('#search_email').val().trim(),
                    phone: $('#search_phone').val().trim(),
                    roleID: $('#search_role').find(":selected").val(),
                    address: $('#search_address').val().trim(),
                    dateCreate: $('#search_dateCreate').val().trim()
                },
                success: function (data) {
                    var html = '';
                    var userList = data;
                    html += '<table class="styled-table" id="userListTable"><thead><tr class="text-center" id="head"> <th>Avatar</th><th>Username</th><th>Tên đầy đủ</th><th>Email</th><th>Phone</th><th>Vai trò</th><th>Địa chỉ</th><th>Hành động</th><th>Lịch sử hoạt đông</th></tr></thead>';
                    $.each(userList, function (index, user) {
                        if (user.status === 0) {
                            html += '<tr class="text-center" style="font-size: medium">';
                            html += '<td><img src="' + user.avatar + '" alt="' + user.userID + '" width="100" height="100"/></td>';
                            html += '<td>' + user.userName + '</td>';
                            html += '<td>' + user.fullName + '</td>';
                            html += '<td>' + user.email + '</td>';
                            html += '<td>' + user.phone + '</td>';
                            html += '<td>' + (user.roleID === 1 ? 'Người dùng' : 'Admin') + '</td>';
                            html += '<td>' + user.address + '</td>';
                            html += '<td>';
                            html += '<a class="btn btn-primary" href="/ProjectJSP/RemoveUserServlet?userID=' + user.userID + '">Xóa</a>';
                            html += '<a class="btn btn-outline-primary" href="/ProjectJSP/UpdateUserServlet?userID=' + user.userID + '">Cập nhật</a>';
                            html += '<td><a class="btn btn-outline-primary" href="/ProjectJSP/ManageUserActivityServlet?userID=' + user.userID + '">Chi tiết</a></td>';
                            html += '</td>';
                            html += '</tr>';
                        }
                    });
                    html += '</table>';
                    $('#userList').html(html);
                    $('#userListTable').DataTable({
                        "info": false,
                        "columnDefs": [
                            {"orderable": false, "targets": [7, 8]} // Vô hiệu hóa sắp xếp cho cột "Hành động" và "Lịch sử hoạt động"
                        ],
                        "language": {
                            "lengthMenu": "Hiển thị _MENU_ mục mỗi trang"
                        }

                    });
                },
                error: function () {
                    alert('Đã xảy ra lỗi khi gửi yêu cầu tìm kiếm.');
                }
            });
        }

        $(document).ready(function () {
            $('#userListTable').DataTable({
                "info": false,
                "columnDefs": [
                    {"orderable": false, "targets": [7, 8]} // Vô hiệu hóa sắp xếp cho cột "Hành động" và "Lịch sử hoạt động"
                ],
                "language": {
                    "lengthMenu": "Hiển thị _MENU_ mục mỗi trang"
                }

            });
            $('#searchForm').submit(search);
            $('#reset').click(reset());

        });

    </script>
</html>

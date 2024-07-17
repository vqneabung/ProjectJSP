<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib  uri="/WEB-INF/tlds/web_taglib" prefix="t" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách người dùng</title>
    </head>
    <body>
        <%@ include file="../../common/web/header.jsp" %>
        <%@ include file="../../common/admin/sidebar.jsp" %>
        <div class="main card">
            <div class="card-body">
                <h1>Quản lí người dùng đang hoạt động</h1>
                <div>
                    <a class="btn btn-secondary btn-lg active" href="/ProjectJSP/InsertUserServlet">Chèn người dùng</a> 
                    <a class="btn btn-third btn-lg active" href="/ProjectJSP/ManageUserServlet?action=deactivateUser">Người dùng không hoạt động</a> 
                    <a class="btn btn-primary btn-lg active" type="button" title="In" onclick="myApp.printTable()"> <i class="fas fa-print"></i> In dữ liệu</a>
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
                                                <option value="0">Người dùng</option>
                                                <option value="1">Admin</option>
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
                                    <a class="btn btn-primary" id="reset">Xóa tất cả</a>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <br>
            <style>
                #head th{
                    text-align: center;
                }
            </style>
            <c:if test="${msg != null}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    
                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                    <symbol id="check-circle-fill" fill="currentColor" viewBox="0 0 16 16">
                        <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
                    </symbol>
                    <symbol id="info-fill" fill="currentColor" viewBox="0 0 16 16">
                        <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm.93-9.412-1 4.705c-.07.34.029.533.304.533.194 0 .487-.07.686-.246l-.088.416c-.287.346-.92.598-1.465.598-.703 0-1.002-.422-.808-1.319l.738-3.468c.064-.293.006-.399-.287-.47l-.451-.081.082-.381 2.29-.287zM8 5.5a1 1 0 1 1 0-2 1 1 0 0 1 0 2z"/>
                    </symbol>
                    <symbol id="exclamation-triangle-fill" fill="currentColor" viewBox="0 0 16 16">
                        <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                    </symbol>
                    </svg>

                    <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Success:"><use xlink:href="#check-circle-fill"/></svg>
                    <c:if test="${msg == 'updateSuccessfully'}">
                        Cập nhật thành công
                    </c:if>
                    <c:if test="${msg == 'updateFailed'}">
                        Cập nhật thất bại
                    </c:if>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
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
                            <th>Thời gian tạo</h1>
                            <th>Hành động</th>
                            <th>Lịch sử hoạt đông</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${requestScope.users}">
                            <c:if test="${user.status == 1}">
                                <tr style="font-size: medium" class="text-center">
                                    <td><img src="${user.avatar}" alt="${user.userID}" width="100" height="100"/></td>
                                    <td>${user.userName}</td>
                                    <td>${user.fullName}</td>
                                    <td>${user.email}</td>
                                    <td>${user.phone}</td>
                                    <td>${user.roleID == 1 ? "Người dùng" : "Admin"}</td>
                                    <td>${user.address}</td>
                                    <td>${user.dateCreate}</td>
                                    <td>
                                        <c:if test="${user.userID != sessionScope.User.userID}">
                                            <a class="btn btn-primary" href="/ProjectJSP/RemoveUserServlet?userID=${user.userID}">Xóa</a>
                                        </c:if>
                                        <a class="btn btn-outline-primary" href="/ProjectJSP/UpdateUserServlet?userID=${user.userID}">Cập nhật</a>
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

        if (window.location.search.includes('msg=')) {
            // Sử dụng replaceState để thay đổi URL mà không tải lại trang
            window.history.replaceState(null, '', '/ProjectJSP/ManageUserServlet');
        }



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
                    html += '<table class="styled-table" id="userListTable"><thead><tr class="text-center" id="head"> <th>Avatar</th><th>Username</th><th>Tên đầy đủ</th><th>Email</th><th>Phone</th><th>Vai trò</th><th>Password</th><th>Địa chỉ</th><th>Thời gian tạo</h1><th>Trạng thái</th><th>Hành động</th><th>Lịch sử hoạt đông</th></tr></thead>';
                    $.each(userList, function (index, user) {
                        if (user.status === 1) {
                            html += '<tr class="text-center" style="font-size: medium">';
                            html += '<td><img src="' + user.avatar + '" alt="' + user.userID + '" width="100" height="100"/></td>';
                            html += '<td>' + user.userName + '</td>';
                            html += '<td>' + user.fullName + '</td>';
                            html += '<td>' + user.email + '</td>';
                            html += '<td>' + user.phone + '</td>';
                            html += '<td>' + (user.roleID === 1 ? 'Người dùng' : 'Admin') + '</td>';
                            html += '<td>' + user.password + '</td>';
                            html += '<td>' + user.address + '</td>';
                            html += '<td>' + user.dateCreate + '</td>';
                            html += '<td>' + (user.status === 1 ? 'Hoạt động' : 'Không hoạt động') + '</td>';
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
                            {"orderable": false, "targets": [8, 9]} // Vô hiệu hóa sắp xếp cho cột "Hành động" và "Lịch sử hoạt động"
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
                    {"orderable": false, "targets": [8, 9]} // Vô hiệu hóa sắp xếp cho cột "Hành động" và "Lịch sử hoạt động"
                ],
                "language": {
                    "lengthMenu": "Hiển thị _MENU_ mục mỗi trang"
                }

            });
            $('#searchForm').submit(search);
            $('#reset').click(reset);
        }
        );

        <c:if test="${msg == 'emailTrung'}">
        window.onload = () => {
            alert("Email Trùng");
        };
        </c:if>
        <c:if test="${msg == 'insertComplete'}">
        window.onload = () => {
            alert("Chèn người dùng thành công!");
        };
        </c:if>
        <c:if test="${msg == 'insertFail'}">
        window.onload = () => {
            alert("Chèn người dùng thất bại!");
        };
        </c:if>
    </script>
</body>
</html>

<%-- 
    Document   : admin_users
    Created on : May 19, 2024, 4:32:46 PM
    Author     : VQN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>
        <%@include file="../../common/admin/sidebar.jsp" %>
        <div class="main card">
            <div class="card-body">
                <h1>Manage User</h1>
                <div>
                    <a class="btn btn-primary btn-lg active" href="jsp/admin/admin_home.jsp"><--Back to homepage </a>
                    <a class="btn btn-secondary btn-lg active" href="InsertUserServlet">Insert User</a> 
                </div>
                <br>
                <table class="table table-hover text-center">
                    <tr>
                        <th>Avatar</th>
                        <th>Username</th>
                        <th>Tên đầy đủ</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Vai trò</th>
                        <th>Password</th>
                        <th>Địa chỉ</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                    <c:forEach var="user" items="${requestScope.users}">
                        <c:if test= "${user.status != 0}" >
                            <tr style="font-size: medium">
                                <th><img src="${user.avatar}" alt="${user.userID}" weight="100" height="100" image"/></th>
                                <th>${user.userName}</th>
                                <th>${user.fullName}</th>
                                <th>${user.email}</th>
                                <th>${user.phone}</th>
                                <th>${user.roleID == 1 ? "Nguời dùng" : "Admin"}</th>
                                <th>${user.password}</th>
                                <th>${user.address}</th>
                                <th>${user.status == 1 ? "Hoạt động" : "Không hoạt động"}</th>
                                <th><a class="btn btn-primary" href="RemoveUserServlet?userID=${user.userID}">remove</a>
                                    <a class="btn btn-outline-primary" href="UpdateUserServlet?userID=${user.userID}">update</a></th>
                            </tr>
                        </c:if>
                        <c:if test="${requestScope.update_status} != null">
                            <p>Update successful</p>
                        </c:if>
                    </c:forEach>
                </table> 
            </div>
        </div>
    </body>
</html>

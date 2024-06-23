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
                <h1>Deactivate Users</h1>
                <div>
                    <a class="btn btn-primary btn-lg active" href="${pageContext.request.contextPath}/jsp/admin/admin_home.jsp"><--Back to homepage</a>
                    <a class="btn btn-secondary btn-lg active" href="${pageContext.request.contextPath}/InsertUserServlet">Insert User</a> 
                    <a class="btn btn-third btn-lg active" href="${pageContext.request.contextPath}/jsp/admin/admin_users.jsp">Activate Users</a> 
                </div>
                <br>
                <c:if test="${not empty error}">
                    <p style="color: red;">${error}</p>
                </c:if>
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
                    <c:forEach var="user" items="${sessionScope.users}">
                        <c:if test="${user.status == 0}">
                            <tr style="font-size: medium">
                                <td><img src="${user.avatar}" alt="${user.userID}" width="100" height="100"/></td>
                                <td>${user.userName}</td>
                                <td>${user.fullName}</td>
                                <td>${user.email}</td>
                                <td>${user.phone}</td>
                                <td>${user.roleID == 1 ? "Người dùng" : "Admin"}</td>
                                <td>${user.password}</td>
                                <td>${user.address}</td>
                                <td>${user.status == 1 ? "Hoạt động" : "Không hoạt động"}</td>
                                <td>
                                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/RemoveUserServlet?userID=${user.userID}">remove</a>
                                    <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/UpdateUserServlet?userID=${user.userID}">update</a>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </table>
            </div>
        </div>
    </body>
</html>

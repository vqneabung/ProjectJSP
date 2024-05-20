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
        <h1>Manage User</h1>
        <table border = "1">
            <tr>
                <th>UserID</th>
                <th>Username</th>
                <th>Full Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Role</th>
                <th>Password</th>
                <th>Address</th>
                <th>Status</th>
                <th>Remove</th>
                <th>Update</th>
            </tr>
            <c:forEach var="user" items="${requestScope.users}">
                <c:if test= "${user.status != 0}" >
                <tr>
                    <th>${user.userID}</th>
                    <th>${user.userName}</th>
                    <th>${user.fullName}</th>
                    <th>${user.email}</th>
                    <th>${user.phone}</th>
                    <th>${user.roleID == 1 ? "User" : "Admin"}</th>
                    <th>${user.password}</th>
                    <th>${user.address}</th>
                    <th>${user.status}</th>
                    <th><a href="RemoveUserServlet?userID=${user.userID}">remove</a></th>
                    <th><a href="UpdateUserServlet?userID=${user.userID}">update</a></th>
                </tr>
                </c:if>
                <c:if test="${requestScope.update_status} != null">
                    <p>Update successful</p>
                </c:if>
            </c:forEach>
        </table> 
    </body>
</html>

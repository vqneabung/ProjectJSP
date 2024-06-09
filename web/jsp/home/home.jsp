<%-- 
    Document   : home
    Created on : May 17, 2024, 10:37:50 PM
    Author     : VQN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Home</title>

    </head>
    <body>
        <%@include file="../../common/web/footer.jsp" %>
        <%
            if (session.getAttribute("UserRoleID") == "0") {
        %>
        <p><a href="/jsp/admin/admin_home.jsp">Admin</a></p>
        <%
        } else if (session.getAttribute("UserRoleID") == "1") {
        %>
        <p><a href="/ProjectJSP/jsp/home/home.jsp">Home</a></p>
        <%
        } else {
        %>
        <p><a href="/ProjectJSP/StartServlet">Login</a></p>
        <p><a href="/ProjectJSP/LogoutServlet">Logout</a></p>
        <%
            }
        %>
        <%
            out.println(session.getAttribute("User"));
            out.println(session.getMaxInactiveInterval());
        %>
        <h1>${sessionScope.User.roleID == 0}</h1>
        <p><a href="/ProjectJSP/ManageUserMealServlet">Manage User Meal</a></p>
    </body>
</html>

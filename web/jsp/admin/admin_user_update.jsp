<%-- 
    Document   : admin_update_user
    Created on : May 19, 2024, 10:55:27 PM
    Author     : VQN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Update user</h1>
        <form action="/ProjectJSP/UpdateUserServlet" method="post">
            <p><input type="text" name="update_fullname" placeholder="Enter Fullname" value="${requestScope.fullName}" required=""/>*</p>
            <p><input type="text" name="update_username" placeholder="Enter Username" value="${requestScope.userName}" required=""/>*</p>
            <p><input type="email" name="update_email" placeholder="Enter Email" value="${requestScope.email}" required=""/>*</p>  
            <p><input type="text" name="update_phone" placeholder="Enter Phone" value="${requestScope.phone}" required=""/>*</p>
            <p><input type="password" name="update_password" placeholder="Enter password" value="${requestScope.password}" required=""/>*</p>
            <p><input type="text" name="update_address" placeholder="Enter Address" value="${requestScope.address}" required=""/>*</p>
            <p>
                <select name="update_role">
                    <option value="0">Admin</option>
                    <option value="1">User</option>
                </select>
            </p>
            <p>
                <select name="update_status">
                    <option value="1">Activate</option>
                    <option value="0">Deactivate</option>
                </select>
            </p>
            <input hidden name="userID" value="${requestScope.userID}"/>
            <p><input type="submit" value="Update" name="update_click"/></p>
        </form>
    </body>
</html>

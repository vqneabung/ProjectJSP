<%-- 
    Document   : admin_user_insert
    Created on : May 19, 2024, 10:09:30 PM
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
        <h1>Hello Admin</h1>
        <h1>Insert</h1>
        <form action="/ProjectJSP/InsertUserServlet" method="post">
            <p><input type="text" name="insert_fullname" placeholder="Enter Fullname" required=""/>*</p>
            <p><input type="text" name="insert_username" placeholder="Enter Username" required=""/>*</p>
            <p><input type="email" name="insert_email" placeholder="Enter Email" required=""/>*</p>  
            <p><input type="text" name="insert_phone" placeholder="Enter Phone" required=""/>*</p>
            <p><input type="password" name="insert_password" placeholder="Enter password" required=""/>*</p>
            <p><input type="text" name="insert_address" placeholder="Enter Address" required=""/>*</p>
            <p>
                <select name="insert_role">
                    <option value="0">Admin</option>
                    <option value="1">User</option>
                </select>
            </p>
            <p><input type="submit" value="Insert"/></p>
        </form>
    </body>
</html>

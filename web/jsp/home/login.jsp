<%-- 
    Document   : login
    Created on : May 18, 2024, 4:22:46 PM
    Author     : VQN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%--Them css--%>
        <%@include file="/common/web/add_css.jsp"%>  
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-6">
                    <h1>Login</h1>
                    <form action="/ProjectJSP/LoginServlet" method="post">
                        <p><input type="text" name="login_email" placeholder="Enter Email" required=""/></p>
                        <p><input type="password" name="login_password" placeholder="Enter Password" required=""/></p>
                        <p><input type="submit" value="Login"/></p>
                    </form>
                </div>
                <div class="col-md-6">
                    <h1>Register</h1>
                    <form action="/ProjectJSP/RegisterServlet" method="post">
                        <p><input type="text" name="register_fullname" placeholder="Enter Fullname" required=""/>*</p>
                        <p><input type="text" name="register_username" placeholder="Enter Username" required=""/>*</p>
                        <p><input type="email" name="register_email" placeholder="Enter Email" required=""/>*</p>  
                        <p><input type="text" name="register_phone" placeholder="Enter Phone" required=""/>*</p>
                        <p><input type="text" name="register_address" placeholder="Enter Address" required=""/>*</p>
                        <p><input type="password" name="register_password" placeholder="Enter password" required=""/>*</p>
                        <p><input type="submit" value="Register"/></p>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>

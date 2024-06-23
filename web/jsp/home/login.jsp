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
        <%@include file="/common/web/add_css_js.jsp"%>  
        <title>JSP Page</title>
    </head>
    <body>
        <div class="main">
            <%@include file="../../common/web/header.jsp" %>
            <div class="container" style="margin-top: 1rem  ">
                <div class="row">
                    <div class="col-md-5 card">
                        <div class="card-body">
                            <h1>Login</h1>
                            <form action="/ProjectJSP/LoginServlet" method="post">
                                <div class="form-group">
                                    <label for="login_email">Email</label>
                                    <p><input id="login_email" class="form-control" type="text" name="login_email" placeholder="Enter Email" required=""/></p>
                                </div>
                                <div class="form-group">
                                    <label for="id="login_password"">Password</label>
                                    <p><input type="password" id="login_password" class="form-control" name="login_password" placeholder="Enter Password" required=""/></p>
                                </div>
                                <p><input type="submit"  class="btn btn-primary" value="Login"/></p>
                            </form>
                            <p>${requestScope.msg}</p>
                        </div>
                    </div>
                    <div class="col-md-1"></div>
                    <div class="col-md-5 card">
                        <div class="card-body">
                            <h1>Register</h1>
                            <form action="/ProjectJSP/RegisterServlet" method="post">
                                <p>Tên đầy đủ<input type="text" class="form-control" name="register_fullname" placeholder="Enter Fullname" required=""/></p>
                                <p>Username<input type="text" class="form-control" name="register_username" placeholder="Enter Username" required=""/></p>
                                <p>Email<input type="email" class="form-control" name="register_email" placeholder="Enter Email" required=""/></p>  
                                <p>Số điện thoại<input type="text" class="form-control" name="register_phone" placeholder="Enter Phone" required=""/></p>
                                <p>Địa chỉ<input type="text" class="form-control" name="register_address" placeholder="Enter Address" required=""/></p>
                                <p>Mật khẩu<input type="password" class="form-control" name="register_password" placeholder="Enter password" required=""/></p>
                                <p><input type="submit" class="btn btn-primary" value="Register"/></p>
                            </form>
                            <p>${requestScope.mesg}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

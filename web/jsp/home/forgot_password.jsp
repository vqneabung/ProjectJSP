<%-- 
    Document   : forgot_password
    Created on : Jun 6, 2024, 8:49:31 AM
    Author     : VQN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quên mật khẩu</title>
    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>
        <div class="container" style="margin-top: 1rem">
            <div class="row">
                <div class="col-md-5 card">
                    <div class="card-body" >
                        <div class="row">
                            <!--login area start-->
                            <div class="account_form">
                                <h2>Reset your password</h2>
                                <form action="ForgotPasswordServlet" method="get" class="form-group">
                                    <p> 
                                        <c:if test="${requestScope.STATUS == 'forgot'}">
                                            <label>Enter email you want to receive the code to reset your password?</label><br/>
                                            <input type="email" class="form-control" name="txtEmail" value="${sessionScope.email}"/>
                                        </c:if>
                                        <c:if test="${requestScope.check == 'true'}">
                                        <h7 style="color: green">${requestScope.message}</h7>
                                        </c:if>
                                        <c:if test="${requestScope.check == 'false'}">
                                        <h7 style="color: red">${requestScope.message}</h7>
                                        </c:if>
                                    </p>
                                    <c:if test="${requestScope.STATUS == 'confirm'}">
                                        <p style="position: relative">   
                                            <label>Code - 6 digit <span>*</span></label>
                                            <input  type="number" class="form-control" name="txtCode" value="${requestScope.code}"/>
                                        </p>

                                    </c:if>
                                    <c:if test="${requestScope.STATUS == 'enterpass'}">
                                        <p style="position: relative">
                                            <label>Passwords <span>*</span></label>
                                            <input id="password" type="password" class="form-control" name="txtPassword" value="${requestScope.newpass}" minlength="6"/>
                                            <i id="iconsee" style="cursor: pointer; position: absolute; top: 40px; right: 10px" onclick="changeIcon(this)" class="fa-solid fa-eye-slash"></i>
                                        </p>
                                        <p style="position: relative">
                                            <label>Confirm passwords <span>*</span></label>
                                            <input id="password" type="password" class="form-control" name="txtConfirm" value="${requestScope.confirmpass}" minlength="6"/>
                                            <!--<i id="iconsee" style="cursor: pointer; position: absolute; top: 40px; right: 10px" onclick="changeIcon(this)" class="fa-solid fa-eye-slash"></i>-->
                                        </c:if>
                                    </p>
                                    <c:if test="${requestScope.STATUS != 'success'}">
                                        <div class="login_submit">
                                            <button name="btnAction" class="btn btn-primary" value="Enter" type="submit">Enter</button>
                                        </div>
                                    </c:if>
                                    <c:if test="${requestScope.STATUS == 'success'}">
                                        <div class="user-actions mb-20">
                                            <h3> 
                                                <a class="btn btn-primary" href="/ProjectJSP/StartServlet?action=login">Click here to login</a>     
                                            </h3>
                                        </div>
                                    </c:if>
                                </form>
                            </div>    
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <br>
    </body>
    <%@include file="../../common/web/footer.jsp" %>
</html>

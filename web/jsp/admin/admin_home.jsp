<%-- 
    Document   : admin_home
    Created on : May 19, 2024, 12:12:19 PM
    Author     : VQN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>
        <h1>Hello Admin</h1>
        <p><a href="/ProjectJSP/ManageUserServlet" >Manage User</a></p>
        <p><a href="admin_user_insert.jsp" >Insert User</a></p>
        <p><a href="/ProjectJSP/ManageProductServlet" >Manage Product</a></p>
        <p><a href="/ProjectJSP/InsertProductServlet" >Insert Product</a></p>
        <p><a href="/ProjectJSP/ManageSpecMealServlet" >Manage Spec Meal</a></p>
        <p><a href="/ProjectJSP/jsp/home/home.jsp" >Home</a></p>
        <p><a href="/ProjectJSP/ManageRecipeDetailServlet" >Manage Recipe</a></p>
        <p><a href="/ProjectJSP/LogoutServlet" >Log out</a></p>
        <img src="/ProjectJSP/assets/home/image/PXL_20240314_020041008.jpg" width="100" height="100" alt="alt"/>
    </body>
</html>

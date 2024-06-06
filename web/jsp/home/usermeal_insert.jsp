<%-- 
    Document   : usermeal_insert
    Created on : Jun 3, 2024, 5:03:13 PM
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
        <h1> Add a plan </h1>
        <form action="/ProjectJSP/InsertUserMealServlet" method="post">


            <p> 
                <label>Dien ten ke hoach</label>
                <input type="text" name="insert_userMealName" value =""/>            
            </p>

            <input hidden name="insert_userMealID" value="${sessionScope.User.userID}">
            <h1>${sessionScope.User.userID}</h1>
            <p><input type="submit" name="btn_insert" value="Insert"/></p>
        </form>
    </body>
</html>

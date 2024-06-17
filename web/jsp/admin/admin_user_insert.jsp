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
        <%@include file="../../common/web/header.jsp" %>
        <h1>Hello Admin</h1>
        <h1>Insert</h1>
        <form action="/ProjectJSP/InsertUserServlet" enctype="multipart/form-data" method="post">
            <p>Điền tên đầy đủ<input type="text" name="insert_fullname" placeholder="Enter Fullname" required=""/>*</p>
            <p>Điền username<input type="text" name="insert_username" placeholder="Enter Username" required=""/>*</p>
            <p>Điền email<input type="email" name="insert_email" placeholder="Enter Email" required=""/>*</p>  
            <p>Điền số điện thoại<input type="tel" name="insert_phone" placeholder="Enter Phone" required=""/>*</p>
            <p>Điền mật khẩu<input type="password" name="insert_password" placeholder="Enter password" required=""/>*</p>
            <p>Điền địa chỉ<input type="text" name="insert_address" placeholder="Enter Address" required=""/>*</p>
            <p> Điền vai trò
                <select name="insert_role">
                    <option value="0">Admin</option>
                    <option value="1">User</option>
                </select>
            </p>
            <div >
                File <input type="file" name="insert_avatar" value="" onchange='previewFile()' /><br>
                <img src="/ProjectJSP/assets/home/image/1200px-Picture_icon_BLACK.svg.png" height="200" alt="avatar" id="image" >
                <input type="button" value="Remove Image" name="remove_image" onclick="removeFile()"/>
            </div>
            <p><input type="submit" value="Insert"/></p>
        </form>
        <script type="text/javascript">
            function previewFile() {
                var preview = document.querySelector('img');
                var file = document.querySelector('input[type=file]').files[0];
                var reader = new FileReader();

                reader.onloadend = function () {
                    preview.src = reader.result;
                };

                if (file) {
                    reader.readAsDataURL(file);
                } else {
                    preview.src = "image/1200px-Picture_icon_BLACK.svg.png";
                }
            }

            function removeFile() {
                var preview = document.querySelector('img');
                var input = document.querySelector("input[type='file']");
                preview.src = "image/1200px-Picture_icon_BLACK.svg.png";
                input.value = "";
            }
        </script>
    </body>
</html>

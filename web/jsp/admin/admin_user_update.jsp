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
        <%@include file="../../common/web/header.jsp" %>
        <%@include file="../../common/admin/sidebar.jsp" %>
        <div class="main">
            <h1>Update user</h1>
            <form action="/ProjectJSP/UpdateUserServlet" method="post" enctype="multipart/form-data">
                <p>Tên đầy đủ <input type="text" name="update_fullname" placeholder="Enter Fullname" value="${requestScope.fullName}" required=""/>*</p>
                <p>User name <input type="text" name="update_username" placeholder="Enter Username" value="${requestScope.userName}" required=""/>*</p>
                <p>Email <input type="email" name="update_email" placeholder="Enter Email" value="${requestScope.email}" required=""/>*</p>  
                <p>Số điện thoại <input type="text" name="update_phone" placeholder="Enter Phone" value="${requestScope.phone}" required=""/>*</p>
                <p>Mật khẩu <input type="password" name="update_password" placeholder="Enter password" value="${requestScope.password}" required=""/>*</p>
                <p>Địa chỉ <input type="text" name="update_address" placeholder="Enter Address" value="${requestScope.address}" required=""/>*</p>
                <p>Vai trò 
                    <select name="update_role">
                        <option value="0">Admin</option>
                        <option value="1">User</option>
                    </select>
                </p>
                <p>Tình trạng
                    <select name="update_status">
                        <option value="1">Activate</option>
                        <option value="0">Deactivate</option>
                    </select>
                </p>
                <div>
                    Chọn ảnh <input type="file" name="insert_avatar" value="" onchange='previewFile()' /> <br>
                    <img src="/ProjectJSP/assets/home/image/1200px-Picture_icon_BLACK.svg.png" height="200" alt="avatar" id="image" >
                    <input type="button" value="Remove Image" name="remove_image" onclick="removeFile()"/>
                </div>
                <input hidden name="userID" value="${requestScope.userID}"/>
                <p><input type="submit" value="Update" name="update_click"/></p>
            </form>
            <script type="text/javascript">
                function previewFile() {
                    var preview = document.querySelector('#image');
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
        </div>
    </body>
</html>

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
        <%@include file="../../common/admin/sidebar.jsp" %>
        <div class="main">
            <div class="card">
                <div class="card-body">
                    <h1>Tạo User</h1>
                    <form action="/ProjectJSP/InsertUserServlet" enctype="multipart/form-data" method="post" id="insert_form">
                        <p>Điền tên đầy đủ <input class="form-control" type="text" name="insert_fullname"  placeholder="Enter Fullname" required=""/></p>
                        <p>Điền username <input class="form-control" type="text" name="insert_username" id="insert_username" placeholder="Enter Username" required=""/></p>
                        <p>Điền email <input class="form-control" type="email" name="insert_email" placeholder="Enter Email" required=""/></p>  
                        <p>Điền số điện thoại <input class="form-control" type="tel" name="insert_phone" placeholder="Enter Phone" required=""/></p>
                        <p>Điền mật khẩu <input class="form-control" type="password" name="insert_password" placeholder="Enter password" required=""/></p>
                        <p>Điền địa chỉ <input class="form-control" type="text" name="insert_address" placeholder="Enter Address" size="50" required=""/></p>
                        <p>Điền vai trò 
                            <select class="form-control" name="insert_role">
                                <option value="0">Admin</option>
                                <option value="1">User</option>
                            </select>
                        </p>
                        <div >
                            Chọn tệp <input class="form-control" type="file" name="insert_avatar" value="" onchange='previewFile()' /><br>
                            <img src="/ProjectJSP/assets/home/image/1200px-Picture_icon_BLACK.svg.png" height="200" alt="avatar" id="image" >
                            <input type="button" value="Remove Image" name="remove_image" onclick="removeFile()"/>
                        </div>
                        <p><input class="form-control" type="submit" value="Insert"/> <input type="reset" value="Reset"></p>
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

                        $("#insert_form").submit(function () {
                            var input_value = $("#insert_username").val();
                            var pattern = /^[\x20-\x7E]*$/;
                            if (!pattern.test(input_value)) {
                                $("#insert_username").after('<span class="error">Only printable ASCII is allowed.</span>');
                            }
                        });
                    </script>
                </div>
            </div>
        </div>
    </body>
</html>

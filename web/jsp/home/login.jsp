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
        <title>Đăng nhập</title>
    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>
        <div class="container" style="margin-top: 1rem">
            <div class="row">
                <div class="col-md-5 card">
                    <div class="card-body">
                        <h1>Login</h1>
                        <form action="/ProjectJSP/LoginServlet" method="post">
                            <div class="form-group">
                                <label for="login_email">Email</label>
                                <p><input id="login_email" class="form-control" type="email" name="login_email" placeholder="Enter Email" required=""/></p>
                            </div>
                            <div class="form-group">
                                <label for="id="login_password"">Password</label>
                                <p><input id="login_password" class="form-control" type="password"  name="login_password" placeholder="Enter Password" required=""/></p>
                            </div>
                            <p><input type="submit"  class="btn btn-primary" value="Login"/><a class="btn btn-detail" href="ForgotPasswordServlet?status=forgot">Quên mật khẩu</a></p>
                        </form>
                        <p>${requestScope.msg}</p>
                    </div>
                </div>
                <style>

                    input:invalid + span::after {
                        content: "✖";
                        color: #8b0000;
                    }

                    input:valid + span::after {
                        content: "✓";
                        color: #009000;
                    }

                </style>
                <div class="col-md-1"></div>
                <div class="col-md-5 card">
                    <div class="card-body">
                        <h1>Register</h1>
                        <form action="/ProjectJSP/RegisterServlet" method="post">
                            <p>Tên đầy đủ(*)<input type="text" class="form-control" name="register_fullname" placeholder="Enter Fullname" required/></p>
                            <p>Username(*)<input type="text" class="form-control" name="register_username" placeholder="Enter Username" required/></p>
                            <p>Email(*)<input type="email" class="form-control" name="register_email" placeholder="Enter Email" required/></p>  
                            <p style="margin-bottom: 0rem">Số điện thoại(*)<div style="display: flex"><input style="width: 90%" type="tel" class="form-control" name="register_phone" id="register_phone" placeholder="Enter Phone" required pattern="[0-9]{10}"/><span style="margin-top: 0.35rem; margin-left: 0.25rem" class="validity"></span></div></p>
                            <div>
                                <div class="row">
                                    <div class="col-4">
                                        <select class=" form-control" id="city" aria-label=".form-select-sm" required>
                                            <option value="" selected>Chọn tỉnh thành</option>           
                                        </select>
                                    </div>
                                    <div class="col-4">
                                        <select class="form-control" id="district" aria-label=".form-select-sm" required>
                                            <option value="" selected>Chọn quận huyện</option>
                                        </select>
                                    </div>
                                    <div class="col-4" style="margin-bottom: 1rem">
                                        <select class="form-control" id="ward" aria-label=".form-select-sm" required onchange="enableNumAdress()">
                                            <option value="" selected>Chọn phường xã</option>
                                        </select>
                                    </div>
                                    <div class="col-12">
                                        <input type="text" class="form-control" id="numAddress" disabled="" >
                                    </div>
                                </div>   
                                <br>
                                <div>
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" id="basic-addon1">Địa chỉ(*):</span>
                                        </div>
                                        <input type="text" class="form-control" id="fullAddress" name="register_address" aria-describedby="basic-addon1" readonly required>
                                    </div>
                                </div>    
                            </div>
                            <p>Mật khẩu(*)<input type="password" class="form-control" name="register_password" placeholder="Enter password" required/></p>
                            <p><input type="submit" class="btn btn-primary" value="Register"/></p>
                        </form>
                        <p>${requestScope.mesg}</p>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script>
        var citis = document.getElementById("city");
        var districts = document.getElementById("district");
        var wards = document.getElementById("ward");
        var numAddress = document.getElementById("numAddress");

        var Parameter = {
            url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
            method: "GET",
            responseType: "application/json"
        };
        var promise = axios(Parameter);
        promise.then(function (result) {
            console.log(result.data);
            renderCity(result.data);
        });

        function enableNumAdress() {
            if (citis.value && districts.value && wards.value) {
                numAddress.removeAttribute("disabled");
            } else {
                numAddress.setAttribute("disabled", "");
            }

        }


        numAddress.addEventListener("change", () => {
            if (citis.value && districts.value && wards.value && numAddress.value) {
                const cityName = citis.options[citis.selectedIndex].text;
                const districtName = districts.options[districts.selectedIndex].text;
                const wardName = wards.options[wards.selectedIndex].text;
                const numAddressName = numAddress.value;
                document.getElementById("fullAddress").value = numAddressName + ', ' + wardName + ', ' + districtName + ', ' + cityName;
            } else {
                document.getElementById("fullAddress").value = "";
            }
        });


        function renderCity(data) {
            for (const x of data) {
                citis.options[citis.options.length] = new Option(x.Name, x.Id);
            }
            citis.onchange = function () {
                district.length = 1;
                ward.length = 1;
                console.log("When city onchange " + this.value);
                if (this.value !== "") {
                    const result = data.filter(n => n.Id === this.value);

                    for (const k of result[0].Districts) {
                        district.options[district.options.length] = new Option(k.Name, k.Id);
                    }
                }
            };
            district.onchange = function () {
                ward.length = 1;
                const dataCity = data.filter((n) => n.Id === citis.value);
                if (this.value !== "") {
                    const dataWards = dataCity[0].Districts.filter(n => n.Id === this.value)[0].Wards;

                    for (const w of dataWards) {
                        wards.options[wards.options.length] = new Option(w.Name, w.Id);
                    }
                }
            };


        }
    </script>
</html>

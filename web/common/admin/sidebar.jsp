<style>
    .sidenav {
        height: 100%;
        width: 320px;
        position: fixed;
        z-index: 1;
        top: 0;
        left: 0;
        background-color: #f1f1f1;
        overflow-x: hidden;
        padding-top: 20px;
        margin-top: 4.5rem;
    }

    .sidenav a {
        padding: 6px 8px 6px 16px;
        text-decoration: none;
        font-size: 25px;
        color: #818181;
        display: block;
    }

    .sidenav a:hover {
        color: #f1f1f1;
    }

    .main {
        margin-left: 320px; /* Same as the width of the sidenav */
        font-size: 20px; /* Increased text to enable scrolling */
        padding: 5px 30px;
    }

    @media screen and (max-height: 450px) {
        .sidenav {
            padding-top: 15px;
        }
        .sidenav a {
            font-size: 18px;
        }
    }
</style>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="sidenav">
    <p><a href="/ProjectJSP/StaticAdminServlet">Thống kê</a></p>
    <p><a href="/ProjectJSP/ManageUserServlet" >Quản lí người dùng</a></p>
    <p><a href="/ProjectJSP/ManageProductServlet" >Quản lí sản phẩm</a></p>
    <p><a href="/ProjectJSP/ManageSpecMealServlet" >Quản lí của chuyên gia</a></p>
    <p><a href="/ProjectJSP/ManageRecipeDetailServlet" >Quản lí thực đơn</a></p>
    <p><a href="/ProjectJSP/ManageOrderServlet" >Quản lí giao hàng</a></p>
    <p><a href="/ProjectJSP/jsp/home/home.jsp" >Home</a></p>
    <p><a href="/ProjectJSP/LogoutServlet" >Log out</a></p>
</div>

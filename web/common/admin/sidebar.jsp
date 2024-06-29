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
        color: #818181;
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

    .styled-table {
        border-collapse: collapse;
        margin: 25px 0;
        font-size: 0.9em;
        font-family: sans-serif;
        min-width: 400px;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
    }

    .styled-table thead tr {
        background-color: #009879;
        color: #ffffff;
        text-align: left;
    }

    .styled-table th,
    .styled-table td {
        padding: 12px 15px;
    }

    .styled-table tbody tr {
        border-bottom: 1px solid #dddddd;
    }

    .styled-table tbody tr:nth-of-type(even) {
        background-color: #f3f3f3;
    }

    .styled-table tbody tr:last-of-type {
        border-bottom: 2px solid #009879;
    }

    .styled-table tbody tr.active-row {
        font-weight: bold;
        color: #009879;
    }

    .pagination {
        display: flex;
        justify-content: center;
        padding: 10px;
    }

    .pagination a {
        margin: 0 5px;
        padding: 5px 10px;
        text-decoration: none;
        color: #000;
        border: 1px solid #ddd;
        border-radius: 5px;
    }

    .pagination a.active {
        font-weight: bold;
        background-color: #ddd;
    }
</style>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="border-end bg-white sidenav" id="sidebar-wrapper" style="margin-top: 3.5rem">
    <div class="list-group list-group-flush">
        <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/ProjectJSP/StaticAdminServlet">Thống kê</a>
        <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/ProjectJSP/ManageUserServlet" >Quản lí người dùng</a>
        <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/ProjectJSP/ManageProductServlet" >Quản lí sản phẩm</a>
        <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/ProjectJSP/ManageSpecMealServlet" >Quản lí của chuyên gia</a>
        <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/ProjectJSP/ManageRecipeDetailServlet" >Quản lí thực đơn</a>
        <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/ProjectJSP/ManageOrderServlet" >Quản lí giao hàng</a>
        <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/ProjectJSP/jsp/home/home.jsp" >Home</a>
        <a class="list-group-item list-group-item-action list-group-item-light p-3" href="/ProjectJSP/LogoutServlet" >Log out</a>
    </div>
</div>

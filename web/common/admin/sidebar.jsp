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
<div class="sidenav">
    <p><a href="/ProjectJSP/ManageUserServlet" >Manage User</a></p>
    <p><a href="/ProjectJSP/ManageProductServlet" >Manage Product</a></p>
    <p><a href="/ProjectJSP/ManageSpecMealServlet" >Manage Spec Meal</a></p>
    <p><a href="/ProjectJSP/ManageRecipeDetailServlet" >Manage Recipe</a></p>
    <p><a href="/ProjectJSP/ManageOrderServlet" >Manage Order</a></p>
    <p><a href="/ProjectJSP/jsp/home/home.jsp" >Home</a></p>
    <p><a href="/ProjectJSP/LogoutServlet" >Log out</a></p>
</div>

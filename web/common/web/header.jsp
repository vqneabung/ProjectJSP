<%-- 
    Document   : footer
    Created on : Jun 6, 2024, 8:55:38 AM
    Author     : VQN
--%>


<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="/common/web/add_css_js.jsp"%>  
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<header class="p-3 bg-dark text-white sticky-top">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
            <a href="StartServlet" class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none">
                <img class="bi me-2" width="40" height="32" role="img" src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/FPT_logo_2010.svg/langfr-1920px-FPT_logo_2010.svg.png">
            </a>
            <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
                <li><a href="/ProjectJSP/StartServlet" class="nav-link px-2 text-secondary">Home</a></li>
                <li><a href="/ProjectJSP/StartServlet?action=shopList" class="nav-link px-2 text-white">Shop</a></li>
                    <c:if test="${sessionScope.User != null}">
                    <li><a href="/ProjectJSP/StartServlet?action=mealUser" class="nav-link px-2 text-white">Kế hoạch của bạn</a></li>
                    </c:if>
                <li><a href="/ProjectJSP/StartServlet?action=about" class="nav-link px-2 text-white">About</a></li>
            </ul>
            <c:if test="${sessionScope.User == null}">
                <div class="text-end">
                    <a class="btn btn-primary" href="/ProjectJSP/StartServlet?action=login" role="button" name="login">Login</a>
                </div>
            </c:if>
            <c:if  test="${sessionScope.User != null}">
                <div class="dropdown text-end">
                    <c:if test="${sessionScope.User.roleID == 0}">
                        <a href="#" class="d-block link-dark text-decoration-none dropdown-toggle" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
                            <img src="${sessionScope.User.avatar}" alt="mdo" width="32" height="32" class="rounded-circle">
                        </a> 
                    </c:if>
                    <c:if test="${sessionScope.User.roleID == 1}">
                        <a href="#" class="d-block link-dark text-decoration-none dropdown-toggle" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
                            <img src="${sessionScope.User.avatar}" alt="mdo" width="32" height="32" class="rounded-circle">
                        </a> 
                    </c:if>
                    <ul class="dropdown-menu text-small" aria-labelledby="dropdownUser1" style="">
                        <c:if test="${sessionScope.User.roleID == 0}">
                            <li>
                                <a class="dropdown-item" href="/ProjectJSP/StaticAdminServlet">Admin</a>
                            </li>
                        </c:if>
                        <li><a class="dropdown-item" href="#">Settings</a></li>
                        <li><a class="dropdown-item" href="/ProjectJSP/ProfileServlet">Profile</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="/ProjectJSP/LogoutServlet">Sign out</a></li>
                    </ul>
                </div>
            </c:if>
            <div style="margin-left: 1rem">
                <a type="button" class="btn btn-primary" id="cart" href="/ProjectJSP/jsp/home/cart.jsp"> <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-cart" viewBox="0 0 16 16">
                    <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5M3.102 4l1.313 7h8.17l1.313-7zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4m7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4m-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2m7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2"></path>
                    </svg> Cart <p id="cartCount" style="display: inline">${sessionScope.cart.size() == null ? "0" : sessionScope.cart.size()}</p></a>
            </div>
        </div>
    </div>
</header>

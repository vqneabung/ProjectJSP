<%-- 
    Document   : usermeal
    Created on : Jun 2, 2024, 9:48:07 AM
    Author     : VQN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kế hoạch tuần</title>
    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>    
        <div class="container" style="margin-top: 1rem; margin-bottom: 1rem">
            <div id="loadingMessage">
                <div class="modal" id="loadingModal" tabindex="-1" role="dialog" aria-labelledby="loadingModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-body text-center">
                                <p>Đang load thực đơn của bạn</p>
                                <div class="spinner-border" role="status">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="loadFirst">
                <h1>Kế hoạch của bạn</h1>
                <p><a  href="/ProjectJSP/InsertUserMealServlet?userID=${sessionScope.User.userID}&insert" class="btn btn-primary">Thêm kế hoạch</a></p>   
                <div class="card">
                    <div class="card-body">
                        <form action="/ProjectJSP/ManageUserMealServlet" method="get">
                            <h3>Tra thực đơn theo tuần</h3> 
                            <input type="text" class="form-control" name="searchUserMeal" placeholder="Nhập món ăn của bạn">
                            <br>
                            <input type="submit" class="btn btn-primary" name="searchUserMeal_btn" value="Chọn">
                        </form>
                    </div>
                </div>
                <br>
                <div >
                    <div class="card">
                        <div class="card-body">
                            <table class="styled-table" style="width: 100%">
                                <thead>
                                    <tr class="text-center">
                                        <td>Thực đơn</td>
                                        <td>Chi tiết</td>
                                        <td>Chỉnh sủa</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${sessionScope.userMealList}" var="userMeal">
                                        <c:if test="${userMeal.isStatus == 1}">
                                            <tr class="text-center">
                                                <td>
                                                    <span class="user-meal-name">${userMeal.userMealName}</span>
                                                    <input type="text" class="edit-user-meal-name form-control d-none" value="${userMeal.userMealName}" />
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#userMealDetail${userMeal.userMealID}">Chi tiết</button>
                                                    <a class="btn btn-primary" href="/ProjectJSP/RemoveUserMealServlet?userMealID=${userMeal.userMealID}">Remove</a>
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-secondary edit-btn">Edit</button>
                                                    <button type="button" class="btn btn-success save-btn d-none" data-user-meal-id="${userMeal.userMealID}">Save</button>
                                                    <button type="button" class="btn btn-danger cancel-btn d-none">Cancel</button>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </tbody>
                            </table>    
                        </div>
                    </div>
                </div>
            </div>
            <div id="loadSecond">

            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                $('#loadingModal').modal('show');
                fetch('HideURLServlet')
                        .then(response => response.text())
                        .then(data => {
                            document.getElementById('loadSecond').innerHTML = data;
                            $('#loadingModal').modal('hide');

                            var content = document.getElementById('loadSecond');
                            var scripts = content.getElementsByTagName('script');

                            for (var i = 0; i < scripts.length; i++) {
                                var script = document.createElement('script');
                                script.text = scripts[i].innerText;
                                document.body.appendChild(script);
                            }
                        })
                        .catch(error => {
                            console.error('Error loading content:', error);
                            $('#loadingModal').modal('hide');
                        });
            });

            $(document).ready(function () {
                $('.edit-btn').click(function () {
                    var row = $(this).closest('tr');
                    row.find('.user-meal-name').addClass('d-none');
                    row.find('.edit-user-meal-name').removeClass('d-none');
                    row.find('.edit-btn').addClass('d-none');
                    row.find('.save-btn, .cancel-btn').removeClass('d-none');
                });

                $('.cancel-btn').click(function () {
                    var row = $(this).closest('tr');
                    row.find('.user-meal-name').removeClass('d-none');
                    row.find('.edit-user-meal-name').addClass('d-none');
                    row.find('.edit-btn').removeClass('d-none');
                    row.find('.save-btn, .cancel-btn').addClass('d-none');
                });

                $('.save-btn').click(function () {
                    var row = $(this).closest('tr');
                    var userMealID = $('.save-btn').data("user-meal-id");
                    var newMealName = row.find('.edit-user-meal-name').val();

                    $.ajax({
                        url: '/ProjectJSP/UpdateUserMealServlet',
                        method: 'GET',
                        data: {
                            userMealID: userMealID,
                            userMealName: newMealName
                        },
                        success: function (response) {
                            row.find('.user-meal-name').text(newMealName).removeClass('d-none');
                            row.find('.edit-user-meal-name').addClass('d-none');
                            row.find('.edit-btn').removeClass('d-none');
                            row.find('.save-btn, .cancel-btn').addClass('d-none');
                        },
                        error: function (error) {
                            alert('An error occurred while updating the meal name.');
                        }
                    });
                });
            });


            const adjustModalZIndex = () => {
                const modals = document.querySelectorAll('.modal.show');
                const modalCount = modals.length;

                modals.forEach((modal, index) => {
                    const baseZIndex = 1040;
                    modal.style.zIndex = baseZIndex + (index * 20) + 10;
                });

                const backdrops = document.querySelectorAll('.modal-backdrop');
                backdrops.forEach((backdrop, index) => {
                    const baseZIndex = 1040;
                    backdrop.style.zIndex = baseZIndex + (index * 20);
                });
            };

            document.addEventListener('shown.bs.modal', adjustModalZIndex);
            document.addEventListener('hidden.bs.modal', adjustModalZIndex);
        </script>
        <%@include file="../../common/web/footer.jsp" %> 
    </body>
</html>









<!--                        <c:forEach var="userMealDetail" items="${requestScope.userMealDetailList}">
    <c:if test= "${userMealDetail.isStatus != 0 && userMealDetail.userMeal.userMealID == userMeal.userMealID}" >
        <tr>
            <th>${userMealDetail.product.productName}</th>
            <th>${userMealDetail.dish.dishName}</th>
            <th>${userMealDetail.day.dayText}</th>
            <th>${userMealDetail.product.productDescribe}</th>
            <th>${userMealDetail.isStatus != 0 ? "Active" : "Deactive"}</th>

            <th><a href="RemoveUserMealDetailServlet?userMealDetailID=${userMealDetail.userMealDetailID}">remove</a></th>
            <th><a href="UpdateUserMealDetailServlet?userMealDetailID=${userMealDetail.userMealDetailID}">update</a></th>
        </tr>
    </c:if>
    <c:if test="${requestScope.update_status} != null">
        <p>Update successful</p>
    </c:if>
</c:forEach>  -->
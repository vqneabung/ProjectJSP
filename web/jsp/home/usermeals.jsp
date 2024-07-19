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
                <br>
                <div >
                    <div class="card">
                        <div class="card-body">
                            <table class="styled-table" style="width: 100%" id="userMealTable">
                                <thead>
                                    <tr class="text-center">
                                        <td class="text-center">ID Thực đơn</td>
                                        <td class="text-center">Thực đơn</td>
                                        <td class="text-center">Chi tiết</td>
                                        <td class="text-center">Chỉnh sủa</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${sessionScope.userMealList}" var="userMeal">
                                        <c:if test="${userMeal.isStatus == 1}">
                                            <tr class="text-center">
                                                <td class="text-center">${userMeal.userMealID}</td>
                                                <td>
                                                    <span class="user-meal-name">${userMeal.userMealName}</span>
                                                    <input type="text" class="edit-user-meal-name form-control d-none" value="${userMeal.userMealName}" />
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#userMealDetail${userMeal.userMealID}">Chi tiết</button>

                                                </td>
                                                <td>
                                                    <a class="btn btn-primary" href="/ProjectJSP/RemoveUserMealServlet?userMealID=${userMeal.userMealID}">Remove</a>
                                                    <button type="button" class="btn btn-secondary edit-btn">Edit</button>
                                                    <button type="button" class="btn btn-success save-btn d-none" id="${userMeal.userMealID}">Save</button>
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




//                $('.edit-btn').click(function () {
//                    var row = $(this).closest('tr');
//                    row.find('.user-meal-name').addClass('d-none');
//                    row.find('.edit-user-meal-name').removeClass('d-none');
//                    row.find('.edit-btn').addClass('d-none');
//                    row.find('.save-btn, .cancel-btn').removeClass('d-none');
//                });
//
//                $('.cancel-btn').click(function () {
//                    var row = $(this).closest('tr');
//                    row.find('.user-meal-name').removeClass('d-none');
//                    row.find('.edit-user-meal-name').addClass('d-none');
//                    row.find('.edit-btn').removeClass('d-none');
//                    row.find('.save-btn, .cancel-btn').addClass('d-none');
//                });
                var table = new DataTable('#userMealTable', {
                    "columnDefs": [
                        {"orderable": false, "targets": [2]}
                    ],
                    "language": {
                        "lengthMenu": "Hiển thị _MENU_ mục mỗi trang"
                    }
                });


                table.on('page.dt', function () {
                    // Hàm bạn muốn chạy khi chuyển trang
                    console.log('Trang đã thay đổi');

                });


                //---------------------------------------------------------
                // Select the node that will be observed for mutations
                const targetNode = document.getElementById("userMealTable");

                // Options for the observer (which mutations to observe)
                const config = {attributes: true, childList: true, subtree: true};

                // Callback function to execute when mutations are observed
                const callback = (mutationList, observer) => {
                    var editButtons = document.querySelectorAll('.edit-btn');
                    var cancelButtons = document.querySelectorAll('.cancel-btn');
                    var saveUserMealNames = document.querySelectorAll(".save-btn");

                    editButtons.forEach(function (button) {
                        button.addEventListener('click', function () {
                            var row = button.closest('tr');
                            row.querySelector('.user-meal-name').classList.add('d-none');
                            row.querySelector('.edit-user-meal-name').classList.remove('d-none');
                            button.classList.add('d-none');
                            row.querySelector('.save-btn').classList.remove('d-none');
                            row.querySelector('.cancel-btn').classList.remove('d-none');
                        });
                    });

                    cancelButtons.forEach(function (button) {
                        button.addEventListener('click', function () {
                            var row = button.closest('tr');
                            row.querySelector('.user-meal-name').classList.remove('d-none');
                            row.querySelector('.edit-user-meal-name').classList.add('d-none');
                            row.querySelector('.edit-btn').classList.remove('d-none');
                            row.querySelector('.save-btn').classList.add('d-none');
                            row.querySelector('.cancel-btn').classList.add('d-none');
                        });
                    });

                    saveUserMealNames.forEach(function (button) {
                        button.addEventListener('click', function () {
                            // Tìm phần tử tr gần nhất
                            var row = button.closest('tr');
                            var userMealID = button.getAttribute('id');
                            var newMealName = row.querySelector('.edit-user-meal-name').value;

                            // Tạo một yêu cầu XMLHttpRequest
                            var xhr = new XMLHttpRequest();
                            xhr.open('GET', '/ProjectJSP/UpdateUserMealServlet?userMealID=' + encodeURIComponent(userMealID) + '&userMealName=' + encodeURIComponent(newMealName), true);

                            xhr.onreadystatechange = function () {
                                if (xhr.readyState === 4) { // Khi hoàn tất yêu cầu
                                    if (xhr.status === 200) { // Nếu thành công
                                        row.querySelector('.user-meal-name').textContent = newMealName;
                                        row.querySelector('.user-meal-name').classList.remove('d-none');
                                        row.querySelector('.edit-user-meal-name').classList.add('d-none');
                                        row.querySelector('.edit-btn').classList.remove('d-none');
                                        row.querySelector('.save-btn').classList.add('d-none');
                                        row.querySelector('.cancel-btn').classList.add('d-none');
                                    } else {
                                        alert('An error occurred while updating the meal name.');
                                    }
                                }
                            };

                            xhr.send();
                        });
                    });

                };

                // Create an observer instance linked to the callback function
                const observer = new MutationObserver(callback);

                // Start observing the target node for configured mutations
                observer.observe(targetNode, config);
                //----------------------------------------------------------

                var editButtons = document.querySelectorAll('.edit-btn');
                var cancelButtons = document.querySelectorAll('.cancel-btn');
                var saveUserMealNames = document.querySelectorAll(".save-btn");

                editButtons.forEach(function (button) {
                    button.addEventListener('click', function () {
                        var row = button.closest('tr');
                        row.querySelector('.user-meal-name').classList.add('d-none');
                        row.querySelector('.edit-user-meal-name').classList.remove('d-none');
                        button.classList.add('d-none');
                        row.querySelector('.save-btn').classList.remove('d-none');
                        row.querySelector('.cancel-btn').classList.remove('d-none');
                    });
                });

                var cancelButtons = document.querySelectorAll('.cancel-btn');

                cancelButtons.forEach(function (button) {
                    button.addEventListener('click', function () {
                        var row = button.closest('tr');
                        row.querySelector('.user-meal-name').classList.remove('d-none');
                        row.querySelector('.edit-user-meal-name').classList.add('d-none');
                        row.querySelector('.edit-btn').classList.remove('d-none');
                        row.querySelector('.save-btn').classList.add('d-none');
                        row.querySelector('.cancel-btn').classList.add('d-none');
                    });
                });

                var saveUserMealNames = document.querySelectorAll(".save-btn");



//                saveUserMealNames.forEach(save => {
//                    save.addEventListener('click', () => {
//                        console.log(save.id);
//                        var row = $(this).closest('tr');
//                        var userMealID = save.id;
//                        var newMealName = row.find('.edit-user-meal-name').val();
//
//                        $.ajax({
//                            url: '/ProjectJSP/UpdateUserMealServlet',
//                            method: 'GET',
//                            data: {
//                                userMealID: userMealID,
//                                userMealName: newMealName
//                            },
//                            success: function (response) {
//                                row.find('.user-meal-name').text(newMealName).removeClass('d-none');
//                                row.find('.edit-user-meal-name').addClass('d-none');
//                                row.find('.edit-btn').removeClass('d-none');
//                                row.find('.save-btn, .cancel-btn').addClass('d-none');
//                            },
//                            error: function (error) {
//                                alert('An error occurred while updating the meal name.');
//                            }
//                        });
//                    });
//                });

                saveUserMealNames.forEach(function (button) {
                    button.addEventListener('click', function () {
                        // Tìm phần tử tr gần nhất
                        var row = button.closest('tr');
                        var userMealID = button.getAttribute('id');
                        var newMealName = row.querySelector('.edit-user-meal-name').value;

                        // Tạo một yêu cầu XMLHttpRequest
                        var xhr = new XMLHttpRequest();
                        xhr.open('GET', '/ProjectJSP/UpdateUserMealServlet?userMealID=' + encodeURIComponent(userMealID) + '&userMealName=' + encodeURIComponent(newMealName), true);

                        xhr.onreadystatechange = function () {
                            if (xhr.readyState === 4) { // Khi hoàn tất yêu cầu
                                if (xhr.status === 200) { // Nếu thành công
                                    row.querySelector('.user-meal-name').textContent = newMealName;
                                    row.querySelector('.user-meal-name').classList.remove('d-none');
                                    row.querySelector('.edit-user-meal-name').classList.add('d-none');
                                    row.querySelector('.edit-btn').classList.remove('d-none');
                                    row.querySelector('.save-btn').classList.add('d-none');
                                    row.querySelector('.cancel-btn').classList.add('d-none');
                                } else {
                                    alert('An error occurred while updating the meal name.');
                                }
                            }
                        };

                        xhr.send();
                    });
                });


//                $('.save-btn').click(function () {
//                    var row = $(this).closest('tr');
//                    var userMealID = $(this).attr("id");
//                    var newMealName = row.find('.edit-user-meal-name').val();
//
//                    $.ajax({
//                        url: '/ProjectJSP/UpdateUserMealServlet',
//                        method: 'GET',
//                        data: {
//                            userMealID: userMealID,
//                            userMealName: newMealName
//                        },
//                        success: function (response) {
//                            row.find('.user-meal-name').text(newMealName).removeClass('d-none');
//                            row.find('.edit-user-meal-name').addClass('d-none');
//                            row.find('.edit-btn').removeClass('d-none');
//                            row.find('.save-btn, .cancel-btn').addClass('d-none');
//                        },
//                        error: function (error) {
//                            alert('An error occurred while updating the meal name.');
//                        }
//                    });
//                });
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
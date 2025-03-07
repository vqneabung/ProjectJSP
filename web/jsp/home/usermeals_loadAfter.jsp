<%@page import="dao.UserMealDetailDAO"%>
<%@page import="model.UserMealDetailDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    ArrayList<UserMealDetailDTO> userMealDetailList = (ArrayList<UserMealDetailDTO>) session.getAttribute("userMealDetailList");

    if (userMealDetailList == null) {
        UserMealDetailDAO umd = new UserMealDetailDAO();
        userMealDetailList = umd.getAllUserMealDetail();
        session.setAttribute("userMealDetailList", userMealDetailList);
    }

%>
<div id="loadAfter">
    <c:forEach items="${sessionScope.userMealList}" var="userMealForModal">
        <c:if test="${userMealForModal.isStatus == 1}">
            <div class="modal fade" id="userMealDetail${userMealForModal.userMealID}" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">${userMealForModal.userMealName}</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="card">
                                <div class="card-body">
                                    <p><a class="btn btn-secondary insertUserMealModal" href="/ProjectJSP/InsertUserMealDetailServlet?userMealID=${userMealForModal.userMealID}" data-user-meal-id="${userMealForModal.userMealID}" data-dismiss="modal" data-toggle="modal"> + Thêm bữa ăn</a> </p>
                                    <c:forEach items="${sessionScope.dayList}" var="day">
                                        <h3>- ${day.dayText}</h3>
                                        <table class="styled-table" style="width: 100%">
                                            <thead>
                                                <tr class="text-center" >
                                                    <th style="width: 10%">Buổi</th>
                                                    <th style="width: 20%">Hình ảnh</th>
                                                    <th style="width: 20%">Product Name</th>
                                                    <th>Remove</th>
                                                    <th>Update</th>
                                                </tr>
                                            <thead>
                                            <tbody>
                                                <tr>
                                                    <td rowspan="0" style="vertical-align : middle;text-align:center; width: 10%"><strong>+ Buổi sáng</strong></td>
                                                </tr>
                                                <c:forEach var="userMealDetail" items="${sessionScope.userMealDetailList}"> 
                                                    <c:if test= "${(userMealDetail.isStatus != 0 && userMealDetail.userMeal.userMealID == userMealForModal.userMealID) && day.dayNum == userMealDetail.day.dayNum && userMealDetail.dish.dishID == 1 }" >
                                                        <tr id="userlMealDetail_${userMealDetail.userMealDetailID}" style="font-size: medium" >
                                                            <th class="text-center"><img src="${userMealDetail.product.productImage[0]}" width="100" height="100"></th>
                                                            <th class="text-center">${userMealDetail.product.productName}</th>
                                                            <th class="text-center"><a href="RemoveUserMealDetailServlet?userMealDetailID=${userMealDetail.userMealDetailID}" class="btn btn-primary btn-remove" data-usermeal-detail-id="${userMealDetail.userMealDetailID}">Xóa</a></th>
                                                            <th class="text-center"><a href="UpdateUserMealDetailServlet?userMealDetailID=${userMealDetail.userMealDetailID}" data-user-meal-detail-id="${userMealDetail.userMealDetailID}" class="btn btn-secondary updateUserMealModal">Cập nhật</a></th>
                                                        </tr>
                                                    </c:if>
                                                </c:forEach>   
                                            </tbody>
                                            <tbody>
                                                <tr>
                                                    <td rowspan="0" style="vertical-align : middle;text-align:center; width: 10%" ><strong>+ Buổi chiều</strong></td>
                                                </tr>
                                                <c:forEach var="userMealDetail" items="${sessionScope.userMealDetailList}">
                                                    <c:if test= "${(userMealDetail.isStatus != 0 && userMealDetail.userMeal.userMealID == userMealForModal.userMealID) && day.dayNum == userMealDetail.day.dayNum && userMealDetail.dish.dishID == 2}" >
                                                        <tr id="userlMealDetail_${userMealDetail.userMealDetailID}" style="font-size: medium" >
                                                            <th class="text-center"><img src="${userMealDetail.product.productImage[0]}" width="100" height="100"></th>
                                                            <th class="text-center">${userMealDetail.product.productName}</th>
                                                            <th class="text-center"><a href="RemoveUserMealDetailServlet?userMealDetailID=${userMealDetail.userMealDetailID}" class="btn btn-primary btn-remove" data-usermeal-detail-id="${userMealDetail.userMealDetailID}">Xóa</a></th>
                                                            <th class="text-center"><a href="UpdateUserMealServlet?userMealDetailID=${userMealDetail.userMealDetailID}" data-user-meal-detail-id="${userMealDetail.userMealDetailID}" class="btn btn-secondary updateUserMealModal">Cập nhật</a></th>
                                                        </tr>
                                                    </c:if>
                                                </c:forEach>   
                                            </tbody>
                                            <tbody>
                                                <tr>
                                                    <td rowspan="0" style="vertical-align : middle;text-align:center; width: 10%"><strong>+ Buổi tối</strong></td>
                                                </tr>
                                                <c:forEach var="userMealDetail" items="${sessionScope.userMealDetailList}">
                                                    <c:if test= "${(userMealDetail.isStatus != 0 && userMealDetail.userMeal.userMealID == userMealForModal.userMealID) && day.dayNum == userMealDetail.day.dayNum && userMealDetail.dish.dishID == 3}" >
                                                        <tr id="userlMealDetail_${userMealDetail.userMealDetailID}" style="font-size: medium" >
                                                            <th class="text-center"><img src="${userMealDetail.product.productImage[0]}" width="100" height="100"></th>
                                                            <th class="text-center">${userMealDetail.product.productName}</th>
                                                            <th class="text-center"><a href="RemoveUserMealDetailServlet?userMealDetailID=${userMealDetail.userMealDetailID}" class="btn btn-primary btn-remove" data-usermeal-detail-id="${userMealDetail.userMealDetailID}">Xóa</a></th>
                                                            <th class="text-center"><a href="UpdateUserMealServlet?userMealDetailID=${userMealDetail.userMealDetailID}" data-user-meal-detail-id="${userMealDetail.userMealDetailID}" class="btn btn-secondary updateUserMealModal">Cập nhật</a></th>
                                                        </tr>
                                                    </c:if>
                                                </c:forEach>  
                                            <tbody>
                                        </table>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </c:forEach>
    <div>
        <div class="modal fade " id="userMealModal" tabindex="-1" role="dialog" aria-labelledby="userMealModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content ">
                    <div class="modal-header">
                        <h5 class="modal-title" id="userMealModalLabel">Thêm kế hoạch</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            $(".insertUserMealModal").on('click', function (e) {
                e.preventDefault();
                var userMealID = $(this).data('user-meal-id');
                $.ajax({
                    url: '/ProjectJSP/InsertUserMealDetailServlet',
                    type: 'GET',
                    data: {userMealID: userMealID},
                    success: function (data) {
                        $('#userMealModal .modal-body').html(data);
                        $('#userMealModal').modal('show');
                    },
                    error: function () {
                        alert('Failed to load the content.');
                    }
                });
            });

            $(".updateUserMealModal").on('click', function (e) {
                e.preventDefault();
                var userMealDetailID = $(this).data('user-meal-detail-id');
                $.ajax({
                    url: '/ProjectJSP/UpdateUserMealDetailServlet',
                    type: 'GET',
                    data: {userMealDetailID: userMealDetailID},
                    success: function (data) {
                        $('#userMealModal .modal-body').html(data);
                        $('#userMealModal').modal('show');
                    },
                    error: function () {
                        alert('Failed to load the content.');
                    }
                });
            });
        });

    </script>
</div>

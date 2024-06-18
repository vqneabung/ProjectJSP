<%-- 
    Document   : admin_specmeals
    Created on : May 25, 2024, 5:27:44 PM
    Author     : VQN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
            <h1>Manage SpecMeal</h1>
            <p><a href="jsp/admin/admin_home.jsp"><--Back to homepage</a></p> 
            <c:forEach items="${requestScope.specMealList}" var="specMeal">
                <h1>${specMeal.specMealName}</h1>
                <div class="card">
                    <div class="card-body">
                        <p><a href="/ProjectJSP/InsertSpecMealServlet?specMealID=${specMeal.specMealID}">Insert</a></p>
                        <c:forEach items="${requestScope.dayList}" var="day">
                            <h3>- ${day.dayText}</h3>
                            <div>

                                <table class="table table-hover">
                                    <tr>
                                        <th>Tên sản phấm</th>

                                        <th>Remove</th>
                                        <th>Update</th>
                                    </tr>
                                    <tr>
                                        <td colspan="5" ><strong>+ Buổi sáng</strong></td>
                                    </tr>
                                    <c:forEach var="specMealDetail" items="${requestScope.specMealDetailList}">
                                        <c:if test= "${(specMealDetail.isStatus != 0 && specMealDetail.specMeal.specMealID == specMeal.specMealID) && (day.dayNum == specMealDetail.day.dayNum  && specMealDetail.dish.dishID == 1)}" >
                                            <tr id="speclMealDetail_${specMealDetail.specMealDetailID}" style="font-size: medium" >
                                                <th class="text-center">${specMealDetail.product.productName}</th>
                                                <th><button class="btn btn-primary btn-remove" data-specmeal-detail-id="${specMealDetail.specMealDetailID}">remove</button></th>
                                                <th><a href="UpdateSpecMealServlet?specMealDetailID=${specMealDetail.specMealDetailID}" class="btn btn-secondary">update</a></th>
                                            </tr>
                                        </c:if>
                                    </c:forEach>   
                                    <tr>
                                        <td colspan="5" ><strong>+ Buổi chiều</strong></td>
                                    </tr>
                                    <c:forEach var="specMealDetail" items="${requestScope.specMealDetailList}">
                                        <c:if test= "${(specMealDetail.isStatus != 0 && specMealDetail.specMeal.specMealID == specMeal.specMealID) && (day.dayNum == specMealDetail.day.dayNum  && specMealDetail.dish.dishID == 2)}" >
                                            <tr id="speclMealDetail_${specMealDetail.specMealDetailID}" style="font-size: medium" >
                                                <th class="text-center">${specMealDetail.product.productName}</th>
                                                <th><button class="btn btn-primary btn-remove" data-specmeal-detail-id="${specMealDetail.specMealDetailID}">remove</button></th>
                                                <th><a href="UpdateSpecMealServlet?specMealDetailID=${specMealDetail.specMealDetailID}" class="btn btn-secondary">update</a></th>
                                            </tr>
                                        </c:if>
                                    </c:forEach>   
                                    <tr>
                                        <td colspan="5" ><strong>+ Buổi tối</strong></td>
                                    </tr>
                                    <c:forEach var="specMealDetail" items="${requestScope.specMealDetailList}">
                                        <c:if test= "${(specMealDetail.isStatus != 0 && specMealDetail.specMeal.specMealID == specMeal.specMealID) && (day.dayNum == specMealDetail.day.dayNum  && specMealDetail.dish.dishID == 3)}" >
                                            <tr id="speclMealDetail_${specMealDetail.specMealDetailID}" style="font-size: medium" >
                                                <th class="text-center">${specMealDetail.product.productName}</th>
                                                <th><button class="btn btn-primary btn-remove" data-specmeal-detail-id="${specMealDetail.specMealDetailID}">remove</button></th>
                                                <th><a href="UpdateSpecMealServlet?specMealDetailID=${specMealDetail.specMealDetailID}" class="btn btn-secondary">update</a></th>
                                            </tr>
                                        </c:if>
                                    </c:forEach>   
                                </table>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:forEach>
        </div>
        <script>
            $(document).ready(function () {
                // Xử lý khi click vào nút Confirm
                $('.btn-remove').click(function () {
                    var specMealDetailID = $(this).data('specmeal-detail-id');
                    removeSpecMeal(specMealDetailID);
                });


                // Hàm gửi yêu cầu AJAX để cập nhật trạng thái đơn hàng
                function removeSpecMeal(specMealDetailID) {
                    $.ajax({
                        type: 'GET',
                        url: '/ProjectJSP/RemoveSpecMealServlet', // Đường dẫn API hoặc servlet để xử lý yêu cầu cập nhật trạng thái
                        data: {
                            specMealDetailID: specMealDetailID
                        },
                        success: function (response) {
                            // Xử lý phản hồi từ máy chủ nếu cần thiết
                            if (response.success) {
                                $('#speclMealDetail_' + specMealDetailID).hide();
                            } else {
                                alert('Update failed');
                            }
                        },
                        error: function () {
                            alert('Error updating order status');
                        }
                    });
                }
            });
        </script>
    </body>
</html>

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
                <div ">
                    <h1>${specMeal.specMealName}</h1>
                    <p><a href="/ProjectJSP/InsertSpecMealServlet?specMealID=${specMeal.specMealID}">Insert</a></p>
                    <table class="table table-hover">
                        <tr>
                            <th>Product Name</th>
                            <th>Dish</th>
                            <th>Day</th>
                            <th>Remove</th>
                            <th>Update</th>
                        </tr>
                        <c:forEach var="specMealDetail" items="${requestScope.specMealDetailList}">
                            <c:if test= "${specMealDetail.isStatus != 0 && specMealDetail.specMeal.specMealID == specMeal.specMealID}" >
                                <tr id="speclMealDetail_${specMealDetail.specMealDetailID}" style="font-size: medium" >
                                    <th>${specMealDetail.product.productName}</th>
                                    <th>${specMealDetail.dish.dishName}</th>
                                    <th>${specMealDetail.day.dayText}</th>
                                    <th><button class="btn btn-primary btn-remove" data-specMealDetail-id="${specMealDetail.specMealDetailID}">remove</button></th>
                                    <th><a href="UpdateSpecMealServlet?specMealDetailID=${specMealDetail.specMealDetailID}" class="btn btn-secondary">update</a></th>
                                </tr>
                            </c:if>
                        </c:forEach>   
                    </table>
                </div>
            </c:forEach>
        </div>
        <script>
            $(document).ready(function () {
                // Xử lý khi click vào nút Confirm
                $('.btn-remove').click(function () {
                    var specMealDetailID = $(this).data('specMealDetail-id');
                    removeSpecMeal(specMealDetailID);
                });


                // Hàm gửi yêu cầu AJAX để cập nhật trạng thái đơn hàng
                function removeSpecMeal(specMealDetailID) {
                    $.ajax({
                        type: 'GET',
                        url: '/ProjectJSP/RemoveSpecMealServlet', // Đường dẫn API hoặc servlet để xử lý yêu cầu cập nhật trạng thái
                        data: {
                            specMealDetailID specMealDetailID,
                        },
                        success: function (response) {
                            // Xử lý phản hồi từ máy chủ nếu cần thiết
                            if (response.success) {
                                $('#specl_meal_' + specMealID).hide();
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

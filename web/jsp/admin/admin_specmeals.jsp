<%-- 
    Document   : admin_specmeals
    Created on : May 25, 2024, 5:27:44 PM
    Author     : VQN
--%>

<%@page import="model.SpecMealDTO"%>
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
            <h1>Quản lí tuần ăn của chuyên gia</h1>
            <div class="card">
                <div class="card-body">
                    <form action="/ProjectJSP/ManageSpecMealServlet" method="get">
                        <h3>Chọn thực đơn theo tuần</h3> 
                        <select class="form-control" name="specMealID">
                            <c:forEach items="${requestScope.specMealList}" var="specMealItem">
                                <option value="${specMealItem.specMealID}"> ${specMealItem.specMealName}</option>
                            </c:forEach>
                        </select>
                        <br>
                        <input type="submit" class="btn btn-primary" value="Chọn">
                    </form>
                </div>
            </div>
            <%
                SpecMealDTO spceMeal = (SpecMealDTO) request.getAttribute("specMeal");
            %>
            <h1>${specMeal.specMealName}</h1>
            <div class="card">
                <div class="card-body">
                    <p><a class="btn btn-primary" href="/ProjectJSP/InsertSpecMealServlet?specMealID=${specMeal.specMealID}">Chèn thêm thức ăn</a></p>
                    <c:forEach items="${requestScope.dayList}" var="day">
                        <h3>- ${day.dayText}</h3>
                        <div>
                            <table class="styled-table" style="margin-left: 3.5em; margin-right: 3.5rem;">
                                <tr class="text-center">
                                    <th>Buổi</th>
                                    <th>Ảnh sản phẩm </th>
                                    <th>Tên sản phấm</th>
                                    <th>Remove</th>
                                    <th>Update</th>
                                </tr>
                                <tbody>
                                    <tr>
                                        <td rowspan="0" style="vertical-align : middle;text-align:center; width: 10%"><strong>+ Buổi sáng</strong></td>
                                    </tr>
                                    <c:forEach var="specMealDetail" items="${requestScope.specMealDetailList}">
                                        <c:if test= "${(specMealDetail.isStatus != 0 && specMealDetail.specMeal.specMealID == specMeal.specMealID) && (day.dayNum == specMealDetail.day.dayNum  && specMealDetail.dish.dishID == 1)}" >
                                            <tr id="speclMealDetail_${specMealDetail.specMealDetailID}" style="font-size: medium;" class="text-center">
                                                <th class="text-center"><img src="${specMealDetail.product.productImage[0]}" width="100" height="100"></th>
                                                <th class="text-center">${specMealDetail.product.productName}</th>
                                                <th><button class="btn btn-primary btn-remove" data-specmeal-detail-id="${specMealDetail.specMealDetailID}">remove</button></th>
                                                <th><a href="UpdateSpecMealServlet?specMealDetailID=${specMealDetail.specMealDetailID}" class="btn btn-secondary">update</a></th>
                                            </tr>
                                        </c:if>
                                    </c:forEach>   
                                </tbody>
                                <tbody>
                                    <tr>
                                        <td rowspan="0" style="vertical-align : middle;text-align:center;"><strong>+ Buổi chiều</strong></td>
                                    </tr>
                                    <c:forEach var="specMealDetail" items="${requestScope.specMealDetailList}">
                                        <c:if test= "${(specMealDetail.isStatus != 0 && specMealDetail.specMeal.specMealID == specMeal.specMealID) && (day.dayNum == specMealDetail.day.dayNum  && specMealDetail.dish.dishID == 2)}" >
                                            <tr id="speclMealDetail_${specMealDetail.specMealDetailID}" style="font-size: medium" class="text-center">
                                                <th><img src="${specMealDetail.product.productImage[0]}" width="100" height="100"</th>
                                                <th class="text-center">${specMealDetail.product.productName}</th>
                                                <th><button class="btn btn-primary btn-remove" data-specmeal-detail-id="${specMealDetail.specMealDetailID}">remove</button></th>
                                                <th><a href="UpdateSpecMealServlet?specMealDetailID=${specMealDetail.specMealDetailID}" class="btn btn-secondary">update</a></th>
                                            </tr>
                                        </c:if>
                                    </c:forEach>  
                                </tbody>
                                <tbody>
                                    <tr>
                                        <td rowspan="0" style="vertical-align : middle;text-align:center;"><strong>+ Buổi tối</strong></td>
                                    </tr>
                                    <c:forEach var="specMealDetail" items="${requestScope.specMealDetailList}">
                                        <c:if test= "${(specMealDetail.isStatus != 0 && specMealDetail.specMeal.specMealID == specMeal.specMealID) && (day.dayNum == specMealDetail.day.dayNum  && specMealDetail.dish.dishID == 3)}" >
                                            <tr id="speclMealDetail_${specMealDetail.specMealDetailID}" style="font-size: medium" class="text-center">
                                                <th class="text-center"><img src="${specMealDetail.product.productImage[0]}" width="100" height="100"</th>
                                                <th class="text-center">${specMealDetail.product.productName}</th>
                                                <th><button class="btn btn-primary btn-remove" data-specmeal-detail-id="${specMealDetail.specMealDetailID}">remove</button></th>
                                                <th><a href="UpdateSpecMealServlet?specMealDetailID=${specMealDetail.specMealDetailID}" class="btn btn-secondary">update</a></th>
                                            </tr>
                                        </c:if>
                                    </c:forEach>   
                                </tbody>
                            </table>
                        </div>
                    </c:forEach>
                </div>
            </div>
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

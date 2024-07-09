<%-- 
    Document   : usermeal_insert
    Created on : Jun 3, 2024, 5:03:13 PM
    Author     : VQN
--%>

<%@page import="model.SpecMealDTO"%>
<%@page import="java.time.temporal.WeekFields"%>
<%@page import="java.time.LocalDate"%>
<%@page import="dao.SpecMealDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thêm kế hoạch của bạ</title>
    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>
        <div class="container" style="margin-top: 1rem">
            <h1> Thêm kế hoạch của bạn </h1>
            <div class="card">
                <div class="card-body">
                    <form action="/ProjectJSP/InsertUserMealServlet" method="post">
                        <div>
                            <label>Điền tên kế hoạch</label>
                            <input type="text" class="form-control" name="insert_userMealName" value =""/>   
                            <input style="margin-top: 1rem" type="submit" name="btn_insert" class="btn btn-primary" value="Thêm"/>
                        </div>
                        <input hidden name="insert_userMealID" value="${sessionScope.User.userID}">
                    </form>
                </div>
            </div>
            <div>
                <%
                    SpecMealDAO sm = new SpecMealDAO();
                    LocalDate instance = LocalDate.now();
                    int week = instance.get(WeekFields.ISO.weekOfWeekBasedYear());

                    SpecMealDTO specMealWeekCurrent = sm.getSpecMeal(week);
                    session.setAttribute("specMealWeekCurrent", specMealWeekCurrent);
                %>
                <div style="margin: 1rem 0 ">
                    <h1>${sessionScope.specMealWeekCurrent.getSpecMealName()}</h1>
                    <a class="btn btn-primary" href="AddToUserMeal?specMealID=${sessionScope.specMealWeekCurrent.getSpecMealID()}&userID=${sessionScope.User.userID}">+ Thêm kế này thành của bạn</a>
                </div>
                <div class="card">
                    <div class="card-body">
                        <c:forEach items="${requestScope.dayList}" var="day">
                            <h3>- ${day.dayText}</h3>
                            <table class="styled-table" style="width: 100%">
                                <tr class="text-center">
                                    <th>Buổi</th>
                                    <th>Hình ảnh</th>
                                    <th>Product Name</th>
                                </tr>
                                <tbody>
                                    <tr>
                                        <td rowspan="0" style="vertical-align : middle;text-align:center; width: 20%" ><strong>+ Buổi sáng</strong></td>
                                    </tr>
                                    <c:forEach var="specMealDetail" items="${requestScope.specMealDetailList}">
                                        <c:if test= "${(specMealDetail.isStatus != 0 && specMealDetail.specMeal.specMealID == sessionScope.specMealWeekCurrent.getSpecMealID()) && (day.dayNum == specMealDetail.day.dayNum  && specMealDetail.dish.dishID == 1)}" >
                                            <tr id="speclMealDetail_${specMealDetail.specMealDetailID}" style="font-size: medium" >
                                                <td class="text-center"><img src="${specMealDetail.product.productImage[0]}" width="100" height="100"></td>
                                                <td class="text-center">${specMealDetail.product.productName}</td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>   
                                </tbody>
                                <tbody>
                                    <tr>
                                        <td rowspan="0" style="vertical-align : middle;text-align:center; width: 20%"><strong>+ Buổi chiều</strong></td>
                                    </tr>
                                    <c:forEach var="specMealDetail" items="${requestScope.specMealDetailList}">
                                        <c:if test= "${(specMealDetail.isStatus != 0 && specMealDetail.specMeal.specMealID == sessionScope.specMealWeekCurrent.getSpecMealID()) && (day.dayNum == specMealDetail.day.dayNum  && specMealDetail.dish.dishID == 2)}" >
                                            <tr id="speclMealDetail_${specMealDetail.specMealDetailID}" style="font-size: medium" >
                                                <td class="text-center"><img src="${specMealDetail.product.productImage[0]}" width="100" height="100"></td>
                                                <td class="text-center">${specMealDetail.product.productName}</td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>  
                                </tbody>
                                <tbody>
                                    <tr>
                                        <td rowspan="0" style="vertical-align : middle;text-align:center; width: 20%"><strong>+ Buổi tối</strong></td>
                                    </tr>
                                    <c:forEach var="specMealDetail" items="${requestScope.specMealDetailList}">
                                        <c:if test= "${(specMealDetail.isStatus != 0 && specMealDetail.specMeal.specMealID == sessionScope.specMealWeekCurrent.getSpecMealID()) && (day.dayNum == specMealDetail.day.dayNum  && specMealDetail.dish.dishID == 3)}" >
                                            <tr id="speclMealDetail_${specMealDetail.specMealDetailID}" style="font-size: medium" >
                                                <td class="text-center"><img src="${specMealDetail.product.productImage[0]}" width="100" height="100"></td>
                                                <td class="text-center">${specMealDetail.product.productName}</td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>   
                                </tbody>
                            </table>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <div style="margin-top: 2rem" class="text-center">
                <h1>-----------------------------------------------------------------------------</h1>
                <h1>Ở dưới đây bạn có thể thêm các tuần khác trong năm</h1>
            </div>
            <div>
                <div class="card">
                    <div class="card-body">
                        <table class="styled-table" style="width: 100%">
                            <thead>
                                <tr class="text-center">
                                    <td>Thực đơn</td>
                                    <td>Chi tiết</td>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${requestScope.specMealList}" var="specMeal">
                                    <c:if test="${specMeal.isStatus == 1}">

                                        <tr class="text-center">
                                            <td>
                                                ${specMeal.specMealName}
                                            </td>
                                            <td>
                                                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#specMealDetail${specMeal.specMealID}">Chi tiết</button>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div>
                            <c:forEach items="${requestScope.specMealList}" var="specMealForModal">
                                <c:if test="${specMealForModal.isStatus == 1}">
                                    <div class="modal fade" id="specMealDetail${specMealForModal.specMealID}" tabindex="-1" aria-hidden="true">
                                        <div class="modal-dialog modal-xl">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">${specMealForModal.specMealName}</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="card">
                                                        <div class="card-body">
                                                            <a class="btn btn-primary" href="AddToUserMeal?specMealID=${specMealForModal.getSpecMealID()}&userID=${sessionScope.User.userID}">+ Thêm kế này thành của bạn</a>
                                                            <c:forEach items="${requestScope.dayList}" var="day">
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
                                                                        <c:forEach var="specMealDetail" items="${requestScope.specMealDetailList}">
                                                                            <c:if test= "${(specMealDetail.isStatus != 0 && specMealDetail.specMeal.specMealID == specMealForModal.specMealID) && (day.dayNum == specMealDetail.day.dayNum  && specMealDetail.dish.dishID == 1)}" >
                                                                                <tr id="speclMealDetail_${specMealDetail.specMealDetailID}" style="font-size: medium" >
                                                                                    <th class="text-center"><img src="${specMealDetail.product.productImage[0]}" width="100" height="100"></th>
                                                                                    <th class="text-center">${specMealDetail.product.productName}</th>
                                                                                </tr>
                                                                            </c:if>
                                                                        </c:forEach>   
                                                                    </tbody>
                                                                    <tbody>
                                                                        <tr>
                                                                            <td rowspan="0" style="vertical-align : middle;text-align:center; width: 10%" ><strong>+ Buổi chiều</strong></td>
                                                                        </tr>
                                                                        <c:forEach var="specMealDetail" items="${requestScope.specMealDetailList}">
                                                                            <c:if test= "${(specMealDetail.isStatus != 0 && specMealDetail.specMeal.specMealID == specMealForModal.specMealID) && (day.dayNum == specMealDetail.day.dayNum  && specMealDetail.dish.dishID == 2)}" >
                                                                                <tr id="speclMealDetail_${specMealDetail.specMealDetailID}" style="font-size: medium" >
                                                                                    <th class="text-center">${specMealDetail.product.productName}</th>
                                                                                </tr>
                                                                            </c:if>
                                                                        </c:forEach>   
                                                                    </tbody>
                                                                    <tbody>
                                                                        <tr>
                                                                            <td rowspan="0" style="vertical-align : middle;text-align:center; width: 10%"><strong>+ Buổi tối</strong></td>
                                                                        </tr>
                                                                        <c:forEach var="specMealDetail" items="${requestScope.specMealDetailList}">
                                                                            <c:if test= "${(specMealDetail.isStatus != 0 && specMealDetail.specMeal.specMealID == specMealForModal.specMealID) && (day.dayNum == specMealDetail.day.dayNum  && specMealDetail.dish.dishID == 3)}" >
                                                                                <tr id="speclMealDetail_${specMealDetail.specMealDetailID}" style="font-size: medium" >
                                                                                    <th class="text-center">${specMealDetail.product.productName}</th>
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
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="../../common/web/footer.jsp" %>
    </body>
</html>

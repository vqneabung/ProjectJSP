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
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>
        <div class="container" style="margin-top: 1rem">
            <h1> Thêm kế hoạch của bạn </h1>
            <div class="card">
                <div class="card-body"
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
                <c:forEach items="${requestScope.specMealList}" var="specMeal">
                    <div style="margin: 1rem 0 ">
                        <h1>${specMeal.specMealName}</h1>
                        <a class="btn btn-primary" href="AddToUserMeal?specMealID=${specMeal.specMealID}&userID=${sessionScope.User.userID}">+ Thêm kế này thành của bạn</a>
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
                                            <c:if test= "${(specMealDetail.isStatus != 0 && specMealDetail.specMeal.specMealID == specMeal.specMealID) && (day.dayNum == specMealDetail.day.dayNum  && specMealDetail.dish.dishID == 1)}" >
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
                                            <c:if test= "${(specMealDetail.isStatus != 0 && specMealDetail.specMeal.specMealID == specMeal.specMealID) && (day.dayNum == specMealDetail.day.dayNum  && specMealDetail.dish.dishID == 2)}" >
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
                                            <c:if test= "${(specMealDetail.isStatus != 0 && specMealDetail.specMeal.specMealID == specMeal.specMealID) && (day.dayNum == specMealDetail.day.dayNum  && specMealDetail.dish.dishID == 3)}" >
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
                </c:forEach>
            </div>
        </div>
        <%@include file="../../common/web/footer.jsp" %>
    </body>
</html>

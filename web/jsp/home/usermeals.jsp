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
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>    
        <div class="container" style="margin-top: 1rem; margin-bottom: 1rem">
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
            <c:forEach items="${requestScope.userMealList}" var="userMeal">
                <c:if test="${userMeal.isStatus == 1}">
                    <h1 style="margin-top: 1rem">${userMeal.userMealName}</h1>
                    <div class="card">
                        <div class="card-body">
                            <p><a class="btn btn-secondary" href="/ProjectJSP/InsertUserMealDetailServlet?userMealID=${userMeal.userMealID}"> + Thêm bữa ăn</a>   <a class="btn btn-primary"    href="/ProjectJSP/RemoveUserMealServlet?userMealID=${userMeal.userMealID}">Remove</a></p>
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
                                        <c:forEach var="userMealDetail" items="${requestScope.userMealDetailList}">
                                            <c:if test= "${(userMealDetail.isStatus != 0 && userMealDetail.userMeal.userMealID == userMeal.userMealID) && (day.dayNum == userMealDetail.day.dayNum  && userMealDetail.dish.dishID == 1)}" >
                                                <tr id="userlMealDetail_${userMealDetail.userMealDetailID}" style="font-size: medium" >
                                                    <th class="text-center"><img src="${userMealDetail.product.productImage[0]}" width="100" height="100"></th>
                                                    <th class="text-center">${userMealDetail.product.productName}</th>
                                                    <th class="text-center"><button class="btn btn-primary btn-remove" data-usermeal-detail-id="${userMealDetail.userMealDetailID}">remove</button></th>
                                                    <th class="text-center"><a href="UpdateUserMealDetailServlet?userMealDetailID=${userMealDetail.userMealDetailID}" class="btn btn-secondary">update</a></th>
                                                </tr>
                                            </c:if>
                                        </c:forEach>   
                                    </tbody>
                                    <tbody>
                                        <tr>
                                            <td rowspan="0" style="vertical-align : middle;text-align:center; width: 10%" ><strong>+ Buổi chiều</strong></td>
                                        </tr>
                                        <c:forEach var="userMealDetail" items="${requestScope.userMealDetailList}">
                                            <c:if test= "${(userMealDetail.isStatus != 0 && userMealDetail.userMeal.userMealID == userMeal.userMealID) && (day.dayNum == userMealDetail.day.dayNum  && userMealDetail.dish.dishID == 2)}" >
                                                <tr id="userlMealDetail_${userMealDetail.userMealDetailID}" style="font-size: medium" >
                                                    <th class="text-center">${userMealDetail.product.productName}</th>
                                                    <th><button class="btn btn-primary btn-remove" data-usermeal-detail-id="${userMealDetail.userMealDetailID}">remove</button></th>
                                                    <th><a href="UpdateUserMealServlet?userMealDetailID=${userMealDetail.userMealDetailID}" class="btn btn-secondary">update</a></th>
                                                </tr>
                                            </c:if>
                                        </c:forEach>   
                                    </tbody>
                                    <tbody>
                                        <tr>
                                            <td rowspan="0" style="vertical-align : middle;text-align:center; width: 10%"><strong>+ Buổi tối</strong></td>
                                        </tr>
                                        <c:forEach var="userMealDetail" items="${requestScope.userMealDetailList}">
                                            <c:if test= "${(userMealDetail.isStatus != 0 && userMealDetail.userMeal.userMealID == userMeal.userMealID) && (day.dayNum == userMealDetail.day.dayNum  && userMealDetail.dish.dishID == 3)}" >
                                                <tr id="userlMealDetail_${userMealDetail.userMealDetailID}" style="font-size: medium" >
                                                    <th class="text-center">${userMealDetail.product.productName}</th>
                                                    <th><button class="btn btn-primary btn-remove" data-usermeal-detail-id="${userMealDetail.userMealDetailID}">remove</button></th>
                                                    <th><a href="UpdateUserMealServlet?userMealDetailID=${userMealDetail.userMealDetailID}" class="btn btn-secondary">update</a></th>
                                                </tr>
                                            </c:if>
                                        </c:forEach>  
                                    <tbody>
                                </table>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
            </c:forEach>  
        </div>
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
<%-- 
    Document   : specmeal
    Created on : Jun 24, 2024, 6:38:43 PM
    Author     : VQN
--%>

<%@page import="model.RecipeDetailDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.RecipeDetailDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/WEB-INF/tlds/web_taglib" prefix="s"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kế hoạch của chuyên gia</title>
    </head>
    <body>     
        <%@include file="../../common/web/header.jsp" %>  
        <div class="main container" style="margin-top: 1rem">
            <h1>Weekly Meal Plan</h1> <p>
            <h4>Nếu bạn đang tìm kiếm cảm hứng để lên kế hoạch bữa ăn hàng tuần, bạn đã đến đúng nơi rồi đấy!
                Mỗi tuần, tôi sẽ chia sẻ một kế hoạch bữa ăn packed (đầy đủ) với các công thức dễ làm, đa dạng, VÀ tôi cũng cố gắng tái sử dụng lại thức ăn thừa từ ít nhất một bữa ăn mỗi tuần để giảm thời gian bếp núc và tối đa hóa thời gian thưởng thức cuộc sống!</h4>

            <c:forEach items="${requestScope.specMealList}" var="specMeal">
                <h1>Kế hoạch tuần: - ${specMeal.specMealName}</h1>
                <div class="card">
                    <div class="card-body">
                        <c:forEach items="${requestScope.dayList}" var="day">
                            <h3>${day.dayText}</h3>
                            <div>
                                <strong>+ Buổi sáng: </strong><br>
                                <c:forEach var="specMealDetail" items="${requestScope.specMealDetailList}">
                                    <c:if test= "${(specMealDetail.isStatus != 0 && specMealDetail.specMeal.specMealID == specMeal.specMealID) && (day.dayNum == specMealDetail.day.dayNum  && specMealDetail.dish.dishID == 1)}" >
                                        <a href="SingleMealShopServlet?productID=${specMealDetail.product.productID}">${specMealDetail.product.productName}:</a>    
                                        <br/>
                                        <p>${specMealDetail.product.productDescribe}</p> 

                                        <div>
                                            <table class="styled-table" style="width: 100%">
                                                <tr class="text-center">
                                                    <th>Nguyên liệu</th>
                                                    <th>Trọng lượng (Gram)</th>
                                                </tr>
                                                <s:recipeDetailListByFoodID foodID="${specMealDetail.product.productID}" var="recipeDetailListByFoodID"/>
                                                <c:forEach var="recipeDetail" items="${recipeDetailListByFoodID}">
                                                    <c:if test= "${recipeDetail.status != 0}" >
                                                        <tr class="text-center">
                                                            <td>${recipeDetail.ingredient.productName}</td>
                                                            <td>${recipeDetail.weight}</td>
                                                        </tr>
                                                    </c:if>
                                                </c:forEach>         
                                            </table>
                                        </div>
                                    </c:if>
                                </c:forEach>   
                                <br/>
                                <strong>+ Buổi chiều</strong> <br>
                                <c:forEach var="specMealDetail" items="${requestScope.specMealDetailList}">
                                    <c:if test= "${(specMealDetail.isStatus != 0 && specMealDetail.specMeal.specMealID == specMeal.specMealID) && (day.dayNum == specMealDetail.day.dayNum  && specMealDetail.dish.dishID == 2)}" >
                                        <a href="SingleMealShopServlet?productID=${specMealDetail.product.productID}">${specMealDetail.product.productName}:</a>  <br/>
                                        * ${specMealDetail.product.productDescribe} </br>   
                                    </c:if>
                                </c:forEach> 
                                <br/>
                                <strong>+ Buổi tối</strong> <br>
                                <c:forEach var="specMealDetail" items="${requestScope.specMealDetailList}">
                                    <c:if test= "${(specMealDetail.isStatus != 0 && specMealDetail.specMeal.specMealID == specMeal.specMealID) && (day.dayNum == specMealDetail.day.dayNum  && specMealDetail.dish.dishID == 3)}" >
                                        <a href="SingleMealShopServlet?productID=${specMealDetail.product.productID}">${specMealDetail.product.productName}:</a>    <br/>
                                        * ${specMealDetail.product.productDescribe} </br>  
                                    </c:if>
                                </c:forEach>   
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:forEach>
        </div>
        <%@include file="../../common/web/footer.jsp" %>   

    </body>
</html>

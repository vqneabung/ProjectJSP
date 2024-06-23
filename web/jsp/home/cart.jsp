<%-- 
    Document   : cart
    Created on : Jun 6, 2024, 8:48:04 AM
    Author     : VQN
--%>

<%@page import="java.util.Date"%>
<%@page import="java.util.HashMap"%>
<%@page import="model.ProductDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>
        <div class="container">
            <h1>Giỏ hàng</h1>
            <div class="card">
                <div class="card-body">
                    <table class="table table-hover">
                        <tr>
                            <th>ID</th>
                            <th>Tên sản phẩm</th>
                            <th>Hình ảnh</th>
                            <th>Giá</th>
                            <th>Số lượng</th>
                            <th>Hành động</th>
                        </tr>
                        <%
                            HashMap<ProductDTO, Integer> cart = (HashMap) session.getAttribute("cart");
                            if (cart != null) {
                        %> 
                        <%
                            int total = 0;
                            for (ProductDTO p : cart.keySet()) {
                                int quantity = cart.get(p);
                                total = total + quantity * p.getProductPrice();
                        %>
                        <form action="/ProjectJSP/EditCartServlet">
                            <input type="hidden" value="<%= p.getProductID()%>" name="edit_productID">
                            <tr>
                                <td><%= p.getProductID()%></td>
                                <td><%= p.getProductName()%></td>
                                <td><img style="width: 150px" src="<%= (p.getProductImage())[0]%>" ></td>
                                <td><%= p.getProductPrice()%></td>
                                <td><input type="number" value="<%= quantity%>" name="edit_quantity"/></td>
                                <td>
                                    <input class="btn btn-primary" type="submit" value="remove" name="btn_action"/>
                                    <input class="btn btn-primary" type="submit" value="update" name="btn_action"/>

                                </td>
                            </tr>
                        </form>
                        <%
                            }
                        %>
                    </table>
                    <h5>Tổng: <%= total%> VND</h5>
                    <h5>Ngày : <%= (new Date()).toString()%></h5>
                    <p><a class="btn btn-primary" href="/ProjectJSP/OrderServlet">Xác nhận mua hàng</a></p>
                    <%
                        } else {
                            out.print("Giỏ hàng này đang trống");
                        }
                    %>
                </div>
            </div>
            <br>
            <p><a class="btn btn-primary" href="/ProjectJSP/MealShopServlet">Quay lại</a></p>
        </div>
    </body>
</html>

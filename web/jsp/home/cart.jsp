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
        <%@include file="../../common/web/footer.jsp" %>  
        <%
            HashMap<ProductDTO, Integer> cart = (HashMap) session.getAttribute("cart");
            if (cart != null) {
        %> 
        <h1>your cart</h1>
        <table>
            <tr>
                <th>ID</th>
                <th>NAME</th>
                <th>IMAGE</th>
                <th>PRICE</th>
                <th>QUANTITY</th>
                <th>ACTION</th>
            </tr>
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
                    <td><img src="<%= p.getProductImage()%>" ></td>
                    <td><%= p.getProductPrice()%></td>
                    <td><input type="number" value="<%= quantity%>" min="1" max="10" name="edit_quantity"/></td>
                    <td>
                        <input type="submit" value="remove" name="btn_action"/>
                        <input type="submit" value="update" name="btn_action"/>
                    </td>
                </tr>
            </form>
            <%
                }
            %>
        </table>
        <p>Total:<%= total%> VND</p>
        <p>Order date: <%= (new Date()).toString()%></p>
        <p><a href="/ProjectJSP/OrderServlet">Hoan thanh</a></p>
        <p><a href="/ProjectJSP/MealShopServlet">Quay lai</a></p>
        <%
            } else {
                out.print("Khong co gi trong gio hang");
            }
        %>
    </body>
</html>

<%@page import="model.PaymentDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.PaymentDAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.HashMap"%>
<%@page import="model.ProductDTO"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Giỏ hàng</title>
        <%@include file="../../common/web/header.jsp" %>
    </head>
    <body>
        <%
            PaymentDAO p = new PaymentDAO();
            ArrayList<PaymentDTO> paymentList = p.getAllPayment();
            System.out.println("paymentList" + paymentList);
        %>
        <div class="container">
            <h1>Giỏ hàng</h1>
            <div class="card">
                <div class="card-body">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tên sản phẩm</th>
                                <th>Hình ảnh</th>
                                <th>Giá</th>
                                <th>Số lượng</th>
                                <th>Tổng</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${not empty sessionScope.cart}">
                                <c:set var="total" value="0" scope="page"/>
                                <c:forEach var="entry" items="${sessionScope.cart}">
                                    <c:set var="p" value="${entry.key}" />
                                    <c:set var="quantity" value="${entry.value}" />
                                    <c:set var="total" value="${total + (p.productPrice * quantity)}" />
                                    <tr>
                                <form action="/ProjectJSP/EditCartServlet">
                                    <input type="hidden" value="${p.productID}" name="edit_productID">
                                    <td>${p.productID}</td>
                                    <td>${p.productName}</td>
                                    <td><img style="width: 150px;" src="${p.productImage[0]}" ></td>
                                    <td>${p.productPrice}</td>
                                    <td>
                                        <c:if test="${quantity > p.productStock}">
                                            <input type="number" value="${p.productStock}" name="edit_quantity" min="0" max="${p.productStock}">
                                        </c:if>
                                        <c:if test="${quantity <= p.productStock}">
                                            <input type="number" value="${quantity}" name="edit_quantity" min="0" max="${p.productStock}">
                                        </c:if>
                                    </td>
                                    <td>${quantity * p.productPrice}</td>
                                    <td>
                                        <input class="btn btn-primary" type="submit" value="Remove" name="btn_action">
                                    </td>
                                </form>
                                </tr>
                            </c:forEach>
                        </c:if>
                        </tbody>
                    </table>
                    <h5><span id="totalCartValue">Tổng: ${total} VND</span></h5>
                    <h5>Ngày : <%= new Date()%></h5>
                    <h5>${requestScope.msgOrder}</h5>
                    <c:choose>
                        <c:when test="${not empty sessionScope.cart}">
                            <form action="/ProjectJSP/OrderServlet" method="post">
                                Chọn phương thức thanh toán: 
                                <select name="paymentID" class="form-control" style="width: 20%">
                                    <c:forEach items="<%= paymentList%>" var="payment">
                                        <option value="${payment.paymentID}">
                                            ${payment.paymentName}
                                        </option>
                                    </c:forEach>
                                </select>
                                <br>
                                <input type="submit" class="btn btn-primary" value="Xác nhận mua hàng"> 
                            </form>
                        </c:when>
                        <c:otherwise>
                            <p>Giỏ hàng này đang trống</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <br>
            <p><a class="btn btn-primary" href="/ProjectJSP/MealShopServlet">Quay lại</a></p>
        </div>
        <script>


            $(document).ready(function () {
                // Bắt sự kiện khi thay đổi số lượng sản phẩm
                $('input[name="edit_quantity"]').on('change', function () {
                    var quantity = $(this).val(); // Lấy số lượng mới từ input

                    // Tìm phần tử cha (tr) chứa thông tin sản phẩm
                    var $tr = $(this).closest('tr');
                    // Lấy giá sản phẩm từ phần tử tr
                    var price = $tr.find('td:eq(3)').text(); // Cột thứ tư trong bảng là giá

                    //Lay Id 

                    var productID = $tr.find('td:eq(0)').text(); // Cột thứ tư trong bảng là giá

                    // Tính toán tổng giá trị cho sản phẩm này
                    var total = quantity * price;
                    // Hiển thị lại tổng giá trị cho sản phẩm này trên giao diện
                    $tr.find('td:eq(5)').text(total); // Cột thứ sáu trong bảng là cột tổng giá trị

                    // Tính toán lại tổng giá trị của toàn bộ giỏ hàng
                    var totalCart = 0;
                    $('input[name="edit_quantity"]').each(function () {
                        var qty = $(this).val();
                        var price = $(this).closest('tr').find('td:eq(3)').text(); // Lấy giá từ cột thứ tư
                        totalCart += qty * price;
                    });
                    // Cập nhật tổng giá trị của giỏ hàng trên giao diện
                    $('#totalCartValue').text("Tổng: " + totalCart + " VND");
                    editToCart(productID, quantity);
                });
                function editToCart(productID, quantity) {
                    $.ajax({
                        type: 'POST',
                        url: '/ProjectJSP/EditCartServlet',
                        data: {
                            edit_productID: productID,
                            edit_quantity: quantity,
                            btn_action: "update"
                        },
                        success: function (data) {

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
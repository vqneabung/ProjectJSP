<%@page import="model.OrderDetailDTO"%>
<%@page import="model.UserDTO"%>
<%@page import="dao.OrderDAO"%>
<%@page import="model.OrderDTO"%>
<%@page import="model.PaymentDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.PaymentDAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.HashMap"%>
<%@page import="model.ProductDTO"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Giỏ hàng</title>
        <%@include file="../../common/web/header.jsp" %>
    </head>

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
                <c:if test="${sessionScope.User.roleID == 1}">
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
                </c:if>
                <c:if test="${sessionScope.User.roleID == 0}">
                    <p>Admin không được phép mua hàng</p>
                </c:if>
            </div>
        </div>
        <br>
        <p><a class="btn btn-primary" href="/ProjectJSP/MealShopServlet">Quay lại</a></p>
        <h1> Lịch sử mua hàng </h1>
        <div>
            <table class="styled-table" id="orderList" style="width: 100%">
                <thead>
                    <tr class="order-head">
                        <th class='text-center'>Order ID</th>
                        <th class='text-center'>Người dùng</th>
                        <th class='text-center'>Tổng tiền</th>
                        <th class='text-center'>Phương thức thanh toán</th>
                        <th class='text-center'>Ngày đặt hàng</th>
                        <th class='text-center'>Địa chỉ</th>
                        <th class='text-center'>Trạng thái</th>
                        <th class='text-center'>Chi tiết</th>
                    </tr>
                <thead>
                <tbody>
                    <%
                        OrderDAO o = new OrderDAO();
                        UserDTO user = (UserDTO) session.getAttribute("User");
                        ArrayList<OrderDTO> orderList = o.getAllOrdersByUserID(user.getUserID());
                        ArrayList<OrderDetailDTO> orderDetailList = o.getOrderDetailByUserID(user.getUserID());
                        System.out.println("orderDetailList" + orderDetailList);
                    %>
                    <c:forEach var="order" items="<%= orderList%>">
                        <tr class="order-body">
                            <td class='text-center'>${order.orderID}</td>
                            <td class='text-center'>${order.user.userName}</td>
                            <td class='text-center'>${order.totalPrice}</td>
                            <td class='text-center'>${order.payment.paymentName}</td> 
                            <td class='text-center'><fmt:formatDate value="${order.orderDate}" type = "both"/></td>
                            <td class='text-center'>${order.user.address}</td>
                            <td id="status_id_${order.orderID}">
                                ${order.orderStatus == 1 ? "Pending" : order.orderStatus == 2 ? "Confirmed" : "Cancelled"}
                            </td>
                            <td>
                                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#order${order.orderID}">
                                    Chi tiết
                                </button>
                                <div>
                                    <div class="modal fade" id="order${order.orderID}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div>
                                                        <table class="table table-hover text-center">
                                                            <tr>
                                                                <th>Mã</th>
                                                                <th>Tên sản phẩm</th>
                                                                <th>Số lượng</th>
                                                                <th>Giá</th>
                                                                <th>Tổng</th>
                                                                <th>Hình ảnh</th>
                                                            </tr>
                                                            <c:forEach var="orderDetail" items="<%= orderDetailList%>">
                                                                <c:if test="${order.orderID == orderDetail.orderID}">
                                                                    <tr style="font-size: medium">               
                                                                        <td>${orderDetail.orderDetailID}</td>
                                                                        <td>${orderDetail.product.productName}</td>
                                                                        <td>${orderDetail.quantity}</td>
                                                                        <td>${orderDetail.product.productPrice}</td>
                                                                        <td>${orderDetail.product.productPrice * orderDetail.quantity}</td>
                                                                        <td><img src="${orderDetail.product.productImage[0]}" alt="${orderDetail.product.productImage[0]}" weight="100" height="100" image"/></td>
                                                                    </tr>
                                                                </c:if>
                                                            </c:forEach>
                                                            <tr>
                                                                <th colspan="3">
                                                                </th>
                                                                <th>
                                                                    <h5>Tổng:</h5>
                                                                </th>
                                                                <th>
                                                                    <span id="totalCartValue">${order.totalPrice} VND</span>
                                                                </th>
                                                                <th>
                                                                </th>
                                                            </tr>
                                                        </table> 
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <%@include file="../../common/web/footer.jsp" %>
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

</html>
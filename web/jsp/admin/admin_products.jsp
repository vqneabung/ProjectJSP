<%-- 
    Document   : admin_products
    Created on : May 22, 2024, 1:52:38 PM
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
        <div class="main" style="margin-top: 1rem">
            <div class="card">
                <div class="card-body">
                    <div class="card-title">
                        <h6>Tìm sản phẩm</h6>
                    </div>
                    <div>
                        <form id="searchProductForm">
                            <div class="row">
                                <div class="col-4" >Tên sản phầm <input type="text" class="form-control" name="search_productName" placeholder="Enter Produce Name" /></div>
                                <div  class="col-4">Tên loại
                                    <select class="form-control" name="search_typeID" onchange="">
                                        <option value="">--Chọn--</option>F
                                        <option value="1">Thức ăn</option>
                                        <option value="2">Nguyên liệu</option>
                                    </select>
                                </div>
                                <div  class="col-4">Tên loại sản phẩm
                                    <select class="form-control" name="search_categoryID" >
                                        <option value="">--Chọn--</option>
                                        <c:forEach items="${requestScope.categoryList}" var="category">
                                            <c:if test="${category.type.typeID == 1}">
                                                <option value="${category.categoryID}">${category.categoryID}.${category.categoryName}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="row">
                                <div  class="col-4" >Có phải là thức ăn dành cho người ăn chay không?
                                    <select class="form-control" name="search_isVegetarian">
                                        <option value="">--Chọn--</option>
                                        <option value="1">Có</option>
                                        <option value="0">Không</option>
                                    </select>
                                </div>
                                <div  class="col-4">
                                    Có phải là thức ăn dành cho người ăn chay trường không?
                                    <select class="form-control" name="search_isVegan">
                                        <option value="">--Chọn--</option>
                                        <option value="1">Có</option>
                                        <option value="0">Không</option>
                                    </select>
                                </div >
                                <div  class="col-4">Điền size<input type="text" class="form-control" name="search_size" placeholder="Enter Size" value=""/></div>
                            </div>
                            <div class="row">
                                <div class="col-4">Điền giá <input type="number" class="form-control" name="search_price" placeholder="Enter Price" /></div>
                                <div class="col-4">Điền số lượng còn <input type="number" class="form-control" name="search_stock" placeholder="Enter Stock" /></div>
                                <div class="col-4">Điền số lượng bán <input type="number" class="form-control" name="search_unitSold" placeholder="Enter Unit Sold" /></div>
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-4">
                                    <div class="row">
                                        <div class="col-4" style="padding-left: 2.5rem; padding-top: 1rem">
                                            <input type="submit" name="btn_search" id="btn_search" class="btn btn-primary" value="Tìm kiếm"/>
                                        </div>
                                        <div class="col-4">
                                            Sắp xếp theo
                                            <select class="form-control" name="order_product">
                                                <option value="">--Chọn--</option>
                                                <option value="productName">Tên sản phẩm</option>
                                                <option value="category">Thể loại</option>
                                                <option value="productPrice ">Giá sản phẩm</option>
                                                <option value="productStock ">Số lượng tồn</option>
                                                <option value="productUnitSold ">Số lượng bán</option>
                                            </select>
                                        </div>
                                        <div class="col-4">
                                            Sắp xếp kiểu
                                            <select class="form-control" name="order_type">
                                                <option value="">--Chọn--</option>
                                                <option value="ASC">Thấp đến cao</option>
                                                <option value="DESC">Cao đến thấp</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <script type="text/javascript">
                                $(document).ready(function () {
                                    var foodOptions = [
                                <c:forEach items="${requestScope.categoryList}" var="category">
                                    <c:if test="${category.type.typeID == 1}">
                                        {id: '${category.categoryID}', name: '${category.categoryName}'},
                                    </c:if>
                                </c:forEach>
                                    ];
                                    var ingredientOptions = [
                                <c:forEach items="${requestScope.categoryList}" var="category">
                                    <c:if test="${category.type.typeID == 2}">
                                        {id: '${category.categoryID}', name: '${category.categoryName}'},
                                    </c:if>
                                </c:forEach>
                                    ];

                                    $('select[name="search_typeID"]').change(function () {
                                        var selectedType = $(this).val();
                                        var optionsToUse = selectedType === '1' ? foodOptions : ingredientOptions;

                                        var $categorySelect = $('select[name="search_categoryID"]');
                                        $categorySelect.empty();

                                        $categorySelect.append($('<option></option>').val('').text('--Chọn--x   '));
                                        $.each(optionsToUse, function (index, item) {
                                            $categorySelect.append($('<option></option>').val(item.id).text(item.id + '.' + item.name));
                                        });
                                        if (selectedType === '1') {
                                            $('select[name="search_isVegetarian"]').closest('p').show();
                                            $('select[name="search_isVegan"]').closest('p').show();
                                            $('select[name="search_hasSpecialDietaryRequirements"]').closest('p').show();
                                        } else {
                                            $('select[name="search_isVegetarian"]').closest('p').hide();
                                            $('select[name="search_isVegan"]').closest('p').hide();
                                            $('select[name="search_hasSpecialDietaryRequirements"]').closest('p').hide();
                                        }


                                    });


                                    $('select[name="order_product"]').change(function () {
                                        // Lấy giá trị của select "order_product"
                                        var selectedValue = $(this).val();

                                        // Nếu giá trị được chọn là productName, category, type, productPrice, productStock, hoặc productUnitSold
                                        // Thì ẩn select có name là "order_type"
                                        if (selectedValue === '') {
                                            $('select[name="order_type"]').prop('disabled', true).val('');
                                        } else {
                                            $('select[name="order_type"]').prop('disabled', false);
                                        }
                                    });
                                    $('select[name="order_type"]').prop('disabled', true).val('');


                                });

                            </script>
                        </form>
                    </div>
                </div>
            </div>
            <h1>Quản lí sản phẩm</h1>
            <p><a class="btn btn-secondary btn-lg active" href="/ProjectJSP/InsertProductServlet" >Insert Product</a>
                <a class="btn btn-primary btn-lg active" type="button" title="In" onclick="myApp.printTable()"> <i class="fas fa-print"></i> In dữ liệu</a>
            </p> 
            <div id="productList">
                <table class="styled-table" id="productListTable">
                    <thead>
                        <tr>
                            <th>Product ID</th>
                            <th>Product Name</th>
                            <th>Category</th>
                            <th>Type</th>
                            <th>Is Vegetarian</th>
                            <th>Is Vegan</th>
                            <th>Has Special Dietary Requirements</th>
                            <th>Product Size</th>
                            <th>Price</th>
                            <th>Discount (%)</th>
                            <th>Stock</th>
                            <th>Unit sold</th>
                            <th>Status</th>
                            <th>Remove</th>
                            <th>Update</th>
                        </tr>
                    </thead>
                    <c:forEach var="product" items="${requestScope.productsPage}">
                        <c:if test= "${product.isStatus != 0}" >
                            <tbody>
                                <tr>
                                    <th>${product.productID}</th>
                                    <th>${product.productName}</th>
                                    <th>${product.category.categoryName}</th>
                                    <th>${product.type.typeName}</th>
                                    <th>${product.isVegetarian == 1 ? "True" : "False"}</th>
                                    <th>${product.isVegan == 1 ? "True" : "False"}</th>
                                    <th>${product.hasSpecialDietaryRequirements == 1 ? "True" : "False"}</th>
                                    <th><c:forEach items="${product.productSize}" var="size" varStatus="loop">
                                            ${size}<c:if test="${not loop.last}">,</c:if>
                                        </c:forEach></th>
                                    <th>${product.productPrice}</th>
                                    <th>${product.discount}</th>
                                    <th>${product.productStock}</th>
                                    <th>${product.productUnitSold}</th>
                                    <th>${product.isStatus == 1 ? "Activate" : "Deactivate"}</th>
                                    <th><a class="btn btn-primary" href="RemoveProduceServlet?productID=${product.productID}">Xóa</a></th>
                                    <th><a class="btn btn-primary" href="UpdateProductServlet?productID=${product.productID}">Cập nhật</a></th>
                                </tr>  
                            </tbody>
                            <tr>
                                <td colspan="15">
                                    <h2>Mô tả</h2>
                                    ${product.productDescribe}
                                </td>
                            </tr>
                        </c:if>
                        <c:if test="${requestScope.update_status} != null">
                            <p>Update successful</p>
                        </c:if>
                    </c:forEach>   
                </table>
            </div>
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="ManageProductServlet?page=${currentPage - 1}">Previous</a>
                </c:if>
                <c:forEach var="i" begin="1" end="${noOfPages}">
                    <a href="ManageProductServlet?page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                </c:forEach>
                <c:if test="${currentPage < noOfPages}">
                    <a href="ManageProductServlet?page=${currentPage + 1}">Next</a>
                </c:if>
            </div>
            <script>

                var myApp = new function () {
                    this.printTable = function () {
                        var tab = document.getElementById('productList');
                        var win = window.open('', '', 'height=700,width=700');
                        win.document.write(tab.outerHTML);
                        win.document.close();
                        win.print();
                    };
                };

                $(document).ready(function () {
                    $('#searchProductForm').on('submit', function (event) {
                        // Ngăn chặn hành động mặc định của form (tải lại trang)
                        event.preventDefault();
                        // Gửi yêu cầu Ajax
                        $.ajax({
                            type: 'POST',
                            url: '/ProjectJSP/SearchProductServlet',
                            data: {
                                productName: $('input[name="search_productName"]').val().trim(),
                                typeID: $('select[name="search_typeID"]').val(),
                                categoryID: $('select[name="search_categoryID"]').val(),
                                isVegetarian: $('select[name="search_isVegetarian"]').val(),
                                isVegan: $('select[name="search_isVegan"]').val(),
                                size: $('input[name="search_size"]').val().trim(),
                                price: $('input[name="search_price"]').val().trim(),
                                stock: $('input[name="search_stock"]').val().trim(),
                                unitSold: $('input[name="search_unitSold"]').val().trim(),
                                order_product: $('select[name="order_product"]').val(),
                                order_type: $('select[name="order_type"]').val()
                            },
                            success: function (data) {
                                var html = ' <table class="styled-table" > <tr><th>ProductID</th><th>Product Name</th><th>Category</th><th>Type</th><th>Is Vegetarian</th><th>Is Vegan</th><th>Has Special Dietary Requirements</th><th>Product Size</th><th>Price</th><th>Discount (%)</th><th>Stock</th><th>Unit sold</th><th>Status</th><th>Remove</th><th>Update</th></tr>';
                                var productList = data; // Dựa vào cấu trúc dữ liệu trả về từ Servlet để xử lý

                                $.each(productList, function (index, product) {
                                    html += '<tr>';
                                    html += '<td>' + product.productID + '</td>';
                                    html += '<td>' + product.productName + '</td>';
                                    html += '<td>' + product.category.categoryName + '</td>';
                                    html += '<td>' + product.type.typeName + '</td>';
                                    html += '<td>' + (product.isVegetarian == 1 ? "True" : "False") + '</td>';
                                    html += '<td>' + (product.isVegan == 1 ? "True" : "False") + '</td>';
                                    html += '<td>' + (product.hasSpecialDietaryRequirements == 1 ? "True" : "False") + '</td>';
                                    html += '<td>';
                                    $.each(product.productSize, function (sizeIndex, size) {
                                        html += size;
                                        if (sizeIndex < product.productSize.length - 1) {
                                            html += ', ';
                                        }
                                    });
                                    html += '</td>';
                                    html += '<td>' + product.productPrice + '</td>';
                                    html += '<td>' + product.discount + '</td>'
                                    html += '<td>' + product.productStock + '</td>';
                                    html += '<td>' + product.productUnitSold + '</td>';
                                    html += '<td>' + (product.isStatus === 1 ? "Activate" : "Deactivate") + '</td>';
                                    html += '<td><a class="btn btn-primary" href="RemoveProduceServlet?productID=' + product.productID + '">remove</a></td>';
                                    html += '<td><a class="btn btn-primary" href="UpdateProductServlet?productID=' + product.productID + '">update</a></td>';
                                    html += '</tr>';
                                    html += '<tr>';
                                    html += '<td colspan="15">';
                                    html += '<h2>Mô tả</h2>';
                                    html += product.productDescribe;
                                    html += '</td>';
                                    html += '</tr>';
                                });
                                html += '</table>'

                                // Thay thế nội dung của bảng với HTML mới xây dựng
                                $('#productList').html(html); // Thay thế nội dung trong #productList bằng danh sách sản phẩm mới
                                $('[data-toggle="tooltip"]').tooltip();
                                $('.dropdown-toggle').dropdown();
                            },
                            error: function () {
                                alert('Đã xảy ra lỗi khi gửi yêu cầu tìm kiếm sản phẩm.');
                            }
                        });
                    });
                });

            </script>
        </div>
    </body>
</html>

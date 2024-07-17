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
        <title>Quản lí sản phẩm</title>
    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>
        <%@include file="../../common/admin/sidebar.jsp" %>
        <div class="main" style="margin-top: 1rem">
            <div class="card" id="searchAdvance" hidden="hidden">
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
                                        <option value="">--Chọn--</option>
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
                                <div class="col-4">Điền giá: <b style="padding-right: 0.5rem">${requestScope.minProductPrice} </b> <input id="productPriceSlider" type="text" class="span2 form-control" value="" data-slider-min="${requestScope.minProductPrice}" data-slider-max="${requestScope.maxProductPrice}" data-slider-step="1000" data-slider-value="[${requestScope.minProductPrice + 999},${requestScope.maxProductPrice}]"/> <b style="padding-left: 1rem">${requestScope.maxProductPrice}</b></div>
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
                                    </div>
                                </div>
                            </div>
                            <script type="text/javascript">

                                $("#productPriceSlider").bootstrapSlider();
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
                <a class="btn btn-primary btn-lg active" type="button" onclick="searchAdvance()"> <i class="fas fa-print"></i> Tìm nâng cao</a>
            </p> 
            <div id="productList">
                <table class="styled-table" id="productListTable" style="font-size:15px">
                    <thead>
                        <tr>
                            <th>Product ID</th>
                            <th>Image</th>
                            <th>Product Name</th>
                            <th>Category</th>
                            <th>Type</th>
                            <th>Is Vegetarian</th>
                            <th>Is Vegan</th>
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
                    <tbody>
                        <c:forEach var="product" items="${requestScope.products}">
                            <c:if test= "${product.isStatus != 0}" >
                                <tr style="text-align: center">
                                    <th>${product.productID}</th>
                                    <th><img src="${product.productImage[0]}" width="100" height="100"</th>
                                    <th>${product.productName}</th>
                                    <th>${product.category.categoryName}</th>
                                    <th>${product.type.typeName}</th>
                                    <th>${product.isVegetarian == 1 ? "True" : "False"}</th>
                                    <th>${product.isVegan == 1 ? "True" : "False"}</th>
                                    <th><c:forEach items="${product.productSize}" var="size" varStatus="loop">
                                            ${size}<c:if test="${not loop.last}">,</c:if>
                                        </c:forEach></th>
                                    <th>${product.productPrice}</th>
                                    <th>${product.discount}</th>
                                    <th>${product.productStock}</th>
                                    <th>${product.productUnitSold}</th>
                                    <th>${product.isStatus == 1 ? "Activate" : "Deactivate"}</th>
                                    <th><a class="btn btn-primary" href="RemoveProduceServlet?productID=${product.productID}">Xóa</a></th>
                                    <th><a class="btn btn-primary" href="UpdateProductServlet?productID=${product.productID}">Cập nhật</a><button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#describeBox${product.productID}">Mô tả và hình ảnh</button>
                                    </th>
                                </tr>  
                            <div>
                                <div class="modal fade" id="describeBox${product.productID}" tabindex="-1" aria-hidden="true">
                                    <div class="modal-dialog modal-lg">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="exampleModalLabel">Mô tả và hình ảnh</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <div>
                                                    <h1>Mô tả</h1>
                                                    <p>${product.productDescribe}</p>
                                                </div>
                                                <div>
                                                    <h1>Hình ảnh</h1>
                                                    <c:forEach items="${product.productImage}" var="image">
                                                        <img src="${image}" style="width: 100%; margin-bottom: 1rem">
 
                                                    </c:forEach>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>   
                    </tbody>
                </table>
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

                function searchAdvance() {
                    var searchAdvance = document.getElementById("searchAdvance");

                    if (searchAdvance.getAttribute("hidden") === "hidden") {
                        searchAdvance.removeAttribute("hidden");
                    } else {
                        searchAdvance.setAttribute("hidden", "hidden");
                        reset();
                    }
                }

                function reset() {
                    var searchForm = document.getElementById("searchForm");
                    searchForm.reset();
                    search(event);
                }

                function search(event) {
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
                            price: $("#productPriceSlider").val(),
                            stock: $('input[name="search_stock"]').val().trim(),
                            unitSold: $('input[name="search_unitSold"]').val().trim()
                        },
                        success: function (data) {
                            var html = ' <table class="styled-table" id="productListTable" style="font-size:15px"><thead><tr><th>ProductID</th><th>Image</th><th>Product Name</th><th>Category</th><th>Type</th><th>Is Vegetarian</th><th>Is Vegan</th><th>Has Special Dietary Requirements</th><th>Product Size</th><th>Price</th><th>Discount (%)</th><th>Stock</th><th>Unit sold</th><th>Status</th><th>Remove</th><th>Update</th></tr></thead>';
                            html += '<tbody>';
                            var productList = data; // Dựa vào cấu trúc dữ liệu trả về từ Servlet để xử lý

                            $.each(productList, function (index, product) {

                                html += '<tr style="text-align: center">';
                                html += '<td>' + product.productID + '</td>';
                                html += '<th><img src="' + product.productImage[0] + '" width="100" height="100"</th>';
                                html += '<td>' + product.productName + '</td>';
                                html += '<td>' + product.category.categoryName + '</td>';
                                html += '<td>' + product.type.typeName + '</td>';
                                html += '<td>' + (product.isVegetarian === 1 ? "True" : "False") + '</td>';
                                html += '<td>' + (product.isVegan === 1 ? "True" : "False") + '</td>';
                                html += '<td>' + (product.hasSpecialDietaryRequirements === 1 ? "True" : "False") + '</td>';
                                html += '<td>';
                                $.each(product.productSize, function (sizeIndex, size) {
                                    html += size;
                                    if (sizeIndex < product.productSize.length - 1) {
                                        html += ', ';
                                    }
                                });
                                html += '</td>';
                                html += '<td>' + product.productPrice + '</td>';
                                html += '<td>' + product.discount + '</td>';
                                html += '<td>' + product.productStock + '</td>';
                                html += '<td>' + product.productUnitSold + '</td>';
                                html += '<td>' + (product.isStatus === 1 ? "Activate" : "Deactivate") + '</td>';
                                html += '<th><a class="btn btn-primary" href="RemoveProduceServlet?productID=' + product.productID + '">Xóa</a></th>';
                                html += '<td><a class="btn btn-primary" href="UpdateProductServlet?productID=' + product.productID + '">Cập nhật</a>';
                                html += '<button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#describeBox' + product.productID + '">Mô tả</button></td>';
                                html += '</tr>';
                                html += '<div>';
                                html += '<div class="modal fade" id="describeBox' + product.productID + '" tabindex="-1" aria-hidden="true">';
                                html += '<div class="modal-dialog">';
                                html += '<div class="modal-content">';
                                html += '<div class="modal-header">';
                                html += '<h5 class="modal-title" id="exampleModalLabel">Mô tả</h5>';
                                html += '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>';
                                html += '</div>';
                                html += '<div class="modal-body">';
                                html += '<p>' + product.productDescribe + '</p>';
                                html += '</div>';
                                html += '<div class="modal-footer">';
                                html += '<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>';
                                html += '</div>';
                                html += '</div>';
                                html += '</div>';
                                html += '</div>';
                                html += '</div>';
                            });
                            html += '</tbody>';
                            html += '</table>';

                            // Thay thế nội dung của bảng với HTML mới xây dựng
                            $('#productList').html(html); // Thay thế nội dung trong #productList bằng danh sách sản phẩm mới
                            $('#productListTable').DataTable({
                                "info": false,
                                "columnDefs": [
                                    {"orderable": false, "targets": [12, 13, 14]}
                                ],
                                "language": {
                                    "lengthMenu": "Hiển thị _MENU_ mục mỗi trang"
                                }
                            });
                            $('[data-toggle="tooltip"]').tooltip();
                            $('.dropdown-toggle').dropdown();
                        },
                        error: function () {
                            alert('Đã xảy ra lỗi khi gửi yêu cầu tìm kiếm sản phẩm.');
                        }
                    });
                }


                $('#searchProductForm').submit(search);


                $(document).ready(function () {
                    $('#productListTable').DataTable({
                        "info": false,
                        "columnDefs": [
                            {"orderable": false, "targets": [12, 13, 14]}
                        ],
                        "language": {
                            "lengthMenu": "Hiển thị _MENU_ mục mỗi trang"
                        }
                    });
                });

            </script>
        </div>
    </body>
</html>

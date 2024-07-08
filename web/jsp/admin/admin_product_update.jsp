<%-- 
    Document   : admin_product_update
    Created on : May 23, 2024, 10:03:40 PM
    Author     : VQN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cập nhật sản phẩm</title>
    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>
        <%@include file="../../common/admin/sidebar.jsp" %>
        <div class="main">
            <div class="card">
                <div class="card-body">
                    <h1>Cập nhật sản phẩm</h1>
                    <form action="/ProjectJSP/UpdateProductServlet" enctype="multipart/form-data" method="post">
                        <p>Tên sản phầm *<input class="form-control" type="text" name="update_productName" placeholder="Enter Produce Name" value="${requestScope.productName}" required=""/></p>
                        <p>Tên loại
                            <select class="form-control" name="update_categoryID" >
                                <c:forEach items="${requestScope.categoryList}" var="category">
                                    <c:if test="${category.type.typeID == 1}">
                                        <option value="${category.categoryID}">${category.categoryID}.${category.categoryName}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </p>
                        <p>Tên loại sản phẩm
                            <select class="form-control" name="update_typeID">
                                <option value="1">Thức ăn</option>
                                <option value="2">Nguyên liệu</option>
                            </select>
                        </p>
                        <p>Có phải là thức ăn dành cho người ăn chay không
                            <select class="form-control" name="update_isVegetarian">
                                <option value="1">Có</option>
                                <option value="0" ${requestScope.isVegetarian == 0 ? "selected" : ""}>Không</option>
                            </select>
                        </p>
                        <p>Có phải là thức ăn dành cho Vegan không
                            <select class="form-control" name="update_isVegan">
                                <option value="1">Có</option>
                                <option value="0" ${requestScope.isVegan == 0 ? "selected" : ""} >Không</option>
                            </select>
                        </p>
                        <p>Có nguyên liệu đặc biệt không?
                            <select class="form-control" name="update_hasSpecialDietaryRequirements">
                                <option value="1">Có</option>
                                <option value="0" ${requestScope.hasSpecialDietaryRequirements == 0 ? "selected" : ""}>Không</option>
                            </select>
                        </p>
                        <p>Điền size *<input class="form-control" type="text" name="update_size" value="${requestScope.size}" placeholder="Enter Size" /></p>
                        <p>Điền giảm giá *<input class="form-control" type="number" name="update_discount" value="${requestScope.discount}" placeholder="Enter Discount" required=""/></p>
                        <p>Điền giá *<input class="form-control" type="number" name="update_price" value="${requestScope.price}" placeholder="Enter Price" required=""/></p>
                        <p>Điền số lượng còn *<input class="form-control" type="number" name="update_stock" value="${requestScope.stock}" placeholder="Enter Stock" required=""/></p>
                        <p>Điền số lượng bán *<input  class="form-control" type="number" name="update_unitSold" value="${requestScope.unitSold}" placeholder="Enter Unit Sold" required=""/></p>
                        <p>Điền status
                            <select class="form-control" name="update_status">
                                <option value="1">Có</option>
                                <option value="0" ${requestScope.status == 0 ? "selected" : ""}>Không</option>
                            </select>
                        </p>
                        <textarea class="form-control" id="text_describe" rol="30" col="30" name="update_describe" placeholder="Write Describe">${requestScope.describe}</textarea>
                        <input hidden name="productID" value="${requestScope.productID}"/>
                        Chọn ảnh thức ăn
                        <div class="row">

                            <div class="col-10">
                                <input type="file" class="form-control"     name="update_image" value="null" multiple/>
                            </div>
                            <div class="col-2">
                                <input class="form-control" type="button" value="Remove Image" name="remove_image" onclick="removeFile()"/>
                            </div>
                        </div>
                        <script type="text/javascript">

                            var textarea = new FroalaEditor('textarea', {
                                imageUpload: false
                            });

                            function removeFile() {
                                var preview = document.querySelector("input[type='file']");
                                preview.value = "";
                            }

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

                                $('select[name="insert_typeID"]').change(function () {
                                    var selectedType = $(this).val();
                                    var optionsToUse = selectedType === '1' ? foodOptions : ingredientOptions;

                                    var $categorySelect = $('select[name="insert_categoryID"]');
                                    $categorySelect.empty();

                                    $.each(optionsToUse, function (index, item) {
                                        $categorySelect.append($('<option></option>').val(item.id).text(item.id + '.' + item.name));
                                    });
                                    if (selectedType === '1') {
                                        $('select[name="insert_isVegetarian"]').closest('p').show();
                                        $('select[name="insert_isVegan"]').closest('p').show();
                                        $('select[name="insert_hasSpecialDietaryRequirements"]').closest('p').show();
                                    } else {
                                        $('select[name="insert_isVegetarian"]').closest('p').hide();
                                        $('select[name="insert_isVegan"]').closest('p').hide();
                                        $('select[name="insert_hasSpecialDietaryRequirements"]').closest('p').hide();
                                    }
                                });
                            });

                        </script>
                        <br>
                        <p><input type="submit" class="btn btn-primary" name="update_click" value="Cập nhật"/></p>
                </div>
            </div>
        </form>
    </div>
</body>
</html>

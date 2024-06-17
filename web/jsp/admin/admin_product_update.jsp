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
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>
        <h1>Update Product</h1>
        <h1>Update</h1>
        <form action="/ProjectJSP/UpdateProductServlet" enctype="multipart/form-data" method="post">
            <p>Tên sản phầm<input type="text" name="update_productName" placeholder="Enter Produce Name" value="${requestScope.productName}" required=""/>*</p>
            <p>Tên loại
                <select name="update_categoryID" >
                    <c:forEach items="${requestScope.categoryList}" var="category">
                        <c:if test="${category.type.typeID == 1}">
                            <option value="${category.categoryID}">${category.categoryID}.${category.categoryName}</option>
                        </c:if>
                    </c:forEach>
                </select>
            </p>
            <p>Tên loại sản phẩm
                <select name="update_typeID">
                    <option value="1">Thức ăn</option>
                    <option value="2">Nguyên liệu</option>
                </select>
            </p>
            <p>Có phải là thức ăn dành cho Vegetarian không
                <select name="update_isVegetarian">
                    <option value="1">Có</option>
                    <option value="0" ${requestScope.isVegetarian == 0 ? "selected" : ""}>Không</option>
                </select>
            </p>
            <p>Có phải là thức ăn dành cho Vegan không
                <select name="update_isVegan">
                    <option value="1">Có</option>
                    <option value="0" ${requestScope.isVegan == 0 ? "selected" : ""} >Không</option>
                </select>
            </p>
            <p>Có nguyên liệu đặc biệt không?
                <select name="update_hasSpecialDietaryRequirements">
                    <option value="1">Có</option>
                    <option value="0" ${requestScope.hasSpecialDietaryRequirements == 0 ? "selected" : ""}>Không</option>
                </select>
            </p>
            <p>Điền size<input type="text" name="update_size" value="${requestScope.size}" placeholder="Enter Size" />*</p>
            <p>Điền giá<input type="number" name="update_price" value="${requestScope.price}" placeholder="Enter Price" required=""/>*</p>
            <p>Điền số lượng còn<input type="number" name="update_stock" value="${requestScope.stock}" placeholder="Enter Stock" required=""/>*</p>
            <p>Điền số lượng bán<input type="number" name="update_unitSold" value="${requestScope.unitSold}" placeholder="Enter Unit Sold" required=""/>*</p>
            <p>Điền status
                <select name="update_status">
                    <option value="1">Có</option>
                    <option value="0" ${requestScope.status == 0 ? "selected" : ""}>Không</option>
                </select>
            </p>
            <textarea id="text_describe" rol="30" col="30" name="update_describe" placeholder="Write Describe">${requestScope.describe}</textarea>
            <input hidden name="productID" value="${requestScope.productID}"/>
            <div >
                Chọn ảnh thức ăn <input type="file" name="update_image" value="null" multiple/>
                <input type="button" value="Remove Image" name="remove_image" onclick="removeFile()"/>
            </div>
            <script type="text/javascript">
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
            <p><input type="submit" name="update_click" value="Update"/></p>
        </form>
    </body>
</html>

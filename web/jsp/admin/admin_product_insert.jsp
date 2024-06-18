<%-- 
    Document   : admin_product_insert
    Created on : May 21, 2024, 9:39:10 PM
    Author     : VQN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/common/web/add_css_js.jsp"%>  
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>
        <%@include file="../../common/admin/sidebar.jsp" %>
        <div class="main">
            <h1>Thêm sản phẩm</h1>
            <form action="/ProjectJSP/InsertProductServlet" enctype="multipart/form-data" method="post" >
                <p>Tên sản phầm <input type="text" name="insert_productName" placeholder="Enter Produce Name" required=""/>*</p>
                <p>Tên loại
                    <select name="insert_typeID" onchange="">
                        <option value="1">Thức ăn</option>
                        <option value="2">Nguyên liệu</option>
                    </select>
                </p>
                <p>Tên loại sản phẩm
                    <select name="insert_categoryID" >
                        <c:forEach items="${requestScope.categoryList}" var="category">
                            <c:if test="${category.type.typeID == 1}">
                                <option value="${category.categoryID}">${category.categoryID}.${category.categoryName}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </p>
                <p>Có phải là thức ăn dành cho Vegetarian không
                    <select name="insert_isVegetarian">
                        <option value="1">Có</option>
                        <option value="0">Không</option>
                    </select>
                </p>
                <p>Có phải là thức ăn dành cho Vegan không 
                    <select name="insert_isVegan">
                        <option value="1">Có</option>
                        <option value="0">Không</option>
                    </select>
                </p>
                <p>Có nguyên liệu đặc biệt không?
                    <select name="insert_hasSpecialDietaryRequirements">
                        <option value="1">Có</option>
                        <option value="0">Không</option>
                    </select>
                </p>
                <p>Điền size<input type="text" name="insert_size" placeholder="Enter Size" value=""/></p>
                <p>Điền giá <input type="number" name="insert_price" placeholder="Enter Price" required=""/>*</p>
                <p>Điền số lượng còn <input type="number" name="insert_stock" placeholder="Enter Stock" required=""/>*</p>
                <p>Điền số lượng bán <input type="number" name="insert_unitSold" placeholder="Enter Unit Sold" required=""/>*</p>
                <label>Viết miêu tả </label><br>
                <textarea id="text_describe" name="insert_describe" rows="4" cols="50" placeholder="Write Describe"></textarea>
                <div>
                    <br>
                    Chọn ảnh <input type="file" name="insert_image" value=""  accept="image/*" multiple/>
                    <input type="button" value="Remove Image" name="remove_image" onclick="removeFile()"/>
                </div>
                <p><input type="submit" name="btn_insert" value="Insert"/></p>
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
            </form>
        </div>
    </body>
</html>

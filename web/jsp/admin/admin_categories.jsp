
<%-- 
    Document   : admin_categories
    Created on : Jul 4, 2024, 8:05:33 AM
    Author     : VQN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lí thể loại</title>
    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>
        <%@include file="../../common/admin/sidebar.jsp" %>
        <%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
        <div class="main">
            <h1>Quản lí Thể loại</h1>
            <a class="btn btn-primary" type="button" title="In" onclick="myApp.printTable()">
                <i class="fas fa-print"></i> In dữ liệu</a>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#insertCategory">Chèn thể loại</button>
            <table class="styled-table" id="categoryList">
                <thead>
                    <tr class="category-head">
                        <th class='text-center'>CategoryID</th>
                        <th class="text-center">Tên dạng</th>
                        <th class="text-center">Tên thể loại</th>
                        <th class="text-center">Hành động</th>
                    </tr>
                <thead>
                <tbody>
                    <c:forEach var="category" items="${requestScope.categories}">
                        <tr class="category-body">
                            <td class="text-center">${category.categoryID}</td>
                            <td class="text-center">${category.categoryName}</td>
                            <td class="text-center">${category.type.typeName}</td>
                            <td class="text-center"><a class="btn btn-primary" href="RemoveCategoryServlet?categoryID=${category.categoryID}">Xóa</a></td>                
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="modal fade" id="insertCategory" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="staticBackdropLabel">Chèn thể loại</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="InsertCategoryServlet" method="get">
                                Nhập tên thể loại<input type="text" name="insert_categoryName" value="" class="form-control">
                                Nhập dạng 
                                <select class="form-control" name="insert_typeID" onchange="">
                                    <option value="1">Thức ăn</option>
                                    <option value="2">Nguyên liệu</option>
                                </select>
                                <br>
                                <input type="submit" name="btn_insert" value="Chèn" class="form-control">
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
            <script>

                var myApp = new function () {
                    this.printTable = function () {
                        var tab = document.getElementById('categoryList');
                        var win = window.open('', '', 'height=700,width=700');
                        win.document.write(tab.outerHTML);
                        win.document.close();
                        win.print();
                    };
                };



                $(document).ready(function () {
                    $('#categoryList').DataTable({
                        "info": false,
                        "columnDefs": [
                            {"orderable": false, "targets": [3]}
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

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib  uri="/WEB-INF/tlds/web_taglib" prefix="t" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thời gian hoạt động của ${requestScope.user.userName}</title>
    </head>
    <body>
        <%@ include file="../../common/web/header.jsp" %>
        <%@ include file="../../common/admin/sidebar.jsp" %>
        <div class="main">
            <h1>Thời gian đăng nhập của ${requestScope.user.userName}</h1>
            <div>
                <table class="table table-hover text-center" id="userList">
                    <tr>
                        <th>ID</th>
                        <th>Thời gian</th>
                    </tr>
                    <c:forEach var="userActivity" items="${requestScope.userActivityList}">
                        <tr style="font-size: medium">
                            <td>${userActivity.userActivityID}</td>
                            <td>${userActivity.activityDate}</td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>
</body>
</html>

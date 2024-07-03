<%-- 
    Document   : template
    Created on : Jul 3, 2024, 11:24:10 AM
    Author     : VQN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="../../common/web/header.jsp" %>  
        <div class="container">
            <h1>Hello World!</h1>
            Filter by price interval: <b>€ 10</b> <input id="ex2" type="text" class="span2" value="" data-slider-min="10" data-slider-max="1000" data-slider-step="5" data-slider-value="[250,450]"/> <b>€ 1000</b>
            <script>
                $("#ex2").slider({
                });

                $("#ex2").on('change', function () {
                    console.log($("#ex2").val());
                });
            </script>
        </div>
        <%@include file="../../common/web/footer.jsp" %> 
    </body>
</html>

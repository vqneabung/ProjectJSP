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
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@mdo">Open modal for @mdo</button>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@fat">Open modal for @fat</button>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@getbootstrap">Open modal for @getbootstrap</button>

            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">New message</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <table class="table-editable">

                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary">Send message</button>
                        </div>
                    </div>
                </div>
            </div>
            <style>
                .card {
                    width: 444px;
                }

                body {
                    background: #eee;
                }
            </style>

            <div class="card p-3 bg-white"><i class="fa fa-apple"></i>
                <div class="about-product text-center mt-2"><img src="https://i.imgur.com/3VTaSeb.png" width="300">
                    <div>
                        <h4>Believing is seeing</h4>
                        <h6 class="mt-0 text-black-50">Apple pro display XDR</h6>
                    </div>
                </div>
                <div class="stats mt-2">
                    <div class="d-flex justify-content-between p-price"><span>Pro Display XDR</span><span>$5,999</span></div>
                    <div class="d-flex justify-content-between p-price"><span>Pro stand</span><span>$999</span></div>
                    <div class="d-flex justify-content-between p-price"><span>Vesa Mount Adapter</span><span>$199</span></div>
                </div>
                <div class="d-flex justify-content-between total font-weight-bold mt-4"><span>Total</span><span>$7,197.00</span></div>
            </div>

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

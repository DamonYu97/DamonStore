        <%@ page import="java.math.BigInteger" %><%--
  Created by IntelliJ IDEA.
  User: damonyu
  Date: 2019-08-21
  Time: 14:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% pageContext.setAttribute("PATH", request.getContextPath());%>
        <% String productID = request.getParameter("productID");%>
<html>
<head>
    <title>Damon Store | Product Detail</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--JQuery-->
    <script type="text/javascript" src="${PATH}/static/js/jquery-3.4.1.min.js"></script>
    <!-- Bootstrap -->
    <link href="${PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <link href="${PATH}/static/css/main.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css?family=Josefin+Sans:300,300i,400,400i,700,700i" rel="stylesheet">
    <!-- Custom Fonts -->
    <link href="${PATH}/static/css/font/flaticon.css" rel="stylesheet" type="text/css">

    <!-- Bootstrap Validator CSS -->
    <link href="${PATH}/static/css/bootstrapValidator.min.css" rel="stylesheet">
    <!-- Bootstrap Validator JavaScript -->
    <script type="text/javascript" src="${PATH}/static/js/bootstrapValidator.js"></script>
</head>
<body>
    <!-- Header -->
    <%@include file="header.jsp"%>
    <% BigInteger memberPoint=null;
        if (member != null) { %>
    <% memberPoint = member.getPoint();
    } %>
    <div class="container" style="min-height: 100%; margin-top: 50px; margin-bottom: 50px">
        <div class="row" style="margin-bottom: 50px">
            <div class="col-lg-6">
                <div>
                    <img width="400px" id="product-big-img">
                </div>
                <div id="product-thumbnails" class="row center-block" style="margin-top: 30px;">
                </div>
            </div>
            <div class="col-lg-6">
                <h3 id="name"></h3>
                <br>
                <h2 id="price" class="text-danger"></h2>
                <br>
                <h4><span class="text-muted">Available:</span><span id="stock"> </span></h4>
                <br>
                <p><span class="text-muted">Brand:</span><span id="brand"> </span></p>
                <br>
                <div class="row">
                    <div class="text-muted col-lg-2" style="font-size: 20px; margin-top: 5px;">Quantity </div>
                    <div class="col-lg-3"><input id="quantity" class="center-block quantity-input" type="number" min="1" value="1"></div>
                </div>
                <div class="row" style="margin-top: 30px;">
                    <div id="point-warning" class="alert alert-danger" role="alert">Your point is not enough to buy this!</div>
                    <div class="col-lg-4"><button id="buy" class="btn btn-danger buy-button" onclick="buy()">Buy it now</button></div>
                    <div class="col-lg-4"><button id="toCart" class="btn btn-danger cart-button" onclick="toCart()">Add to cart</button></div>
                </div>
            </div>
        </div>
        <div style="border-top: 1px solid #d4d4d4; margin-bottom: 30px">
            <h3 class="text-muted">Description</h3>
            <p id="description"></p>
        </div>
        <video id="videoIntro" class="center-block" controls width="60%"></video>
    </div>

    <!-- Footer -->
    <%@include file="footer.jsp"%>

    <script type="text/javascript">
        $('#point-warning').hide();
        let member = "<%=member%>";
        let point = 0;
        $.ajax({
            type: 'POST',
            url: "${PATH}/member/product/showProductDetail"+window.location.search,
            async: true,
            dataType: "json",
            success: function (data) {
                let baseUrl = 'http://54.157.15.110:8080/images/product/';
                $('#product-big-img').attr("src",baseUrl + data.images[0].url);
                let thumbnails = '';
                for (let i = 0; i < data.images.length; i++) {
                    if (data.images[i].isMain == 1) {
                        $('#product-big-img').val(data.images[i].url);
                    }
                    thumbnails += '<a class="col-lg-2 thumbnail" href="#" style="margin-right: 10px;" onclick="changeImg(\'' + baseUrl + data.images[i].url + '\')">\n' +
                        '<img style="height: 100px;width: 100px" src="' + baseUrl + data.images[i].url + '">\n' +
                        '</a>';
                }
                point = data.product.point;
                let price = data.product.price;
                let priceTag = '$' + price;
                if (point != 0) {
                    priceTag += ' + ' + point + 'P';
                }
                $('#product-thumbnails').html(thumbnails);
                $('#name').html(data.product.name);
                $('#price').html(priceTag);
                $('#name').val(data.product.name);
                $('#price').val(data.product.price);
                $('#stock').html(" " + data.product.stock);
                $('#brand').html(" " + data.product.brandName);
                $('#description').html(data.product.description);
                let videoUrl = data.product.videoUrl;
                if ("" == videoUrl) {
                    $('#videoIntro').hide();
                } else {
                    $('#videoIntro').attr("src","http://47.106.104.159:8080/videos/" + videoUrl);
                }
                $('#quantity').attr("max",data.product.stock);
                if (data.product.stock == 0) {
                    $('#quantity').attr("min",0);
                    $('#quantity').val(0);
                    $('#buy').attr("disabled","disabled");
                    $('#toCart').attr("disabled","disabled");
                }
            }
        });

        function changeImg(data) {
            console.log("src"+data);
            $('#product-big-img').attr("src",data);
        };
        function buy() {
            if (member == "null") {
                window.location = "${PATH}/member/toLogout";
            } else {
                let item = [{"productID":<%=productID%>,"quantity":$('#quantity').val()}];
                if (point > 0 ){
                    let memberPoint = <%=memberPoint%>;
                    console.log("member point: " + memberPoint);
                    if (memberPoint < point) {
                        $('#point-warning').show();
                        return;
                    }
                }
                //加入缓存
                window.localStorage.setItem("items",JSON.stringify(item));
                window.location = "${PATH}/member/orderConfirm?from=buy";
            }
        };
        function toCart() {
            if (member == "null") {
                window.location = "${PATH}/member/toLogout";
            } else {
                if (point > 0 ){
                    let memberPoint = <%=memberPoint%>;
                    console.log("member point: " + memberPoint);
                    if (memberPoint < point) {
                        $('#point-warning').show();
                        return;
                    }
                }
                $.ajax({
                    type: 'POST',
                    url: '${PATH}/member/cart/addToCart',
                    data: {"productID":<%=productID%>,"quantity":$('#quantity').val()},
                    dataType: 'json',
                    success: function (data) {
                        if (data.result == true) {
                            $('#cart-item-count').html(data.count);
                            console.log("add success!");
                        } else {
                            console.log("add failed!");
                        }
                    }
                });
            }
        }
    </script>
</body>
</html>

<%--
  Created by IntelliJ IDEA.
  User: damonyu
  Date: 2019-08-20
  Time: 11:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% pageContext.setAttribute("PATH", request.getContextPath());%>
<html>
<head>
    <title>Damon Store | Products</title>
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
    <!-- Navigation -->
    <nav class="navbar navbar-collapse" style="margin-bottom: 0px;border-radius: 0px;">
        <div class="container">
            <ul class="nav nav-tabs" id="categoryTop">
            </ul>
        </div>
    </nav>
    <div class="container" style="min-height: 100%;">
        <h3 id="type">All product</h3>
        <br>
        <div class="row" id="productBox">
        </div>
    </div>
    <!-- Footer -->
    <%@include file="footer.jsp"%>

    <!-- nav categories javascript -->
    <script type="text/javascript">
        $.ajax({
            type: 'POST',
            url: "${PATH}/member/product/showAllProductType",
            async: true,
            dataType: "json",
            success: function (data) {
                console.log("types: " + data[0]);
                let categories = '<li ><a href=\"${PATH}/member/index\">Home</a></li>' +
                    '<li ><a href="${PATH}/member/products">All Products</a></li>';
                for (let i = 0; i < data.length; i++) {
                    if (data[i].type.isEnd == 1) {
                        categories += '<li ><a href="${PATH}/member/products?typeID=' + data[i].type.id + '">' + data[i].type.name + '</a></li>';
                    } else {
                        categories += '<li >\n' +
                            '<a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">\n' +
                            data[i].type.name +
                            '</a>\n' +
                            '<ul class="dropdown-menu">\n';
                        for (let j = 0; j < data[i].children.length; j++) {
                            if (data[i].children[j].type.isEnd == 1) {
                                categories += '<li ><a href="${PATH}/member/products?typeID=' + data[i].children[j].type.id + '">' + data[i].children[j].type.name + '</a></li>';
                            } else {
                                categories += '<li class="dropdown-submenu">\n' +
                                    '<a href="#" role="button">\n' +
                                    data[i].children[j].type.name +
                                    '</a>\n' +
                                    '<ul class="dropdown-menu">\n';
                                for (let k = 0; k < data[i].children[j].children.length; k++) {
                                    if (data[i].children[j].children[k].type.isEnd == 1) {
                                        categories += '<li ><a href="${PATH}/member/products?typeID=' + data[i].children[j].children[k].type.id + '">' + data[i].children[j].children[k].type.name + '</a></li>';
                                    }
                                }
                                categories += '</ul>\n' + '</li>';
                            }
                        }
                        categories += '</ul>\n' + '</li>';
                    }
                }
                $('#categoryTop').html(categories);
            }
        });
    </script>
    <!-- products info javascript -->
    <script type="text/javascript">
        $.ajax({
            type: 'POST',
            url: "${PATH}/member/product/showProduct"+window.location.search,
            async: true,
            dataType: "json",
            success: function (data) {
                $('#type').html(data.type);
                let productsBox = "";
                for (let i = 0; i < data.products.length; i++) {
                    let point = data.products[i].product.point;
                    let price = data.products[i].product.price;
                    let priceTag = '$' + price;
                    if (point != 0) {
                        priceTag += ' + ' + point + 'P';
                    }
                    productsBox += '<div class="col-sm-6 col-md-3">\n' +
                        '<a href="${PATH}/member/productDetail?productID=' + data.products[i].product.id + "\" role=\"button\" class=\"thumbnail\">\n    <img style=\"height: 250px;\" src=\"http://54.157.15.110:8080/images/product/" + data.products[i].mainImage + '" alt="' + data.products[i].mainImage +'">\n' +
                        '    <div class="caption">\n' +
                        '        <p style="height: 70px;">' + data.products[i].product.name + '</p>\n' +
                        '        <h3 class="text-danger text-center">' + priceTag + '</h3>\n' +
                        '    </div>' +
                        '</a>\n' +
                        '</div>';
                }
                $('#productBox').html(productsBox);
            }
        });
    </script>
</body>
</html>

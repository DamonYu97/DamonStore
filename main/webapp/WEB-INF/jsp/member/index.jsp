<%--
  Created by IntelliJ IDEA.
  User: damonyu
  Date: 2019-08-15
  Time: 10:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% pageContext.setAttribute("PATH", request.getContextPath());%>
<html>
<head>
    <title>Damon Store</title>
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
    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
        </ol>

        <!-- Wrapper for slides -->
        <div class="carousel-inner" role="listbox">
            <div class="item active">
                <img src="${PATH}/static/images/bg.jpg" alt="...">
                <div class="carousel-caption">
                    <div class="row">
                        <div class="col-xl-6 col-lg-7 text-white">
                            <h2 class="text-uppercase">New Arrivals</h2>
                            <h1 class="text-uppercase">denim jackets</h1>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis ipsum sus-pendisse ultrices gravida. Risus commodo viverra maecenas accumsan lacus vel facilisis. </p>
                            <a href="#" class="site-btn sb-line">DISCOVER</a>
                            <a href="#" class="site-btn sb-white">ADD TO CART</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="item">
                <img src="${PATH}/static/images/bg-2.jpg" alt="...">
                <div class="carousel-caption">
                    <div class="row">
                        <div class="col-xl-6 col-lg-7 col-lg-offset-7 text-white">
                            <h2 class="text-uppercase">New Arrivals</h2>
                            <h1 class="text-uppercase">denim jackets</h1>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis ipsum sus-pendisse ultrices gravida. Risus commodo viverra maecenas accumsan lacus vel facilisis. </p>
                            <a href="#" class="site-btn sb-line">DISCOVER</a>
                            <a href="#" class="site-btn sb-white">ADD TO CART</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Controls -->
        <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
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
</body>
</html>
<%--
  Created by IntelliJ IDEA.
  User: damonyu
  Date: 2019/8/25
  Time: 3:50 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% pageContext.setAttribute("PATH", request.getContextPath());%>
<html>
<head>
    <title>Damon Store | My account</title>
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
    <% if (member == null) {%>
    <jsp:forward page="login.jsp"></jsp:forward>
    <% } %>
    <div class="container-fluid">
        <div class="row">
            <div class="navbar-default sidebar col-lg-3" role="navigation">
                <div class="sidebar-nav container">
                    <ul class="nav nav-pills nav-stacked">
                        <li class="navbar-header"><h3>My account</h3></li>
                        <li><a href="${PATH}/member/myAccount"> Personal info</a></li>
                        <li><a href="${PATH}/member/address"> Address</a></li>
                        <li><a href="${PATH}/member/cart"> Shopping Cart</a> </li>
                        <li class="active"><a href="${PATH}/member/pointRecord"> Point record</a></li>
                        <li class="navbar-header"><h3>Orders</h3></li>
                        <li><a href="${PATH}/member/allOrders"> All orders</a></li>
                        <li><a href="${PATH}/member/unpaidOrders"> Unpaid orders</a></li>
                        <li><a href="${PATH}/member/unshippedOrders"> Unshipped orders</a></li>
                        <li><a href="${PATH}/member/unreceivedOrders"> Unreceived orders</a></li>
                    </ul>
                </div>
            </div>

            <div class="panel panel-default col-lg-9 container">
                <div class="panel-body">
                    <div style="width: 90%; height:100%; margin-bottom: 60px;" class="center-block">
                        <h1>Point Record</h1>
                        <div id="pointRecords">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Footer -->
    <%@include file="footer.jsp"%>

    <script type="text/javascript">
        $.ajax({
            type: 'POST',
            url: '${PATH}/member/point/checkPointRecord',
            dataType: 'json',
            success:function (data) {
                let pointRecordHtml = '';
                for (let i = 0; i < data.length; i++) {
                    pointRecordHtml += '<div class="card">\n' +
                        '                  <div class="row" style="margin: 0px 0px;">\n' +
                        '                      <h4 class="col-lg-4"><span class="text-muted">ID: </span><span> </span> ' + data[i].id + '</h4>\n' +
                        '                      <h4 class="col-lg-4">' + data[i].createTime + '</h4>\n' +
                        '                  </div>\n' +
                        '               <div class="row" style="margin: 0px 0px;">\n';
                    let type = '';
                    switch (data[i].type) {
                        case 1:
                            type = 'exchange';
                            pointRecordHtml += '<h4 class="col-lg-4"><span class="text-danger">Type: </span><span>' + type + '</span></h4>\n' +
                                '               <h4 class="col-lg-5"><span class="text-muted">from order(id): </span><span>' + data[i].orderId + '</span></h4>\n';
                            break;
                        case 2:
                            type = 'return';
                            pointRecordHtml += '<h4 class="col-lg-4"><span class="text-danger">Type: </span><span>' + type + '</span></h4>\n' +
                                '               <h4 class="col-lg-5"><span class="text-muted">from order(id): </span><span>' + data[i].orderId + '</span></h4>\n';
                            break;
                        case 3:
                            type = 'overdue';
                            pointRecordHtml += '<h4 class="col-lg-4"><span class="text-danger">Type: </span><span>' + type + '</span></h4>\n';
                            break;
                        default:
                            type = 'consumption';
                            pointRecordHtml += '<h4 class="col-lg-4"><span class="text-danger">Type: </span><span>' + type + '</span></h4>\n' +
                                '               <h4 class="col-lg-5"><span class="text-muted">from order(id): </span><span>' + data[i].orderId + '</span></h4>\n';
                    }
                    pointRecordHtml += '   <h4 class="col-lg-3"><span class="text-info">' + data[i].point + '</span> </h4>\n' +
                        '               </div>\n' +
                        '             </div>';
                }
                $('#pointRecords').html(pointRecordHtml);
            }
        });
    </script>
</body>
</html>


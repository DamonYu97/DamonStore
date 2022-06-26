<%--
  Created by IntelliJ IDEA.
  User: damonyu
  Date: 2019-08-11
  Time: 20:40
--%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% pageContext.setAttribute("PATH", request.getContextPath());%>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Damon Store management system - point management</title>

    <!-- Bootstrap Core CSS -->
    <link href="${PATH}/static/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="${PATH}/static/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="${PATH}/static/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Morris Charts CSS -->
    <link href="${PATH}/static/vendor/morrisjs/morris.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="${PATH}/static/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- DataTables CSS -->
    <link href="${PATH}/static/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

    <!-- DataTables Responsive CSS -->
    <link href="${PATH}/static/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">

    <!-- Bootstrap Validator CSS -->
    <link href="${PATH}/static/css/bootstrapValidator.min.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

<div id="wrapper">
    <!-- Navigation -->
    <%@include file="navigation.jsp"%>

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Point management</h1>
            </div>
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <i class="fa fa-adn fa-fw"></i> Manage point record
                    </div>
                    <div class="panel-body">
                        <table width="100%" class="table table-striped table-bordered table-hover" id="point">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Member ID</th>
                                <th>Type</th>
                                <th>Point</th>
                                <th>Order ID</th>
                                <th>Create time</th>
                                <th>Status</th>
                            </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->

<!-- jQuery -->
<script src="${PATH}/static/vendor/jquery/jquery.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="${PATH}/static/vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="${PATH}/static/vendor/metisMenu/metisMenu.min.js"></script>

<!-- Morris Charts JavaScript -->
<script src="${PATH}/static/vendor/raphael/raphael.min.js"></script>
<script src="${PATH}/static/vendor/morrisjs/morris.min.js"></script>
<script src="${PATH}/static/data/morris-data.js"></script>

<!-- Custom Theme JavaScript -->
<script src="${PATH}/static/dist/js/sb-admin-2.js"></script>

<!-- DataTables JavaScript -->
<script src="${PATH}/static/vendor/datatables/js/jquery.dataTables.min.js"></script>
<script src="${PATH}/static/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
<script src="${PATH}/static/vendor/datatables-responsive/dataTables.responsive.js"></script>

<!-- Bootstrap table javascript -->
<script type="text/javascript">
    $(document).ready(function() {
        $('#point').DataTable({
            "order": [[0, "desc"]],　
            "processing": true,
            "serverSide": false,
            "ajax": {
                "url": "${PATH}/admin/point/showAllPoint",
                "type": "POST",
                "dataType": "json",
                "data": "",
                "dataSrc": ""
            },
            "columns": [
                {   "data": "id" },
                {   "data": "memberId" },
                {   "data": "type",
                    "render": function (data, type, row, meta) {
                        switch (data) {
                            case 1:
                                return 'Exchange';
                                break;
                            case 2:
                                return 'Return';
                                break;
                            case 3:
                                return 'Overdue';
                                break;
                            default:
                                return 'Consumption';
                        }
                    }
                },
                {   "data": "point" },
                {   "data": "orderId" },
                {   "data": "createTime" },
                {   "data": "status",
                    "render": function (data, type, row, meta) {
                        if (data == 1){
                            return "Valid";
                        } else {
                            return "Invalid";
                        }
                    }
                }
            ]
        });
    });
</script>

</body>
</html>

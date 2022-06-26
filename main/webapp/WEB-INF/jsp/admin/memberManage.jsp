<%--
  Created by IntelliJ IDEA.
  User: damonyu
  Date: 2019-08-11
  Time: 9:12
--%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% pageContext.setAttribute("PATH", request.getContextPath());%>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Damon Store management system - member management</title>

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
                <h1 class="page-header">Member management</h1>
            </div>
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <i class="fa fa-adn fa-fw"></i> Manage members
                    </div>
                    <div class="panel-body">
                        <table width="100%" class="table table-striped table-bordered table-hover" id="member">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Username</th>
                                <th>Gender</th>
                                <th>Phone number</th>
                                <th>Email</th>
                                <th>Point</th>
                                <th>Status</th>
                                <th>Operations</th>
                            </tr>
                            </thead>
                        </table>

                        <!-- Reset Password Modal -->
                        <div class="modal fade" id="resetModal" tabindex="-1" role="dialog" aria-labelledby="resetModalLabel">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title" id="resetModalLabel">Update password</h4>
                                    </div>
                                    <form id="passwordForm" action="${PATH}/admin/member/updatePassword" method="post">
                                        <div class="modal-body">
                                            <div class="form-group">
                                                <label for="inputPassword">New Password</label>
                                                <input type="password" class="form-control" name="password" id="inputPassword" placeholder="Password">
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <input type="hidden" id="resetName" name="name"/>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                            <button type="submit" class="btn btn-primary">Update</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
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
        $('#member').DataTable({
            "order": [[0, "asc"]],
            "processing": true,
            "serverSide": false,
            "ajax": {
                "url": "${PATH}/admin/member/showAllMember",
                "type": "POST",
                "dataType": "json",
                "data": "",
                "dataSrc": ""
            },
            "columns": [
                {   "data": "id" },
                {   "data": "name" },
                {   "data": "gender",
                    "render": function (data, type, row, meta) {
                        if (typeof(data) == "undefined") {
                            return '';
                        } else if (data == 0) {
                            return 'Man';
                        } else {
                            return 'Women';
                        }
                    }
                },
                {   "data": "phoneNumber",
                    "render": function (data, type, row, meta) {
                        if (typeof(data) == "undefined") {
                            return '';
                        } else {
                            return data;
                        }
                    }
                },
                {   "data": "email",
                    "render": function (data, type, row, meta) {
                        if (typeof(data) == "undefined") {
                            return '';
                        } else {
                            return data;
                        }
                    }
                },
                {   "data": "point" },
                {   "data": "status",
                    "render": function (data, type, row, meta) {
                        if (data == 1){
                            return "Valid";
                        } else {
                            return "Invalid";
                        }
                    }
                },
                {
                    "data": null,
                    "searchable": false,
                    "render": function (data, type, row, meta) {
                        var disable = "";
                        var name = row.name;
                        var status = row.status;
                        console.log(name);
                        if (status == 0) {
                            disable = "disabled=\"disabled\"";
                        }
                        var resetButton = " <button type=\"button\" "+disable+" class=\"btn btn-warning\" \n" +
                            " data-toggle=\"modal\" data-target=\"#resetModal\" data-name="+name+">Reset Password</button>";
                        return resetButton;
                    }
                }
            ]
        });
    });
</script>

<script type="text/javascript">
    $('#resetModal').on('show.bs.modal', function (event) {
        let button = $(event.relatedTarget);
        let name = button.data('name');
        console.log('reset password name: '+name);
        let modal = $(this);
        modal.find('.modal-title').text('Reset password of ' + name);
        $('#resetName').val(name);
    });
</script>

</body>
</html>

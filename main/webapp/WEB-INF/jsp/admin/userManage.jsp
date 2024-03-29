<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% pageContext.setAttribute("PATH", request.getContextPath());%>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Damon Store management system - user management</title>

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
                <h1 class="page-header">User management</h1>
            </div>
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <i class="fa fa-adn fa-fw"></i> Manage admins
                    </div>
                    <div class="panel-body">
                        <button type="button" style="margin-bottom: 5px;" class="btn btn-info" data-toggle="modal" data-target="#addModal">
                           Add new admin
                        </button>
                        <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title" id="phoneModalLabel">Create a new admin account</h4>
                                    </div>
                                    <form class="form-horizontal" id="addForm" action="${PATH}/admin/createAdmin" method="post">
                                        <div class="modal-body">
                                            <div class="form-group">
                                                <label for="inputUsername" class="col-sm-4 control-label">Username</label>
                                                <div class="col-sm-6">
                                                    <input type="text" class="form-control" name="username" id="inputUsername" placeholder="Username">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="inputRealName" class="col-sm-4 control-label">Real Name</label>
                                                <div class="col-sm-6">
                                                    <input type="text" class="form-control" name="realName" id="inputRealName" placeholder="Real name">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="inputPassword" class="col-sm-4 control-label">Password</label>
                                                <div class="col-sm-6">
                                                    <input type="text" class="form-control" name="password" id="inputPassword" placeholder="Password">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="inputPhone" class="col-sm-4 control-label">Phone Number</label>
                                                <div class="col-sm-6">
                                                    <input type="text" class="form-control" name="phoneNumber" id="inputPhone" placeholder="Phone">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-4 control-label">Role</label>
                                                <div class="col-sm-6">
                                                    <select id="selectRole" name="role" class="form-control">
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                            <button type="submit" class="btn btn-primary">Create</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <table width="100%" class="table table-striped table-bordered table-hover" id="admin">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Username</th>
                                <th>Real name</th>
                                <th>Phone number</th>
                                <th>Role</th>
                                <th>Status</th>
                                <th>Operations</th>
                            </tr>
                            </thead>
                        </table>
                        <div class="modal fade" id="resetModal" tabindex="-1" role="dialog" aria-labelledby="resetModalLabel">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title" id="resetModalLabel">Reset password of this account</h4>
                                    </div>
                                    <form id="resetForm" action="${PATH}/admin/updatePassword?type=userManage" method="post">
                                        <div class="modal-body">
                                            <div class="form-group">
                                                <label for="inputNewPassword">New Password</label>
                                                <input type="text" class="form-control" name="newPassword" id="inputNewPassword" placeholder="Password">
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <input type="hidden" id="resetUsername" name="username"/>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                            <button type="submit" class="btn btn-primary">Reset</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                   <div class="modal-header">
                                       <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                       <h4 class="modal-title" id="deleteModalLabel">Warning! Delete this account?</h4>
                                   </div>
                                  <div class="modal-body">
                                  </div>
                                   <div class="modal-footer">
                                       <input type="hidden" id="deleteURL"/>
                                       <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                       <button type="button" class="btn btn-primary" onclick="urlDelete()">Delete</button>
                                   </div>
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

<!-- Bootstrap Validator JavaScript -->
<script type="text/javascript" src="${PATH}/static/js/bootstrapValidator.js"></script>

<!-- Bootstrap table javascript -->
<script type="text/javascript">
    $(document).ready(function() {
        $('#admin').DataTable({
            "order": [[0, "asc"]],
            "processing": true,
            "serverSide": false,
            "ajax": {
                "url": "${PATH}/admin/showAllAdmin",
                "type": "POST",
                "dataType": "json",
                "data": "",
                "dataSrc": ""
            },
            "columns": [
                {   "data": "admin.id" },
                {   "data": "admin.username" },
                {   "data": "admin.realName" },
                {   "data": "admin.phoneNumber" },
                {   "data": "role" },
                {   "data": "admin.status",
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
                        var username = row.admin.username;
                        var status = row.admin.status;
                        console.log(username);
                        if (username == "${admin.username}" || status == 0) {
                            disable = "disabled=\"disabled\"";
                        }
                        var resetButton = " <button type=\"button\" "+disable+" class=\"btn btn-warning\" \n" +
                            " data-toggle=\"modal\" data-target=\"#resetModal\" data-username="+username+">Reset Password</button>";
                        var deleteButton = " <button type=\"button\" "+disable+" class=\"btn btn-danger\" \n" +
                            " data-toggle=\"modal\" data-target=\"#deleteModal\" data-username="+username+">Delete</button>";
                        return resetButton+deleteButton;
                    },
                    width: "115px"
                }
            ]
        });
    });
</script>

<!-- Add new admin javascript -->
<script type="text/javascript">
    $.ajax({
            type: 'POST',
            url: "${PATH}/admin/showAllRole",
            async: true,
            dataType: "json",
            success: function (date) {
                let optionString = "";
                for (let j = 0; j < date.length;j++) {
                    optionString += "<option value=\"" + date[j].id + "\" >" +date[j].name+" " + "</option>";
                }
                $("#selectRole").html(optionString);
            }
        }
    );
</script>

<!-- Bootstrap Validator -->
<script type="text/javascript">
    $(document).ready(function() {
        $('#addForm').bootstrapValidator({
            message: 'This value is not valid',
            live: 'enable',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                username: {
                    message: 'The username is not valid',
                    validators: {
                        notEmpty: {
                            message: 'The username is required and can\'t be empty'
                        },
                        remote: {
                            type: 'POST',
                            url: '${PATH}/admin/checkUsername',
                            message: 'The username is not available',
                            delay: 1000
                        }
                    }
                },
                phoneNumber: {
                    message: 'The phone number is not valid',
                    validators: {
                        notEmpty: {
                            message: 'The phone number is required and can\'t be empty'
                        },
                        digits: {
                            message: 'The value can contain only digits'
                        },
                        stringLength: {
                            max: 11,
                            min: 11,
                            message: 'The length should be 11'
                        }
                    }
                }
            }
        });
    });
</script>

<script type="text/javascript">
    $('#deleteModal').on('show.bs.modal', function (event) {
        let button = $(event.relatedTarget);
        let username = button.data('username');
        console.log('delete username: '+username);
        let modal = $(this);
        modal.find('.modal-body').text('Are you sure you want to delete user ' + username + '?');
        $('#deleteURL').val('${PATH}/admin/deleteAdmin?username='+username);
    });
    function urlDelete() {
        var url=$.trim($("#deleteURL").val());
        window.location.href=url;
    };
    $('#resetModal').on('show.bs.modal', function (event) {
        let button = $(event.relatedTarget);
        let username = button.data('username');
        console.log('reset password username: '+username);
        let modal = $(this);
        modal.find('.modal-title').text('Reset password of ' + username);
        $('#resetUsername').val(username);
    });
</script>
</body>
</html>
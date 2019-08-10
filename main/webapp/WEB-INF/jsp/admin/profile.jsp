<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% pageContext.setAttribute("PATH", request.getContextPath());%>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Damon Store management system - Profile</title>

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
    <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="${PATH}/admin/index">Damon Store Management System</a>
        </div>
        <!-- /.navbar-header -->

        <ul class="nav navbar-top-links navbar-right">
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="fa fa-envelope fa-fw"></i> <i class="fa fa-caret-down"></i>
                </a>
                <ul class="dropdown-menu dropdown-messages">
                </ul>
                <!-- /.dropdown-messages -->
            </li>
            <!-- /.dropdown -->
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="fa fa-tasks fa-fw"></i> <i class="fa fa-caret-down"></i>
                </a>
                <ul class="dropdown-menu dropdown-tasks">
                </ul>
                <!-- /.dropdown-tasks -->
            </li>
            <!-- /.dropdown -->
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="fa fa-bell fa-fw"></i> <i class="fa fa-caret-down"></i>
                </a>
                <ul class="dropdown-menu dropdown-alerts">
                </ul>
                <!-- /.dropdown-alerts -->
            </li>
            <!-- /.dropdown -->
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                </a>
                <ul class="dropdown-menu dropdown-user">
                    <li><a href="${PATH}/admin/profile"><i class="fa fa-user fa-fw"></i> User Profile</a>
                    </li>
                    <li><a href="#"><i class="fa fa-gear fa-fw"></i> Settings</a>
                    </li>
                    <li class="divider"></li>
                    <li><a href="${PATH}/logout.do"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                    </li>
                </ul>
                <!-- /.dropdown-user -->
            </li>
            <!-- /.dropdown -->
        </ul>
        <!-- /.navbar-top-links -->

        <div class="navbar-default sidebar" role="navigation">
            <div class="sidebar-nav navbar-collapse">
                <ul class="nav" id="side-menu">
                    <li class="sidebar-search">
                        <div class="input-group custom-search-form">
                            <input type="text" class="form-control" placeholder="Search...">
                            <span class="input-group-btn">
                                <button class="btn btn-default" type="button">
                                    <i class="fa fa-search"></i>
                                </button>
                            </span>
                        </div>
                        <!-- /input-group -->
                    </li>
                    <li>
                        <a href="${PATH}/admin/index"><i class="fa fa-dashboard fa-fw"></i> Dashboard</a>
                    </li>
                    <li>
                        <a href="${PATH}/admin/profile"><i class="fa fa-user fa-fw"></i> Profile</a>
                    </li>
                    <security:authorize access="hasAuthority('ROLE_CHECK_ADMIN')">
                        <li>
                            <a href="${PATH}/admin/userManage"><i class="fa fa-adn fa-fw"></i> User Management</a>
                        </li>
                    </security:authorize>
                    <security:authorize access="hasAuthority('ROLE_CHECK_PRODUCT')">
                        <li>
                            <a href="${PATH}/admin/productManage"><i class="fa fa-gift fa-fw"></i> Product Management</a>
                        </li>
                    </security:authorize>
                    <security:authorize access="hasAuthority('ROLE_CHECK_ORDER')">
                        <li>
                            <a href="${PATH}/admin/index"><i class="fa fa-truck fa-fw"></i> Order Management</a>
                        </li>
                    </security:authorize>
                    <security:authorize access="hasAuthority('ROLE_CHECK_MEMBER')">
                        <li>
                            <a href="${PATH}/admin/index"><i class="fa fa-users fa-fw"></i> Member Information</a>
                        </li>
                    </security:authorize>
                    <security:authorize access="hasAuthority('ROLE_CHECK_POINT')">
                        <li>
                            <a href="${PATH}/admin/index"><i class="fa fa-euro fa-fw"></i> Point Information</a>
                        </li>
                    </security:authorize>
                </ul>
            </div>
            <!-- /.sidebar-collapse -->
        </div>
        <!-- /.navbar-static-side -->
    </nav>

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">
                    Profile
                </h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <i class="fa fa-user fa-fw"></i> Personal info
                    </div>
                    <div class="panel-body">
                        <br>
                        <div class="row center-block" style="width: 700px; height: 80px">
                            <button type="button" class="btn btn-default btn-lg btn-block" data-toggle="modal" data-target="#usernameModal">
                                <div class="col-md-4 text-muted text-left">USERNAME</div>
                                <div class="col-md-7 text-left">${admin.username}</div>
                                <div class="col-md-1 text-right"><i class="glyphicon glyphicon-menu-right"></i> </div>
                            </button>
                            <div class="modal fade" id="usernameModal" tabindex="-1" role="dialog" aria-labelledby="usernameModalLabel">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                            <h4 class="modal-title" id="usernameModalLabel">Update username</h4>
                                        </div>
                                        <form id="usernameForm" action="${PATH}/admin/updateUsername?name=${admin.username}" method="post">
                                            <div class="modal-body">
                                                <div class="form-group">
                                                    <label for="inputUsername">New username</label>
                                                    <input type="text" class="form-control" name="username" id="inputUsername" placeholder="Username">
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                <button type="submit" class="btn btn-primary">Update</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row center-block" style="width: 700px; height: 80px">
                            <button type="button" class="btn btn-default btn-lg btn-block" disabled="disabled">
                                <div class="col-md-4 text-muted text-left">REAL NAME</div>
                                <div class="col-md-8 text-left">${admin.realName}</div>
                            </button>
                        </div>
                        <div class="row center-block" style="width: 700px; height: 80px">
                            <button type="button" class="btn btn-default btn-lg btn-block" data-toggle="modal" data-target="#passwordModal">
                                <div class="col-md-4 text-muted text-left">PASSWORD</div>
                                <div class="col-md-7 text-left">
                                    ........
                                </div>
                                <div class="col-md-1 text-right"><i class="glyphicon glyphicon-menu-right"></i> </div>
                            </button>
                            <div class="modal fade" id="passwordModal" tabindex="-1" role="dialog" aria-labelledby="passwordModalLabel">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                            <h4 class="modal-title" id="passwordModalLabel">Update password</h4>
                                        </div>
                                        <form id="passwordForm" action="${PATH}/admin/updatePassword?type=profile&username=${admin.username}" method="post">
                                            <div class="modal-body">
                                                <div class="form-group">
                                                    <label for="inputOldPassword">Old Password</label>
                                                    <input type="password" class="form-control" name="oldPassword" id="inputOldPassword" placeholder="Old password">
                                                </div>
                                                <div class="form-group">
                                                    <label for="inputPassword">New Password</label>
                                                    <input type="password" class="form-control" name="newPassword" id="inputPassword" placeholder="Password">
                                                </div>
                                                <div class="form-group">
                                                    <label for="inputConfirmPassword">Retype Password</label>
                                                    <input type="password" class="form-control" name="confirmPassword" id="inputConfirmPassword" placeholder="Password">
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                <button type="submit" class="btn btn-primary">Update</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row center-block" style="width: 700px; height: 80px">
                            <button type="button" class="btn btn-default btn-lg btn-block" data-toggle="modal" data-target="#phoneModal">
                                <div class="col-md-4 text-muted text-left">PHONE</div>
                                <div class="col-md-7 text-left">${admin.phoneNumber}</div>
                                <div class="col-md-1 text-right"><i class="glyphicon glyphicon-menu-right"></i> </div>
                            </button>
                            <div class="modal fade" id="phoneModal" tabindex="-1" role="dialog" aria-labelledby="phoneModalLabel">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                            <h4 class="modal-title" id="phoneModalLabel">Update phone number</h4>
                                        </div>
                                        <form id="phoneForm" action="${PATH}/admin/updatePhone?name=${admin.username}" method="post">
                                            <div class="modal-body">
                                                <div class="form-group">
                                                    <label for="inputPhone">New phone number</label>
                                                    <input type="text" class="form-control" name="phoneNumber" id="inputPhone" placeholder="Phone">
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                <button type="submit" class="btn btn-primary">Update</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /.row (nested) -->
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
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

<!-- Bootstrap Validator JavaScript -->
<script type="text/javascript" src="${PATH}/static/js/bootstrapValidator.js"></script>

<!-- Bootstrap Validator -->
<script type="text/javascript">
    $(document).ready(function() {
        $('#usernameForm').bootstrapValidator({
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
                }
            }
        });
        $('#passwordForm').bootstrapValidator({
            message: 'This value is not valid',
            live: 'enable',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                oldPassword: {
                    message: 'The old password is not valid',
                    validators: {
                        notEmpty: {
                            message: 'The old password is required and can\'t be empty'
                        },
                        remote: {
                            type: 'POST',
                            url: '${PATH}/admin/checkPassword?password=${admin.password}',
                            message: 'The old password is not correct',
                            delay: 1000
                        }
                    }
                },
                newPassword: {
                    validators: {
                        notEmpty: {
                            message: 'The password is required and can\'t be empty'
                        }
                    }
                },
                confirmPassword: {
                    validators: {
                        notEmpty: {
                            message: 'The confirm password is required and can\'t be empty'
                        },
                        identical: {
                            field: 'newPassword',
                            message: 'The password and its confirm are not the same'
                        }
                    }
                },
            }
        });
        $('#phoneForm').bootstrapValidator({
            message: 'This value is not valid',
            live: 'enable',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
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

</body>

</html>
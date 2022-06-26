<%--
  Created by IntelliJ IDEA.
  User: damonyu
  Date: 2019-08-16
  Time: 15:08
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
                        <li class="active"><a href="${PATH}/member/myAccount"> Personal info</a></li>
                        <li><a href="${PATH}/member/address"> Address</a></li>
                        <li><a href="${PATH}/member/cart"> Shopping Cart</a> </li>
                        <li><a href="${PATH}/member/pointRecord"> Point record</a></li>
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
                    <div style="width: 65%; height:100%; margin-bottom: 60px;" class="center-block">
                        <h1>Your personal info</h1>
                        <div class="list-group">
                            <li class="list-group-item">
                                <div class="row">
                                    <div class="col-md-3">
                                        <h4 class="text-muted">Photo:</h4>
                                    </div>
                                    <div class="col-md-5">
                                        <a href="#" class="thumbnail center-block" role="button" style="width: 100px; border-radius: 50%;">
                                            <img id="profilePhoto" class="img-circle" height="100px" width="100px" src="http://47.106.104.159:8080/images/profile/default.jpg">
                                        </a>
                                    </div>
                                </div>
                            </li>
                            <li class="list-group-item">
                                <div class="row">
                                    <div class="col-md-3">
                                        <h4 class="text-muted">Name:</h4>
                                    </div>
                                    <div class="col-md-7">
                                        <h4>${member.name}</h4>
                                    </div>
                                    <div class="col-md-2">
                                        <button class="btn btn-default" style="width: 65px;" data-toggle="modal" data-target="#editNameModal">Edit</button>
                                    </div>
                                </div>
                            </li>
                            <li class="list-group-item">
                                <div class="row">
                                    <div class="col-md-3">
                                        <h4 class="text-muted">Password:</h4>
                                    </div>
                                    <div class="col-md-7">
                                        <h4>........</h4>
                                    </div>
                                    <div class="col-md-2">
                                        <button class="btn btn-default" style="width: 65px;" data-toggle="modal" data-target="#editPasswordModal">Reset</button>
                                    </div>
                                </div>
                            </li>

                            <li class="list-group-item">
                                <div class="row">
                                    <div class="col-md-3">
                                        <h4 class="text-muted">Gender:</h4>
                                    </div>
                                    <div class="col-md-7">
                                        <h4>${member.gender==0?"Male":"Female"}</h4>
                                    </div>
                                    <div class="col-md-2">
                                        <button class="btn btn-default" style="width: 65px;" data-toggle="modal" data-target="#editGenderModal">Edit</button>
                                    </div>
                                </div>
                            </li>
                            <li class="list-group-item">
                                <div class="row">
                                    <div class="col-md-3">
                                        <h4 class="text-muted">Phone:</h4>
                                    </div>
                                    <div class="col-md-7">
                                        <h4>${member.phoneNumber}</h4>
                                    </div>
                                    <div class="col-md-2">
                                        <button class="btn btn-default" style="width: 65px;" data-toggle="modal" data-target="#editPhoneModal">Edit</button>
                                    </div>
                                </div>
                            </li>

                            <li class="list-group-item">
                                <div class="row">
                                    <div class="col-md-3">
                                        <h4 class="text-muted">Email:</h4>
                                    </div>
                                    <div class="col-md-7">
                                        <h4>${member.email}</h4>
                                    </div>
                                    <div class="col-md-2">
                                        <button class="btn btn-default" style="width: 65px;" data-toggle="modal" data-target="#editEmailModal">Edit</button>
                                    </div>
                                </div>
                            </li>

                            <li class="list-group-item">
                                <div class="row">
                                    <div class="col-md-3">
                                        <h4 class="text-muted">Point:</h4>
                                    </div>
                                    <div class="col-md-7">
                                        <h4>${member.point} P</h4>
                                    </div>
                                </div>
                            </li>
                        </div>

                        <div class="modal fade" id="editNameModal" tabindex="-1" role="dialog" aria-labelledby="editNameModalLabel">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title" id="editNameModalLabel">Update your name</h4>
                                    </div>
                                    <form id="nameForm" method="post" action="${PATH}/member/updateName?oldName=${member.name}">
                                        <div class="modal-body">
                                            <div class="form-group">
                                                <label for="inputName">New Name</label>
                                                <input type="text" class="form-control" name="name" id="inputName" placeholder="Name">
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

                        <div class="modal fade" id="editPasswordModal" tabindex="-1" role="dialog" aria-labelledby="editPasswordModalLabel">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title" id="editPasswordModalLabel">Reset your password</h4>
                                    </div>
                                    <form id="passwordForm" method="post" action="${PATH}/member/updatePassword?name=${member.name}">
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

                        <div class="modal fade" id="editPhoneModal" tabindex="-1" role="dialog" aria-labelledby="editPhoneModalLabel">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title" id="editPhoneModalLabel">Update your phone number</h4>
                                    </div>
                                    <form id="phoneForm" method="post" action="${PATH}/member/updatePhone?name=${member.name}">
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

                        <div class="modal fade" id="editEmailModal" tabindex="-1" role="dialog" aria-labelledby="editEmailModalLabel">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title" id="editEmailModalLabel">Update your email</h4>
                                    </div>
                                    <form id="emailForm" method="post" action="${PATH}/member/updateEmail?name=${member.name}">
                                        <div class="modal-body">
                                            <div class="form-group">
                                                <label for="inputEmail">New email</label>
                                                <input type="text" class="form-control" name="email" id="inputEmail" placeholder="Email">
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

                    <div class="modal fade" id="editGenderModal" tabindex="-1" role="dialog" aria-labelledby="editGenderModalLabel">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="editGenderModalLabel">Set your gender</h4>
                                </div>
                                <form id="genderForm" class="form-horizontal" method="post" action="${PATH}/member/setGender?name=${member.name}">
                                    <div class="modal-body">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label">Gender</label>
                                            <div class="col-sm-6">
                                                <select name="gender" class="form-control">
                                                    <option value="0">Male</option>
                                                    <option value="1">Female</option>
                                                </select>
                                            </div>
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
            </div>
        </div>
    </div>
    <!-- Footer -->
    <%@include file="footer.jsp"%>

    <!-- Bootstrap Validator -->
    <script type="text/javascript">
        $(document).ready(function() {
            $('#nameForm').bootstrapValidator({
                message: 'This value is not valid',
                live: 'enable',
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    name: {
                        message: 'The new name is not valid',
                        validators: {
                            notEmpty: {
                                message: 'The new name is required and can\'t be empty'
                            },
                            remote: {
                                type: 'POST',
                                url: '${PATH}/member/checkUsername',
                                message: 'The name is not available',
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
                                url: '${PATH}/member/checkPassword?password=${member.password}',
                                message: 'The password is not correct',
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
                    }
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
            $('#emailForm').bootstrapValidator({
                message: 'This value is not valid',
                live: 'enable',
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    email: {
                        message: 'The phone number is not valid',
                        validators: {
                            notEmpty: {
                                message: 'The phone number is required and can\'t be empty'
                            },
                            emailAddress: {
                                message: 'The input is not a valid email address'
                            }
                        }
                    }
                }
            });
        });
    </script>
</body>
</html>

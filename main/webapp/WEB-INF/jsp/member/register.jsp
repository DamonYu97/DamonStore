<%--
  Created by IntelliJ IDEA.
  User: damonyu
  Date: 2019-08-15
  Time: 16:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% pageContext.setAttribute("PATH", request.getContextPath());%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--JQuery-->
    <script type="text/javascript" src="${PATH}/static/js/jquery-3.4.1.min.js"></script>
    <!-- Bootstrap -->
    <link href="${PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${PATH}/static/css/main.css" rel="stylesheet">
    <link href="${PATH}/static/css/bootstrapValidator.min.css" rel="stylesheet">
    <script src="${PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script src="${PATH}/static/js/bootstrapValidator.min.js"></script>
    <script src="${PATH}/static/js/bootstrapValidator.js"></script>
    <title>Sign in or Register</title>
</head>
<body>
<div class="container">
    <p id="home"><a href="${PATH}/member/index">DamonStore</a></p>
    <h1 id="hello">Create an account</h1>
    <h5 class="text-center" style="margin-bottom: 50px;">Already a member?
        <a href="${PATH}/member/toLogin">Sign in</a>
    </h5>
    <form id="registerForm" action="${PATH}/member/register" method="post">
        <div class="center-block" style="width: 350px;">
            <div class="form-group">
                <input type="text" class="form-control login-input center-block" name="name" placeholder="Username">
            </div>
            <div class="form-group">
                <input type="password" class="form-control login-input center-block" name="password" placeholder="Password">
            </div>
            <div class="form-group">
                <input type="password" class="form-control login-input center-block" name="confirmPassword" placeholder="Confirm password">
            </div>
        </div>
        <button type="submit" class="btn btn-primary long-button center-block">Create</button>
    </form>
</div>
<footer class="footer navbar-fixed-bottom text-center">
    Copyright &copy; 2019 Damon Inc. All Rights Reserved.<br>
    <a href="${PATH}/member/index"><img src="${PATH}/static/images/logo_DamonStore.png" width="200px"></a>
</footer>

<!-- Bootstrap Validator -->
<script type="text/javascript">
    $(document).ready(function() {
        $('#registerForm').bootstrapValidator({
            message: 'This value is not valid',
            live: 'enable',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                name: {
                    message: 'The username is not valid',
                    validators: {
                        notEmpty: {
                            message: 'The username is required and can\'t be empty'
                        },
                        remote: {
                            type: 'POST',
                            url: '${PATH}/member/checkUsername',
                            message: 'The username is not available',
                            delay: 1000
                        },
                        regexp: {
                            regexp: /^[a-zA-Z0-9_\.]+$/,
                            message: 'The username can only consist of alphabetical, number, dot and underscore'
                        }
                    }
                },
                password: {
                    message: 'The password is not valid',
                    validators: {
                        notEmpty: {
                            message: 'The password is required and can\'t be empty'
                        }
                    }
                },
                confirmPassword: {
                    message: 'The confirm password is not valid',
                    validators: {
                        notEmpty: {
                            message: 'Confirm password is require and can\'t be empty'
                        },
                        identical: {
                            field: 'password',
                            message: 'The password and its confirm are not the same'
                        }
                    }
                }
            }
        });
    });
</script>
</body>
</html>

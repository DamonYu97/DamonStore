<%--
  Created by IntelliJ IDEA.
  User: damonyu
  Date: 2019-08-15
  Time: 09:57
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <h1 id="hello">Hello</h1>
    <h5 class="text-center" style="margin-bottom: 50px;">Sign in to DamonStore or
        <a href="${PATH}/member/toRegister">create an account</a> or
        <a href="${PATH}/admin/index">manage system</a>
    </h5>
    <form id="loginForm" action="${PATH}/member/login" method="post">
        <div class="center-block" style="width: 350px;">
            <div class="form-group">
                <input type="text" class="form-control login-input center-block" name="name" placeholder="Username">
            </div>
            <div class="form-group">
                <input type="password" class="form-control login-input center-block" name="password" placeholder="Password">
            </div>
            <c:if test="${not empty param.error}">
                <p class="text-danger" style="margin-left: 6px">Wrong username or password!</p>
            </c:if>
            <div class="checkbox" style="margin-left: 6px">
                <label>
                    <input type="checkbox" name="remember-me" value="true"> Remember Me
                </label>
            </div>
        </div>
        <button type="submit" class="btn btn-primary long-button center-block">Sign in</button>
    </form>
    <h5 class="text-center" style="font-weight: normal;"><a href="" style="text-decoration: none;">Reset your password</a></h5>
</div>
<footer class="footer navbar-fixed-bottom text-center">
    Copyright &copy; 2019 Damon Inc. All Rights Reserved.<br>
    <a href="${PATH}/member/index"><img src="${PATH}/static/images/logo_DamonStore.png" width="200px"></a>
</footer>

<!-- Bootstrap Validator -->
<script type="text/javascript">
    $(document).ready(function() {
        $('#loginForm').bootstrapValidator({
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
                }
            }
        });
    });
</script>
</body>
</html>

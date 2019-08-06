<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% pageContext.setAttribute("PATH", request.getContextPath());%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <!--JQuery-->
    <script type="text/javascript" src="${PATH}/static/js/jquery-3.4.1.min.js"></script>
    <!-- Bootstrap -->
    <link href="${PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${PATH}/static/css/main.css" rel="stylesheet">
    <link href="${PATH}/static/css/bootstrapValidator.min.css" rel="stylesheet">
    <script src="${PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script src="${PATH}/static/js/bootstrapValidator.min.js"></script>
    <script src="${PATH}/static/js/bootstrapValidator.js"></script>
    <title>Admin Sign in</title>
</head>
<body>
    <div class="container">
        <p id="home"><a href="${PATH}/admin/index">DamonStore</a></p>
        <h1 id="hello">Hello</h1>
        <h5 class="text-center" style="margin-bottom: 50px;">Sign in to the management system of Damon Store</h5>
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <input type="text" class="form-control login-input center-block" name="username" id="inputUsername" placeholder="Username" required data-bv-notempty="true">
            </div>
            <div class="form-group">
                <input type="password" class="form-control login-input center-block" name="password" id="inputPassword" placeholder="Password" required data-bv-notempty="true">
            </div>
            <c:if test="${not empty param.error}">
                <p class="text-danger text-center">Wrong username or password!</p>
            </c:if>
            <button type="submit" class="btn btn-primary long-button center-block">Sign in</button>
        </form>
        <h5 class="text-center" style="font-weight: normal;"><a href="" style="text-decoration: none;">Reset your password</a></h5>
    </div>
    <footer class="footer navbar-fixed-bottom">
            Copyright &copy; 2019 Damon Inc. All Rights Reserved.<br>
            <a href="${PATH}/admin/index"><img src="${PATH}/static/images/logo_DamonStore.png" width="200px"></a>
    </footer>
    </body>
</html>
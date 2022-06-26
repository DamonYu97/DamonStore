<%--
  Created by IntelliJ IDEA.
  User: damonyu
  Date: 2019-08-11
  Time: 8:30
--%>
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
                        <a href="${PATH}/admin/orderManage"><i class="fa fa-truck fa-fw"></i> Order Management</a>
                    </li>
                </security:authorize>
                <security:authorize access="hasAuthority('ROLE_CHECK_MEMBER')">
                    <li>
                        <a href="${PATH}/admin/memberManage"><i class="fa fa-users fa-fw"></i> Member Information</a>
                    </li>
                </security:authorize>
                <security:authorize access="hasAuthority('ROLE_CHECK_POINT')">
                    <li>
                        <a href="${PATH}/admin/pointManage"><i class="fa fa-euro fa-fw"></i> Point Information</a>
                    </li>
                </security:authorize>
            </ul>
        </div>
        <!-- /.sidebar-collapse -->
    </div>
    <!-- /.navbar-static-side -->
</nav>

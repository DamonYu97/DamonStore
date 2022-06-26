<%--
  Created by IntelliJ IDEA.
  User: damonyu
  Date: 2019-08-15
  Time: 11:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.damon.dao.entity.Member" %>
<% Member member = (Member) session.getAttribute("member");%>
<% int cartItemQuantity = 0;%>
<% if (session.getAttribute("cartItemQuantity") != null) { %>
<% cartItemQuantity = (int)session.getAttribute("cartItemQuantity"); } %>
<header>
    <div class="header-top">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-2 text-center">
                    <!-- logo -->
                    <a href="${PATH}/member/index" class="site-logo">
                        <img height="40px" src="${PATH}/static/images/logo_DamonStore.png" alt="DamonStore">
                    </a>
                </div>
                <div class="col-lg-6 text-center">
                    <form class="header-search-form">
                        <input type="text" placeholder="Search on damonstore ....">
                        <button><i class="flaticon-search"></i></button>
                    </form>
                </div>
                <div class="col-lg-4 text-center">
                    <div class="user-panel" style="padding-top: 5px;">
                        <div class="up-item">
                            <% if (member != null) { %>
                            <div class="dropdown">
                                <i class="flaticon-user"></i>
                                <a href="#" class="btn dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" role="button">
                                    <% out.print(member.getName()); %> <span class="caret"></span>
                                </a>
                                <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                                    <li><a href="${PATH}/member/myAccount">My account</a></li>
                                    <li><a href="${PATH}/member/allOrders">All orders</a></li>
                                    <li role="separator" class="divider"></li>
                                    <li><a href="${PATH}/member/toLogout">Log out</a></li>
                                </ul>
                            </div>
                            <% } else { %>
                            <i class="flaticon-user"></i>
                            <a href="${PATH}/member/toLogin">Sign</a> In or <a href="${PATH}/member/toRegister">Create Account</a>
                            <% } %>
                        </div>
                        <div class="up-item">
                            <div class="shopping-card">
                                <i class="flaticon-bag"></i>
                                <span id="cart-item-count"><%=cartItemQuantity%></span>
                            </div>
                            <a href="${PATH}/member/cart">Shopping Cart</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>

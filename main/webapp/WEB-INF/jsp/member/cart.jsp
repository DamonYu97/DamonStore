<%--
  Created by IntelliJ IDEA.
  User: damonyu
  Date: 2019-08-22
  Time: 21:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% pageContext.setAttribute("PATH", request.getContextPath());%>
<html>
<head>
    <title>Damon Store | Cart</title>
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
                        <li><a href="${PATH}/member/myAccount"> Personal info</a></li>
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
                    <div style="width: 98%; height:100%; margin-bottom: 60px;" class="center-block">
                        <div class="row">
                            <h1 class="col-lg-9">Your shopping cart</h1>
                            <div class="col-lg-2">
                                <button id="edit" onclick="edit()" class="btn btn-warning" style="margin: 12px 0px;">Edit</button>
                                <button id="done" onclick="done()" class="btn btn-success" style="margin: 12px 0px;">Done</button>
                            </div>
                        </div>
                        <ul id="itemsList" class="list-group">
                        </ul>
                        <div class="row" style="margin:0px 5px 5px 0px;background-color: rgba(235,235,235,0.37);">
                            <div class="col-lg-2">
                                <input type="checkbox" onclick="checkAll(this)" id="all" style="margin: 25px 5px 20px 20px;"> All
                            </div>
                            <div class="col-lg-2 col-lg-offset-3">
                                <h3 id="totalLabel" class="text-muted"></h3>
                            </div>
                            <div class="col-lg-2">
                                <h3 id="total" class="text-danger" style="color: #d40f03"></h3>
                            </div>
                            <div class="col-lg-2">
                                <button id="checkOut" onclick="checkout()" disabled="disabled" class="btn btn-danger" style="margin: 12px 0px;">Check out</button>
                                <button id="delete" onclick="deleteItem()" disabled="disabled" class="btn btn-danger" style="margin: 12px 0px;">Delete</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Footer -->
    <%@include file="footer.jsp"%>

    <script type="text/javascript">
        $('#done').hide();
        $('#delete').hide();
        function showItems() {
            $.ajax({
                type: 'POST',
                url: '${PATH}/member/cart/checkCartItem',
                dataType: 'json',
                success:function (data) {
                    let itemsHtml = '';
                    let totalPrice = 0;
                    let totalPoint = 0;
                    for (let i =0; i < data.length; i++) {
                        let price = data[i].price;
                        let point = data[i].point;
                        let priceTag = '$' + price;
                        if (point != 0) {
                            priceTag += ' + ' + point + 'P';
                        }
                        let quantity = data[i].quantity;
                        let singleTotalPrice = price * quantity;
                        let singleTotalPoint = point * quantity;
                        totalPrice += singleTotalPrice;
                        totalPoint += singleTotalPoint;
                        itemsHtml += '<li class="list-group-item">\n' +
                            '             <div class="row" style="margin-left: 10px;">\n' +
                            '                 <div class="col-lg-1">\n' +
                            '                     <input type="checkbox" name="item" onclick="check(this,' + singleTotalPrice + ',' + singleTotalPoint +')" ' +
                            '                           style="margin-top: 30px;" value="' + data[i].id + '">' +
                            '                 </div>\n' +
                            '                 <div class="col-lg-2 thumbnail">\n' +
                            '                     <img src="http://54.157.15.110:8080/images/product/' + data[i].url+'">\n' +
                            '                 </div>\n' +
                            '                 <div class="col-lg-4">\n' +
                            '                     <p>' + data[i].name + '</p>\n' +
                            '                 </div>\n' +
                            '                 <div class="col-lg-2">\n' +
                            '                     <h4 class="text-danger">' + priceTag + '</h4>\n' +
                            '                 </div>\n' +
                            '                 <div class="col-lg-1">\n' +
                            '                     <h4 class="text-muted quantityH">x ' + quantity + '</h4>\n' +
                            '                     <input name="quantity" hidden="hidden" class="quantity-input" type="number" min="1" value="' + quantity +'">' +
                            '                 </div>\n' +
                            '             </div>' +
                            '           </li>';
                    }
                    $('#itemsList').html(itemsHtml);
                    $('#itemsList').val(totalPrice);
                    $('#total').val(totalPoint);
                }
            });
        };
        showItems();
        $('#done').hide();
    </script>
    <script type="text/javascript">
        let count = 0;
        let totalPrice = 0;
        let totalPoint = 0;
        function check(checkBox,price,point) {
            if (checkBox.checked == true){
                count ++;
                totalPrice += price;
                totalPoint += point;
                let priceTag = '$'+totalPrice;
                if (totalPoint != 0) {
                    priceTag += ' + ' + totalPoint + 'P';
                }
                $("#checkOut").html('Check out ('+count+')');
                $('#checkOut').removeAttr("disabled");
                $('#totalLabel').html('Total');
                $('#total').html(priceTag);
                $("#delete").html('Delete ('+count+')');
                $('#delete').removeAttr("disabled");
            } else {
                count --;
                totalPrice -= price;
                totalPoint -= point;
                if (count == 0) {
                    $("#checkOut").html('Check out');
                    $("#delete").html('Delete');
                    $('#checkOut').attr("disabled","disabled");
                    $('#totalLabel').html('');
                    $('#total').html('');
                    $('#delete').attr("disabled","disabled");
                } else {
                    let priceTag = '$'+totalPrice;
                    if (totalPoint != 0) {
                        priceTag += ' + ' + totalPoint + 'P';
                    }
                    $("#checkOut").html('Check out ('+count+')');
                    $("#delete").html('Delete ('+count+')');
                    $('#totalLabel').html('Total');
                    $('#total').html(priceTag);
                }
            }
        }
        function checkAll(checkBox) {
            let items = $('input[name="item"]');
            if (checkBox.checked == true) {
                totalPrice = $('#itemsList').val();
                totalPoint = $('#total').val();
                count = 0;
                items.each(function () {
                    count ++;
                    $(this).prop("checked",true);
                });
                let priceTag = '$'+totalPrice;
                if (totalPoint != 0) {
                    priceTag += ' + ' + totalPoint + 'P';
                }
                $("#checkOut").html('Check out ('+count+')');
                $('#checkOut').removeAttr("disabled");
                $('#totalLabel').html('Total');
                $('#total').html(priceTag);
                $("#delete").html('Delete ('+count+')');
                $('#delete').removeAttr("disabled");

            } else {
                items.each(function () {
                    $(this).prop("checked",false);
                });
                totalPrice = 0;
                totalPoint = 0;
                count = 0;
                $("#checkOut").html('Check out');
                $("#delete").html('Delete');
                $('#checkOut').attr("disabled","disabled");
                $('#totalLabel').html('');
                $('#total').html('');
                $('#delete').attr("disabled","disabled");
            }
        }
        function edit() {
            $('#edit').hide();
            $('#done').show();
            $('#checkOut').hide();
            $('#delete').show();
            $('#totalLabel').hide();
            $('#total').hide();
            $('.quantityH').hide();
            let quantityInput = $("input[name='quantity']");
            quantityInput.each(function () {
                $(this).removeAttr("hidden");
            })
        }
        function deleteItem() {
            let items = $('input[name="item"]:checked');
            let checkedItems = [];
            items.each(function () {
                let checkBox = $(this);
                checkedItems.push(checkBox.val());
            });
            $.ajax({
                type: 'POST',
                url: '${PATH}/member/cart/deleteCartItem',
                data: {"items":JSON.stringify(checkedItems)},
                dataType: 'json',
                success:function (data) {
                    if (data.result == true) {
                        $('#cart-item-count').html(data.count);
                        showItems();
                    } else {

                    }
                }
            })
        }
        function done() {
            let itemCheckBoxes = $('input[name="item"]');
            let allItemIDs = [];
            itemCheckBoxes.each(function () {
                allItemIDs.push($(this).val());
            });
            let allItemQuantities = [];
            let quantityInput = $("input[name='quantity']");
            quantityInput.each(function () {
                $(this).attr("hidden","hidden");
                allItemQuantities.push($(this).val());
            });
            let items = [];
            for (let i = 0; i < allItemIDs.length; i++) {
                let json = '{"id":' + allItemIDs[i] + ',"quantity":' + allItemQuantities[i] + '}';
                items.push(JSON.parse(json));
            }
            console.log("items: " + JSON.stringify(items));
            $.ajax({
                type: 'POST',
                url: '${PATH}/member/cart/updateCartItemQuantity',
                data: {"items":JSON.stringify(items)},
                dataType: 'json',
                success:function (msg) {
                    if (msg.result == true) {
                        showItems();
                        let quantityInput = $("input[name='quantity']");
                        quantityInput.each(function () {
                            $(this).attr("hidden","hidden");
                        });
                        $('#done').hide();
                        $('#edit').show();
                        $('#delete').hide();
                        $('#checkOut').show();
                        $('#totalLabel').show();
                        $('#total').show();
                        totalPrice = 0;
                        count = 0;
                        $("#checkOut").html('Check out');
                        $("#delete").html('Delete');
                        $('#checkOut').attr("disabled","disabled");
                        $('#totalLabel').html('');
                        $('#total').html('');
                        $('#delete').attr("disabled","disabled");
                    } else {

                    }
                }
            });
        }
        function checkout() {
            let itemCheckBoxes = $('input[name="item"]:checked');
            let allItemIDs = [];
            itemCheckBoxes.each(function () {
                let json = '{"cartItemID":' + $(this).val() + '}';
                allItemIDs.push(JSON.parse(json));
            });
            //加入缓存
            window.localStorage.setItem("items",JSON.stringify(allItemIDs));
            window.location = "${PATH}/member/orderConfirm?from=cart";
        }
    </script>
</body>
</html>

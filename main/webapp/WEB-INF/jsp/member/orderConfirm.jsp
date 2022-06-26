<%--
  Created by IntelliJ IDEA.
  User: damonyu
  Date: 2019-08-22
  Time: 09:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% pageContext.setAttribute("PATH", request.getContextPath());%>
<html>
<head>
    <title>Damon Store | Confirm order</title>
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
    <div class="container">
        <h3>Confirm your order</h3>
        <div class="panel panel-default">
            <div class="panel-body">
                <div style="margin: 20px 5px;">
                    <h3 class="text-muted"> Receiver's info</h3>
                    <div class="col-lg-11" style="margin: 20px 20px 40px 20px;">
                        <p id="address-warning" class="text-danger"></p>
                        <select id="address" class="form-control">
                        </select>
                    </div>
                </div>
                <div style="margin: 20px 5px;">
                    <h3 class="text-muted"> Payment method</h3>
                    <div class="btn-group" data-toggle="buttons" style="margin: 20px 20px 40px 20px;">
                        <label class="btn btn-success active">
                            <input type="radio" name="payment" id="weChat" checked> WeChat
                        </label>
                        <label class="btn btn-info">
                            <input type="radio" name="payment" id="aliPay"> AliPay
                        </label>
                        <label class="btn btn-primary">
                            <input type="radio" name="payment" id="creditCard"> Credit card
                        </label>
                    </div>
                </div>
                <div style="margin: 20px 5px;">
                    <h3 class="text-muted"> Items</h3>
                    <ul id="itemsList" class="list-group">
                    </ul>
                </div>
            </div>
        </div>
        <div class="row" style="margin:0px 10px 10px 10px;background-color: rgba(231,231,231,0.6);">
            <div class="col-lg-1 col-lg-offset-8">
                <h3 class="text-muted">Total</h3>
            </div>
            <div class="col-lg-3">
                <h3 id="total" class="text-danger" style="color: #da1007;"></h3>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-2 col-lg-offset-10">
                <button class="btn btn-danger btn-confirm" onclick="submitOrder()" data-toggle="modal" data-target="#reactModal">Confirm</button>
            </div>
        </div>
        <div class="modal fade" id="reactModal" tabindex="-1" role="dialog" aria-labelledby="reactModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="reactModalLabel"></h4>
                    </div>
                    <div class="modal-body">
                        <h4 id="message"></h4>
                    </div>
                    <div class="modal-footer" id="operation">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <%@include file="footer.jsp"%>

    <script type="text/javascript">
        $.ajax({
            type: 'POST',
            url: "${PATH}/member/address/checkAddress",
            async: true,
            dataType: "json",
            success: function (date) {
                let addresses = "";
                if (date.length == 0) {
                    $('#address-warning').html('No any address yet, go to <a href="${PATH}/member/address">add one</a>');
                }
                for (let i = 0; i < date.length; i++) {
                    if (date[i].isDefault == 1) {
                        addresses += '<option selected value="' + date[i].id + '">' + date[i].receiverName + ' ' +
                                date[i].receiverPhone + ' ' + date[i].province + ' Province,' + date[i].city + ' City,' + date[i].detail +
                                '</option>';
                    } else {
                        addresses += '<option value="' + date[i].id + '">' + date[i].receiverName + ' ' +
                            date[i].receiverPhone + ' ' + date[i].province + ' Province,' + date[i].city + ' City,' + date[i].detail +
                            '</option>';
                    }
                }
                $('#address').html(addresses);
            }
        });
    </script>

    <script type="text/javascript">
        let items = null;
        let totalPrice = 0;
        let totalPoint = 0;
        let itemInfo = JSON.parse(window.localStorage.getItem("items"));
        //show items
        $.ajax({
            type: 'POST',
            url: '${PATH}/member/order/checkItem'+window.location.search,
            data: {"items":JSON.stringify(itemInfo)},
            dataType: 'json',
            success:function (data) {
                items = data;
                let itemsHtml = '';
                for (let i =0; i < data.length; i++) {
                    let price = data[i].price;
                    let point = data[i].point;
                    let priceTag = '$' + price;
                    if (point != 0) {
                        priceTag += ' + ' + point + 'P';
                    }
                    let quantity = data[i].quantity;
                    totalPrice += price * quantity;
                    totalPoint += point * quantity;
                    itemsHtml += '<li class="list-group-item">\n' +
                        '             <div class="row" style="margin-left: 10px;">\n' +
                        '                 <div class="col-lg-2 thumbnail">\n' +
                        '                     <img src="http://54.157.15.110:8080/images/product/' + data[i].url+'">\n' +
                        '                 </div>\n' +
                        '                 <div class="col-lg-5 col-lg-offset-1">\n' +
                        '                     <p>' + data[i].name + '</p>\n' +
                        '                 </div>\n' +
                        '                 <div class="col-lg-2">\n' +
                        '                     <h4 class="text-danger">' + priceTag + '</h4>\n' +
                        '                 </div>\n' +
                        '                 <div class="col-lg-2">\n' +
                        '                     <h4 class="text-muted">x ' + quantity + '</h4>\n' +
                        '                 </div>\n' +
                        '             </div>' +
                        '           </li>';
                }
                $('#itemsList').html(itemsHtml);
                let totalPriceTag = '$' + totalPrice;
                if (totalPoint != 0) {
                    totalPriceTag += ' + ' + totalPoint + 'P';
                }

                $('#total').html(totalPriceTag);
            }
        });

        //submit order
        function submitOrder(){
            //获取选中的收货地址ID
            $('#reactModal').modal('hide');
            let addressID = $('#address').val();
            console.log('addressID: ' + addressID);
            $.ajax({
                type: 'POST',
                url: '${PATH}/member/order/submitOrder'+window.location.search,
                data: {"items":JSON.stringify(items),"addressID":addressID,"totalPrice":totalPrice,"totalPoint":totalPoint},
                dataType: 'json',
                success:function (data) {
                    if (data.result == true) {
                        //如果是来自购物车
                        if (window.location.search == '?from=cart') {
                            $('#cart-item-count').html(data.count);
                        }
                        $('#reactModal').on('show.bs.modal', function (event) {
                            let modal = $(this);
                            modal.find('.modal-title').text('Paying......');
                            let message = 'Order successfully! going to pay $'+ totalPrice + ' now';
                            $('#message').html(message);
                            let goPayButton = '<button type="button" class="btn btn-primary" onclick="pay(' + data.orderID + ')">Pay</button>';
                            $('#operation').html(goPayButton);
                        });
                    } else {
                        $('#reactModal').on('show.bs.modal', function (event) {
                            let modal = $(this);
                            modal.find('.modal-title').text('Warning info!');
                            let message = 'Failed to order, because ' + data.message;
                            $('#message').html(message);
                            let goBackButton = '<button type="button" class="btn btn-primary" onclick="window.history.back()">Go back</button>';
                            $('#operation').html(goBackButton);
                        });
                    }
                    $('#reactModal').modal('show');
                }
            });
        }

        //付款
        function pay(orderID) {
            //获取支付方式
            let payment = $("input[name='payment']:checked").val();
            $.ajax({
                type: 'POST',
                url: '${PATH}/member/order/pay',
                data: {"orderID":orderID,"price":totalPrice,"payment":payment},
                dataType: 'json',
                success:function (data) {
                    console.log(data.result);
                    window.location.href = "${PATH}/member/allOrders";
                }
            });
        }
    </script>
</body>
</html>

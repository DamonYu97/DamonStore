<%--
  Created by IntelliJ IDEA.
  User: damonyu
  Date: 2019-08-19
  Time: 14:12
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
                    <li><a href="${PATH}/member/myAccount"> Personal info</a></li>
                    <li class="active"><a href="${PATH}/member/address"> Address</a></li>
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
                <div style="width: 75%; min-height:100%; margin-bottom: 20px;" class="center-block">
                    <h1>Your addresses</h1>
                    <div class="list-group" id="addressList">
                    </div>
                    <button data-toggle="modal" data-target="#addAddressModal" style="border: 1px dashed lightgray; border-radius: 5px; width: 100%; padding: 10px;">
                        <img class="text-center" src="${PATH}/static/images/plus-black-symbol.png">
                        <h3 class="text-muted text-center">Add Address</h3>
                    </button>
                </div>
                <div class="modal fade" id="addAddressModal" tabindex="-1" role="dialog" aria-labelledby="addAddressModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="addAddressModalLabel">Add new address</h4>
                            </div>
                            <form id="addForm" class="form-horizontal" method="post" action="${PATH}/member/address/addAddress">
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label for="inputReceiverName" class="col-sm-4 control-label">Receiver's name</label>
                                        <div class="col-sm-6">
                                            <input type="text" class="form-control" name="receiverName" id="inputReceiverName" placeholder="Name">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputReceiverPhone" class="col-sm-4 control-label">Receiver's phone</label>
                                        <div class="col-sm-6">
                                            <input type="text" class="form-control" name="receiverPhone" id="inputReceiverPhone" placeholder="Phone">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputProvince" class="col-sm-4 control-label">Province</label>
                                        <div class="col-sm-6">
                                            <input type="text" class="form-control" name="province" id="inputProvince" placeholder="Province">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputCity" class="col-sm-4 control-label">City</label>
                                        <div class="col-sm-6">
                                            <input type="text" class="form-control" name="city" id="inputCity" placeholder="City">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputDetail" class="col-sm-4 control-label">Detail</label>
                                        <div class="col-sm-6">
                                            <textarea maxlength="250" class="form-control" name="detail" id="inputDetail" placeholder="Add more address detail here"></textarea>
                                        </div>
                                    </div>
                                    <div class="checkbox form-group">
                                        <div class="col-sm-6 col-sm-offset-4">
                                            <input type="checkbox" name="default" value="1">Default Address
                                        </div>
                                    </div>
                                    <input type="hidden" id="inputDefaultAddressID" name="defaultAddressID"/>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                    <button type="submit" class="btn btn-primary">Add</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="editAddressModal" tabindex="-1" role="dialog" aria-labelledby="editAddressModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="editAddressModalLabel">Update this address</h4>
                            </div>
                            <form id="editForm" class="form-horizontal" method="post" action="${PATH}/member/address/updateAddress">
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label for="inputName" class="col-sm-4 control-label">Receiver's name</label>
                                        <div class="col-sm-6">
                                            <input type="text" class="form-control" name="receiverName" id="inputName" placeholder="Name">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputPhone" class="col-sm-4 control-label">Receiver's phone</label>
                                        <div class="col-sm-6">
                                            <input type="text" class="form-control" name="receiverPhone" id="inputPhone" placeholder="Phone">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputEditProvince" class="col-sm-4 control-label">Province</label>
                                        <div class="col-sm-6">
                                            <input type="text" class="form-control" name="province" id="inputEditProvince" placeholder="Province">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputEditCity" class="col-sm-4 control-label">City</label>
                                        <div class="col-sm-6">
                                            <input type="text" class="form-control" name="city" id="inputEditCity" placeholder="City">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputEditDetail" class="col-sm-4 control-label">Detail</label>
                                        <div class="col-sm-6">
                                            <textarea maxlength="250" class="form-control" name="detail" id="inputEditDetail" placeholder="Add more address detail here"></textarea>
                                        </div>
                                    </div>
                                    <input type="hidden" id="addressID" name="id"/>
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

<!-- show addresses javascript -->
<script type="text/javascript">
    $.ajax({
        type: 'POST',
        url: "${PATH}/member/address/checkAddress",
        async: true,
        dataType: "json",
        success: function (data) {
            let addresses = "";
            let defaultAddressID = -1;
            for (let j = 0; j < data.length;j++) {
                if (data[j].isDefault == 1) {
                    defaultAddressID = data[j].id;
                }
            }
            for (let j = 0; j < data.length;j++) {
                let isDefault = '';
                let setDefault = '';
                if (data[j].isDefault == 0) {
                    setDefault = ' | <a href="${PATH}/member/address/setAsDefault?id=' + data[j].id + '&defaultAddressID=' +
                        defaultAddressID + '">Set as Default</a>';
                } else {
                    isDefault = 'Default';
                }
                addresses += '<li class="list-group-item">' +
                    '<div class="row">' +
                    '   <div class="col-md-2" style="padding-top: 20px;">' +
                    '       <img width="50px"src="${PATH}/static/images/location.png">' +
                    '   </div>' +
                    '   <div class="col-md-8">' +
                    '       <h4><span style="font-weight: bolder;">' + data[j].receiverName + '</span> ' +
                             data[j].receiverPhone + '</h4' +
                    '       <h4>' + data[j].province + 'Province, ' + data[j].city + 'City,</h4>' +
                    '       <h4>' + data[j].detail + '</h4>' +
                    '   </div>' +
                    '   <div class="col-md-2" style="padding-top: 20px;">' +
                    '       <h3 class="text-primary">' + isDefault + '</h3>' +
                    '   </div>' +
                    '</div>' +
                    '<div class="row">' +
                    '   <div class="col-md-5 col-md-offset-7">' +
                        '<button  class="btn btn-link" data-toggle="modal" data-target="#editAddressModal" data-name=' +
                        data[j].receiverName + ' data-phone=' + data[j].receiverPhone + ' data-province=' + data[j].province +
                        ' data-city=' + data[j].city + ' data-detail="' + data[j].detail + '" data-id=' + data[j].id + '>Edit</button>' +
                        ' | <a href="${PATH}/member/address/deleteAddress?id=' + data[j].id + '">Delete</a>' +
                        setDefault +
                    '   </div>' +
                    '</div>' +
                    '</li> <br>';
            }
            $("#addressList").html(addresses);
            $('#inputDefaultAddressID').val(defaultAddressID);
        }
    });
</script>

<script type="text/javascript">
    $('#editAddressModal').on('show.bs.modal', function (event) {
        let button = $(event.relatedTarget);
        let name = button.data('name');
        let phone = button.data('phone');
        let province = button.data('province');
        let city = button.data('city');
        let detail = button.data('detail');
        let id = button.data('id');
        console.log('address info: '+phone);
        let modal = $(this);
        $('#inputName').val(name);
        $('#inputPhone').val(phone);
        $('#inputEditProvince').val(province);
        $('#inputEditCity').val(city);
        $('#inputEditDetail').val(detail);
        $('#addressID').val(id);
    });
</script>
</body>
</html>

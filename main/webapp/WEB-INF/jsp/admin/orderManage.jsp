<%--
  Created by IntelliJ IDEA.
  User: damonyu
  Date: 2019-08-11
  Time: 14:43
--%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% pageContext.setAttribute("PATH", request.getContextPath());%>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Damon Store management system - user management</title>

    <!-- Bootstrap Core CSS -->
    <link href="${PATH}/static/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="${PATH}/static/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="${PATH}/static/dist/css/sb-admin-2.css" rel="stylesheet">
    <link href="${PATH}/static/css/main.css" rel="stylesheet">

    <!-- Morris Charts CSS -->
    <link href="${PATH}/static/vendor/morrisjs/morris.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="${PATH}/static/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- DataTables CSS -->
    <link href="${PATH}/static/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

    <!-- DataTables Responsive CSS -->
    <link href="${PATH}/static/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">

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
    <%@include file="navigation.jsp"%>

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Order management</h1>
            </div>
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <i class="fa fa-adn fa-fw"></i> Manage orders
                    </div>
                    <div class="panel-body">
                        <table width="100%" class="table table-striped table-bordered table-hover" id="order">
                            <thead>
                            <tr>
                                <th></th>
                                <th>ID</th>
                                <th>Member ID</th>
                                <th>Receiver's Info</th>
                                <th>Total price</th>
                                <th>Create time</th>
                                <th>Modify time</th>
                                <th>Status</th>
                                <th>Operations</th>
                            </tr>
                            </thead>
                        </table>
                        <div class="modal fade" id="addressModal" tabindex="-1" role="dialog" aria-labelledby="addressModalLabel">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title" id="addressModalLabel">Update receiver's address</h4>
                                    </div>
                                    <form class="form-horizontal" action="${PATH}/admin/order/updateAddress" method="post">
                                        <div class="modal-body">
                                            <div class="form-group">
                                                <label for="inputName" class="col-sm-4 control-label">Receiver name</label>
                                                <div class="col-sm-6">
                                                    <input type="text" class="form-control" name="receiverName" id="inputName" placeholder="Name">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="inputPhone" class="col-sm-4 control-label">Receiver phone</label>
                                                <div class="col-sm-6">
                                                    <input type="text" class="form-control" name="receiverPhone" id="inputPhone" placeholder="Phone">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="inputAddress" class="col-sm-4 control-label">Receiver address</label>
                                                <div class="col-sm-6">
                                                    <textarea class="form-control" name="receiverAddress" id="inputAddress" placeholder="Address"></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <input type="hidden" id="orderID" name="orderID"/>
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

<!-- DataTables JavaScript -->
<script src="${PATH}/static/vendor/datatables/js/jquery.dataTables.min.js"></script>
<script src="${PATH}/static/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
<script src="${PATH}/static/vendor/datatables-responsive/dataTables.responsive.js"></script>

<!-- Bootstrap table javascript -->
<script type="text/javascript">
    $(document).ready(function() {
        var table = $('#order').DataTable({
            "order": [[1, "desc"]],
            "processing": true,
            "serverSide": false,
            "ajax": {
                "url": "${PATH}/admin/order/showAllOrder",
                "type": "POST",
                "dataType": "json",
                "data": "",
                "dataSrc": ""
            },
            "columns": [
                {
                    "className": 'details-control',
                    "orderable": false,
                    "data": null,
                    select:"single",
                    "defaultContent": '',
                    "render": function () {
                        return '<i class="fa fa-plus-square" aria-hidden="true"></i>';
                    },
                    width:"15px"
                },
                {   "data": "order.id" },
                {   "data": "order.memberId" },
                {   "data": "order.receiverName",
                    "render": function (data, type, row, meta) {
                        return data + ' ' + row.order.receiverPhone + '<br>' + row.order.receiverAddress;
                    },
                    width: "100px"
                },
                {   "data": "order.totalPrice",
                    "render": function (data,type,row,meta) {
                        let priceTag = '$' + data;
                        let point = row.order.totalPoint;
                        if (point > 0) {
                            priceTag += '+' + row.order.totalPoint + 'P';
                        }
                        return priceTag;
                    }
                },
                {   "data": "order.createTime" },
                {   "data": "order.modifyTime",
                    "render": function (data,type,row,meta) {
                        if (typeof(data) != "undefined") {
                            return data;
                        } else {
                            return '';
                        }
                    }
                },
                {   "data": "order.status",
                    "render": function (data, type, row, meta) {
                        switch (data) {
                            case 0:
                                return 'Canceled';
                                break;
                            case 1:
                                return 'Unpaid';
                                break;
                            case 2:
                                return 'Unshipped';
                                break;
                            case 3:
                                return 'Unreceived';
                                break;
                            case 4:
                                return 'Done';
                        }
                    }
                },
                {
                    "data": null,
                    "searchable": false,
                    "orderable": false,
                    "render": function (data, type, row, meta) {
                        let receiverName = row.order.receiverName;
                        let receiverPhone = row.order.receiverPhone;
                        let receiverAddress = row.order.receiverAddress;
                        let status = row.order.status;
                        let shippedButton = " <button type=\"button\" class=\"btn btn-primary\"" +
                                                    " onclick=\"shipped(" + row.order.id + ")\">Shipped</button>";
                        let cancelButton = " <button type=\"button\" class=\"btn btn-danger\"" +
                                        " onclick=\"cancelOrder(" + row.order.id + "," + row.order.totalPoint + "," + row.order.memberId + ")\">Cancel</button>";
                        let updateAddressButton = " <button type=\"button\"  class=\"btn btn-warning\" " +
                                    " data-toggle=\"modal\" data-target=\"#addressModal\" data-name=\"" + receiverName +
                                    "\" data-phone=\"" + receiverPhone + "\" data-address=\"" + receiverAddress  +
                                    "\" data-id=" + row.order.id + ">Update address</button>";
                        switch (status) {
                            case 1:
                                return cancelButton + updateAddressButton;
                            case 2:
                                return cancelButton + updateAddressButton + shippedButton;
                            default:
                                return '';
                        }
                    }
                }
            ]
        });
        // Add event listener for opening and closing details
        $('#order tbody').on('click', 'td.details-control', function () {
            var tr = $(this).closest('tr');
            var tdi = tr.find("i.fa");
            var row = table.row(tr);

            if (row.child.isShown()) {
                // This row is already open - close it
                row.child.hide();
                tr.removeClass('shown');
                tdi.first().removeClass('fa-minus-square');
                tdi.first().addClass('fa-plus-square');
            }
            else {
                // Open this row
                row.child(format(row.data())).show();
                tr.addClass('shown');
                tdi.first().removeClass('fa-plus-square');
                tdi.first().addClass('fa-minus-square');
            }
        });

        table.on("user-select", function (e, dt, type, cell, originalEvent) {
            if ($(cell.node()).hasClass("details-control")) {
                e.preventDefault();
            }
        });
    });
    function format(d) {
        let items = '';
        for (let i = 0; i < d.item.length; i++) {
            let item =  '<td>' +
                '<td><div class="row">' +
                '<div class="col-md-3">Product '+d.item[i].product.id + '</div>' +
                '<div class="col-md-5">'+d.item[i].product.name + '</div>' +
                '<div class="col-md-2">$ '+d.item[i].product.price + '</div>' +
                '<div class="col-md-2">X '+d.item[i].quantity + '</div>' +
                '</div></td>'+
                '</tr>';
            items += item;
        }
        let detail = '<table class="table table-hover">' + items +
            '</table>';
        return detail;
    };

    //取消订单
    function cancelOrder(orderID,point,memberID) {
        $.ajax({
            type: 'POST',
            url: '${PATH}/admin/order/cancelOrder',
            data: {"orderID":orderID,"point":point,"memberID":memberID},
            dataType: 'json',
            success:function (data) {
                console.log("cancel order " + orderID + " " + data.result);
                if (data.result == true) {
                    window.location.href = "${PATH}/admin/orderManage";
                }
            }
        });
    }
    //确认发货
    function shipped(orderID) {
        $.ajax({
            type: 'POST',
            url: '${PATH}/admin/order/shipped',
            data: {"orderID":orderID},
            dataType: 'json',
            success:function (data) {
                console.log("shipped order " + orderID + " " + data.result);
                if (data.result == true) {
                    window.location.href = "${PATH}/admin/orderManage";
                }
            }
        });
    };
    $('#addressModal').on('show.bs.modal', function (event) {
        let button = $(event.relatedTarget);
        let orderID = button.data('id');
        let name = button.data('name');
        let phone = button.data('phone');
        let address = button.data('address');
        console.log(address);
        $('#inputName').attr("value",name);
        $('#inputPhone').attr("value",phone);
        $('#inputAddress').val(address);
        $('#orderID').val(orderID);
    });
</script>

</body>
</html>


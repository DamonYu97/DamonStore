<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% pageContext.setAttribute("PATH", request.getContextPath());%>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Damon Store management system - product management</title>

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
                <h1 class="page-header">Product management</h1>
            </div>
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <i class="fa fa-gift fa-fw"></i> Manage products
                    </div>
                    <div class="panel-body">
                        <button type="button" style="margin-bottom: 5px;" class="btn btn-info" data-toggle="modal" data-target="#addModal">
                            Add new product
                        </button>
                        <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title" id="addModalLabel">Create a new product</h4>
                                    </div>
                                    <form class="form-horizontal" id="addForm" action="${PATH}/admin/product/" method="post">
                                        <div class="modal-body">
                                            <div class="form-group">
                                                <label for="inputName" class="col-sm-3 control-label">Product name</label>
                                                <div class="col-sm-7">
                                                    <input type="text" class="form-control" name="name" id="inputName" placeholder="Name">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="inputBrandName" class="col-sm-3 control-label">Brand name</label>
                                                <div class="col-sm-7">
                                                    <input type="text" class="form-control" name="brandName" id="inputBrandName" placeholder="Brand">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="inputDescription" class="col-sm-3 control-label">Description</label>
                                                <div class="col-sm-7">
                                                    <textarea class="form-control" maxlength="500" name="description" id="inputDescription" placeholder="write description no more than 500 letters."></textarea>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="inputStock" class="col-sm-3 control-label">Stock</label>
                                                <div class="col-sm-7">
                                                    <input type="number" min="1" class="form-control" name="stock" id="inputStock" placeholder="Stock">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="inputPrice" class="col-sm-3 control-label">Price</label>
                                                <div class="col-sm-7">
                                                    <input type="number"  min="0" step="0.01" class="form-control" name="price" id="inputPrice" placeholder="Price">
                                                </div>
                                            </div>
                                            <div class="form-group hidden">
                                                <label for="inputPoint" class="col-sm-3 control-label">Point</label>
                                                <div class="col-sm-7">
                                                    <input type="number"  min="0" class="form-control" name="point" id="inputPoint" placeholder="Point">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                            <button type="submit" class="btn btn-primary">Add</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <table width="100%" class="table table-striped table-bordered table-hover" id="product">
                            <thead>
                            <tr>
                                <th></th>
                                <th>ID</th>
                                <th>Image</th>
                                <th>Name</th>
                                <th>Type</th>
                                <th>Stock</th>
                                <th>Price</th>
                                <th>Status</th>
                                <th>Operations</th>
                            </tr>
                            </thead>
                        </table>
                        <div class="modal fade" id="originModal" tabindex="-1" role="dialog">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-body">
                                        <img id="originImg" class="img-responsive center-block">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title" id="editModalLabel">Update this product</h4>
                                    </div>
                                    <form class="form-horizontal" id="resetForm" action="${PATH}/admin/product/updateProduct" method="post">
                                        <div class="modal-body">
                                            <input type="hidden" name="id" id="editProductID"/>
                                            <div class="form-group">
                                                <label  class="col-md-3" for="inputEditStock">Stock</label>
                                                <div class="col-md-7">
                                                    <input type="number" min="1" class="form-control" name="stock" id="inputEditStock">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label  class="col-md-3" for="inputEditStock">Price</label>
                                                <div class="col-md-7">
                                                    <input type="number" min="0" step="0.01" class="form-control" name="price" id="inputEditPrice">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <input type="hidden" id="resetUsername" name="username"/>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                            <button type="submit" class="btn btn-primary">Update</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title" id="deleteModalLabel">Warning! Delete this product?</h4>
                                    </div>
                                    <div class="modal-body">
                                        Are you sure you want to delete this product?
                                    </div>
                                    <div class="modal-footer">
                                        <input type="hidden" id="deleteURL"/>
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                        <button type="button" class="btn btn-primary" onclick="urlDelete()">Delete</button>
                                    </div>
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

<!-- Bootstrap Validator JavaScript -->
<script type="text/javascript" src="${PATH}/static/js/bootstrapValidator.js"></script>

<!-- Bootstrap table javascript -->
<script type="text/javascript">
    $(document).ready(function() {
        var table = $('#product').DataTable({
            "order": [[0, "asc"]],
            "processing": true,
            "serverSide": false,
            "ajax": {
                "url": "${PATH}/admin/product/showAllProduct",
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
                {   "data": "product.id" },
                {   "data": "mainImageUrl",
                    "render": function (data, type, row, meta) {
                    var mainUrl = "http://47.106.104.159:8081/images/product/"+data;
                    var img = "<a href=\"#originModal\" role='button' class=\"thumbnail\" data-toggle=\"modal\" data-filename="+data+">\n" +
                        "      <img height='50px' width='50px' src="+mainUrl+" alt="+mainUrl+">\n" +
                        "    </a>"
                    return img;
                    }
                },
                {   "data": "product.name" },
                {   "data": "type.name" },
                {   "data": "product.stock" },
                {   "data": "product.price" },
                {   "data": "product.status",
                    "render": function (data, type, row, meta) {
                        if (data == 1){
                            return "Valid";
                        } else {
                            return "Invalid";
                        }
                    }
                },
                {
                    "data": null,
                    "searchable": false,
                    "render": function (data, type, row, meta) {
                        var productID = row.product.id;
                        const productName = row.product.name;
                        const productStock = row.product.stock;
                        const productPrice = row.product.price;
                        var disable = "";
                        var status = row.product.status;
                        if (status == 0) {
                            disable = "disabled=\"disabled\"";
                        }
                        var editButton = " <button type=\"button\" "+disable+" class=\"btn btn-warning\" \n" +
                            " data-toggle=\"modal\" data-target=\"#editModal\" data-productstock=\"" +productStock + "\" data-productprice=\"" +productPrice +"\" data-productid="+productID+">Edit</button>";
                        var deleteButton = " <button type=\"button\" "+disable+" class=\"btn btn-danger\" \n" +
                            " data-toggle=\"modal\" data-target=\"#deleteModal\" data-productid="+productID+">Delete</button>";
                        return editButton+deleteButton;
                    },
                    width: "115px"
                }
            ]
        });
        // Add event listener for opening and closing details
        $('#product tbody').on('click', 'td.details-control', function () {
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
    function format(d){
        console.log(d.imageUrls);
        // `d` is the original data object for the row
        var imagesRow = '';
        for (var i =0; i < d.imageUrls.length; i++) {
            var filename = d.imageUrls[i].url;
            var thumbnailUrl = "http://47.106.104.159:8081/images/product/" + filename;
            imagesRow = imagesRow + "<div class='col-md-2'><a href=\"#originModal\" role='button' class=\"thumbnail\" data-toggle=\"modal\" data-filename="+filename+">\n" +
                "      <img height='50px' width='50px' src="+thumbnailUrl+" alt="+thumbnailUrl+">\n" +
                "    </a></div>";
        }
        console.log('modify:'+d.product.modifyTime);
        var modifyInfo = '';
        if ( typeof (d.product.modifyTime) != "undefined") {
            modifyInfo =  '<tr>' +
                '<td><span class="text-muted">Modify info:</span></td>' +
                '<td> Modified at <span class="text-info">' + d.product.modifyTime +
                '</span> by admin of ID: <span class="text-info">' + d.product.modifyAdminId + '</span></td>' +
                '</tr>';
        }
        console.log("imageRow "+imagesRow);
        var detail = '<div class="row">' + imagesRow + '</div>' +
            '<table class="table table-hover">' +
            '<tr>' +
            '<td><span class="text-muted">Brand name:</span></td>' +
            '<td>' + d.product.brandName + '</td>' +
            '</tr>' +
            '<tr>' +
            '<td><span class="text-muted">Description:</span></td>' +
            '<td>' + d.product.description + '</td>' +
            '</tr>' +
            '<tr>' +
            '<td><span class="text-muted">Create info:</span></td>' +
            '<td> Created at <span class="text-info">' + d.product.createTime +
            '</span> by admin of ID: <span class="text-info">' + d.product.createAdminId + '</span></td>' +
            '</tr>' + modifyInfo +
            '</table>';
        return detail;
    }
</script>

<script type="text/javascript">
    $('#originModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var imageUrl = "http://47.106.104.159:8081/images/product/"+button.data('filename');
        console.log('image Url: '+imageUrl);
        var modal = $(this);
        $('#originImg').attr("src",imageUrl);
    });
    $('#deleteModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var productID = button.data('productid');
        console.log('delete product id: '+productID);
        var modal = $(this);
        $('#deleteURL').val('${PATH}/admin/product/deleteProduct?id='+productID);
    });
    function urlDelete() {
        var url=$.trim($("#deleteURL").val());
        window.location.href=url;
    };
    $('#editModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        const productID = button.data('productid');
        const productStock = button.data('productstock');
        const productPrice = button.data('productprice');
        console.log('edit product stock: '+productStock);
        console.log('edit product price: '+productPrice);
        $('#inputEditStock').attr("value",productStock);
        $('#inputEditPrice').attr("value",productPrice);
        $('#editProductID').attr("value",productID);
    });
</script>
</body>
</html>
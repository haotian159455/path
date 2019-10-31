<%--
  Created by IntelliJ IDEA.
  User: lht
  Date: 2019/9/16
  Time: 19:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/common/head.jsp"></jsp:include>
    <title>Title</title>
</head>
<body>
<jsp:include page="/common/nav-v3.jsp"></jsp:include>

<div class="container">
    <%--栅格布局的第一行 条件查询--%>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-success">
                <div class="panel-heading">产品查询</div>
                <div class="panel-body">
                    <form class="form-horizontal" id="productForm">
                        <div class="form-group">
                            <label  class="col-sm-1 control-label">产品名</label>
                            <div class="col-sm-5">
                                <input type="text" class="form-control" id="goodsName" placeholder="请输入产品名">
                            </div>
                            <label class="col-sm-1 control-label">价格范围</label>
                            <div class="col-sm-5">
                                <div class="input-group">
                                    <input type="text" name="minPrice" class="form-control" id="minGoodsPrice" placeholder="产品最小价格">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-yen"></i></span>
                                    <input type="text" name="maxPrice" class="form-control" id="maxGoodsPrice" placeholder="产品最大价格">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-1 control-label">生产时间</label>
                            <div class="col-sm-5">
                                <div class="input-group">
                                    <input type="text" name="minDate" class="form-control" id="minGoodsDate" placeholder="产品最早上架时间">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                    <input type="text" name="maxDate" class="form-control" id="maxGoodsDate" placeholder="产品最晚上架时间">
                                </div>
                            </div>

                        </div>

                        <div class="form-group" style="text-align: center">
                            <button class="btn btn-primary btn-lg" onclick="search()" type="button"><i class="glyphicon glyphicon-search">查询</i></button>
                            <button class="btn btn-default btn-lg" type="reset"><i class="glyphicon glyphicon-refresh">重置</i></button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
        <button class="btn btn-success" onclick="addGoods()"><i class="glyphicon glyphicon-plus"></i>新增</button>
        <%--栅格布局第二行  展示的table表格--%>
    <div class="row">
            <div class="col-md-12">
                <div class="panel panel-success">
                    <div class="panel-heading">产品列表</div>
                    <table id="goodsTable" class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th>编号</th>
                            <th>产品名</th>
                            <th>产品价格</th>
                            <th>上架时间</th>
                            <th>操作</th>
                        </tr>
                        </thead>



                        <tfoot>
                        <tr>
                            <th>编号</th>
                            <th>产品名</th>
                            <th>产品价格</th>
                            <th>上架时间</th>
                            <th>操作</th>
                        </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
</div>

<%--新增的form表单--%>
<div id="addGoodsDiv" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">产品名:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入产品名" id="add_goodsName"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">产品价格:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入产品价格" id="add_goodsPrice"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">产品上架日期:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入产品上架日期" id="add_goodsTime"  >
            </div>
        </div>

    </form>
</div>


<jsp:include page="/common/script.jsp"></jsp:include>
</body>
<script type="text/javascript">
    var add_goodsFrom;
    $(function () {
        initTable();
        initDate();
        initSearchDate();
        add_goodsFrom = $("#addGoodsDiv").html();
    })



    /*展示页面*/
    var GoodsTable;
    function initTable(){
        GoodsTable=$("#goodsTable").DataTable({
            "aLengthMenu":[5,10,15],//自定义每页展示条数
            "serverSide": true,//开启服务器分页模式
            "searching": false,//是否允许检索
            "language": {
                url:"/js/DataTables-1.10.18/Chinese.json"
            },
            "ajax":{
                url:"<%=request.getContextPath()%>/goods/list.do",
                type:"post",
            },
            columns: [
                { data: 'id' },
                { data: 'goodsName' },
                { data: 'price' },
                { data: 'createDate' },
                { data: "id",
                    render:function(data,type,row,meta){
                        return "<div class=\"btn-group\" role=\"group\" aria-label=\"...\">\n" +
                            "  <button type=\"button\" onclick=\"deleteGoods('"+data+"')\" class=\"btn btn-danger\"><span class=\"glyphicon glyphicon-trash\"></span>删除</button>\n" +
                            "  <button type=\"button\" onclick=\"findUpdateGoods('"+data+"')\" class=\"btn btn-info\"><span class=\"glyphicon glyphicon-pencil\"></span>修改</button>\n" +
                            "</div>";
                    }}
            ]
        });
    }

    /*新增修改初始化日期*/
    function initDate(){
        $("#add_goodsTime").datetimepicker({
            format: 'YYYY-MM-DD',
            showClear:true,
            locale:"zh-CN",
        });
      /*  $("#update_shopTime").datetimepicker({
            format: 'YYYY-MM-DD',
            showClear:true,
            locale:"zh-CN",
        });*/
    }


    /*条件查询的日期初始化*/
    function initSearchDate(){
        $("#minGoodsDate").datetimepicker({
            format: 'YYYY-MM-DD',
            showClear:true,
            locale:"zh-CN",
        });
        $("#maxGoodsDate").datetimepicker({
            format: 'YYYY-MM-DD',
            showClear:true,
            locale:"zh-CN",
        });
    }
    /*新增的ajax*/
    var v_goodsAdd;
    function addGoods() {
            v_goodsAdd=  bootbox.dialog({
                title:"新增页面",
                message: $("#addGoodsDiv form"),
                size:"large",
                buttons: {
                    confirm: {
                        label: "<span class='glyphicon glyphicon-ok'></span>保存",
                        className: 'btn-danger',
                        callback: function(){
                           //点击确认 发送ajax请求 插入数据
                            var v_goodsName = $("#add_goodsName",v_goodsAdd).val();
                            var v_goodsPrice = $("#add_goodsPrice",v_goodsAdd).val();
                            var v_goodsDate = $("#add_goodsTime",v_goodsAdd).val();
                            $.ajax({
                                url:"/goods/add.do",
                                type:"post",
                                data:{
                                    "goodsName":v_goodsName,
                                    "price":v_goodsPrice,
                                    "createDate":v_goodsDate
                                },
                                success:function (result) {
                                    if(result.code == 200){
                                        alert("成功！");
                                        search();
                                    }
                                }
                                
                            })
                        }
                    },
                    cancel: {
                        label: "<span class='glyphicon glyphicon-remove'></span>关闭",
                        className: 'btn-warning',

                    },
                },
            })
            $("#addGoodsDiv").html(add_goodsFrom);
            initDate();
    }

    /*删除的ajax*/
    function deleteGoods(id) {
        bootbox.confirm({
            message: "你确认要删除么?",
            buttons: {
                confirm: {
                    label: '<span class="glyphicon glyphicon-ok"></span>确认',
                    className: 'btn-success'
                },
                cancel: {
                    label: '<span class="glyphicon glyphicon-remove"></span>关闭',
                    className: 'btn-danger'
                }
            },
            callback: function (result) {
                if (result){
                    $.post({
                        url:"/goods/deleteGoods.do",
                        data:{
                            "id":id,
                        },
                        success:function (result) {
                            if (result.code==200){
                                //刷新页面
                                search();
                            }
                        }
                    })
                }
            }
        });
    }

    function search() {
        var v_goodsName = $("#goodsName").val();
        var v_minGoodsPrice = $("#minGoodsPrice").val();
        var v_maxGoodsPrice = $("#maxGoodsPrice").val();
        var v_minGoodsDate = $("#minGoodsDate").val();
        var v_maxGoodsDate = $("#maxGoodsDate").val();
        var param = {};
        param.goodsName = v_goodsName;
        param.minGoodsPrice = v_minGoodsPrice;
        param.maxGoodsPrice = v_maxGoodsPrice;
        param.minGoodsDate = v_minGoodsDate;
        param.maxGoodsDate = v_maxGoodsDate;
        GoodsTable.settings()[0].ajax.data=param;
        GoodsTable.ajax.reload();
    }
    
</script>
</html>

<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/24/024
  Time: 17:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>品牌页面</title>
    <jsp:include page="/common/head.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/common/nav-v3.jsp"></jsp:include>
<%--所有按钮--%>
<div class="container">
    <button onclick="addBrand()" type="button" class="btn btn-primary btn-lg"><i class="glyphicon glyphicon-plus">新增</i></button>
</div>

<%--栅格布局  展示的table表格--%>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-success">
                <div class="panel-heading">品牌列表</div>
                <table id="brandTable" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                    <tr>
                        <th>id</th>
                        <th>品牌名</th>
                        <th>热销</th>
                        <th>序列</th>
                        <th>品牌图片</th>
                        <th>操作</th>

                    </tr>
                    </thead>
                    <tfoot>
                    <tr>
                        <th>id</th>
                        <th>品牌名</th>
                        <th>热销</th>
                        <th>序列</th>
                        <th>品牌图片</th>
                        <th>操作</th>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>
<%--新增的form表单--%>
<div id="addBrandDiv" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">品牌名:</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" placeholder="请输入品牌名" id="add_brandName"  >
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">是否热销:</label>
            <div class="col-sm-6">
                <input type="radio" value="1" name="add_status" checked>是
                <input type="radio" value="0" name="add_status">否
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">序列号:</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" placeholder="请输入序列号名" id="add_sortId"  >
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">图片:</label>
            <div style="height: 45%">
                <div class="col-sm-8">
                    <input type="file" name="files" id="add_brandImg" ><br/>
                    <input type="hidden"  id="fileInput" >
                </div>
            </div>
        </div>
    </form>
</div>
<%--修改的form表单--%>
<div id="updateBrandDiv" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">品牌名:</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" placeholder="请输入品牌名" id="update_brandName"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">是否热销:</label>
            <div class="col-sm-6">
                <input type="radio" value="1" name="update_status" checked>是
                <input type="radio" value="0" name="update_status">否
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">序列号:</label>
            <div class="col-sm-6">
                <input type="text" class="form-control"  id="update_sortId"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">图片:</label>
            <div style="height: 30%">
                <div class="col-sm-10">
                    <input type="file" name="files" id="updateImg" >
                    <input type="hidden"  id="updateFileInput" name="updateFileInput">
                </div>
            </div>
        </div>
    </form>
</div>

<jsp:include page="/common/script.jsp"></jsp:include>
</body>
<script>
    var v_brandAddFrom;
    var v_brandUpdateFrom;
    /*页面加载事件*/
    $(function () {
        initTable();
        backup();
        initFileInput();
    })

    /*备份*/
    function backup(){
        v_brandAddFrom =  $("#addBrandDiv").html();
        v_brandUpdateFrom = $("#updateBrandDiv").html();
    }
    
    function seach() {
        brandTable.ajax.reload();
    }
    
    var brandTable;
    /*展示页面*/
    function initTable(){
        brandTable=  $("#brandTable").DataTable( {
            "aLengthMenu":[10],//自定义每页展示条数
            "serverSide": true,//开启服务器分页模式
            "searching": false,//是否允许检索
            "language": {
                url:"/js/DataTables-1.10.18/Chinese.json",
            },
            "ajax":{
                url:"<%=request.getContextPath()%>/brand/findPageBrandList.do",
                type:"post",
            },
            columns: [
                { data: 'id' },
                { data: 'brandName' },
                { data: 'status',
                    "render": function (data) {
                        return data==1?"热销":"不热销";
                    },
                },
                { data:"sortId",render:function (data,type,row) {
                        var str = '<input type="text" class="form-control" id="sort_'+row.id+'" value="'+data+'">&nbsp;';
                        str += '<button  type="button" class="btn btn-default btn-sm"  onclick="sort('+row.id+')">修改 <span class="glyphicon glyphicon-refresh"></span></button >';
                        return str;
                    }},
                { data: 'brandImg',
                    render:function (data,type,row,meta) {
                        return "<img alt='图片' src='https://1231521.oss-cn-beijing.aliyuncs.com/"+data+"' width='60px'/>"
                    }
                },
                { data: "id",
                    render:function(data,type,row,meta){
                        var a= row.status==0?"btn btn-success":"btn btn-default";
                        var b= row.status==0?"热销":"不热销";
                        return "<div class=\"btn-group\" role=\"group\" aria-label=\"...\">\n" +
                            "  <button type=\"button\" onclick=\"deleteBrand('"+data+"')\" class=\"btn btn-danger\"><span class=\"glyphicon glyphicon-trash\"></span>删除</button>\n" +
                            "  <button type=\"button\" onclick=\"updateBrand('"+data+"')\" class=\"btn btn-info\"><span class=\"glyphicon glyphicon-pencil\"></span>修改</button>\n" +
                            "  <button type=\"button\" onclick=\"statusUp('"+data+"')\" class=\""+a+"\">"+b+"</button>\n" +
                            "</div>";

                    }}
            ]
        } );}

    /*新增的ajax*/
    var v_brandAdd;
    function addBrand(){
        v_brandAdd=  bootbox.dialog({
            title:"新增页面",
            message: $("#addBrandDiv form"),
            size:"large",
            buttons: {
                confirm: {
                    label: "<span class='glyphicon glyphicon-ok'></span>保存",
                    className: 'btn-danger',
                    callback: function(){
                        //点击确定按钮 发送ajax请求，插入数据
                        var v_brandName = $("#add_brandName",v_brandAdd).val();
                        var v_status = $("input[name='add_status']:checked",v_brandAdd).val();
                        var v_sortId = $("#add_sortId",v_brandAdd).val();
                        var v_add_brandImg = $("#fileInput",v_brandAdd).val();
                        var v_jsonBrand = {};
                        v_jsonBrand.brandName = v_brandName;
                        v_jsonBrand.brandImg = v_add_brandImg;
                        v_jsonBrand.status = v_status;
                        v_jsonBrand.sortId = v_sortId;
                        $.ajax({
                            url:"/brand/addBrand.do",
                            type:"post",
                            data:v_jsonBrand,
                            success:function (result) {
                                if (result.code==200){
                                    alert("添加成功")
                                    //刷新页面
                                    seach();
                                }else {
                                    bootbox.alert({
                                        size: "small",
                                        title: "提示信息",
                                        message: "添加失败",
                                    })
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
        $("#addBrandDiv").html( v_brandAddFrom);
        initFileInput();

    }

    function sort(id) {
        bootbox.confirm({
            message: "你确认要更改序列号嘛？",
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
                var sortId = $("#sort_"+id).val();
                $.post({
                    url:"/brand/sortBrand.do",
                    data:{
                        "id":id,
                        "sortId":sortId
                    },
                    success:function (result) {
                        if (result.code==200){
                            alert("操作成功")
                            seach();
                        }
                    }
                })
            }
        });
    }

    function statusUp(id) {
        bootbox.confirm({
            message: "你确认要更改热销状态嘛？",
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
                $.post({
                    url:"/brand/status.do",
                    type:"post",
                    data:{"id":id},
                    success:function (result) {
                        if (result.code==200){
                            alert("操作成功")
                            seach();
                        }
                    }
                })
            }
        });
    }



    function initFileInput() {
        $("#add_brandImg").fileinput({
            language: 'zh', //设置语言
            uploadUrl:"<%=request.getContextPath()%>/file/update.do", //上传的地址
            allowedFileExtensions : ["jpg","bmp","png","gif","docx","zip","xlsx","txt","jpeg"],/*上传文件格式限制*/
            showUpload:false, //是否显示上传按钮
            showRemove:false, //显示移除按钮
            validateInitialCount:true,
        }).on("fileuploaded", function (event, data, previewId, index){
            var url = data.response.data;
            $("#fileInput",v_brandAdd).val(url);
        });
    }

    /*修改上传图片*/
    function updateFileInput(){
        var ss = $("#updateFileInput").val();
        var file = "https://1231521.oss-cn-beijing.aliyuncs.com/"+ss;
        var markArr = [];
        if(ss != null && ss!=""){
            markArr.push(file);
        }
        $("#updateImg").fileinput({
            uploadUrl:"/file/update.do",//图片上传路径
            language:'zh',//插件语言
            showUpload:false, //是否显示上传按钮
            showRemove:false, //显示移除按钮
            initialPreviewAsData: true,//图片回显开启
            initialPreview:markArr,//图片 预览开启路径放进来
        }).on("fileuploaded",function(event, data, previewId, index){
            var url = data.response.data;
            $("#updateFileInput",v_brandUpdate).val(url);
        })
    }



    /*删除的ajax*/
    function deleteBrand(id) {
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
                        url:"/brand/deleteBrand.do",
                        data:{
                            "id":id,
                        },
                        success:function (result) {
                            if (result.code==200){
                                //刷新页面
                                seach();
                            }else {
                                bootbox.alert({
                                    size: "small",
                                    title: "提示信息",
                                    message: "<span class=''></span>删除失败",

                                })
                            }
                        }
                    })
                }
            }
        });
    }
    /*修改*/
    var v_brandUpdate;
    function updateBrand(id) {
        $.post({
            url:"/brand/findUpdateBrand.do",
            data:{
                "id":id
            },
            success:function(result){
                if(result.code==200){
                    //赋值
                    var v_brandName = result.data.brandName;
                    var v_brandImg = result.data.brandImg;
                    var v_sortId = result.data.sortId;

                    $("#update_brandName").val(v_brandName);
                    if(result.data.status==1){
                        $("input[name='update_status'][value='1']").attr("checked",true);
                    }else {
                        $("input[name='update_status'][value='0']").attr("checked",true);
                    }
                    $("#updateFileInput").val(v_brandImg);
                    $("#updateImg").attr("src",v_brandImg);
                    $("#update_sortId").val(v_sortId);
                    v_brandUpdate =  bootbox.dialog({
                        title:"修改页面",
                        message: $("#updateBrandDiv form"),
                        size:"large",
                        buttons: {
                            confirm: {
                                label: "<span class='glyphicon glyphicon-ok'></span>保存",
                                className: 'btn-danger',
                                callback: function(){
                                    //获取文本框的值
                                    var v_brandName = $("#update_brandName",v_brandUpdate).val();
                                    var v_status = $("input[name='update_status']:checked",v_brandUpdate).val();
                                    var v_brandImg = $("#updateFileInput",v_brandUpdate).val();
                                    var v_sortId = $("#update_sortId",v_brandUpdate).val();
                                    //json对象传值用
                                    var v_jsonUpdateShop= {};
                                    v_jsonUpdateShop.id=id;
                                    v_jsonUpdateShop.brandName = v_brandName;
                                    v_jsonUpdateShop.status = v_status;
                                    v_jsonUpdateShop.brandImg = v_brandImg;
                                    v_jsonUpdateShop.sortId = v_sortId;
                                    $.post({
                                        url:"/brand/updateBrand.do",
                                        data:v_jsonUpdateShop,
                                        success:function (result) {
                                            if (result.code==200){
                                                alert("修改成功")
                                                seach();
                                            }
                                            else{
                                                bootbox.alert({
                                                    size: "small",
                                                    title: "提示信息",
                                                    message: "修改失败",
                                                })
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
                    updateFileInput();
                    $("#updateBrandDiv").html(v_brandUpdateFrom);
                }
            }
        })
    }
</script>
</html>

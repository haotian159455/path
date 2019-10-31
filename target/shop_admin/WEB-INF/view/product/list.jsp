<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/23/023
  Time: 16:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商品管理</title>
    <jsp:include page="/common/head.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/common/nav-v3.jsp"></jsp:include>
<%--整个JSP页面的栅格布局--%>
<div class="container">
    <%--栅格布局的第一行 模糊查询--%>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-success">
                <div class="panel-heading">商品查询</div>
                <div class="panel-body">
                    <form class="form-horizontal" id="productForm">
                        <div class="form-group">
                            <label  class="col-sm-1 control-label">商品名</label>
                            <div class="col-sm-5">
                                <input type="text" name="shopName" class="form-control" id="shopName" placeholder="请输入商品名">
                            </div>
                            <label class="col-sm-1 control-label">价格范围</label>
                            <div class="col-sm-5">
                                <div class="input-group">
                                    <input type="text" name="minPrice" class="form-control" id="minPrice" placeholder="最小价格">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-yen"></i></span>
                                    <input type="text" name="maxPrice" class="form-control" id="maxPrice" placeholder="最大价格">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-1 control-label">生产时间</label>
                            <div class="col-sm-5">
                                <div class="input-group">
                                    <input type="text" name="minDate" class="form-control" id="minDate" placeholder="最早时间">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                    <input type="text" name="maxDate" class="form-control" id="maxDate" placeholder="最晚时间">
                                </div>
                            </div>

                        </div>

                        <div class="form-group">
                            <div class="col-sm-12">
                                <div class="form-group" id="classSelectDiv">
                                    <label class="control-label col-sm-1">类型</label>
                                    <input type="hidden" name="cl1">
                                    <input type="hidden" name="cl2">
                                    <input type="hidden" name="cl3">
                                </div>
                            </div>
                        </div>




                        <div class="form-group" style="text-align: center">
                            <button type="button" class="btn btn-primary" onclick="searchShop();"><span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>
                            <button class="btn btn-default" type="reset"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span>重置</button>

                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <%--所有按钮--%>
    <div style="background: #2aabd2">
        <button type="button" class="btn btn-primary" onclick="addShop();"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增</button>
        <button type="button" class="btn btn-success" onclick="exportExcel();"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>导出Excel</button>
        <button type="button" class="btn btn-success" onclick="exportPdf();"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>导出Pdf</button>
        <button type="button" class="btn btn-success" onclick="exportWord();"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>导出Word</button>
    </div>
    <%--栅格布局第二行  展示的table表格--%>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-success">
                <div class="panel-heading">商品列表</div>
                <table id="shopTable" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                    <tr>
                        <th>id</th>
                        <th>商品名</th>
                        <th>价格</th>
                        <th>库存</th>
                        <th>上架</th>
                        <th>热销</th>
                        <th>图片</th>
                        <th>品牌</th>
                        <th>类型</th>
                        <th>生产日期</th>
                        <th>操作</th>

                    </tr>
                    </thead>
                    <tfoot>
                    <tr>
                        <th>id</th>
                        <th>商品名</th>
                        <th>价格</th>
                        <th>库存</th>
                        <th>上架</th>
                        <th>热销</th>
                        <th>图片</th>
                        <th>品牌</th>
                        <th>类型</th>
                        <th>生产日期</th>
                        <th>操作</th>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>
<%--新增的form表单--%>
<div id="addShopDiv" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">商品名:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入商品名" id="add_shopName"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">商品价格:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入商品价格" id="add_price"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">是否热销:</label>
            <div class="col-sm-10">
                <input type="radio" value="1" name="add_radio" checked>是
                <input type="radio" value="0" name="add_radio">否
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-12">
                <div class="form-group" id="add_class">
                    <label class="control-label col-sm-2">类型</label>
                </div>
            </div>
        </div>




        <div class="form-group">
            <label class="col-sm-2 control-label">库存:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入库存量" id="add_stock"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">图片:</label>
            <div class="col-sm-10">
                <input type="file" name="files" id="add_shopImg" >
                <input type="hidden"  id="fileInput" >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">生产日期:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入生产日期" id="add_shopTime"  >
            </div>
        </div>

    </form>
</div>
<%--修改的form表单--%>
<div id="updateShopDiv" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">商品名:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入商品名" id="update_shopName"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">商品价格:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入商品价格" id="update_price"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">是否热销:</label>
            <div class="col-sm-10">
                <input type="radio" value="1" name="update_radio" checked>是
                <input type="radio" value="0" name="update_radio">否
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-12">
                <div class="form-group" id="update_class">
                    <label class="control-label col-sm-2">类型:</label>
                </div>
            </div>
        </div>


        <div class="form-group">
            <label class="col-sm-2 control-label">库存:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入库存量" id="update_stock"  >
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">图片:</label>
            <div class="col-sm-10">
                <input type="file" name="files" id="update_shopImg"><br/>
                <input type="hidden"  id="updateFileInput" >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">生产日期:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入生产日期" id="update_shopTime"  >
            </div>
        </div>

    </form>
</div>

<jsp:include page="/common/script.jsp"></jsp:include>
<script>
    var  v_shopAddFrom;
    var v_shopUpdateFrom;
    $(function () {
        initTable();
        initDate();
        backup();
        initSearchDate();
        initFileInput("add_shopImg","fileInput");
        initClass("classSelectDiv",0);
    })
    /*备份*/
    function backup(){
        v_shopAddFrom =  $("#addShopDiv").html();
        v_shopUpdateFrom = $("#updateShopDiv").html();
    }
    /*  拼接三级联动  */
    function initClass(elementName,id,obj) {
        if(obj){
            $(obj).parent().nextAll().remove();
        }
        $.ajax({
            url:"/class/queryClass.do",
            type:"post",
            data:{
                "id":id
            },
            success:function (data) {
                if(data.code == 200){
                    if(!data.data.length){
                        return false;
                    }
                    var v_select = '<div class="col-sm-2"><select class="form-control" name="classSelect" onchange="initClass(\''+elementName+'\',this.value,this)"><option value="-1">==请选择==</option> ';
                    var v_classArr = data.data;
                    for (var i=0;i<v_classArr.length;i++){
                        v_select += "<option value='"+v_classArr[i].id+"' data-categoryname = '"+v_classArr[i].name+"'>"+v_classArr[i].name+"</option>";
                    }
                    v_select += '</select></div>';
                    if (elementName == "classSelectDiv"){
                        $("#"+elementName).append(v_select);
                    }else if(elementName == "add_class"){
                        $("#"+elementName,v_shopAdd).append(v_select);
                    }
                    if(elementName == "update_class"){
                        $("#"+elementName,v_shopUpdate).append(v_select);
                    }
                }
            }
        })
    }
    
    function exportExcel() {
        var cl1 = $($("select[name='classSelect']",$("#productForm"))[0]).val();
        var cl2 = $($("select[name='classSelect']",$("#productForm"))[1]).val();
        var cl3 = $($("select[name='classSelect']",$("#productForm"))[2]).val();
        $("input[name='cl1']").val(cl1);
        $("input[name='cl2']").val(cl2);
        $("input[name='cl3']").val(cl3);
        // 获取form表单
        var v_productForm = document.getElementById("productForm");
        // 动态设置action属性
        v_productForm.action = "/pro/exportExcel.do";
        v_productForm.method = "post";
        // setGCInfo();
        v_productForm.submit();
    }


    /*新增修改初始化日期*/
    function initDate(){
        $("#add_shopTime").datetimepicker({
            format: 'YYYY-MM-DD HH:mm:ss',
            showClear:true,
            locale:"zh-CN",
        });
        $("#update_shopTime").datetimepicker({
            format: 'YYYY-MM-DD HH:mm:ss',
            showClear:true,
            locale:"zh-CN",
        });
    }
    /*条件查询的日期初始化*/
    function initSearchDate(){
        $("#minDate").datetimepicker({
            format: 'YYYY-MM-DD HH:mm:ss',
            showClear:true,
            locale:"zh-CN",
        });
        $("#maxDate").datetimepicker({
            format: 'YYYY-MM-DD HH:mm:ss',
            showClear:true,
            locale:"zh-CN",
        });
    }
    //上下架
    function isUpShop(id) {
        bootbox.confirm({
            title:"上下架",
            message: "你确认要上架或下架么?",
            buttons: {
                confirm: {
                    label: '<span class="glyphicon glyphicon-ok"></span>确认',
                    className: 'btn-success',
                },
                cancel: {
                    label: "<span class='glyphicon glyphicon-remove'></span>关闭",
                    className: 'btn-warning',
                },
            },
            callback: function (result) {
                if (result) {
                    $.post({
                        url:"/pro/isUpShop.do",
                        type:"post",
                        data:{
                            "id":id
                        },
                        success:function (result) {
                            if (result.code==200){
                                alert("操作成功")
                                searchShop();
                            }
                        }
                    })
                }
            }
        });
    }


    /*展示页面*/
    var shopTable1;
    function initTable(){
        shopTable1=$("#shopTable").DataTable( {
            "aLengthMenu":[5,10],//自定义每页展示条数
            "serverSide": true,//开启服务器分页模式
            "searching": false,//是否允许检索
            "language": {
                url:"/js/DataTables-1.10.18/Chinese.json"
            },
            "ajax":{
                url:"<%=request.getContextPath()%>/pro/findPageShopList.do",
                type:"post",
            },
            columns: [
                { data: 'id' },
                { data: 'shopName' },
                { data: 'price' },
                { data: 'stock' },
                { data: 'isUp',
                    "render": function (data, type, row, meta) {
                        return data==1?"上架":"下架";
                    },
                },
                { data: 'isSaleWell',
                    "render": function (data, type, row, meta) {
                        return data==1?"热销":"不热销";
                    },
                },

                { data: 'shopImg',
                    render : function (data,type,row,meta) {
                        return "<img alt='图片' src="+data+" width='60px'/>";
                    }
                },
                {data:'brandIds'},
                {data:'clName'},
                { data: 'shopTime' },
                { data: "id",
                    render:function(data,type,row,meta){
                        var a= row.isUp==0?"btn btn-success":"btn btn-default";
                        var b= row.isUp==0?"上架":"下架";
                        return "<div class=\"btn-group\" role=\"group\" aria-label=\"...\">\n" +
                            "  <button type=\"button\" onclick=\"deleteShop('"+data+"')\" class=\"btn btn-danger\"><span class=\"glyphicon glyphicon-trash\"></span>删除</button>\n" +
                            "  <button type=\"button\" onclick=\"findUpdateShop('"+data+"')\" class=\"btn btn-info\"><span class=\"glyphicon glyphicon-pencil\"></span>修改</button>\n" +
                             "  <button type=\"button\" onclick=\"isUpShop('"+data+"')\" class=\""+a+"\"><span class=\"glyphicon glyphicon-heart-empty\"></span>"+b+"</button>\n" +
                            "</div>";
                    }}
            ]
        } );}

    /*新增的ajax*/
    var v_shopAdd;
    function addShop(){
        initClass("add_class",0);
        v_shopAdd=  bootbox.dialog({
            title:"新增页面",
            message: $("#addShopDiv form"),
            size:"large",
            buttons: {
                confirm: {
                    label: "<span class='glyphicon glyphicon-ok'></span>保存",
                    className: 'btn-danger',
                    callback: function(){
                        //点击确定按钮 发送ajax请求，插入数据
                        var v_shopName = $("#add_shopName",v_shopAdd).val();
                        var v_price = $("#add_price",v_shopAdd).val();
                        var v_shopImg = $("#fileInput",v_shopAdd).val();
                        var v_shopTime = $("#add_shopTime",v_shopAdd).val();
                        var v_isSaleWell = $("input[name='add_radio']:checked",v_shopAdd).val();
                        var v_stock = $("#add_stock",v_shopAdd).val();
                        var cl1 = $($("select[name='classSelect']",v_shopAdd)[0]).val();
                        var cl2 = $($("select[name='classSelect']",v_shopAdd)[1]).val();
                        var cl3 = $($("select[name='classSelect']",v_shopAdd)[2]).val();


                        var v_jsonShop = {};

                        v_jsonShop.shopName = v_shopName;
                        v_jsonShop.price = v_price;
                        v_jsonShop.shopTime = v_shopTime;
                        v_jsonShop.shopImg = v_shopImg;
                        v_jsonShop.isSaleWell = v_isSaleWell;
                        v_jsonShop.stock = v_stock;
                        v_jsonShop.cl1 = cl1;
                        v_jsonShop.cl2 = cl2;
                        v_jsonShop.cl3 = cl3;

                        console.log(v_jsonShop);

                        $.ajax({
                            url:"/pro/addShop.do",
                            type:"post",
                            data:v_jsonShop,
                            success:function (result) {
                                if (result.code==200){
                                    alert("添加成功")
                                    //刷新页面
                                    searchShop()
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
        $("#addShopDiv").html(v_shopAddFrom);
        initDate();
        initFileInput("add_shopImg","fileInput");
    }

    /*删除的ajax*/
    function deleteShop(id) {
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
                        url:"/pro/deleteShop.do",
                        data:{
                            "id":id,
                        },
                        success:function (result) {
                            if (result.code==200){
                              //刷新页面
                                searchShop();
                            }
                        }
                    })
                }
            }
        });
    }

    /*修改*/
    var v_clName;
    var v_shopUpdate;
    function findUpdateShop(id) {
        //initClass("update_class",0);
        $.post({
            url:"/pro/findUpdateShop.do",
            data:{
                "id":id
            },
            success:function(result){
                if(result.code==200){
                    //赋值
                    var v_shopName = result.data.shopName;
                    var v_price = result.data.price;
                    var v_shopTime = result.data.shopTime;
                    var v_shopImg = result.data.shopImg;
                    var v_stock = result.data.stock;
                    if(result.data.isSaleWell==1){
                        $("input[name='update_radio'][value='1']").attr("checked",true);
                    }else {
                        $("input[name='update_radio'][value='0']").attr("checked",true);
                    }
                    v_clName = result.data.clName;
                    $("#update_shopName").val(v_shopName);
                    $("#update_class").html(" <label class=\"control-label col-sm-2\">类型:</label><div class='col-sm-10'>"+result.data.clName+"&nbsp;&nbsp;&nbsp;<button type=\"button\" class=\"btn btn-primary\" onclick=\"edit(this);\"><span class=\"glyphicon glyphicon-pencil\" aria-hidden=\"true\"></span>编辑</button></div>");
                    $("#update_price").val(v_price);
                    $("#update_shopTime").val(v_shopTime);
                    $("#updateFileInput").val(v_shopImg);
                    $("#update_stock").val(v_stock);
                    initFileInput("update_shopImg","updateFileInput");
                   v_shopUpdate =  bootbox.dialog({
                        title:"修改页面",
                        message: $("#updateShopDiv form"),
                        size:"large",
                        buttons: {
                            confirm: {
                                label: "<span class='glyphicon glyphicon-ok'></span>保存",
                                className: 'btn-danger',
                                callback: function(){
                                    //获取文本框的值
                                    var v_updateShopName = $("#update_shopName",v_shopUpdate).val();
                                    var v_updatePrice = $("#update_price",v_shopUpdate).val();
                                    var v_updateShopTime = $("#update_shopTime",v_shopUpdate).val();
                                    var v_updateShopImg = $("#updateFileInput",v_shopUpdate).val();
                                    var v_isSaleWell = $("input[name='update_radio']:checked",v_shopAdd).val();
                                    var v_stock= $("#update_stock",v_shopUpdate).val();
                                    var updateClass = $("select[name='classSelect']",v_shopUpdate);
                                    var cl1;
                                    var cl2;
                                    var cl3;
                                    if(updateClass.length===3){
                                        cl1 = $($("select[name='classSelect']",v_shopUpdate)[0]).val();
                                        cl2 = $($("select[name='classSelect']",v_shopUpdate)[1]).val();
                                        cl3 = $($("select[name='classSelect']",v_shopUpdate)[2]).val();
                                    }
                                    //json对象传值用
                                    var v_jsonUpdateShop= {};
                                    v_jsonUpdateShop.id=id;
                                    v_jsonUpdateShop.shopName=v_updateShopName;
                                    v_jsonUpdateShop.price = v_updatePrice;
                                    v_jsonUpdateShop.shopTime = v_updateShopTime;
                                    v_jsonUpdateShop.shopImg = v_updateShopImg;
                                    v_jsonUpdateShop.isSaleWell = v_isSaleWell;
                                    v_jsonUpdateShop.stock = v_stock;
                                    v_jsonUpdateShop.cl1 = cl1;
                                    v_jsonUpdateShop.cl2 = cl2;
                                    v_jsonUpdateShop.cl3 = cl3;
                                    $.post({
                                        url:"/pro/updateShop.do",
                                        data:v_jsonUpdateShop,
                                        success:function (result) {
                                            if (result.code==200){
                                                alert("修改成功")
                                                searchShop();
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
                    $("#updateShopDiv").html(v_shopUpdateFrom);
                    initDate();

                }
            }
        })
    }

    /*  编辑按钮触发事件  */
    function edit(obj){
        // 把当前元素 转换为 jquery  然后根据这个元素 获取父级元素
        $(obj).parent().remove();
        // 调用 三级联动事件
        initClass("update_class",0);
        // 拼接 一个 button按钮  内容和作用 为 取消编辑
        var str = '<button type="button" class="btn btn-primary" onclick="onexit();"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>取消编辑</button>'
        // 追加给 指定 div  又因为  我们使用了 弹出框 所有需要指定作用域
        $("#update_class",v_shopUpdate).append(str)
    }
    /*  取消编辑触发事件 */
    function onexit(){
        var str = '<label class="control-label col-sm-2">类型:</label><div class="col-sm-10">"'+v_clName+'"&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-primary" onclick="edit(this);"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑</button></div>';
        $("#update_class",v_shopUpdate).html(str)
    }



    /*fileinput图片的上传*/
    function initFileInput(prefix,aftrUrl) {
        /*修改回显*/
        if (aftrUrl=="updateFileInput"){
            var url=$("#"+aftrUrl).val();
            var urlArr=[];
            urlArr.push(url);
            console.log(urlArr)
        }
        $("#"+prefix).fileinput({
            language: 'zh', //设置语言
            uploadUrl:"/brand/addFileInput.do", //上传的地址
            allowedFileExtensions : ["jpg","bmp","png","gif","docx","zip","xlsx","txt"],/*上传文件格式限制*/
            uploadAsync: true, //默认异步上传
            showUpload:true, //是否显示上传按钮
            showRemove :true, //显示移除按钮
            showPreview :true, //是否显示预览
            showCaption:false,//是否显示标题
            browseClass:"btn btn-primary", //按钮样式
            dropZoneEnabled: false,//是否显示拖拽区域
            maxFileSize:0,//单位为kb，如果为0表示不限制文件大小
            minFileCount: 0,
            maxFileCount:10, //表示允许同时上传的最大文件个数
            validateInitialCount:true,
            previewFileIcon: "<iclass='glyphicon glyphicon-king'></i>",
            msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
            initialPreview:urlArr,
            initialPreviewAsData:true,
            // 默认预览的详细配置，回显时会用到
        }).on("fileuploaded", function (event, data, previewId, index){
            if (prefix=="update_shopImg"){
                $("#"+aftrUrl,v_shopUpdate).val(data.response.url);
            }else{
                $("#"+aftrUrl,v_shopAdd).val(data.response.url);

            }
        });
    }

    /*条件查询*/
    function searchShop(){
        var v_shopName = $("#shopName").val();
        var v_minPrice = $("#minPrice").val();
        var v_maxPrice = $("#maxPrice").val();
        var v_minDate = $("#minDate").val();
        var v_maxDate = $("#maxDate").val();
        var cl1 = $($("select[name='classSelect']",$("#productForm"))[0]).val();
        var cl2 = $($("select[name='classSelect']",$("#productForm"))[1]).val();
        var cl3 = $($("select[name='classSelect']",$("#productForm"))[2]).val();
        var searchJson= {};
        searchJson.shopName=v_shopName;
        searchJson.minPrice = v_minPrice;
        searchJson.maxPrice = v_maxPrice;
        searchJson.minDate = v_minDate;
        searchJson.maxDate = v_maxDate;
        searchJson.cl1 = cl1;
        searchJson.cl2 = cl2;
        searchJson.cl3 = cl3;
        shopTable1.settings()[0].ajax.data=searchJson;
        shopTable1.ajax.reload();
    }
</script>
</body>
</html>

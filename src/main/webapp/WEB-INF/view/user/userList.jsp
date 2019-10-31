<%--
  Created by IntelliJ IDEA.
  User: 86131
  Date: 2019/8/14
  Time: 20:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <jsp:include page="/common/head.jsp"></jsp:include>
<title>用户管理</title>
</head>
<body>
<jsp:include page="/common/nav-v3.jsp"></jsp:include>
<!-- 条件查询 -->
<div class="container">
    <div class="row">
        <div class="panel panel-primary">
            <div class="panel-heading">条件查询</div>
            <div class="panel-body">
                <form class="form-horizontal" id="areaSeach">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-4">
                            <input type="email" class="form-control" id="sel_userName" placeholder="请输入用户名...">
                        </div>
                        <label  class="col-sm-2 control-label">真实姓名</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="sel_realName"  placeholder="请输入真实姓名...">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">年龄范围</label>
                        <div class="col-sm-4">
                            <div class="input-group">
                                <input type="text" class="form-control" id="sel_minAge" placeholder="最小年龄..." >
                                <span class="input-group-addon" ><i class="glyphicon glyphicon-arrow-right"></i></span>
                                <input type="text" class="form-control" id="sel_maxAge" placeholder="最大年龄..." aria-describedby="basic-addon2">
                            </div>
                        </div>
                        <label  class="col-sm-2 control-label">薪资范围</label>
                        <div class="col-sm-4">
                            <div class="input-group">
                                <input type="text" class="form-control" id="sel_minSalary" placeholder="最低工资..." >
                                <span class="input-group-addon" ><i class="glyphicon glyphicon-yen"></i></span>
                                <input type="text" class="form-control" id="sel_maxSalary" placeholder="最高工资..." aria-describedby="basic-addon2">
                            </div>
                        </div>

                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">入职时间</label>
                        <div class="col-sm-4">
                            <div class="input-group">
                                <input type="text" class="form-control" id="sel_minComeTime" placeholder="最早入职时间..." >
                                <span class="input-group-addon" ><i class="glyphicon glyphicon-calendar"></i></span>
                                <input type="text" class="form-control" id="sel_maxComeTime" placeholder="最晚入职时间..." aria-describedby="basic-addon2">
                            </div>
                        </div>
                        <label  class="col-sm-2 control-label">角色名称</label>
                        <div class="col-sm-4" >
                            <div class="input-group"id="selectid">

                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                            <div class="col-sm-12">
                                <div class="form-group" id="selectArea">
                                    <label class="control-label col-sm-2">地区：</label>
                                </div>
                            </div>
                    </div>

                    <div style="text-align: center">
                        <button type="button" class="btn btn-primary" onclick="initData()"><i class="glyphicon glyphicon-search"></i>查询</button>
                        <button type="reset" class="btn btn-default"><i class="glyphicon glyphicon-refresh"></i>重置</button>
                    </div>
                </form>

            </div>
        </div>
    </div>
    <div class="row">
<div style="background: #5bc0de">
    <button class="btn btn-success" onclick="addUser()"><i class="glyphicon glyphicon-plus"></i>新增</button>
    <button class="btn btn-danger" onclick="batchDelete()"><i class="glyphicon glyphicon-plus"></i>批量删除</button>
    <button type="button" class="btn btn-success" onclick="exportExcel();"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>导出Excel</button>
    <button type="button" class="btn btn-success" onclick="exportPdf();"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>导出Pdf</button>
    <button type="button" class="btn btn-success" onclick="exportWord();"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>导出Word</button>
</div>
    </div>
    <div class="row">
        <div class="panel panel-primary">
            <div class="panel-heading">页面展示</div>
                <table id="table" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                    <tr>
                        <th>操作</th>
                        <th>id</th>
                        <th>用户名</th>
                        <th>真实姓名</th>
                        <th>性别</th>
                        <th>年龄</th>
                        <th>电话</th>
                        <th>邮箱</th>
                        <th>薪水</th>
                        <th>入职日期</th>
                        <th>角色</th>
                        <th>地区</th>
                        <th>图片</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                </table>
        </div>
    </div>
</div>

<%--用户的新增--%>
<div id="addUser1" style="display: none;">
    <form id="add_form" class="form-horizontal" class="form-horizontal">
        <div class="form-group">
            <label  class="col-sm-2 control-label">用户名</label>
            <div class="col-sm-4">
                <input type="text" name="add_userName" class="form-control" id="userName" placeholder="请输入用户名...">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">真实姓名</label>
            <div class="col-sm-4">
                <input type="text" name="add_realName" class="form-control" id="realName" placeholder="请输入真实姓名...">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">密码</label>
            <div class="col-sm-4">
                <input type="password" name="add_password" class="form-control" id="password" placeholder="请输入密码...">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">确认密码</label>
            <div class="col-sm-4">
                <input type="password" name="add_password2" class="form-control" id="password2" placeholder="请输入密码...">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">性别</label>
            <div class="col-sm-4">
                <input type="radio" value="1" name="sex" checked>男
                <input type="radio" value="0" name="sex">女
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">年龄</label>
            <div class="col-sm-4">
                <input type="text" name="add_age" class="form-control" id="age" placeholder="请输入年龄...">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">电话</label>
            <div class="col-sm-4">
                <input type="text" name="add_phone" class="form-control" id="phone" placeholder="请输入电话...">
            </div>
        </div>
<div class="form-group">
            <label class="col-sm-2 control-label">邮件</label>
            <div class="col-sm-4">
                <input type="text" name="add_email" class="form-control" id="email" placeholder="请输入邮件...">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">薪水</label>
            <div class="col-sm-4">
                <input type="text" name="add_salary" class="form-control" id="salary" placeholder="请输入薪水...">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">入职日期</label>
            <div class="col-sm-4">
                <input type="text" name="add_comeTime" class="form-control" id="add_comeTime"   placeholder="请输入入职日期...">
            </div>
        </div>

        <div class="form-group" id="add_div">
            <label class="col-sm-2 control-label">角色</label>
            <div class="col-sm-4" id="add_selectid">
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-12">
                <div class="form-group" id="add_area">
                    <label class="control-label col-sm-2">地区</label>
                </div>
            </div>
        </div>



        <div class="form-group">
            <label class="col-sm-2 control-label">图片</label>
            <div class="col-sm-4">
                <input type="file" name="imageInfo" id="mainImage">
                <input type="hidden" id="add_mainImagePath"/>
            </div>
        </div>

    </form>
</div>
<%--用户的修改--%>
<div id="updateUser" style="display: none;">
    <form class="form-horizontal">
        <div class="form-group">
            <label  class="col-sm-2 control-label">用户名</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="update_userName" placeholder="请输入用户名...">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">真实姓名</label>
            <div class="col-sm-4">
                <input type="text" class="form-control"  id="update_realName" placeholder="请输入真实姓名...">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">密码</label>
            <div class="col-sm-4">
                <input type="password" class="form-control" id="update_password" placeholder="请输入密码...">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">性别</label>
            <div class="col-sm-4">
                <input type="radio" value="1" name="update_sex" >男
                <input type="radio" value="0" name="update_sex">女
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">年龄</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="update_age" placeholder="请输入年龄...">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">电话</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="update_phone" placeholder="请输入电话...">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">邮件</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="update_email" placeholder="请输入邮件...">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">薪水</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="update_salary" placeholder="请输入薪水...">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">入职日期</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="update_comeTime"   placeholder="请输入入职时间...">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">角色名称</label>
            <div class="col-sm-4" id="update_selectid">
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-12">
                <div class="form-group" id="update_area">
                    <label class="control-label col-sm-2">地区:</label>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">图片</label>
            <div class="col-sm-4">
                <input type="file" name="imageInfo" id="update_mainImage">
                <input type="hidden" id="update_mainImagePath"/>
            </div>
        </div>
    </form>
</div>

<jsp:include page="/common/script.jsp"></jsp:include>
</body>
<script>
    var v_keepForm;
    var v_updateUser;
    var userTable;
    $(function(){
        initArea("selectArea",1);
        initRoleCheckbox("selectid","seach");
        initRoleCheckbox("add_selectid","add");
        initRoleCheckbox("update_selectid","update");
        initData();
        initAddUserDate();
        initDate();
        initUpdateUserDate();
        initBindEvent();
        initMainImage("mainImage");
        v_keepForm=$("#addUser1").html();
        v_updateUser=$("#updateUser").html();
        yanzheng();
    });

    function initArea(elementName,id,obj) {
        if(obj){
            $(obj).parent().nextAll().remove();
        }
        $.ajax({
            url:"/area/queryArea.do",
            type:"post",
            data:{
                "id":id
            },
            success:function (result) {
                if(result.code == 200){
                    if(!result.data.length){
                        return false;
                    }
                    var v_select = '<div class="col-sm-2"><select class="form-control" name="areaSelect" onchange="initArea(\''+elementName+'\',this.value,this)"><option value="-1">==请选择==</option> ';
                    var v_areaArr = result.data;
                    for(var i=0;i<v_areaArr.length;i++){
                        v_select += "<option value='"+v_areaArr[i].id+"' data-categoryname = '"+v_areaArr[i].name+"'>"+v_areaArr[i].areaName+"</option>";
                    }
                    v_select += '</select></div>';
                    if(elementName == "selectArea"){
                        $("#"+elementName).append(v_select);
                    }else if(elementName == "add_area"){
                        $("#"+elementName,v_addUserForm).append(v_select);
                    }
                    if(elementName == "update_area"){
                        $("#"+elementName,v_updateUserForm).append(v_select);
                    }
                }
            }
        })
    }

    function yanzheng() {
    $('#add_form').bootstrapValidator({
        // 默认的提示消息
        message: 'This value is not valid',
        // 表单框里右侧的icon
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        submitHandler: function (validator, form, submitButton) {


        },
        fields: {
            add_userName: {
                validators: {
                    notEmpty: {
                        message: '用户名不能为空'
                    },
                    stringLength: {  //长度限制
                        min: 2,
                        max: 8,
                        message: '用户名长度必须在2到8位之间'
                    },
                    regexp: { //正则表达式
                        regexp: /^[a-zA-Z0-9_]+$/,
                        message: '用户名只能包含大写、小写、数字和下划线'
                    },
                    remote: {
                        url: "/user/confirmUserName.do",
                        message: "用户名已存在",
                        type:"post",
                        delay:2000
                    }
                }
            },
            add_realName: {
                validators: {
                    notEmpty: {
                        message: '真实名不能为空'
                    },
                    stringLength: {  //长度限制
                        min: 2,
                        max: 5,
                        message: '真实名长度必须在2到5位之间'
                    },
                    regexp: { //正则表达式
                        regexp: /^[a-zA-Z0-9_]+$/,
                        message: '真实名只能包含大写、小写、数字和下划线'
                    }
                }
            },
            add_password: {
                validators: {
                    notEmpty: {
                        message: '密码不能为空'
                    },
                    stringLength: {  //长度限制
                        min: 3,
                        max: 10,
                        message: '密码长度必须在3到10位之间'
                    },
                    regexp: { //正则表达式
                        regexp: /^[a-zA-Z0-9_]+$/,
                        message: '密码只能包含大写、小写、数字和下划线'
                    }
                }
            },
            add_password2: {
                validators: {
                    notEmpty: {
                        message: '密码不能为空'
                    },
                    identical: {
                        field: 'add_password',
                        message: '两次输入的密码不一致！'
                    },
                    stringLength: {  //长度限制
                        min: 3,
                        max: 10,
                        message: '密码长度必须在3到10位之间'
                    },
                    regexp: { //正则表达式
                        regexp: /^[a-zA-Z0-9_]+$/,
                        message: '密码只能包含大写、小写、数字和下划线'
                    }
                }
            },
            add_age: {
                validators: {
                    between: {
                        min: 0,
                        max: 150,
                        message: '请输入正常的年龄,范围为%s到%s',
                    }
                }
            },
            add_phone: {
                validators: {
                    notEmpty: {
                        message: '手机号不能为空'
                    },
                    digits: {
                        message: '只能填写数字'
                    },
                    callback: {
                        callback: function(value, validator) {
                            if (value.length < 11 ||value.length>11) {
                                return {
                                    valid: false,
                                    message: '请输入正确的手机号'
                                }
                            }
                            return true;
                        }
                    }
                }
            },
            add_email:{
                validators: {
                    emailAddress: { // 可以不用自己写正则
                        message: '邮箱格式不正确'
                    }
                }
            },
            add_salary:{
                validators: {
                    between: {
                        min: 1000,
                        max: 10000000,
                        message: '请输入正常的薪资,范围为%s到%s',
                    }
                }
            },
            add_comeTime:{
                validators: {
                    notEmpty: { // 非空校验
                        message: '入职日期不能为空!'
                    }
                }
            },
        }
    });
}
    function exportExcel() {
        location.href="/user/exportExcel.do"
    }
    function exportPdf() {
        location.href="/user/exportPdf.do"
    }
    function exportWord() {
        location.href="/user/exportWord.do"

    }
    function initMainImage(imgId) {
        if (imgId=="update_mainImage"){
    var url=$("#update_mainImagePath").val();
    var urlArr=[];
    urlArr.push(url);
        }
        var s = {
            language: 'zh',
            uploadUrl: "/file/uploadImage.do",
            showUpload : false,
            showRemove : false,
            allowedFileExtensions : [ 'jpg', 'png', 'jpeg', 'gif'] //上传的文件的后缀名
        };

        var settings = {
            theme : 'fa',
            dropZoneTitle : "请上传小于5M的图片！",
            uploadUrl: "/file/uploadImage.do",
            language : "zh",
            autoReplace : true,
            showCaption : false,
            showUpload : true,
            overwriteInitial : true,
            uploadAsync : true,
            showUploadedThumbs : true,
            maxFileCount : 5,
            minFileCount : 1,
            initialPreview:urlArr,
            initialPreviewAsData: true,
            showRemove : true,
            showClose : false,
            autoReplace : true,
            overwriteInitial : true,
            layoutTemplates : {
                actionDelete:'',    //去掉图片的删除按钮
                actionUpload: '',
            },
            previewSettings : {
                image : {
                    width : "100%",
                    height : "100%"
                },
            }
        }
        $("#"+imgId).fileinput(settings).on("fileuploaded", function(event, t, previewId, index) {
            var data = t.response;
            if (data.code == 200) {
                if (imgId!="update_mainImage"){
                    $("#add_mainImagePath",v_addUserForm).val(data.data);
                } else {
                    $("#update_mainImagePath",v_updateUserForm).val(data.data);
                }

            }
        });
    }

    function initRoleCheckbox(idName,name1) {
        $.ajax({
            type: "post",
            url: "/role/selectRoleList.do",
            success: function (result) {
                if (result.code==200) {
                    var roleIds="<select class='selectpicker' title='请选择'   multiple id='"+name1+"_selectId"+"'>\n" +
                        "               ";
                    var datas=result.data;
                    for (var i =0;i<datas.length;i++) {
                        roleIds+="<option name='"+name1+"_selectName"+"' value="+datas[i].id+">"+datas[i].roleName+"</option>";
                    }
                    roleIds+=" </select>"
                  $("#"+idName).html(roleIds);
                    $(".selectpicker").selectpicker("refresh");
                }else {
                    alert(result.msg);
                }
            }
        })
    }

    function initAddUserDate() {
        $('#add_comeTime').datetimepicker({
            format: 'YYYY/MM/DD',
            locale: 'zh-CN',
            showClear: true
        });
    }

    function initUpdateUserDate() {
        $('#update_comeTime').datetimepicker({
            format: 'YYYY/MM/DD',
            locale: 'zh-CN',
            showClear: true
        });
    }

    function initDate() {
        $('#sel_minComeTime').datetimepicker({
            format: 'YYYY/MM/DD',
            locale: 'zh-CN',
            showClear: true
        });

        $('#sel_maxComeTime').datetimepicker({
            format: 'YYYY/MM/DD',
            locale: 'zh-CN',
            showClear: true
        });
    }

    function deleteUser(id) {
        //阻止冒泡
        event.stopPropagation();
        bootbox.confirm({
            message: "你确定删除吗?",
            size: 'small',
            title: "提示信息",
            buttons: {
                confirm: {
                    label: '<span class="glyphicon glyphicon-ok"></span>确定',
                    className: 'btn-success'
                },
                cancel: {
                    label: '<span class="glyphicon glyphicon-remove"></span>取消',
                    className: 'btn-danger'
                }
            },
            callback: function (result) {
                if (result) {
                    $.ajax({
                        type: "post",
                        url: "/user/deleteUser.do",
                        data: {"id": id},
                        success: function (result) {
                            if (result.code==200) {
                                alert(result.msg);
                                initData();
                            }else {
                                alert(result.msg);
                            }
                        }
                    })
                }
            }
        })
    }

    var ids1=[];
    function initBindEvent() {
            $("#table tbody").on("click", "tr", function () {
                var v_checkbox = $(this).find("input[type='checkbox']")[0];
                if (v_checkbox.checked) {
                    $(this).css("background-color", "");
                    v_checkbox.checked = false;
                   var a=v_checkbox.value;
                    for (var i = ids1.length-1; i >= 0; i--) {
                        if (ids1[i] ==a) {
                            ids1.splice(i,1);
                        }
                    }
                } else {
                    $(this).css("background-color", "red");
                    v_checkbox.checked = true;
                    ids1.push(v_checkbox.value);
                }
            })
    }


    function batchDelete() {
        if (ids1.length > 0) {
            bootbox.confirm({
                message: "你确定删除吗?",
                size: 'small',
                title: "提示信息",
                buttons: {
                    confirm: {
                        label: '<span class="glyphicon glyphicon-ok"></span>确定',
                        className: 'btn-success'
                    },
                    cancel: {
                        label: '<span class="glyphicon glyphicon-remove"></span>取消',
                        className: 'btn-danger'
                    }
                },
                callback: function (result) {
                    if (result) {
                        $.ajax({
                            type:"post",
                            url:"/user/deleteBatch.do",
                            data:{"ids":ids1},
                            success:function (r) {
                                if (r.code == 200) {
                                    ids1 = [];
                                   initData();
                                }
                            }
                        })
                    }
                }
            })
        } else {
            bootbox.alert({
                message: "<span class='glyphicon glyphicon-exclamation-sign'></span>请选择要删除的数据",
                size: 'small',
                title: "提示信息"
            });
        }
    }

    function areaEdit(obj) {
        // 把当前元素 转换为 jquery  然后根据这个元素 获取父级元素
        $(obj).parent().remove();
        // 调用 三级联动事件
        initArea("update_area",1);
        // 拼接 一个 button按钮  内容和作用 为 取消编辑
        var str = '<button type="button" class="btn btn-primary" onclick="onExit();"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>取消编辑</button>'
        // 追加给 指定 div  又因为  我们使用了 弹出框 所有需要指定作用域
        $("#update_area",v_updateUserForm).append(str)
    }
    
    function onExit() {
        /* 取消编辑触发事件 */
            var str = '<label class="control-label col-sm-2">地区:</label><div class="col-sm-10">'+v_aName+'&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-primary" onclick="areaEdit(this);"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑</button></div>';
            $("#update_area",v_updateUserForm).html(str)
    }

    var v_updateUserForm;
    function updateUser(id) {
        //阻止冒泡
        event.stopPropagation();
        $.post({
            url:"/user/selectUserById.do",
            dataType:"json",
            type:"post",
            data:{
                "id":id
            },
            success:function(result){
                var data=result.data;
                $("#update_userName").val(data.userName);
                $("#update_realName").val(data.realName);
                $("#update_password").val(data.password);
                $("#update_age").val(data.age);
                $("#update_phone").val(data.phone);
                $("#update_email").val(data.email);
                $("#update_salary").val(data.salary);
                $("#update_comeTime").val(new Date(data.comeTime).toLocaleDateString());
                $("#update_mainImagePath").val(data.imgPath);
                v_aName = result.data.aName;
                $("#update_area").html(" <label class=\"control-label col-sm-2\">地区:</label><div class='col-sm-10'>"+v_aName+"&nbsp;&nbsp;&nbsp;<button type=\"button\" class=\"btn btn-primary\" onclick=\"areaEdit(this);\"><span class=\"glyphicon glyphicon-pencil\" aria-hidden=\"true\"></span>编辑</button></div>");
                if(data.sex==1){
                    $("input[name='update_sex'][value='1']").attr("checked",true);
                }else {
                    $("input[name='update_sex'][value='0']").attr("checked",true);
                }
                var ids=data.roleIds;
                var v_id1=[]
                var strings = ids.split(",");
                        for (var i=0;i<strings.length;i++) {
                            v_id1.push(strings[i])
                        }
                $("#update_selectId").selectpicker('val',v_id1).trigger("change");

                 initMainImage("update_mainImage");
                v_updateUserForm= bootbox.dialog({
                    title: '修改用户',
                    message: $("#updateUser form"),
                    size:"large",
                    buttons: {
                        confirm: {
                            label: '<span class="glyphicon glyphicon-ok"></span>提交',
                            className: 'btn-primary',
                            callback: function(){
                                var userName=$("#update_userName",v_updateUserForm).val();
                                var realName=$("#update_realName",v_updateUserForm).val();
                                var password=$("#update_password",v_updateUserForm).val();
                                var sex =$("input[type='radio']:checked",v_updateUserForm).val();
                                var age=$("#update_age",v_updateUserForm).val();
                                var phone=$("#update_phone",v_updateUserForm).val();
                                var email=$("#update_email",v_updateUserForm).val();
                                var salary=$("#update_salary",v_updateUserForm).val();
                                var comeTime=$("#update_comeTime",v_updateUserForm).val();
                                var imgPath=$("#update_mainImagePath",v_updateUserForm).val();
                                var ids1="";
                                $("option[name='update_selectName']:selected",v_updateUserForm).each(function () {
                                    ids1+=","+this.value
                                })
                                if (ids1.length>0) {
                                    ids1=ids1.substring(1);
                                }
                                var updateArea = $("select[name='areaSelect']",v_updateUserForm);
                                var a1;
                                var a2;
                                var a3;
                                if(updateArea.length===3){
                                    a1 = $($("select[name='areaSelect']",v_updateUserForm)[0]).val();
                                    a2 = $($("select[name='areaSelect']",v_updateUserForm)[1]).val();
                                    a3 = $($("select[name='areaSelect']",v_updateUserForm)[2]).val();
                                }
                                var dataJson={};
                                dataJson.id=id;
                                dataJson.userName=userName;
                                dataJson.realName=realName;
                                dataJson.password=password;
                                dataJson.sex=sex;
                                dataJson.age=age;
                                dataJson.phone=phone;
                                dataJson.email=email;
                                dataJson.salary=salary;
                                dataJson.comeTime=comeTime;
                                dataJson.roleIds=ids1;
                                dataJson.imgPath=imgPath;
                                dataJson.a1=a1;
                                dataJson.a2=a2;
                                dataJson.a3=a3;
                                $.post({
                                    url:"/user/updateUser.do",
                                    type:"post",
                                    data:dataJson,
                                    success: function (result) {
                                        if (result.code==200) {
                                        }else {
                                        }
                                        initData();
                                    }

                                })
                            }
                        },
                        cancel: {
                            label: '<span class="glyphicon glyphicon-remove"></span>取消',
                            className: 'btn-danger',
                        }
                    }
                });
                $("#updateUser").html(v_updateUser);
                initUpdateUserDate();
                initRoleCheckbox("update_role","update");
                initRoleCheckbox("update_selectid","update");
            },
            error:function(){
                alert("查询异常");
            }
        })
    }

    var v_addUserForm;
    function addUser() {
        initArea("add_area",1);
        v_addUserForm= bootbox.dialog({
            title: '添加用户',
            message: $("#addUser1 form"),
            size:"large",
            buttons: {
                confirm: {
                    label: '<span class="glyphicon glyphicon-ok"></span>确认',
                    className: 'btn-primary',
                    callback: function(){
                        $('#add_form',v_addUserForm).data('bootstrapValidator').validate();
                        var flag = $('#add_form',v_addUserForm).data('bootstrapValidator').isValid();
                        if(!flag)
                            return false;
                        if(flag){
                            var userName=$("#userName",v_addUserForm).val();
                            var realName=$("#realName",v_addUserForm).val();
                            var password=$("#password",v_addUserForm).val();
                            var sex =$("input[type='radio']:checked",v_addUserForm).val();
                            var age=$("#age",v_addUserForm).val();
                            var phone=$("#phone",v_addUserForm).val();
                            var email=$("#email",v_addUserForm).val();
                            var salary=$("#salary",v_addUserForm).val();
                            var comeTime=$("#add_comeTime",v_addUserForm).val();
                            var imgPath=$("#add_mainImagePath",v_addUserForm).val();
                            var a1 = $($("select[name='areaSelect']",v_addUserForm)[0]).val();
                            var a2 = $($("select[name='areaSelect']",v_addUserForm)[1]).val();
                            var a3 = $($("select[name='areaSelect']",v_addUserForm)[2]).val();
                            var ids="";
                            $("option[name='add_selectName']:selected",v_addUserForm).each(function () {
                                ids+=","+this.value
                            })
                            if (ids.length>0) {
                                ids=ids.substring(1);
                            }
                            //自定义的json对象
                            var dataJson={};
                            dataJson.userName=userName;
                            dataJson.realName=realName;
                            dataJson.password=password;
                            dataJson.sex=sex;
                            dataJson.age=age;
                            dataJson.phone=phone;
                            dataJson.email=email;
                            dataJson.salary=salary;
                            dataJson.comeTime=comeTime;
                            dataJson.roleIds=ids;
                            dataJson.imgPath=imgPath;
                            dataJson.a1=a1;
                            dataJson.a2=a2;
                            dataJson.a3=a3;
                           $.post({
                                url:"/user/addUser.do",
                                type:"post",
                                data: dataJson,
                                success:function (result) {
                                    if (result.code==200){
                                        alert("新增成功");
                                        initData();
                                    } else {
                                        initData();
                                    }
                                }
                            })
                        }
                    }
                },
                cancel: {
                    label: '<span class="glyphicon glyphicon-remove"></span>取消',
                    className: 'btn-danger',
                }
            }
        });
        $("#addUser1").html(v_keepForm);
        initAddUserDate();
        initRoleCheckbox("add_role","add");
        initMainImage();
        initRoleCheckbox("add_selectid","add");
        yanzheng();
    }

    function initData(){
        var ids="";
        $("option[name='seach_selectName']:selected").each(function () {
            ids+=","+this.value
        })
        if (ids.length>0) {
            ids=ids.substring(1);
        }
        userTable= $('#table').DataTable( {
            "processing": true,
            "aLengthMenu":[5,10],
           "serverSide":true,
           "searching":false,
           "destroy":true,
            "ajax":{
                url:"/user/selectUser.do",
                type:"post",
                data:{
                    "userName":$("#sel_userName").val(),
                    "realName":$("#sel_realName").val(),
                    "minAge":$("#sel_minAge").val(),
                    "maxAge":$("#sel_maxAge").val(),
                    "minSalary":$("#sel_minSalary").val(),
                    "maxSalary":$("#sel_maxSalary").val(),
                    "minComeTime":$("#sel_minComeTime").val(),
                    "maxComeTime":$("#sel_maxComeTime").val(),
                    "a1":$($("select[name='areaSelect']",$("#areaSeach"))[0]).val(),
                    "a2":$($("select[name='areaSelect']",$("#areaSeach"))[1]).val(),
                    "a3":$($("select[name='areaSelect']",$("#areaSeach"))[2]).val(),
                    "roleIds":ids,
                 },
                },
            drawCallback:
                function (s) {
                console.log(ids1)
                $("#table tbody tr").each(function () {
                    var v_checkbox = $(this).find("input[type='checkbox']")[0];
                        var id = v_checkbox.value;
                        for (var i = 0; i<ids1.length; i++) {
                            if (ids1[i]==id){
                                $(this).css("background-color", "red");
                                v_checkbox.checked = true;
                            }
                        }
                })
            },
            columns:
                [
                    { data: 'id',
                        "render": function (data, type, row, meta) {
                            return "<input type='checkbox' name='ids' value='"+data+"'/>";
                        },
                    },
                    { data: 'id' },
                    { data: 'userName' },
                    { data: 'realName'},
                    { data: 'sex',
                        "render": function (data, type, row, meta) {
                            return data==1?"男":"女";
                        },
                    },
                    { data: 'age'},
                    { data: 'phone'},
                    { data: 'email'},
                    { data: 'salary'},
                    { data: 'comeTime'},
                    { data: 'roleIds'},
                    { data: 'aName'},
                    { data: 'imgPath',
                        "render": function (data, type, row, meta) {
                        return "<img src='"+data+"'width=\"80px\"></img>";
        }
              },
                    { data: 'id' ,
                        "render": function (data, type, row, meta) {
                            return "<div class=\"btn-group\" role=\"group\"><a class='btn btn-danger' onclick='deleteUser("+data+")'><i class='glyphicon glyphicon-trash'></i>删除</a><a  class='btn btn-warning' onclick='updateUser("+data+")'><i class='glyphicon glyphicon-pencil'></i>修改</a></div>"
                        },
                    }
                ],

           "language": {
               "url": "/js/DataTables-1.10.18/Chinese.json"
           },

        });


    }
    
    //重置密码
    /*function resetUserPassword(uid) {
        bootbox.confirm({
            message:"你确定要重置此用户密码吗？",
            size:"small",
            title:"提示信息",
            buttons:{
                confirm:{
                    label:"<span class='glyphicon glyphicon-ok'></span>确认",
                    className:"btn-success",
                },
                cancel:{
                    label:"<span class='glyphicon glyphicon-remove'></span>取消",
                    className:"btn-danger",
                }
            },
            callback:function (result) {
                if(result){
                   $.ajax({
                       url:"/user/resetUserPassword.do",
                       type:"post",
                       data:{
                           "id":uid
                       },
                       success:function (data) {
                           if(data.code == 200){
                            alert("重置成功！");
                            search();
                           }
                       }
                   })
                }
            }
        })
    }*/
</script>
</html>

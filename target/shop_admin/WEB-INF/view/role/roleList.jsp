<%--
  Created by IntelliJ IDEA.
  User: 86131
  Date: 2019/8/21
  Time: 22:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <jsp:include page="/common/head.jsp"></jsp:include>
    <title>角色管理</title>
</head>
<body>
<jsp:include page="/common/nav-v3.jsp"></jsp:include>
<div class="container">
<div class="row">
    <div style="background: #5bc0de">
        <button class="btn btn-success" onclick="addRole()"><i class="glyphicon glyphicon-plus"></i>新增</button>
    </div>
</div>
<div class="row">
    <div class="panel panel-primary">
        <div class="panel-heading">页面展示</div>
        <table id="table" class="table table-striped table-bordered" style="width:100%">
            <thead>
            <tr>
                <th>id</th>
                <th>角色名</th>
                <th>操作</th>
            </tr>
            </thead>
        </table>
    </div>
</div>
</div>

<div id="addRole" style="display: none;">
    <form class="form-horizontal">
        <div class="form-group">
            <label  class="col-sm-2 control-label">角色名</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="add_roleName" placeholder="请输入角色名...">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">权限</label>
            <div class="col-sm-10">
                <ul id="menuTree" class="ztree"></ul>
            </div>
        </div>
    </form>
</div>



<div id="updateRole" style="display: none;">
    <form class="form-horizontal">
        <div class="form-group">
            <label  class="col-sm-2 control-label">角色名</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="update_roleName" placeholder="请输入角色名...">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">权限</label>
            <div class="col-sm-10">
                <ul id="update_menuTree" class="ztree"></ul>
            </div>
        </div>
    </form>
</div>

<jsp:include page="/common/script.jsp"></jsp:include>
</body>
<script>
    var v_keepForm;
    var v_updateRole;
    $(function(){
        initData();
        v_keepForm=$("#addRole").html();
        v_updateRole=$("#updateRole").html();
    })

    function initTree(idName) {
        $.ajax({
            "type":"post",
            "url":"/menu/selectMenuList.do",
            "async":false,
            "success":function (data) {
                if (data.code == 200) {
                    var setting = {

                        check: {
                            enable: true,
                            chkboxType: {"Y": "p", "N": "p"}
                        },
                        data: {
                            simpleData: {
                                enable: true,
                                pIdKey: "pId"
                            },
                            key: {
                                name: "areaName"
                            }
                        },
                    };
                    $.fn.zTree.init($("#" + idName), setting, data.data);
                    var treeObj = $.fn.zTree.getZTreeObj(idName);
                    treeObj.expandAll(true);
                }
            }
        })
    }

    var v_updateRoleForm;
    function updateRole(id) {
        initTree("update_menuTree");
        $.post({
            url:"/role/selectRoleById.do",
            dataType:"json",
            type:"post",
            data:{"id":id
            },
            success:function(result){
                var data=result.data;
                $("#update_roleName").val(data.roleName);
                var treeObj = $.fn.zTree.getZTreeObj("update_menuTree");
                var v_id=data.menuId
                for (var i =0;i<v_id.length;i++) {
                    var nodes = treeObj.getNodeByParam("id",v_id[i], null);
                    treeObj.checkNode(nodes,true);
                }
                v_updateRoleForm= bootbox.dialog({
                    title: '修改用户',
                    message: $("#updateRole form"),
                    size:"large",
                    buttons: {
                        confirm: {
                            label: '<span class="glyphicon glyphicon-ok"></span>提交',
                            className: 'btn-primary',
                            callback: function(){
                                var roleName=$("#update_roleName",v_updateRoleForm).val();
                                var treeObj = $.fn.zTree.getZTreeObj("update_menuTree");
                                var nodes=treeObj.getCheckedNodes(true);
                                var v_roleId=[];
                                $(nodes).each(function(){
                                    v_roleId.push(this.id);
                                })
                                if(v_roleId.length==0){
                                    v_roleId.push(-1)
                                }
                                $.post({
                                    url:"/role/updateRole.do",
                                    type:"post",
                                    data:{"id":id,
                                        "roleName":roleName,
                                    "v_roleId":v_roleId
                                    },
                                    success: function (result) {
                                        if (result.code==200) {
                                        }else {
                                        }
                                    }

                                })
                                initData();
                            }
                        },
                        cancel: {
                            label: '<span class="glyphicon glyphicon-remove"></span>取消',
                            className: 'btn-danger',
                        }
                    }
                });
                $("#updateRole").html(v_updateRole);
            },
            error:function(){
                alert("查询异常");
            }
        })
    }


    function deleteRole(id) {
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
                        url: "/role/deleteRole.do",
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

    var v_addRoleForm;
    function addRole() {
        initTree("menuTree");
        v_addRoleForm= bootbox.dialog({
            title: '添加用户',
            message: $("#addRole form"),
            size:"large",
            buttons: {
                confirm: {
                    label: '<span class="glyphicon glyphicon-ok"></span>确认',
                    className: 'btn-primary',
                    callback: function(){
                        var roleName=$("#add_roleName",v_addRoleForm).val();
                        var treeObj = $.fn.zTree.getZTreeObj("menuTree");
                        var nodes=treeObj.getCheckedNodes(true);
                        var roleId=[];
                        $(nodes).each(function(){
                            roleId.push(this.id);
                        })
                        if(roleId.length==0){
                            roleId.push(-1)
                        }
                        $.post({
                            url:"/role/addRole.do",
                            type:"post",
                            data:{"roleName":roleName,
                                "roleId":roleId
                            } ,
                            success:function (result) {
                                if (result.code==200){
                                    alert("新增成功");
                                } else {
                                    alert("新增失败");
                                }
                            }
                        })
                        initData();
                    }
                },
                cancel: {
                    label: '<span class="glyphicon glyphicon-remove"></span>取消',
                    className: 'btn-danger',
                }
            }
        });
        $("#addRole").html(v_keepForm);
    }

    function initData(){
        $('#table').DataTable( {
            "aLengthMenu":[2,5,10],
            "serverSide":true,
            "searching":false,
            "destroy":true,
            "ajax":{
                url:"/role/selectRoleUser.do",
                type:"post",
            },
            columns:
                [
                    { data: 'id' },
                    { data: 'roleName' },
                    { data: 'id' ,
                        "render": function (data, type, row, meta) {
                            return "<div class=\"btn-group\" role=\"group\"><a class='btn btn-danger' onclick='deleteRole("+data+")'><i class='glyphicon glyphicon-trash'></i>删除</a><a  class='btn btn-warning' onclick='updateRole("+data+")'><i class='glyphicon glyphicon-pencil'></i>修改</a></div>"
                        },
                    }
                ],
            "language": {
                "url": "/js/DataTables-1.10.18/Chinese.json"
            },
        });
    }
</script>
</html>

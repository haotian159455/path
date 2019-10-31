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
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Title</title>
    <link rel="stylesheet"  href="/js/bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
    <link rel="stylesheet"  href="/js/DataTables-1.10.18/css/dataTables.bootstrap.min.css"/>
</head>
<body>
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
                    <th>姓名</th>
                    <th>是否住宿</th>
                    <th>是否搬运行李</th>
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
            <label  class="col-sm-2 control-label">姓名</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="name" placeholder="请输入姓名...">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">是否住宿</label>
            <div class="col-sm-10">
                <input type="radio" value="是" name="add_zs" >是
                <input type="radio" value="否"  name="add_zs" >否
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">是否托运行李</label>
            <div class="col-sm-10">
                <input type="radio"  value="是" name="add_ty" >是
                <input type="radio" value="否"  name="add_ty" >否
            </div>
        </div>
    </form>
</div>




<script type="text/javascript" src="/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/js/DataTables-1.10.18/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="/js/DataTables-1.10.18/js/dataTables.bootstrap.min.js"></script>
<script type="text/javascript" src="/js/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/js/bootbox/bootbox.min.js"></script>
</body>
<script>
    var v_keepForm;
    $(function(){
        initData();
        v_keepForm=$("#addRole").html();
    })



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
                        url: "/role/deleteStu.do",
                        data: {"id": id},
                        success: function (result) {
                            if (result.code==200) {
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
        v_addRoleForm= bootbox.dialog({
            title: '添加用户',
            message: $("#addRole form"),
            size:"large",
            buttons: {
                confirm: {
                    label: '<span class="glyphicon glyphicon-ok"></span>确认',
                    className: 'btn-primary',
                    callback: function(){
                        var name=$("#name",v_addRoleForm).val();
                        var iszs= $("input[name='add_zs']:checked",v_addRoleForm).val();
                        var isty= $("input[name='add_ty']:checked",v_addRoleForm).val();
                        $.post({
                            url:"/role/addStu.do",
                            type:"post",
                            data:{"name":name,"iszs":iszs,"isty":isty,
                            } ,
                            success:function (result) {
                                if (result.code==200){
                                    alert("新增成功");
                                    initData();
                                } else {
                                    alert("新增失败");
                                }
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
        $("#addRole").html(v_keepForm);
    }

    function initData(){
        $('#table').DataTable( {
            "aLengthMenu":[5,10,15],
            "serverSide":true,
            "searching":false,
            "destroy":true,
            "ajax":{
                url:"/role/selectStu.do",
                type:"post",
            },
            columns:
                [
                    { data: 'id' },
                    { data: 'name' },
                    { data: 'iszs' },
                    { data: 'isty' },
                    { data: 'id' ,
                        "render": function (data, type, row, meta) {
                            return "<a class='btn btn-danger' onclick='deleteRole("+data+")'><i class='glyphicon glyphicon-trash'></i>删除</a>"
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

    <%--
      Created by IntelliJ IDEA.
      User: 86131
      Date: 2019/8/25
      Time: 9:47
      To change this template use File | Settings | File Templates.
    --%>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <html lang="zh-CN">
        <head>
        <title>菜单管理</title>
    <jsp:include page="/common/head.jsp"></jsp:include>
        </head>
        <body>
        <jsp:include page="/common/nav-v3.jsp"></jsp:include>
    <div class="container">
        <!-- 树展示 -->
        <div class="row">
            <!-- ztree树展示 -->
            <div class="col-md-5">
                <!-- 地区类型树 -->
                <div class="col-md-12">
                <div class="panel panel-info">
                <div class="panel-heading">
                     <%-- 权限管理--%>
                     <button type="button" class="btn btn-success" onclick="showAddAreaDlg();"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>添加</button>
                     <button type="button" class="btn btn-info" onclick="showUpdateAreaDlg();"><span class="glyphiconglyphicon-pencil" aria-hidden="true"></span>修改</button>
                     <button type="button" class="btn btn-danger" onclick="deleteArea();"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>
        </div>
        <div class="panel-body">
        <ul id="areaTree" class="ztree"></ul>


                          </div>
                     </div>
                 </div>
            </div>
        </div>






        <%--新增的div--%>
        <div id="addAreaDiv" style="display: none;">
            <form class="form-horizontal">
            <div class="form-group">
                <label class="col-sm-2 control-label">权限名</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="add_areaName" placeholder="请输入地区名...">
                </div>
            </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">菜单类型</label>
                    <div class="col-sm-4">
                        <input type="radio"  name="add_menuType" value="1">菜单
                        <input type="radio"  name="add_menuType"  value="2">按钮
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label">路径</label>
                    <div class="col-sm-4">
                     <input type="text" class="form-control" id="add_url" placeholder="请输入路径...">
                    </div>
                </div>
            </form>
        </div>

        <div id="updateAreaDiv" style="display: none;">
            <form class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-2 control-label">权限名</label>
                    <div class="col-sm-4">
                      <input type="text" class="form-control" id="update_areaName" placeholder="请输入地区名...">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">菜单类型</label>
                    <div class="col-sm-4">
                        <input type="radio"  name="update_menuType" value="1">菜单
                        <input type="radio"  name="update_menuType"  value="2">按钮
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label">路径</label>
                    <div class="col-sm-4">
                     <input type="text" class="form-control" id="update_url" placeholder="请输入路径...">
                    </div>
                </div>
            </form>
        </div>

        <jsp:include page="/common/script.jsp"></jsp:include>
        </body>
        <script>
        var v_addAreaSource;
        var v_updateAreaSource;
        $(function() {
            initTree();
            v_addAreaSource=$("#addAreaDiv").html();
            v_updateAreaSource= $("#updateAreaDiv").html();
        })


        function deleteArea() {
        var treeObj = $.fn.zTree.getZTreeObj("areaTree");
        var nodes = treeObj.getSelectedNodes();
        if (nodes.length > 0) {
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
                // 获取当前选中的节点及其它的子子孙孙
                var nodeArr = treeObj.transformToArray(nodes);
                var ids = [];
                    for (var i = 0; i < nodeArr.length; i++) {
                    ids.push(nodeArr[i].id);
                    $.ajax({
                             type:"post",
                             data:{
                                    "ids":ids
                             },
                             url:"/menu/deleteArea.do",
                            success:function(data) {
                            if (data.code == 200) {
                                    for (var i=0; i < nodeArr.length; i++) {
                                        treeObj.removeNode(nodeArr[i]);
                                    }
                                }
                            }
                          })
                    }
                }
            }
        })
        } else {
        bootbox.alert({
        message: "<span class='glyphicon glyphicon-exclamation-sign'></span>请选择一个节点",
        size: 'small',
        title: "提示信息"
        });
        }
        }

        function showUpdateAreaDlg() {
        var treeObj = $.fn.zTree.getZTreeObj("areaTree");
        var nodes = treeObj.getSelectedNodes();
            var v_id = nodes[0].id;
            $.ajax({
            type:"post",
            url:"/menu/selectMenuById.do",
            data:{"id":v_id},
            success:function(result) {

            if (nodes.length == 1) {
            // 回填名字
            $("#update_areaName").val(nodes[0].areaName);
            $("#update_url").val(result.data.menuUrl);
            if(result.data.menuType==1){
            $("input[name='update_menuType'][value='1']").attr("checked",true);
            }else {
            $("input[name='update_menuType'][value='2']").attr("checked",true);
            }
            var v_updateAreaDialog = bootbox.dialog({
            title: '修改权限',
            message: $("#updateAreaDiv form"),
            size:"large",
            buttons: {
            confirm: {
            label: '<span class="glyphicon glyphicon-ok"></span>确认',
            className: 'btn-primary',
            callback: function(){
            // 更新
            var v_areaName = $("#update_areaName", v_updateAreaDialog).val();
            var v_url = $("#update_url", v_updateAreaDialog).val();
            var v_menuType = $("input[name='update_menuType']:checked", v_updateAreaDialog).val();
            $.ajax({
            type:"post",
            url:"/menu/updateArea.do",
            data:{"id":v_id, "areaName":v_areaName,
            "menuUrl":v_url,"menuType":v_menuType
            },
            success:function (data) {
            if (data.code == 200) {
            nodes[0].areaName=v_areaName;
            treeObj.updateNode(nodes[0]);
            }
            }
            })

            }
            },
            cancel: {
            label: '<span class="glyphicon glyphicon-remove"></span>取消',
            className: 'btn-danger'
            }
            }
            });
            // 还原
            $("#updateAreaDiv").html(v_updateAreaSource);
            }else if (nodes.length > 1) {
            bootbox.alert({
            message: "<span class='glyphicon glyphicon-exclamation-sign'></span>只能选择一个节点",
            size: 'small',
            title: "提示信息"
            });
            } else {
            bootbox.alert({
            message: "<span class='glyphicon glyphicon-exclamation-sign'></span>至少选择一个节点",
            size: 'small',
            title: "提示信息"
            });
            }
            }
            })
        }

        function showAddAreaDlg() {
        var treeObj = $.fn.zTree.getZTreeObj("areaTree");
        var nodes = treeObj.getSelectedNodes();
        if (nodes.length == 1) {
        var v_addAreaDialog = bootbox.dialog({
        title: '添加权限',
        message: $("#addAreaDiv form"),
        size:"large",
        buttons: {
        confirm: {
        label: '<span class="glyphicon glyphicon-ok"></span>确认',
        className: 'btn-primary',
        callback: function(){
        var v_fatherId = nodes[0].id;
        var v_areaName = $("#add_areaName", v_addAreaDialog).val();
        var v_url = $("#add_url", v_addAreaDialog).val();
        var v_menuType = $("input[name='add_menuType']:checked", v_addAreaDialog).val();
        alert(v_menuType);
        $.ajax({
        type:"post",
        data:{"pId":v_fatherId, "areaName":v_areaName,
            "menuUrl":v_url,"menuType":v_menuType
            },
        url:"/menu/addArea.do",
        success:function (data) {
        if (data.code == 200) {
        // 动态添加节点
        var newNode = {id:data.data,areaName:v_areaName,pId:v_fatherId};
        treeObj.addNodes(nodes[0], newNode);
        }
        }

        })
        }
        },
        cancel: {
        label: '<span class="glyphicon glyphicon-remove"></span>取消',
        className: 'btn-danger'
        }
        }
        });

        // 还原
        $("#addAreaDiv").html(v_addAreaSource);
        } else if (nodes.length > 1) {
        bootbox.alert({
        message: "<span class='glyphicon glyphicon-exclamation-sign'></span>只能选择一个节点",
        size: 'small',
        title: "提示信息"
        });
        } else {
        bootbox.alert({
        message: "<span class='glyphicon glyphicon-exclamation-sign'></span>至少选择一个节点",
        size: 'small',
        title: "提示信息"
        });
        }
        }

        function initTree() {
        $.ajax({
        "type":"post",
        "url":"/menu/selectMenuList.do",
        "success":function (data) {
        if (data.code == 200) {
        var setting = {
        data: {
        simpleData: {
        enable: true,
        pIdKey: "pId"
        },
        key: {
        name: "areaName"
        }
        }
        };
        $.fn.zTree.init($("#areaTree"), setting, data.data);
        }
        }
        })
        }
        </script>
        </html>

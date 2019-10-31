<%--
  Created by IntelliJ IDEA.
  User: lht
  Date: 2019/9/9
  Time: 18:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="/common/head.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/common/nav-v3.jsp"></jsp:include>
<%--栅格布局  展示的table表格--%>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-success">
                <div class="panel-heading">日志列表</div>
                <table id="logTable" class="table table-striped table-bordered" style="TABLE-LAYOUT:fixed;WORD-BREAK:break-all">
                    <thead>
                    <tr>
                        <th>用户姓名</th>
                        <th>真实姓名</th>
                        <th>方法名称</th>
                        <th>操作事情</th>
                        <th>日志状态</th>
                        <th>错误信息</th>
                        <th>详细</th>
                        <th>操作时间</th>
                    </tr>
                    </thead>

                    <tfoot>
                    <tr>
                        <th>用户姓名</th>
                        <th>真实姓名</th>
                        <th>方法名称</th>
                        <th>操作事情</th>
                        <th>日志状态</th>
                        <th>错误信息</th>
                        <th>详细</th>
                        <th>操作时间</th>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>



<jsp:include page="/common/script.jsp"></jsp:include>
</body>
<script type="text/javascript">

    $(function () {
        initTable();
    })

    /*展示页面*/
    function initTable(){
        $("#logTable").DataTable( {
            "aLengthMenu":[5,10,15,20,25,30],//自定义每页展示条数
            "serverSide": true,//开启服务器分页模式
            "searching": false,//是否允许检索
            "ajax":{
                url:"<%=request.getContextPath()%>/log/list.do",
                type:"post",
            },
            columns: [
                { data: 'userName' },
                { data: 'realName'},
                { data: 'content'},
                { data: 'info'},
                { data: 'status',render:function (data) {
                       if(data==1){
                           return "成功";
                       }
                       if(data==0){
                           return "异常";
                       }
                       if(data==null){
                           return "";
                       }
                    }},
                { data: 'errorMsg'},
                { data: 'datail'},
                { data: 'currDate'},
            ],
            "language": {
                url:"/js/DataTables-1.10.18/Chinese.json",
            },
          });
       }


</script>
</html>

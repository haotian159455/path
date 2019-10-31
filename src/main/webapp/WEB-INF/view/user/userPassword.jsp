<%--
  Created by IntelliJ IDEA.
  User: lht
  Date: 2019/9/11
  Time: 14:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改密码页面</title>
    <jsp:include page="/common/head.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/common/nav-v3.jsp"></jsp:include>

<div class="container">
    <div class="row">
        <div class="panel panel-primary">
            <div class="panel-heading">修改密码</div>
            <div class="panel-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">原密码</label>
                        <div class="col-sm-4">
                            <input type="password" class="form-control" id="password" placeholder="请输入原密码...">
                        </div>

                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">新密码</label>
                        <div class="col-sm-4">
                            <input type="password" class="form-control" id="newPassword" placeholder="请输入新密码...">
                        </div>

                    </div>


                    <div class="form-group">
                        <label  class="col-sm-2 control-label">确认密码</label>
                        <div class="col-sm-4">
                            <input type="password" class="form-control" id="reomPassword" placeholder="请输入确认密码...">
                        </div>


                    </div>
                    <div style="text-align: center">
                        <button type="button" class="btn btn-primary" onclick="initUpdate()"><i class="glyphicon glyphicon-ok"></i>修改</button>
                        <button type="reset" class="btn btn-default"><i class="glyphicon glyphicon-refresh"></i>重置</button>
                    </div>
                </form>

            </div>
        </div>
    </div>





<jsp:include page="/common/script.jsp"></jsp:include>
    <script type="text/javascript">
       function initUpdate() {
           var password = $("#password").val();
           var newPassword = $("#newPassword").val();
           var reomPassword = $("#reomPassword").val();

               $.ajax({
                   url:"/user/updatePassword.do",
                   type:"post",
                   data:{
                       "password":password,
                       "newPassword":newPassword,
                       "reomPassword":reomPassword
                   },
                   success:function (data) {
                      if (data.code == 200){
                          alert("修改成功！");
                      }
                   }
               })

       }
    </script>
</body>
</html>

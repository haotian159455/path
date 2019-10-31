<%--
  Created by IntelliJ IDEA.
  User: 86131
  Date: 2019/8/14
  Time: 20:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新增页面</title>
</head>
<body>
<form action="/user/addUser.do" method="post">
    用户名：<input type="text" name="userName"><br>
    真实姓名：<input type="text" name="realName"><br>
    密码：<input type="text" name="password"><br>
    性别：<input type="radio" name="sex" value="1">男
        <input type="radio" name="sex" value="0">女<br>
    年龄：<input type="text" name="age"><br>
    电话：<input type="text" name="phone"><br>
    邮件：<input type="text" name="email"><br>
    <input type="submit" value="提交">
    <input type="reset" value="重置">
</form>
</body>
</html>

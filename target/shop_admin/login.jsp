<%--
  Created by IntelliJ IDEA.
  User: 86131
  Date: 2019/8/28
  Time: 20:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
    <meta name="keywords" content="Flat Dark Web Login Form Responsive Templates, Iphone Widget Template, Smartphone login forms,Login form, Widget Template, Responsive Templates, a Ipad 404 Templates, Flat Responsive Templates" />
    <link href="css/style.css" rel='stylesheet' type='text/css' />
    <link href='http://fonts.useso.com/css?family=PT+Sans:400,700,400italic,700italic|Oswald:400,300,700' rel='stylesheet' type='text/css'>
    <link href='http://fonts.useso.com/css?family=Exo+2' rel='stylesheet' type='text/css'>
</head>

<body>

<!--SIGN UP-->
<h1> Login </h1>
<div class="login-form">
    <div class="avtar">
        <img src="images/avtar.png" />
    </div>
    <form>
        <input type="text" class="text" id="a1" placeholder="账号" ><br><br>
        <div class="key">
            <input type="password"  id="a2" placeholder="密码"><br></b>
        </div>
            <input type="text"  id="a3" placeholder="验证码"><br>
            <img src="/img/code" id="imgCode"><br><a href="#" onclick="code()">看不清楚，换一张</a><br></br><br>
    </form>
    <div class="signin">
        <input type="submit" id="loginButton" value="Login" onclick="login()">
    </div>
</div>

<script src="<%=request.getContextPath()%>/js/jquery-3.3.1.min.js"></script>
</body>
<script>
    
    function code() {
        var t = new Date().getTime();
        document.getElementById("imgCode").src="/img/code?t="+t;
    }
    
    function login(){
        var name=$("#a1").val();
        var password=$("#a2").val();
        var imgCode = $("#a3").val();
        $.ajax({
            url:"/user/login.do",
            data:{
                "userName":name,
                "password":password,
                "imgCode":imgCode
            },
            success:function(result) {
                if (result.code == 200) {
                    location.href = "/index/index.do"
                } else {
                alert(result.msg);
            }
            },
            error:function(){
                alert("登陆异常");
            }
        });
    };
</script>
</html>

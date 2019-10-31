<%@ page import="com.fh.shop.servlet.DistributedSession" %>
<%@ page import="com.fh.shop.utils.RedisUtil" %>
<%@ page import="com.fh.shop.servlet.KeyUtil" %>
<%@ page import="com.fh.shop.po.user.User" %>
<%@ page import="com.alibaba.fastjson.JSON" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .dropdown-submenu {
        position: relative;
    }

    .dropdown-submenu > .dropdown-menu {
        top: 0;
        left: 100%;
        margin-top: -6px;
        margin-left: -1px;
        -webkit-border-radius: 0 6px 6px 6px;
        -moz-border-radius: 0 6px 6px;
        border-radius: 0 6px 6px 6px;
    }

    .dropdown-submenu:hover > .dropdown-menu {
        display: block;
    }

    .dropdown-submenu > a:after {
        display: block;
        content: " ";
        float: right;
        width: 0;
        height: 0;
        border-color: transparent;
        border-style: solid;
        border-width: 5px 0 5px 5px;
        border-left-color: #ccc;
        margin-top: 5px;
        margin-right: -10px;
    }

    .dropdown-submenu:hover > a:after {
        border-left-color: #fff;
    }

    .dropdown-submenu.pull-left {
        float: none;
    }

    .dropdown-submenu.pull-left > .dropdown-menu {
        left: -100%;
        margin-left: 10px;
        -webkit-border-radius: 6px 0 6px 6px;
        -moz-border-radius: 6px 0 6px 6px;
        border-radius: 6px 0 6px 6px;
    }
</style>
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">飞狐电商后台管理</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="menuDiv">
            <%--<ul class="nav navbar-nav">--%>
                <%--<li class="active"><a href="#">商品管理 <span class="sr-only">(current)</span></a></li>--%>
                <%--<li><a href="#">品牌管理</a></li>--%>
                <%--<li><a href="#">地区管理</a></li>--%>
                <%--<li><a href="#">分类管理</a></li>--%>
                <%----%>
                    <%--<li><a href="#" data-toggle="dropdown">系统管理<span class="caret"></span></a>--%>
                    <%--<ul class="dropdown-menu">--%>
                        <%--<li><a href="/user/index.jhtml">用户管理</a></li>--%>
                        <%--<li role="separator" class="divider"></li>--%>
                        <%--<li><a href="/role/index.jhtml">角色管理</a></li>--%>
                        <%--<li role="separator" class="divider"></li>--%>
                        <%--<li><a href="/resource/index.jhtml">菜单管理</a></li>--%>
                        <%--<li role="separator" class="divider"></li>--%>
                        <%--<li class="dropdown-submenu">--%>
                            <%--<a tabindex="-1" href="#">角色管理</a>--%>
                            <%--<ul class="dropdown-menu">--%>
                                <%--        <li class="dropdown-submenu"><a tabindex="-1" href="#">Second level link</a>--%>
                                <%--<ul class="dropdown-menu">--%>
                                    <%--<li><a tabindex="-1" href="#">Second level link</a></li>--%>
                                    <%--<li><a tabindex="-1" href="#">Second level link</a></li>--%>
                                <%--</ul>--%>
                            <%--</li>--%>
                                <%--        <li><a tabindex="-1" href="#">Second level link</a></li>--%>
                                <%--        <li><a tabindex="-1" href="#">Second level link</a></li>--%>
                                <%--        <li><a tabindex="-1" href="#">Second level link</a></li>--%>
                                <%--        <li><a tabindex="-1" href="#">Second level link</a></li>--%>
                                <%--      </ul>--%>
                        <%--</li>--%>
                    <%--</ul>--%>
                <%--</li>--%>
            <%--</ul>--%>

                <%
                    String sessionId = DistributedSession.getSessionId(request, response);
                    String userJson = RedisUtil.get(KeyUtil.user(sessionId));
                    User user = JSON.parseObject(userJson, User.class);
                %>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="#">欢迎<%=user.getRealName()%>登录</a></li>
                    <li><a href="#">今天是第<%=user.getLoginCount()%>次登录</a></li>
                    <c:if test="<%=user.getLockTime()!=null%>">
                    <li><a href="#">上次登录的时间<fmt:formatDate value="<%=user.getScTime()%>" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate> </a></li>
                    <li><a href="/user/loginOut.do">注销</a> </li>
                    </c:if>
        </div>
    </div>
</nav>
<script type="text/javascript" src="/js/jquery-3.3.1.min.js"></script>
<script>
    $(function () {
        find();
         a();
    })
    function a(){
    $.ajaxSetup({
        complete:function (result) {
            var data=result.responseJSON;
            if (data.code== -10000) {
                bootbox.alert({
                    size: "small",
                    title: "提示信息",
                    message: "<span class=''></span>没有该权限",

                })
            }
            if(data.code==-1){
                bootbox.alert({
                    size: "small",
                    title: "提示信息",
                    message: "<span class=''></span>操作失败",

                })
            }
        }
    })
}
    var v_menuArr;
    function find(){
        $.post({
            url:"/menu/selectMenu.do",
            success:function (result) {
                if (result.code==200){
                    v_menuArr=result.data;
                    initMenu(1,1);
                    $("#menuDiv").append(v_html);
                }
            }
        })
    }

    var v_html = "";
    function initMenu(id,level){
        //获取指定id下的所有id
        var sonArr= getSon(id);
        if (sonArr.length > 0){
            if (level==1){
                v_html+='<ul class="nav navbar-nav">';
            }else {
                v_html+='<ul class="dropdown-menu">';
            }
            for (var i = 0; i < sonArr.length; i++) {
                var v_node = sonArr[i];
                var sons= son(v_node.id);

                if (sons){

                    if (level==1){
                        v_html+='<li><a href="'+sonArr[i].menuUrl+'" data-toggle="dropdown">'+sonArr[i].areaName+'<span class="caret"></span></a>';
                    }else {
                        v_html+='<li class="dropdown-submenu"> <a href="'+sonArr[i].menuUrl+'">'+sonArr[i].areaName+'</a>';
                    }
                }else{

                    v_html+='<li><a href="'+sonArr[i].menuUrl+'">'+sonArr[i].areaName+'</a>';
                }
                initMenu(v_node.id,level+1);
                v_html+='</li>'
            }
            v_html+='</ul>'
        }

    }
    function getSon(id) {
        var v_sonArr = [];
        for (var i = 0; i < v_menuArr.length; i++) {
            if (v_menuArr[i].pId==id){
                v_sonArr.push(v_menuArr[i]);
            }
        }
        return v_sonArr;
    }
    function son(id) {
        for (var i = 0; i < v_menuArr.length; i++) {
            if (v_menuArr[i].pId==id){
                return true;
            }
        }
        return false;
    }
</script>



<%--<script>--%>
    <%--$(function () {--%>
        <%--selectMenu()--%>
    <%--})--%>

    <%--var menuJson;--%>
    <%--function selectMenu() {--%>
        <%--$.ajax({--%>
            <%--url:"/menu/selectMenu.do",--%>
            <%--type:"post",--%>
            <%--success:function (result) {--%>
                <%--if (result.code==200){--%>
                    <%--menuJson=result.data;--%>
                    <%--var a= initMenu(1,1);--%>
                    <%--$("#menuDiv").append(a);--%>
                <%--}--%>
            <%--}--%>
        <%--})--%>
    <%--}--%>
    <%--var menuStr="";--%>
    <%--function initMenu(id,level) {--%>
        <%--//获取顶级菜单id数组--%>
        <%--var topIdArr = getTopIdArr(id);--%>
        <%--if (level==1) {--%>

        <%--}--%>
        <%--for (var i = 0; i < topIdArr.length; i++) {--%>
            <%--var hasChilds = hasChild(topIdArr[i].id);--%>
            <%--if (hasChilds){--%>
                <%--if (level==1) {--%>
                    <%--menuStr += '<ul class="nav navbar-nav"><li><a href="#" data-toggle="dropdown">系统管理<span class="caret"></span></a>'--%>
                <%--}else{--%>
                    <%--menuStr += '<ul class="dropdown-menu"><li class="dropdown-submenu"><a tabindex="-1" href="#">角色管理</a>'--%>
                <%--}--%>
                <%--initMenu(topIdArr[i].id,level+1);--%>
            <%--}else {--%>
                <%--if (level==1) {--%>
                    <%--menuStr+= '<ul class="nav navbar-nav"><li><a href='+topIdArr[i].menuUrl+'>'+topIdArr[i].areaName+'</a></li>'--%>
                <%--}else{--%>
                    <%--menuStr+= ' <ul class="dropdown-menu"><li><a href='+topIdArr[i].menuUrl+'>'+topIdArr[i].areaName+'</a></li>'--%>

                <%--}--%>
            <%--}--%>
        <%--}--%>

        <%--menuStr+='</li>'--%>
        <%--menuStr+='</ul>'--%>
    <%--}--%>


    <%--function getTopIdArr(id) {--%>
        <%--var topIdArr=[];--%>
        <%--for (var i = 0; i <menuJson.length ; i++) {--%>
            <%--if (menuJson[i].pId==id){--%>
                <%--topIdArr.push(menuJson[i]);--%>
            <%--}--%>
        <%--}--%>
        <%--return topIdArr;--%>
    <%--}--%>

    <%--function hasChild(id) {--%>
        <%--for (var i = 0; i <menuJson.length ; i++) {--%>
            <%--if (menuJson[i].pId==id){--%>
                <%--return true;--%>
            <%--}--%>
        <%--}--%>
        <%--return false;--%>
    <%--}--%>


<%--</script>--%>
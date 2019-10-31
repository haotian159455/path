<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-2" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">电商后台管理</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-2">
            <ul class="nav navbar-nav" id="menuItems">
            <c:forEach items="${menu}" var="l">
                <c:if test="${empty l.anNiu}">
                <li  id="item_1"><a href=${l.menuUrl}>${l.areaName}</a>
                    </c:if>
                    <c:if test="${!empty l.anNiu}">
                          <li id="item_2" class="dropdown">
                        <a  class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">${l.areaName}<span class="caret"></span></a>
                    </c:if>

                <c:if test="${!empty l.anNiu}">
                    <ul class="dropdown-menu">
                    <c:forEach items="${l.anNiu}" var="list">
                        <li><a href=${list.menuUrl}>${list.areaName}</a></li>
                    </c:forEach>
                    </ul>
                  </li>
                </c:if>

            </c:forEach>
            </ul>


            <ul class="nav navbar-nav navbar-right">
                <li class="active"><a >欢迎${user.realName}登录,当天登陆次数${user.loginCount},上次登录时间为<fmt:formatDate value="${user.scTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></a></li>
                <li><a href="/user/loginOut.do">注销</a> </li>
            </ul>

        </div>
    </div>
</nav>


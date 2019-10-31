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
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li class="active"><a >欢迎${user.realName}登录,当天登陆次数${user.loginCount},上次登录时间为<fmt:formatDate value="${user.scTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></a></li>
                <li><a href="/user/loginOut.do">注销</a> </li>
            </ul>
        </div>
    </div>
</nav>
<jsp:include page="/common/script.jsp"></jsp:include>
<script>
$(function () {
    selectMenu()
})
    var resource;

     // var jsonArr;
     var childStr='';
     function selectMenu() {
         $.ajax({
             url:"/menu/selectMenu.do",
             type:"post",
             success:function (result) {
                 if (result.code==200){
                     resource=result.data;
                     initResource();
                 }
             }
         })
     }


    function initResource() {
        var v_TopMenuHTML=getTopMenuHTML();
        var v_TopMenuObj=$(v_TopMenuHTML);
        var v_TopMenuIdArr=getTopMenuIdArr();
        for (var i=0;i<v_TopMenuIdArr.length;i++) {
            var v_childMenuArr=getChildMenuArr(v_TopMenuIdArr[i]);
            if(v_childMenuArr.length>0){
                var v_href=v_TopMenuObj.find("a[data-id='"+v_TopMenuIdArr[i]+"']");

                v_href.attr("data-toggle","dropdown");
                v_href.append("<span class=\"caret\"></span>");

                var v_childMenuHTML=getChildMenuHTML(v_childMenuArr);
                v_href.parent().append(v_childMenuHTML);
            }
        }
        $("#menuItems").html(v_TopMenuObj);
    }
    function getTopMenuHTML() {
        var v_TopMenuHTML="";
        for (var i=0;i<resource.length;i++) {
            if(resource[i].pId==1){
                v_TopMenuHTML+="<li><a href=\""+resource[i].menuUrl+"\" data-id=\""+resource[i].id+"\">"+resource[i].areaName+"</a></li>";
            }

        }
        return v_TopMenuHTML;
    }
    function getTopMenuIdArr() {
        var v_TopMenuIdArr=[];
        for (var i=0;i<resource.length;i++) {
            if(resource[i].pId==1){
                v_TopMenuIdArr.push(resource[i].id)
            }
        }
        return v_TopMenuIdArr;
    }
    function getChildMenuArr(id) {
        var v_childMenuArr=[];
        for (var i=0;i<resource.length;i++) {
            if(resource[i].pId==id){
                v_childMenuArr.push(resource[i])
            }
        }
        return v_childMenuArr;
    }
    function getChildMenuHTML(childMenuArr) {
        var v_childMenuHTML="<ul class=\"dropdown-menu\">";
        for (var i=0;i<childMenuArr.length;i++) {
            v_childMenuHTML+="<li role=\"separator\" class=\"divider\"></li><li><a href=\""+childMenuArr[i].menuUrl+"\">"+childMenuArr[i].areaName+"</a></li>";
        }
        v_childMenuHTML+="</ul>";
        return v_childMenuHTML;
    }



   //  $(function () {
   //      selectMenu();
   //  })
   //
   //  var jsonArr;
   //  var childStr='';
   //  function selectMenu() {
   //      $.ajax({
   //          url:"/menu/selectMenu.do",
   //          type:"post",
   //          success:function (result) {
   //              if (result.code==200){
   //                  jsonArr=result.data;
   //                  initMenu();
   //              }
   //          }
   //      })
   //  }
   //
   //  function initMenu() {
   //     //获取最顶级的菜单
   //      var topMenu = getTopMenu();
   //      var topMenuObj=$(topMenu);
   //      //获取顶级菜单id
   //      var topMenuId = getTopMenuId();
   //      //获取子节点菜单
   //      for (var i = 0; i <topMenuId.length; i++) {
   //          getChildMenu(topMenuId[i]);
   //          var childId = getChildId(topMenuId[i]);
   //          if (childId.length > 0) {
   //              var v_href = topMenuObj.find("a[data-id='" + topMenuId[i] + "']");
   //              v_href.attr("data-toggle", "dropdown");
   //              v_href.append('<span class="caret"></span>');
   //              v_href.parent().append(childStr)
   //          }
   //      }
   //
   // $("#menuItems").html(getTopMenu);
   //  }
   //  function getTopMenu() {
   //      var topArr="";
   //      for (var i = 0; i < jsonArr.length; i++) {
   //          if (jsonArr[i].pId==1) {
   //              topArr+='<li><a href='+jsonArr[i].menuUrl+' data-id="'+jsonArr[i].id+'">'+jsonArr[i].areaName+'</a></li>'
   //          }
   //      }
   //         return topArr;
   //  }
   //
   //  function getTopMenuId() {
   //      var topMenuId=[];
   //      for (var i = 0; i < jsonArr.length; i++) {
   //          if (jsonArr[i].pId==1) {
   //              topMenuId.push(jsonArr[i].id)
   //          }
   //      }
   //      return topMenuId;
   //  }
   //
   //  function getChildId(id) {
   //      var childIdArr=[]
   //      for (var i = 0; i < jsonArr.length; i++) {
   //          var a=jsonArr[i].pId;
   //          if (a==id) {
   //              childIdArr.push(jsonArr[i].id)
   //          }
   //      }
   //      return childIdArr;
   //  }
   //
   //  function getChildMenu(aid) {
   //      childStr+="<ul class='dropdown-menu'>";
   //      for (var i = 0; i < jsonArr.length; i++) {
   //          var a=jsonArr[i].pId;
   //          if (a==aid) {
   //              childStr+= '<li><a href='+jsonArr[i].menuUrl+'>'+jsonArr[i].areaName+'</a></li>'
   //          }
   //      }
   //      childStr+="</ul>"
   //  }

</script>
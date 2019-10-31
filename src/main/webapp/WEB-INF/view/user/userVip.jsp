<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <jsp:include page="/common/head.jsp"></jsp:include>
    <title>会员用户展示</title>

</head>
<body>
<jsp:include page="/common/nav-v3.jsp"></jsp:include>
<div class="container">
    <!-- 条件查询 -->
    <div class="row">
        <div class="panel panel-primary">
            <div class="panel-heading">条件查询</div>
            <div class="panel-body">
                <form class="form-horizontal" id="areaSeach">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">会员名称</label>
                        <div class="col-sm-4">
                            <input type="email" class="form-control" id="vip_name" placeholder="请输入用户名...">
                        </div>
                        <label  class="col-sm-2 control-label">真实姓名</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="vip_realName"  placeholder="请输入真实姓名...">
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">用户生日</label>
                        <div class="col-sm-4">
                            <div class="input-group">
                                <input type="text" class="form-control" id="vip_minBirthday">
                                <span class="input-group-addon" ><i class="glyphicon glyphicon-calendar"></i></span>
                                <input type="text" class="form-control" id="vip_maxBirthday">
                            </div>
                        </div>

                    </div>

                    <div class="form-group">
                        <div class="col-sm-12">
                            <div class="form-group" id="selectArea">
                                <label class="control-label col-sm-2">地区：</label>
                            </div>
                        </div>
                    </div>

                    <div style="text-align: center">
                        <button type="button" class="btn btn-primary" onclick="searchArea()"><i class="glyphicon glyphicon-search"></i>查询</button>
                        <button type="reset" class="btn btn-default"><i class="glyphicon glyphicon-refresh"></i>重置</button>
                    </div>
                </form>

            </div>
        </div>
    </div>
    <!--表单展示-->
    <div class="row">
            <div class="panel panel-primary">
                <div class="panel-heading">会员用户展示</div>
                <table id="table" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                    <tr>
                        <th>id</th>
                        <th>用户名</th>
                        <th>真实姓名</th>
                        <th>电话</th>
                        <th>邮箱</th>
                        <th>用户生日</th>
                        <th>地区</th>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/common/script.jsp"></jsp:include>
<script type="text/javascript">
    $(function () {
        initArea(1);
        initTable();
        initDate();
    })

    function initArea(id,obj) {
        if(obj){
            $(obj).parent().nextAll().remove();
        }
        $.ajax({
            url:"/area/queryArea.do",
            data:{
                "id":id
            },
            success:function (result) {
                if(result.code == 200){
                    if(result.data.length == 0){
                        return false;
                    }
                    var v_select = '<div class="col-sm-2"><select class="form-control" name="areaSelect" onchange="initArea(this.value,this)"><option value="-1">==请选择==</option> ';
                    var v_areaArr = result.data;
                    for(var i=0;i<v_areaArr.length;i++){
                        v_select += "<option value='"+v_areaArr[i].id+"' data-categoryname = '"+v_areaArr[i].areaName+"'>"+v_areaArr[i].areaName+"</option>";
                    }
                    v_select += '</select></div>';
                    $("#selectArea").append(v_select);
                }
            }
        })
    }


    function initDate() {
        $('#vip_minBirthday').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-CN',
            showClear: true
        });

        $('#vip_maxBirthday').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-CN',
            showClear: true
        });
    }

    /*条件查询*/
    function searchArea(){
        var v_name = $("#vip_name").val();
        var v_realName = $("#vip_realName").val();
        var v_minBirthday = $("#vip_minBirthday").val();
        var v_maxBirthday = $("#vip_maxBirthday").val();
        var a1 = $($("select[name='areaSelect']",$("#areaSeach"))[0]).val();
        var a2 = $($("select[name='areaSelect']",$("#areaSeach"))[1]).val();
        var a3 = $($("select[name='areaSelect']",$("#areaSeach"))[2]).val();
        var searchJson= {};
        searchJson.name=v_name;
        searchJson.realName = v_realName;
        searchJson.minBirthday = v_minBirthday;
        searchJson.maxBirthday = v_maxBirthday;
        searchJson.a1 = a1;
        searchJson.a2 = a2;
        searchJson.a3 = a3;
        userVipTable.settings()[0].ajax.data=searchJson;
        userVipTable.ajax.reload();
    }


    var userVipTable;
    function initTable() {
        userVipTable =  $("#table").DataTable( {
            "aLengthMenu":[10],//自定义每页展示条数
            "serverSide": true,//开启服务器分页模式
            "searching": false,//是否允许检索
            "language": {
                "url": "/js/DataTables-1.10.18/Chinese.json",
            },
            "ajax":{
                url:"/userVip/queryVipList.do",
            },
            columns: [
                { data: 'id' },
                { data: 'name' },
                { data: 'realName'},
                { data: "phone"},
                { data: "email"},
                { data: "birthday"},
                { data: "clName"}
            ]
        } );
    }
</script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>购机商场管理</title>
    <meta name="decorator" content="base"/>
    <meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />

</head>
<body>
<div class="sfpagebg bk-gray ">
    <div class="sfpage table-header-settable">
        <div class="page-orderWait">
            <div id="tab-system" class="HuiTab">
                <div class="tabBar cl mb-10">
              <sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_SERVICECATE_TAB" html='<a class="btn-tabBar " href="${ctx}/order/category/headerList">服务品类</a> '></sfTags:pagePermission>
		<sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_SERVICEBRAND_TAB" html='<a class="btn-tabBar" href="${ctx}/order/category/siteBrandRelList">服务品牌</a> '></sfTags:pagePermission>
		<sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_MSGORIGIN_TAB" html='<a class="btn-tabBar" href="${ctx}/order/orderOrigin">信息来源</a> '></sfTags:pagePermission>
	<%-- 	<sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_MALTIONTYPE_TAB" html='<a class="btn-tabBar" href="${ctx}/order/malfunction">故障类型</a>'></sfTags:pagePermission>  --%>
			<a class="btn-tabBar" href="${ctx}/order/printdesign">工单打印模板</a>
			<a class="btn-tabBar" href="${ctx}/order/orderMustFill/getMustFillInfo">工单必填项</a>
			<a class="btn-tabBar " href="${ctx}/order/township">乡镇设置</a>
			<sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_MSGMALL_TAB" html='<a class="btn-tabBar current" href="${ctx}/order/orderMall">购机商场</a>'></sfTags:pagePermission>
			 <%-- <a class="btn-tabBar " href="${ctx}/order/siteSuperviseSetting">监督内容</a> --%>
			<a class="btn-tabBar " href="${ctx}/order/serviceType">服务类型</a>
			<a class="btn-tabBar " href="${ctx}/order/serviceMode">服务方式</a> 
			<a class="btn-tabBar " href="${ctx}/order/customerType">用户类型</a>

                </div>
                <div class="tabCon">
                    <form id="searchForm">
                        <input type="hidden" name="page" id="pageNo" value="1">
                        <input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
                   <p class="f-r btnWrap" style='    position: absolute; right: 14px;top: 49px;'>
                        <sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_MSGMALL_PLDELETE_BTN" html='<a href="javascript:;"  onclick="showwxgd()"class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-rubbish"></i>批量删除</a>'></sfTags:pagePermission>
                        <sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_MSGMALL_ADD_BTN" html='<a class="sfbtn sfbtn-opt " id="btn-add" ><i class="sficon sficon-add"></i>添加</a>'></sfTags:pagePermission>
                    </p>
                        <div style='margin-top: 48px;'>
                            <table id="table-waitdispatch" class="table"></table>
                            <!-- pagination -->
                            <div class="cl pt-10">
                                <div class="f-r">
                                    <div class="pagination"></div>
                                </div>
                            </div>
                            <!-- pagination -->
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </div>
</div>


<div class="popupBox porigin editMall" >
    <h2 class="popupHead">
        修改
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer pos-r">
        <div class="popupMain">
            <div class="pcontent" id="originbox" >
                <input type="hidden" id="saveid"/>
                <div class="cl mt-20 ml-15">
                    <label class="f-l w-70"><em class="mark">*</em>商场名称：</label>
                    <input type="text" class="input-text w-140 f-l editelabelname"  />
                    <label class="f-l w-90">排序：</label>
                    <input type="text" class="input-text w-140 f-l editelabelsort" />
                </div>
            </div>
            <div class="text-c mt-15 pt-20 mb-5">
                <a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5"  onclick="save()">保存</a>
                <a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="quxiao()">取消</a>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">

    $('#btn-add').click(function(){
        layer.open({
            type : 2,
            content:'	${ctx}/order/orderMall/form',
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            anim:-1
        })
    });



    var sfGrid;
    var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
    var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部

    $(function(){
        $.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
        $.tabfold("#moresearch",".moreCondition",1,"click");
        initSfGrid();
    });

    //初始化jqGrid表格，传递的参数按照说明
    function initSfGrid(){
        sfGrid = $("#table-waitdispatch").sfGrid({
            url : '${ctx}/order/orderMall/mallList',
            sfHeader: defaultHeader,
            sfSortColumns: sortHeader,
            shrinkToFit: true,
            rownumbers : true,
            gridComplete:function(){
                _order_comm.gridNum();
            }
        });
    }


    function fmtOper(rowData){
        var authFlage = '${fns:checkBtnPermission("SYSSETTLE_ORDERMSGSET_MSGMALL_UPDATE_BTN")}';
        var uphtml = '';
        if(authFlage === 'true'){
            uphtml +="<span><a href=javascript:updateMsg('"+rowData.id+"') class='c-0383dc'><i class='sficon sficon-edit'></i>修改</a></span>"
        }
        return uphtml;
    }

    function updateMsg(id){
        $.ajax({
            type:'POST',
            url:"${ctx}/order/orderMall/getMallByid",
            data:{
                "id":id,
            },
            success:function(data){
                if(data!=null){
                    $("#saveid").val(data.columns.id);
                    $(".editelabelname").val(data.columns.mall_name);
                    $(".editelabelsort").val(data.columns.sort);
                    $('.editMall').popup();
                }else{
                    layer.msg("操作失败请稍后重试");
                    return;
                }
            },
            error:function(){
                layer.alert("系统繁忙!");
                return;
            }
        })
    }
    
    function quxiao() {
        $("#saveid").val("");
        $(".editelabelname").val("");
        $(".editelabelsort").val("");
        $.closeDiv($('.editMall'));
    }


    var saveflag = false
    function save(){
        if(saveflag){
            return
        }
        var id = $("#saveid").val();
        var name = $(".editelabelname").val();
        var sort = $(".editelabelsort").val();
        if(name==""||name==null){
            layer.msg("请填写商场名称");
            return
        }
        if((sort.length!=0)&&(sort.match(/\D/))){
            layer.msg("排序请输入数字");
            return;
        }
        saveflag=true;
        $.ajax({
            type:'POST',
            url:"${ctx}/order/orderMall/update",
            data:{
                "id":id,
                "names":name,
                "sorts":sort,
            },
            success:function(data){
                if(data=="rename"){
                    layer.msg("商场名称已存在");
                    $(".editelabelname").focus;
                    saveflag=false;
                    return;
                }
                if(data=="ok"){
                    layer.msg("修改成功");
                    search();
                    $.closeDiv($('.editMall'));
                } else if(data=="nullname"){
                    layer.msg("请填写购机商场");
                    return;
                } else{
                    layer.msg("操作失败请稍后重试");
                    return;
                }
                $("#saveid").val("");
                $(".editelabelname").val("");
                $(".editelabelsort").val("");
                $.closeDiv($('.editMall'));
                saveflag=false;
            },
            error:function(){
                layer.alert("系统繁忙!");
                return;
            }
        })

    }


    function search(){
        var pageSize = $("#pageSize").val();
        if ($.trim(pageSize) == '' || pageSize == null) {
            $("#pageSize").val(20);
        }
        $("#table-waitdispatch").sfGridSearch({
            postData: $("#searchForm").serializeJson()
        });
    }




    function showwxgd(){
        var idArr=$('#table-waitdispatch').jqGrid('getGridParam','selarrrow');
        if(idArr.length<1){layer.msg("请选择数据！");}else{
            var content = "确认要删除"+idArr.length+"条购机商场？";
            //$("#decategory").val($("#tabswitchCurrent").text());
            //$("#deserviceMeasures").val(_name);

            $('body').popup({
                level:3,
                title:"删除",
                content:content,
                fnConfirm :function(){
                    $.ajax({
                        type:"POST",
                        url:"${ctx}/order/orderMall/deleteMall",
                        traditional: true,
                        data:{
                            "idArr":idArr
                        },
                        //async:false,
                        success:function(data){
                            if(data=="ok"){
                                layer.msg("删除完成!");
                                search();
                            }else{
                                layer.msg("操作失败!",{time:2000});
                            }
                        },
                        error:function(){
                            layer.alert("系统繁忙!");
                            return;
                        }
                    });
                    layer.closeAll('dialog');
                }
            });

        }
    }


/*    $('#btn-add').click(function(){
        var thisTr = $('.table-jd').find('tr.active');
        var index = $(thisTr).children('td').eq(2).children('div').size();
        if (index > 0) {
            var type = $('input:radio[name="chk_trb"]:checked').val();
            $("#serviceMeasures").val(type);
            $("#serviceMeasures").attr("disabled", "disabled");
            isSelectedAdding = true;
        } else {
            isSelectedAdding = false;
            $("#serviceMeasures").val('');
        }
        $('.curMaskbox-tjgzlb').css({
            'left':'50%',
            'margin-left':-parseInt($('.curMaskbox-tjgzlb').outerWidth()/2),
            "top":"50px"
        });
        $('.curMaskbox-tjgzlb').show();
        $(".bottommask").show();
    });*/


/*    $('.btn-xzgz').bind('click', function () {
        var _this = $(this);
        if (_this.hasClass("btn-xzyes")) {
            _this.removeClass("btn-xzyes");
        } else {
            _this.addClass("btn-xzyes");
        }
    });

    $(document).on("click",".btn-xzgz",function(){
        var _this = $(this);
        if (_this.hasClass("btn-xzyes")) {
            _this.removeClass("btn-xzyes");
            _this.parent('.gzyymain').children('.gzyybox').removeClass("del-active");
        } else {
            _this.addClass("btn-xzyes");
            _this.parent('.gzyymain').children('.gzyybox').addClass("del-active");
        }
    });*/





</script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>商品信息管理</title>
    <meta name="decorator" content="base"/>

</head>
<body>
<div class="sfpagebg bk-gray">
    <div class="sfpage table-header-settable">
        <div class="page-orderWait">
            <div id="tab-system" class="HuiTab">
                <div class="tabBar cl mb-10">
                        <a class="btn-tabBar  current" href="${ctx}/order/goodscategory">商品类别设置</a>
                        <a class="btn-tabBar    " href="${ctx }/order/unit">计量单位设置</a>
                        <a class="btn-tabBar" href="${ctx}/order/supplier">供应商设置</a>
                    <p class="f-r btnWrap">
                            <a href="javascript:;"  onclick="showwxgd()"class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>批量删除</a>
                            <a class="sfbtn sfbtn-opt" id="btn-add" >添加</a>
                    </p>
                </div>
                <div class="tabCon">
                    <form id="searchForm">
                        <input type="hidden" name="page" id="pageNo" value="1">
                        <input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
                        <div>
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


<script type="text/javascript">

    $('#btn-add').click(function(){
        layer.open({

            type : 2,
            content:'	${ctx}/order/goodscategory/form',
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            anim:-1
        })
    })



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
            url : '${ctx}/order/goodscategory/goodsCateList',
            /* url : '${ctx}/order/orderType/orderTypeList', */
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
        var editehtml = '';
            return "<a href=javascript:updateMsg('"+rowData.id+"') style='color:blue;'>修改</a>";//system权限
        return editehtml;
    }
    function updateMsg(id){
        layer.open({
            type : 2,
            content:'${ctx}/order/goodscategory/edite?id='+id,
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            anim:-1
        })
        //var = "<a href=${ctx}/order/orderOrigin/edite?id="+rowData.id+">";

    }

    function search(){
        var pageSize = $("#pageSize").val();
        if ($.trim(pageSize) == '' || pageSize == null) {
            $("#pageSize").val(20);
        }
        $("#table-waitdispatch").sfGridSearch($("#searchForm").serializeJson());
    }




    function showwxgd(){
        var idArr=$('#table-waitdispatch').jqGrid('getGridParam','selarrrow');
        if(idArr.length<1){layer.msg("请选择数据！");}else{
            var content = "确认要删除"+idArr.length+"条商品类别？";
            //$("#decategory").val($("#tabswitchCurrent").text());
            //$("#deserviceMeasures").val(_name);
            $('body').popup({
                level:3,
                title:"删除",
                content:content,
                fnConfirm :function(){
                    $.ajax({
                        type:"POST",
                        url:"${ctx}/order/goodscategory/deletegoodsCate",
                        traditional: true,
                        data:{
                            "idArr":idArr
                        },
                        async:false,
                        success:function(data){
                            if(data){
                                layer.msg("删除完成!",{time:2000});
                                window.location.reload(true);
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
            })



        }
    }

    $('#btn-add').click(function(){
//	if (!editable) {
//		return;
//	}
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
    });


    $('.btn-xzgz').bind('click', function () {
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
    });





</script>
</body>
</html>
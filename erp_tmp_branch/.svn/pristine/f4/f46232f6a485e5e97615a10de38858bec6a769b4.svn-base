<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>厂家结算录入</title>
	<meta name="decorator" content="base"/>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/>
	<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script>
	
</head>
<body>
<div class="sfpagebg bk-gray">
<div class="sfpage table-header-settable">
<div class="page-orderWait">
	<div class="tabBar cl mb-10">
	<sfTags:pagePermission authFlag="FINANCEMGM_SEQ_TAB" html='<a class="btn-tabBar " href="${ctx}/finance/balanceManager/balance">收支流水明细</a>'></sfTags:pagePermission>
		<sfTags:pagePermission authFlag="FINANCEMGM_FACTORYSETTLE_FACTORYSETTLE_TAB" html='<a class="btn-tabBar current"  href="${ctx }/finance/factorysettle">400结算录入</a>'></sfTags:pagePermission>
		<p class="f-r btnWrap">
		
			<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
		</p>
	</div>
	
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
				<div class="bk-gray pt-10 pb-5">
					<table class="table table-search">
						<tr>
							<th style="width: 76px" class="text-r">厂家：</th>
							<td>
								<input type="text" class="input-text" name= "vendorid"/>		
							</td>
						</tr>
					</table>
				</div>
				<div class="mt-10">
					<sfTags:pagePermission authFlag="FINANCEMGM_FACTORYSETTLE_FACTORYSETTLE_ADD_BTN" html='<a class="sfbtn sfbtn-opt" id="btn-add"  onclick="openadd()"><i class="sficon sficon-add"></i>添加</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="FINANCEMGM_FACTORYSETTLE_FACTORYSETTLE_PLDELETE_BTN" html='<a href="javascript:;"  onclick="showwxgd()"class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-rubbish"></i>批量删除</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="FINANCEMGM_FACTORYSETTLE_FACTORYSETTLE_EDITE_BTN" html='<a class="sfbtn sfbtn-opt" id="btn-edite"  onclick="openedite()"><i class="sficon sficon-edit2"></i>修改</a>'></sfTags:pagePermission>
				</div>
				<div class="mt-10">
					<table id="table-waitdispatch" class="table">
					
					</table>
		
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




<div class="popupBox addcjlrbox tjmb" style="z-index:101;">
	<h2 class="popupHead">
		新增
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<div class="popupMain pd-15">
			<div class="mb-10 cl">
				<label class="w-140 text-r f-l" >厂家：</label>
				<span class="w-140">
					<select class="select easyui-combobox"  id="tjvendorid"  name="tjvendorid" style="width:100%;height:25px" panelMaxHeight="300px">
						<c:forEach items="${vendornamelist }" var="vendor">
                    	   <option value="${vendor.columns.name }">${vendor.columns.name }</option>
                    	</c:forEach>
					</select>
				</span>
				<!-- <select class="select w-140 f-l  tjvendorid" name="tjvendorid" id="tjvendorid">
					<option value="">请选择</option>
				</select> -->
			</div>
			<div class="mb-10 cl">
				<label class="w-140 text-r f-l">年份：</label>
				<input type="text" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'yyyy'})" id="datemin" name="datemin" class="input-text Wdate w-140  f-l tjyear">
			</div>
			<div class="mb-10 cl">
				<label class="w-140 text-r f-l">月份：</label>
				<select class="select w-140 f-l  tjmonth" id="tjmonths" name="tjmonth">
					<option value="1">1月</option>
					<option value="2">2月</option>
					<option value="3">3月</option>
					<option value="4">4月</option>
					<option value="5">5月</option>
					<option value="6">6月</option>
					<option value="7">7月</option>
					<option value="8">8月</option>
					<option value="9">9月</option>
					<option value="10">10月</option>
					<option value="11">11月</option>
					<option value="12">12月</option>
				</select>
			</div>
			<div class="mb-10 cl">
				<label class="w-140 text-r f-l">结算金额：</label>
				<div class="priceWrap w-140 f-l">
					<input type="text" class="input-text tjmoney" />
					<span class="unit">元</span>
				</div>
			</div>
			<div class="mb-10 cl">
				<label class="w-140 text-r f-l">备注：</label>
				<div class="w-140 f-l">
					<input type="text" class="input-text tjremark" maxlength="100"/>
				</div>
			</div>
			<div class="text-c mt-15">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" id="btnSubmitsave">保存</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" id="guanbisave">取消</a>
			</div>
		</div>
	</div>
</div>




<div class="popupBox addcjlrbox xgmb" style="z-index:101;">
	<h2 class="popupHead">
		修改
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<div class="popupMain pd-15">
			<div class="mb-10 cl">
			<input type="hidden" id="ids"/>
				<label class="w-140 text-r f-l" >厂家：</label>
				<span class="w-140">
					<select class="select easyui-combobox"  id="xgvendorid"   name="xgvendorid" style="width:100%;height:25px" panelMaxHeight="300px">
						<c:forEach items="${vendornamelist }" var="vendor">
                    	   <option value="${vendor.columns.name }">${vendor.columns.name }</option>
                    	</c:forEach>
					</select>
				</span>
			</div>
			<div class="mb-10 cl">
				<label class="w-140 text-r f-l">年份：</label>
				<input type="text" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'yyyy'})" id="datemin" name="datemin" class="input-text Wdate w-140  f-l xgyear">
			</div>
			<div class="mb-10 cl">
				<label class="w-140 text-r f-l">月份：</label>
				<select class="select w-140 f-l  xgmonth" name="xgmonth">
					<option value="1">1月</option>
					<option value="2">2月</option>
					<option value="3">3月</option>
					<option value="4">4月</option>
					<option value="5">5月</option>
					<option value="6">6月</option>
					<option value="7">7月</option>
					<option value="8">8月</option>
					<option value="9">9月</option>
					<option value="10">10月</option>
					<option value="11">11月</option>
					<option value="12">12月</option>
				</select>
			</div>
			<div class="mb-10 cl">
				<label class="w-140 text-r f-l">结算金额：</label>
				<div class="priceWrap w-140 f-l">
					<input type="text" class="input-text xgmoney" />
					<span class="unit">元</span>
				</div>
			</div>
			<div class="mb-10 cl">
				<label class="w-140 text-r f-l">备注：</label>
				<div class="w-140 f-l">
					<input type="text" class="input-text xgremark" maxlength="100"/>
				</div>
			</div>
			<div class="text-c mt-15">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" id="btnSubmitedite">保存</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" id="guanbiedite">取消</a>
			</div>
		</div>
	</div>
</div>

<div class="popupBox w-320 vipPromptBox">
	<h2 class="popupHead">
		提示
	</h2>
	<div class="popupContainer">
		<div class="popupMain text-c pt-30 pb-20">
			<div class="">
				<i class="iconType iconType2"></i>
				<strong class="f-16">VIP会员功能</strong>
			</div>
			<p class="c-666 lh-26">
				抱歉，此功能需要<span class="c-bb3906">开通VIP会员</span>后才能使用！
			</p>
			<div class="text-c mt-30">
				<%-- <a  href="#" onclick="jumpToVIP();return false;" class="sfbtn sfbtn-opt3 w-100">开通VIP会员</a>--%>
				<span class="sfbtn sfbtn-opt3 w-100" onclick="jumpToVIP();">开通VIP会员</span>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">
var sfGrid;
var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部

$(function(){
	$.tabfold("#moresearch",".moreCondition",1,"click");
	initSfGrid();
});

//初始化jqGrid表格，传递的参数按照说明
function initSfGrid(){
	sfGrid = $("#table-waitdispatch").sfGrid({
		url : '${ctx}/finance/factorysettle/factorysettlelist', 
		sfHeader: defaultHeader,
		sfSortColumns: sortHeader,
		shrinkToFit: true,
		rownumbers : true,
		gridComplete:function(){
			_order_comm.gridNum();
		},
		loadComplete: function(data){
		var sum=$("#table-waitdispatch").getCol("money",false,"sum");
		if(sum) {
		    sum = parseFloat(sum);
		    if (!isNaN(sum)) {
		        sum = sum.toFixed(2);
			} else {
		        sum = '----';
			}
		}
		$("#table-waitdispatch").addRowData("1", {"factory_id":"合计","year":"----","month":"----","money":sum}, "last");
		$("#1").find("td").eq(1).addClass("hide");
		$("#1").find("td").eq(2).attr("colspan","2");
		/* var rowData = $("#grid_selector").jqGrid('getRowData',rowid);  
        if(...) { */
            /* $("#table-waitdispatch").jqGrid("waitdispatch", "1",false);//设置该行不能被选中。  
            layer.msg('提示信息'); *///提示信息  
        //}  
		},
		onSelectRow:function(id)//选择某行时触发事件
		   {
			//var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
		     var curRowData = jQuery("#table-waitdispatch").jqGrid('getRowData', id);
		     if(id=='1'){
		    	 $("#table-waitdispatch").jqGrid("setSelection", id,false);
		     }
		   }
	});
}

function openadd(){//打开添加弹出框
	$('.tjmb').popup();
}

$('#btnSubmitsave').click(function () {//提交添加信息
    var vendorid = $('#tjvendorid').combobox('getValues');
    var year = $('.tjyear').val();
    var month = $('.tjmonth').val();
    var money = $('.tjmoney').val();
    var remark = $(".tjremark").val();

    if (!vendorid) {
        layer.msg("请选择厂商");
        return;
    }
    if (!money.match(/^[0-9]+([.]{1}[0-9]+){0,1}$/)) {
        layer.msg("金额请输入小数或整数");
        return;
    }
    if (year.match(/\D/)) {
        layer.msg("年份请输入数字");
        return;
    }

    $.ajax({
        type: 'POST',
        url: "${ctx}/finance/factorysettle/addfactorysettle",
        traditional: true,
        data: {
            "vendorid": vendorid,
            "year": year,
            "month": month,
            "money": money,
			"remark": remark
        },
        success: function (data) {
            $.closeDiv($(".tjmb"));
            parent.layer.msg("添加成功！");
            seretss();
            search();
        },
        error: function () {
            layer.alert("系统繁忙!");
            return;
        }

    });

});

function seretss(){
	$("#tjvendorid").combobox('clear');
    $("#tjmonths").val('');
    $("#datemin").val('');
    $(".tjmoney").val('');
    $(".tjremark").val('');
}

function openedite() {
    //打开修改弹出框
    var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
    if (idArr.length < 1) {
        layer.msg("请选择数据");
        return;
    } else if (idArr.length > 1) {
        layer.msg("选择数据不能大于1")
    } else {
        var id = idArr[0];
        $.ajax({
            type: 'POST',
            url: "${ctx}/finance/factorysettle/getfactorysettlebyid",
            traditional: true,
            data: {
                "id": id
            },
            success: function (factorySettle) {
                $('#ids').val(factorySettle.columns.id);
                $('.xgvendorid').val(factorySettle.columns.factory_id);
                $('#xgvendorid').combobox('setValue',factorySettle.columns.factory_id);
                $('.xgyear').val(factorySettle.columns.year);
                $('.xgmonth').val(factorySettle.columns.month);
                $('.xgmoney').val(factorySettle.columns.money);
                $('.xgremark').val(factorySettle.columns.remark);
                $('.xgmb').popup();

            }
        });
    }
}

$('#btnSubmitedite').click(function () {
    var id = $('#ids').val();
    var vendorid = $('#xgvendorid').combobox('getValues');
    var year = $('.xgyear').val();
    var month = $('.xgmonth').val();
    var money = $('.xgmoney').val();
    var remark = $('.xgremark').val();
    if (!vendorid) {
        layer.msg("请选择厂商");
        return;
    }
    if (!money.match(/^[0-9]+([.]{1}[0-9]+){0,1}$/)) {
        layer.msg("金额请输入小数或整数");
        return;
    }
    if (year.match(/\D/)) {
        layer.msg("年份请输入数字");
        return;
    }

    $.ajax({
        type: 'POST',
        url: "${ctx}/finance/factorysettle/updatefactorysettle",
        traditional: true,
        data: {
            "id": id,
            "vendorid": vendorid,
            "year": year,
            "month": month,
            "money": money,
			"remark": remark
        },
        success: function (data) {
            $.closeDiv($(".xgmb"));
            parent.layer.msg("修改成功！");
            search();
        },
        error: function () {
            layer.alert("系统繁忙!");
            return;
        }

    })

});

$('#guanbisave').on('click', function() {
	$("#tjvendorid").combobox('clear');
	$.closeDiv($('.tjmb'));
});
$('#guanbiedite').on('click',function(){
	$.closeDiv($('.xgmb'));
});


function showwxgd() {
    var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
    if (idArr.length < 1) {
        layer.msg("请选择数据！");
    } else {
        var content = "确认要删除" + idArr.length + "条厂家结算数据？";
        $('body').popup({
            level: 3,
            title: "删除",
            content: content,
            fnConfirm: function () {
                $.ajax({
                    type: "POST",
                    url: "${ctx}/finance/factorysettle/deletefactorysettle",
                    traditional: true,
                    data: {
                        "idArr": idArr
                    },
                    async: false,
                    success: function (data) {
                        if (data) {
                            layer.msg("删除完成!", {time: 2000});
                            //window.location.reload(true);
                            search();
                        } else {
                            layer.msg("操作失败!", {time: 2000});
                        }
                    },
                    error: function () {
                        layer.alert("系统繁忙!");
                        return;
                    }
                });
                layer.closeAll('dialog');
            }
        });
    }
}

function search() {
    var pageSize = $("#pageSize").val();
    if ($.trim(pageSize) == '' || pageSize == null) {
        $("#pageSize").val(20);
    }
    $("#table-waitdispatch").sfGridSearch({
        postData: $("#searchForm").serializeJson()
    });

}

function jumpToVIP() {
    layer.open({
        type: 2,
        content: '${ctx}/goods/sitePlatformGoods/jumpVIP',
        title: false,
        area: ['100%', '100%'],
        closeBtn: 0,
        shade: 0,
        anim: -1
    });
}

</script>
</body>
</html>
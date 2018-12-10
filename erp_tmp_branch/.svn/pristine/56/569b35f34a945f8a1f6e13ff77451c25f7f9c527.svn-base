<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
  <head>
    
    <meta name="decorator" content="base"/>
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script> 
  </head>
  
  <body>
    <div class="sfpagebg">
	<div class="sfpage bk-gray table-header-settable">
	<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
			<sfTags:pagePermission authFlag="FINANCEMGM_SITEREVENUEDETAIL_GOODSORDERDETAILED_TAB" html='<a class="btn-tabBar" href="${ctx}/finance/revenue/goods">商品订单明细</a>'></sfTags:pagePermission>
		<sfTags:pagePermission authFlag="FINANCEMGM_SITEREVENUEDETAIL_GOODSSALESCOMMISSION_TAB" html='<a class="btn-tabBar current" href="${ctx}/finance/revenue/toEmployeGoodsDetail">销售提成明细</a>'></sfTags:pagePermission>
			
			<p class="f-r btnWrap">
				<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
			</p>
		</div>
		<div class="">
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
				<div class="bk-gray pt-10 pb-5">
				<input type="hidden" name="siteId" id="siteId" value="${siteId }"> 
					<table class="table table-search">
						<tr>
						
							<th style="width: 76px;" class="text-r">销售人员：</th>
							<td>
								<span class=" f-l w-120">
								<select class="select f-l w-120" name="employeName" id="employeName">
									<option value="">请选择</option>
									<c:forEach items="${empList }" var="el">
										<option value="${el.columns.name }" <c:if test="${map1.employeName==el.columns.name }">selected="selected"</c:if>>${el.columns.name }</option>
									</c:forEach> 
								</select>
								</span> 
							</td>
							<th style="width: 76px;" class="text-r">零售时间：</th>
							<td colspan="2">
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'createTimeMax\')||\'%y-%M-%d\'}'})" id="createTimeMin" name="createTimeMin"  class="input-text Wdate w-120" style="width:120px">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'createTimeMin\')}',maxDate:'%y-%M-%d'})" id="createTimeMax" name="createTimeMax" value="" class="input-text Wdate w-120" style="width:120px">
							</td>
							<th style="width: 76px;" class="text-r">收款时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'confirmTimeTimeMax\')||\'%y-%M-%d\'}'})" id="confirmTimeTimeMin" name="confirmTimeTimeMin" class="input-text Wdate w-120" style="width:120px">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'confirmTimeTimeMin\')}',maxDate:'%y-%M-%d'})" id="confirmTimeTimeMax" name="confirmTimeTimeMax" value="" class="input-text Wdate w-120" style="width:120px">
							</td>
							
						</tr>
						<tr>
							<th style="width: 76px;" class="text-r">出库时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'outstockTimeMax\')||\'%y-%M-%d\'}'})" id="outstockTimeMin" name="outstockTimeMin" class="input-text Wdate w-120" style="width:120px">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'outstockTimeMin\')}',maxDate:'%y-%M-%d'})" id="outstockTimeMax" name="outstockTimeMax" value="" class="input-text Wdate w-120" style="width:120px">
							</td>
						</tr>
					</table>
				</div>
			</form>
			<div class="pt-10 pb-5 cl">
				<div class="f-l">
					<a class="radiobox radiobox-selected mr-15" onclick="huizong1()"  >提成明细</a>
					<a class="radiobox"  onclick="huizong()" >汇总</a>
				</div>
				<div class="f-r">
				<sfTags:pagePermission authFlag="FINANCEMGM_SITEREVENUEDETAIL_GOODSSALE_EXPORT_BTN" html='<a  onclick="return exports()" class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
				</div>
			</div>
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
		</div>
	</div>
</div>

</div>
</div>
<script type="text/javascript">
var sfGrid;
var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部
$(function(){
	
	initTableH();
	initSfGrid();
	$.setPos($('.gcsjsmxhzWrap'));
	
	$('#employeName').select2();
	$(".selection").css("width","120px");
	
/* 	window.onresize = function(){
		$("#table-waitdispatch").setGridWidth(950);
		$("#table-waitdispatch").setGridHeight(400);
	} */
	
})

function huizong(){
	window.location.href="${ctx}/finance/revenue/employeCostGoodsAll?map="+$("#searchForm").serialize();
	$('#Hui-article-box',window.top.document).css({'z-index':'9'});
}

function huizong1(){
	window.location.href="${ctx}/finance/revenue/toEmployeGoodsDetail?map="+$("#searchForm").serialize();
	$('#Hui-article-box',window.top.document).css({'z-index':'9'});
}

//初始化jqGrid表格，传递的参数按照说明
function initSfGrid(){
	var url = "${ctx}/finance/revenue/toEmployeGoodsDetailGrid";
	sfGrid = $("#table-waitdispatch").sfGrid({
		url:url, 
		sfHeader:defaultHeader,
		sfSortColumns:sortHeader,
		postData:$("#searchForm").serializeJson(),
		multiselect: false,
		width:950,
		height:350,
		rownumbers : true,
		gridComplete:function(){
			_order_comm.gridNum();
		}
	});
}


	function search() {
		var pageSize = $("#pageSize").val();
		if ($.trim(pageSize) == '' || pageSize == null) {
			$("#pageSize").val(20);
		}
		$("#table-waitdispatch").sfGridSearch({
			postData : $("#searchForm").serializeJson()
		});
	}

	function initTableH() {
		var h2 = $('#boxWrapTable table').height();
		if (h2 > 470) {
			$('#boxWrapHead').css({
				'padding-right' : '17px'
			});
		}
	}

	//保修类型
	function protectType(row) {
		if (row.warranty_type == '1') {
			return "保内";
		} else if (row.warranty_type == '2') {
			return "保外";
		} else if (row.warranty_type == '3') {
			return "保外转保内";
		} else {
			return "---";
		}
	}

	function reset() {
		$("#endTimeMin").val('');
		$("#endTimeMax").val('');
		$("#settlementTimeMin").val('');
		$("#settlementTimeMax").val('');
	}

	function toCostAll() {
		//$.closeDiv($(".gcsjsmxhzWrap"));
		layer.open({
			type : 2,
			content : '${ctx}/finance/revenue/toCostAll',
			title : false,
			area : [ '100%', '100%' ],
			closeBtn : 0,
			shade : 0,
			anim : -1
		});

	}

	function exports() {
		var idArr = $("#table-waitdispatch").jqGrid('getGridParam', 'records')
		var content = "共" + idArr + "条数据，本次允许导出前10000条，确定继续导出吗？";
		if (idArr > 10000) {
			$('body')
					.popup(
							{
								level : 3,
								title : "导出",
								content : content,
								fnConfirm : function() {
									location.href = "${ctx}/finance/revenue/employeGoodsDetailExport?formPath=/a/finance/revenue/toEmployeGoodsDetail&&maps="
											+ $("#searchForm").serialize();
								}
							});
		} else {
			location.href = "${ctx}/finance/revenue/employeGoodsDetailExport?formPath=/a/finance/revenue/toEmployeGoodsDetail&&maps="
					+ $("#searchForm").serialize();
		}

	}

	function ifPay(rowData) {
		if (rowData.confirm_time != null && $.trim(rowData.confirm_time) != "") {
			return "是";
		}
		return "否";
	}

	function ifOutstocks(rowData) {
		if (rowData.outstock_time != null
				&& $.trim(rowData.outstock_time) != "") {
			return "是";
		}
		return "否";
	}
</script>
  </body>
</html>
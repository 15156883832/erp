<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
  <head>
    
    <meta name="decorator" content="base"/>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script> 
  </head>
  
  <body>
  <div class="popupBox gcsjsmxhzWrap ceshiyixia">
	<h2 class="popupHead">
		提成明细
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pd-15" >
		<form action="" id="searchForm" method="post">
		<input type="hidden" name="page" id="pageNo" value="1">
		<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
			<div class="cl mb-10">
				<label class="f-l w-100 text-r">&#12288;&#12288;&#12288;销售人员：</label>
				<span class=" f-l w-120">
				<select class="select f-l w-120" name="employeName" id="employeName">
					<option value="">请选择</option>
					<c:forEach items="${empList }" var="el">
						<option value="${el.columns.salesman }" <c:if test="${map1.employeName==el.columns.salesman }">selected="selected"</c:if>>${el.columns.salesman }</option>
					</c:forEach> 
				</select>
				</span> 
				
				<label class="f-l w-100 text-r">商品名称：</label>
				<input type="text"  id="goodName" name="goodName" value="${map1.goodName }" class="input-text  f-l w-120" >
				
				<label class="f-l w-100 text-r">零售时间：</label>
				<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'createTimeMax\')||\'%y-%M-%d\'}'})" id="createTimeTimeMin" name="createTimeMin" value="${map1.createTimeMin }" class="input-text Wdate f-l w-120" style="width:120px">
				<span class="pd-5 f-l"> 至</span>
				<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'createTimeMin\')}',maxDate:'%y-%M-%d'})" id="createTimeMax" name="createTimeMax" value="${map1.createTimeMax }" class="input-text Wdate f-l w-120" style="width:120px">
			</div>
			<div class="cl mb-10">
				<label class="f-l w-100 text-r">收款时间：</label>
				<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'confirmTimeTimeMax\')||\'%y-%M-%d\'}'})" id="confirmTimeTimeMin" name="confirmTimeTimeMin" value="${map1.confirmTimeTimeMin }" class="input-text Wdate f-l w-120" style="width:120px">
				<span class="pd-5 f-l"> 至</span>
				<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'confirmTimeTimeMin\')}',maxDate:'%y-%M-%d'})" id="confirmTimeTimeMax" name="confirmTimeTimeMax" value="${map1.confirmTimeTimeMax }" class="input-text Wdate f-l w-120" style="width:120px">
				
				<label class="f-l w-100 text-r" style="margin-left: 78px">出库时间：</label>
				<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'outstockTimeMax\')||\'%y-%M-%d\'}'})" id="outstockTimeMin" name="outstockTimeMin" value="${map1.outstockTimeMin }" class="input-text Wdate f-l w-120" style="width:120px">
				<span class="pd-5 f-l"> 至</span>
				<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'outstockTimeMin\')}',maxDate:'%y-%M-%d'})" id="outstockTimeMax" name="outstockTimeMax" value="${map1.outstockTimeMax }" class="input-text Wdate f-l w-120" style="width:120px">
			</div>
			
		</form>
			<div class="mt-15" id="gcsjsmx">
				<div class="tabBarP2 mb-15">
					<a class="radiobox radiobox-selected mr-15" onclick="huizong1()"  >提成明细</a>
					<a class="radiobox"  onclick="huizong()" >汇总</a>
					
					<a class="sfbtn sfbtn-opt w-70 f-r ml-10" target="_blank" onclick="return exports()"><i class="sficon sficon-export"></i>导出</a> 
					<a class="sfbtn sfbtn-opt w-70 f-r ml-10" href="javascript:search();"><i class="sficon sficon-search"></i>查询</a>
					<!-- <a href="javascript:reset();" class="sfbtn sfbtn-opt w-70 f-r ml-10" id="reset"><i class="sficon sficon-reset"></i>重置</a> -->
				</div>
				
				<div >
					<table class="table" id="table-waitdispatch">
						<!-- 明细的表格 -->
					</table>
				</div>
				<div class="cl mt-10">
					<!-- 分页 -->
					<div class="pagination"></div>
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
	
	window.onresize = function(){
		$("#table-waitdispatch").setGridWidth(950);
		$("#table-waitdispatch").setGridHeight(400);
	}
	
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
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品信息管理</title>
	<meta name="decorator" content="base"/>
	
</head>
<body>
	<div class="sfpagebg bk-gray"><div class="sfpage">
		<div class="page-orderWait">
			<div id="tab-system" class="HuiTab">
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
			<sfTags:pagePermission authFlag="NEWSITESETTLE_NEWFAPIAOAPPLYSET_TEEDEFINEDSET_TAB" html='<a class="btn-tabBar  current" href="${ctx}/order/distribution">配送信息记录</a>'></sfTags:pagePermission>
		<p class="f-r btnWrap">
			
			<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
		</p>
		</div>
		<div class="tabCon">
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
				<div class="bk-gray pt-10 pb-5">
					<table class="table table-search">
						<tr>
							<th style="width: 76px;" class="text-r">配送单号：</th>
							<td>
								<input type="text" class="input-text" name="distribution_number" id="distribution_number"/>
							</td>
							<th  style="width: 76px;" class="text-r">工单编号：</th>
							<td >
								<input type="text" class="input-text"  name="order_number" id="order_number"/>
							</td>
							<th  style="width: 76px;" class="text-r">车牌号码：</th>
							<td >
								<input type="text" class="input-text"  name="plate_number" id="plate_number"/>
							</td>
							<th  style="width: 76px;" class="text-r">配送人员：</th>
							<td >
								<input type="text" class="input-text"  name="driver_name" id="driver_name"/>
							</td>
							<th  style="width: 76px;" class="text-r">用户姓名：</th>
							<td >
								<input type="text" class="input-text"  name="customer_name" id="customer_name"/>
							</td>
						</tr>
						<tr>
							<th style="width: 76px;" class="text-r">用户电话：</th>
							<td>
								<input type="text" class="input-text" name="customer_mobile" id="customer_mobile"/>
							</td>
							<th  style="width: 76px;" class="text-r">配送日期：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'distributionTimeMax\')||\'%y-%M-%d\'}'})" id="distributionTimeMin" name="distributionTimeMin"  value="" class="input-text Wdate w-140" style="width:140px">
								至
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'distributionTimeMin\')}',maxDate:'%y-%M-%d'})" id="distributionTimeMax" name="distributionTimeMax"  value="" class="input-text Wdate w-140" style="width:140px">
							</td>
						</tr>
					</table>
				</div>
			</form>
				<div class="pt-10 pb-5 cl">

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
</div>


<script type="text/javascript">


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
		url : '${ctx}/order/distribution/distributionList', 
		sfHeader: defaultHeader,
		sfSortColumns: sortHeader,
		shrinkToFit: true,
		rownumbers : true,
		multiselect: false,
 		gridComplete:function(){
 			_order_comm.gridNum();
 		}
	});
}


function fmtOper(rowData){	
	var authFlage = '${fns:checkBtnPermission("NEWSITESETTLE_NEWFAPIAOAPPLYSET_TEEDEFINEDSET_EDIT_BTN")}';
	var editehtml = '';
	if(authFlage === 'true'){
		editehtml += "<span><a href=javascript:deleteVehicle('"+rowData.id+"') class='c-0383dc'><i class='sficon sficon-del'></i>删除</a></span>"
	}
	
	return editehtml;	
}


function search(){
	var pageSize = $("#pageSize").val();
	if ($.trim(pageSize) == '' || pageSize == null) {
		$("#pageSize").val(20);
	}
	$("#table-waitdispatch").sfGridSearch({
		postData : $("#searchForm").serializeJson()
	});
}


</script>
</body>
</html>
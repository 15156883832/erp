<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
  <head>
    <title>orderType管理</title>
    <meta name="decorator" content="base"/>
  </head>
  
  <body>
  		<div class="sfpagebg">
<div class="sfpage bk-gray table-header-settable">
<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
			<a class="btn-tabBar current">全部工单<sup>10</sup></a>
			<a class="btn-tabBar">暂不派工<sup>10</sup></a>
			<a class="btn-tabBar">拒接工单<sup>10</sup></a>
			<p class="f-r btnWrap">
				<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt moresearch" id="moresearch" ><i class="sficon sficon-moresearch"></i>更多查询</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
				<a href="${ctx}/order/orderType/form" class="sfbtn sfbtn-opt"><i class="sficon sficon-reset"></i>添加</a>
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
		url : '${ctx}/order/orderType/orderTypeList',
		sfHeader: defaultHeader,
		sfSortColumns: sortHeader,
		rownumbers : true,
 		gridComplete:function(){
 			_order_comm.gridNum();
 		}
	});
}

function fmtOper(rowData){
		//return "<span><a href=${ctx}/order/orderType/form?id="+rowData.id+">修改</a></span><span><a href=${ctx}/order/orderType/delete?id="+rowData.id+">删除</a></span>";
		return "<span><a href=${ctx}/order/orderType/form?id="+rowData.id+">修改</a></span><span><a href=${ctx}/order/orderType/delete?id="+rowData.id+">删除</a></span>";
}

function search(){
	var pageSize = $("#pageSize").val();
	if ($.trim(pageSize) == '' || pageSize == null) {
		$("#pageSize").val(20);
	}
    $("#table-waitdispatch").sfGridSearch($("#searchForm").serializeJson());
}

</script>
  </body>
</html>

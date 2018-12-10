<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
  <head>
    
    <meta name="decorator" content="base"/>
    <script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
    								<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script> 
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <div class="sfpagebg">
	<div class="sfpage bk-gray table-header-settable">
	<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
		<a class="btn-tabBar " href="${ctx }/goods/nanDao/sysOrder">南岛订单</a>
		<sfTags:pagePermission authFlag="SYSTEM_AUTH_NANDAO_SITERANT_TAB" html='<a class="btn-tabBar current" href="${ctx}/statistic/siteRankList">网点排名</a>'/>
		<sfTags:pagePermission authFlag="SYSTEM_AUTH_NANDAO_SITEANALYSIS_TAB" html='<a class="btn-tabBar " href="${ctx}/statistic/siteLoubaoList">统计分析</a>'/>
			<p class="f-r btnWrap">
			<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:jsClearForm();;" class="sfbtn sfbtn-opt"><i class="sficon sficon-reset"></i>重置</a>
			</p>
		</div>
			
		<div class="tabCon">
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
					<div class="bk-gray pt-10 pb-5">
						<table class="table table-search">
							<tr>
								<th style="width: 76px;" class="text-r">网点名称：</th>
								<td><input type="text" class="input-text" name="siteName" />
								</td>
							</tr>
						</table>
					</div>
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
	var url = "${ctx}/statistic/siteRankData";
	sfGrid = $("#table-waitdispatch").sfGrid({
		url:url,
		sfHeader:[{name : 'siteName',index: 'siteName',label : '网点名称',align:'center'},{name : 'cs',index: 'cs',label : '漏保购买次数',align:'center'},{name : 'zs',label : '漏保购买总数量',index: 'zs',align:'center'}],
		shrinkToFit:true,
		multiselect: false,
		rownumbers : true,
 		gridComplete:function(){
 			_order_comm.gridNum();
 		}
	});
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

</script>
  </body>
</html>
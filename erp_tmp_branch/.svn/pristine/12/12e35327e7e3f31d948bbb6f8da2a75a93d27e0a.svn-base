<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<title>全部工单</title>
<meta name="decorator" content="base"/>
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
</head>
<body>
<div class="sfpagebg bk-gray">
<div class="sfpage table-header-settable">
<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
			<a class="btn-tabBar current"  href="${ctx }/goods/platFormOrder/msgHeaderList">短信销售记录</a>
			<a class="btn-tabBar "  href="${ctx }/goods/platFormOrder/msgHeaderListerror">未支付短信订单</a>
			<p class="f-r btnWrap">
				<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
			</p>
		</div>
		<div class="tabCon">
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
				<div class="bk-gray pt-10 pb-5">
					<table class="table table-search">
						<tr>
							<th style="width: 76px;" class="text-r">服务商名称：</th>
							<td>
								<input type="text" class="input-text"  name = "siteName"/>
							</td>
							<th style="width: 76px;" class="text-r">付款时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'paymentTime1\')||\'%y-%M-%d\'}'})"  id=paymentTime name="paymentTime"  class="input-text Wdate w-120" style="width:120px">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'paymentTime\')}',maxDate:'%y-%M-%d'})" id="paymentTime1" name="paymentTime1"   class="input-text Wdate w-120" style="width:120px">
							</td>
						</tr>
					</table>
				</div>
			</form>
			
			<div class="pt-10 pb-5 cl">
				<div class="f-r">
		<a class="sfbtn sfbtn-opt" target="_blank" onclick="return exports()"><i class="sficon sficon-export"></i>导出</a>
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

<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef"></script>
<script type="text/javascript">
	
var id = '${headerData.id}';						//服务商表格的ID
var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部
var defaultId = '${headerData.defaultId}';			//系统表格的ID
var rId;
var ifFk;
var ifSuccess;

$(function(){

 	$.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
	$.tabfold("#moresearch",".moreCondition",1,"click");
	
	initSfGrid(); 
	
});

function search(){
	var pageSize = $("#pageSize").val();
	if ($.trim(pageSize) == '' || pageSize == null) {
		$("#pageSize").val(20);
	}
    $("#table-waitdispatch").sfGridSearch({
        postData: $("#searchForm").serializeJson()
    });
}

function initSfGrid(){
	$("#table-waitdispatch").sfGrid({
		url : '${ctx}/goods/platFormOrder/msgGrid',
		sfHeader: defaultHeader,
		sfSortColumns: sortHeader,
		shrinkToFit: true,
		rownumbers : true,
		gridComplete:function(){
			_order_comm.gridNum();
		}
	});
} 

function detail(rowData){
	return "<span ><a class='c-0383dc'>"+rowData.number+"</a></span>";
}

function exports(){
	var idArr=$("#table-waitdispatch").jqGrid('getGridParam','records')
	var content="共"+idArr+"条数据，本次允许导出前10000条，确定继续导出吗？";
	if(idArr>10000){
		$('body').popup({
			level:3,
			title:"导出",
			content:content,
			 fnConfirm :function(){
				 location.href="${ctx}/goods/platFormOrder/export1?formPath=/a/goods/platFormOrder/msgHeaderList&&maps="+$("#searchForm").serialize(); 
			 }
		});
	}else{
		 location.href="${ctx}/goods/platFormOrder/export1?formPath=/a/goods/platFormOrder/msgHeaderList&&maps="+$("#searchForm").serialize();
	}

}
</script>
	
</body>
</html>
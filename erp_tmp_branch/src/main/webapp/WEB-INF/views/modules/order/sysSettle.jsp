<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
  <head>
    
    <meta name="decorator" content="base"/>
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
	
			<p class="f-r btnWrap">
				<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt moresearch" id="moresearch" ><i class="sficon sficon-moresearch"></i>更多查询</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt"><i class="sficon sficon-reset"></i>重置</a>
				<a href="${ctx}/order/settle/toadd" class="sfbtn sfbtn-opt"><i class="sficon sficon-reset"></i>添加</a>
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
	var url = "${ctx}/order/settle/settleList";
	sfGrid = $("#table-waitdispatch").sfGrid({
		url:url, 
		sfHeader:defaultHeader,
		sfSortColumns:sortHeader
	});
}
/* function delect(id){
	layer.confirm('您确定删除该信息？', {
		  btn: ['确定','取消'] //按钮
		}, function(){
			$.ajax({
				type:"POST",
				url : "${ctx}/sys/settle/deletesettle",
				data : "id=" + id,
				success: function(data){
					window.location.reload(true);
				}
			});
			
		}, function(){
		  
		});
} */

/* function fmtOper(rowData){
		return "<span><a href=${ctx}/sys/settle/delete?id="+rowData.id+">删除</a></span>";
	
} */
/* function update(id){
	$.ajax({
		type:"POST",
		url : "${ctx}/sys/settle/updatesettle",
		data : "id=" + id,
		success: function(data){
			window.location.reload(true);
		}
	});
} */
/* function updates(id){
	$.ajax({
		type:"POST",
		url : "${ctx}/sys/settle/updatesettles",
		data : "id=" + id,
		success: function(data){
			window.location.reload(true);
		}
	});
} */
function fmtOper(rowData){
	return "<a href=${ctx}/order/settle/deletesettle?id="+rowData.id+">删除</a>";

}
function typeLook(rowData){
	if(rowData.type=1){
		return "<span>结算设置</span>"
	}else{
		return "<span>未定义</span>"
	}
}
function updateOper(rowData){
	if(rowData.figure==0){
		return "<span>开启<div><a style='color:blue' href=${ctx}/order/settle/updatesettle?id="+rowData.id+">点击关闭</a></div></span>";
	}if(rowData.figure==1){
		return "<span>关闭<div><a style='color:blue' href=${ctx}/order/settle/updatesettles?id="+rowData.id+">点击开启</a></div></span>";
	}


}

function search(){
$("#table-waitdispatch").sfGridSearch($("#searchForm").serializeJson());
}




</script>

  </body>
</html>
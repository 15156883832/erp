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
			<a class="btn-tabBar" href="${ctx}/order/goodscategory">商品类别设置</a>
			<a class="btn-tabBar" href="${ctx }/order/unit">计量单位设置</a>
			<a class="btn-tabBar current" href="${ctx}/order/supplier">供应商设置</a>
			<p class="f-r btnWrap">
				<a class="sfbtn sfbtn-opt" id="btn-add"><i class="sficon sficon-add"></i>添加</a>
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
		content:'${ctx}/order/supplier/form',
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
	var url = "${ctx}/order/supplier/supplierList";
	sfGrid = $("#table-waitdispatch").sfGrid({
		url:url, 
		sfHeader:defaultHeader,
		sfSortColumns:sortHeader,
		shrinkToFit: true,
		multiselect: false,
		rownumbers : true,
 		gridComplete:function(){
 			_order_comm.gridNum();
 		}
	});
}

function OpenSupplier(rowData){
	return "<a href=javascript:openMsg('"+rowData.id+"') >"+rowData.name+"</a>";
}


function fmtOper(rowData){	
	return "<span><a href=javascript:updateMsg('"+rowData.id+"') style='color:blue'>修改</a></span>&nbsp;&nbsp;<span><a style='color:blue' href=javascript:deleteMsg('"+rowData.id+"')>删除</a></span>";	
}
function deleteMsg(id){
	var content="确定要删除该供应商设置？"
		$('body').popup({
			level:3,
			title:"删除",
			content:content,
			 fnConfirm :function(){
					$.ajax({
						type:"POST",
						url:"${ctx}/order/supplier/deletesuppier",
						traditional: true,
								data:{
								"id":id
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
		});

	
}

function updateMsg(id){
layer.open({
	type : 2,
	content:'${ctx}/order/supplier/editesupplier?id='+id,
	title:false,
	area: ['100%','100%'],
	closeBtn:0,
	shade:0,
	anim:-1 
});
//var = "<a href=${ctx}/order/orderOrigin/edite?id="+rowData.id+">";
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
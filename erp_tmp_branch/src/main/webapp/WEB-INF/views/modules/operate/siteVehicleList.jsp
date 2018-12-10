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
			<sfTags:pagePermission authFlag="NEWSITESETTLE_NEWFAPIAOAPPLYSET_TEEDEFINEDSET_TAB" html='<a class="btn-tabBar  current" href="${ctx}/operate/siteVehicle">车辆信息设置</a>'></sfTags:pagePermission>
			<sfTags:pagePermission authFlag="NEWSITESETTLE_NEWFAPIAOAPPLYSET_TEEDEFINEDSET_TAB" html='<a class="btn-tabBar  " href="${ctx}/operate/siteDriver">司机信息设置</a>'></sfTags:pagePermission>
		<p class="f-r btnWrap">
			<%-- <sfTags:pagePermission authFlag="NEWSITESETTLE_NEWFAPIAOAPPLYSET_TEEDEFINEDSET_PLDELETE_BTN" html='<a href="javascript:;"  onclick="showwxgd()"class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-rubbish"></i>批量删除</a>'></sfTags:pagePermission> --%>
			
			<a href="javascript:search();" class="sfbtn sfbtn-opt">
								<i class="sficon sficon-search"></i>
								查询
							</a>
		</p>
		</div>
		<div class="tabCon">
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
				<div class="bk-gray pt-10 pb-5">
					<table class="table table-search">
						<tr>
							<th style="width: 76px;" class="text-r">车牌号码：</th>
							<td>
								<input type="text" class="input-text" name="plateNumber" id="plateNumber"/>
							</td>
							
						</tr>
					</table>
				</div>
			</form>
				<div class="pt-10 pb-5 cl">
					<div class="f-l">
						<sfTags:pagePermission authFlag="NEWSITESETTLE_NEWFAPIAOAPPLYSET_TEEDEFINEDSET_ADD_BTN" html='<a class="sfbtn sfbtn-opt" id="btn-add" ><i class="sficon sficon-add"></i>添加</a>'></sfTags:pagePermission>
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

$('#btn-add').click(function(){
	layer.open({
	
		type : 2,
		content:'	${ctx}/operate/siteVehicle/form',
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
		url : '${ctx}/operate/siteVehicle/siteVehicleList', 
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

	var delMark = false;
	function deleteVehicle(id) {
		if(delMark){
			return;
		}
		var content = "确认要删除这车辆信息？";
			$('body').popup({
				level : 3,
				title : "删除",
				content : content,
				fnConfirm : function() {
					delMark = true;
					$.ajax({
						type : "POST",
						url : "${ctx}/operate/siteVehicle/deleteVehicle",
						traditional : true,
						data : {
							"id" : id
						},
						async : false,
						success : function(data) {
							delMark = false;
							if (data=="ok") {
								layer.msg("删除完成!", {
									time : 2000
								});
								window.location.reload(true);
							}else{
								layer.msg("操作失败!", {
									time : 2000
								});
							}
							return;
						},
						error : function() {
							layer.alert("系统繁忙!");
							return;
						}
					});
					layer.closeAll('dialog');
				}
			})
	
	}

</script>
</body>
</html>
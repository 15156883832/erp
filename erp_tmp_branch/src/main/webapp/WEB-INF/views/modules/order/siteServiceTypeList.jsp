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
					<sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_SERVICECATE_TAB" html='<a class="btn-tabBar " href="${ctx}/order/category/headerList">服务品类</a> '></sfTags:pagePermission>
		<sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_SERVICEBRAND_TAB" html='<a class="btn-tabBar " href="${ctx}/order/category/siteBrandRelList">服务品牌</a> '></sfTags:pagePermission>
		<sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_MSGORIGIN_TAB" html='<a class="btn-tabBar" href="${ctx}/order/orderOrigin">信息来源</a> '></sfTags:pagePermission>
	<%-- 	<sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_MALTIONTYPE_TAB" html='<a class="btn-tabBar" href="${ctx}/order/malfunction">故障类型</a>'></sfTags:pagePermission>  --%>
			<a class="btn-tabBar" href="${ctx}/order/printdesign">工单打印模板</a>
			<a class="btn-tabBar" href="${ctx}/order/orderMustFill/getMustFillInfo">工单必填项</a>
			<a class="btn-tabBar " href="${ctx}/order/township">乡镇设置</a>
			<sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_MSGMALL_TAB" html='<a class="btn-tabBar " href="${ctx}/order/orderMall">购机商场</a>'></sfTags:pagePermission>
			 <%-- <a class="btn-tabBar " href="${ctx}/order/siteSuperviseSetting">监督内容</a> --%>
			<a class="btn-tabBar current" href="${ctx}/order/serviceType">服务类型</a>
			<a class="btn-tabBar " href="${ctx}/order/serviceMode">服务方式</a>
				<a class="btn-tabBar " href="${ctx}/order/customerType">用户类型</a>
		</div>
		<div class="tabCon">
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
			<p class="f-r btnWrap" style='position: absolute; right: 14px;top: 49px;'>
				<a class="sfbtn sfbtn-opt" id="btn-add" ><i class="sficon sficon-add"></i>添加</a>
			</p>
				<div style='margin-top: 48px;'>
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
		content:'	${ctx}/order/serviceType/siteServiceTypeForm',
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
	var url = "${ctx}/order/serviceType/siteServiceTypeList";
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
function fmtisDefault(rowData){	
	var type = rowData.is_default;
	if(type =="1"){
	return "<span>是</span>";	
	}
	return "<span></span>";	
}

function fmtOper(rowData){	
	var type = rowData.site_id;
	return "<span><a href=javascript:updateMsg('"+rowData.id+"') style='color:blue'>修改</a></span>&nbsp;&nbsp;<span><a href=javascript:deleteMsg('"+rowData.id+"') style='color:blue'>删除</a></span>";	
}
function deleteMsg(id){
	var content="确定要删除该服务类型？";
		$('body').popup({
			level:3,
			title:"删除",
			content:content,
			 fnConfirm :function(){
					$.ajax({
						type:"POST",
						url:"${ctx}/order/serviceType/deleteMall",
						traditional: true,
								data:{
								"id":id
								},
								async:false,
							 success:function(data){
									if(data== "ok"){
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
	content:'${ctx}/order/serviceType/edite?id='+id,
	title:false,
	area: ['100%','100%'],
	closeBtn:0,
	shade:0,
	anim:-1 
})
//var = "<a href=${ctx}/order/orderOrigin/edite?id="+rowData.id+">";

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

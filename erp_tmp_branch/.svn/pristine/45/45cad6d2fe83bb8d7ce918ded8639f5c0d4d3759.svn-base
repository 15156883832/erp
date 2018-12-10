<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
  <head>
    
    <meta name="decorator" content="base"/>
    <script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <div class="sfpagebg bk-gray">
	<div class="sfpage table-header-settable">
	<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
			<sfTags:pagePermission authFlag="OPERATEMGM_SENDSMS_SENDSMS_TAB" html='<a class="btn-tabBar current" href="${ctx}/operate/sendedSms">发送短信记录</a>'></sfTags:pagePermission>
			<sfTags:pagePermission authFlag="OPERATEMGM_SENDSMS_RECEIVEDSMS_TAB" html='<a class="btn-tabBar   " href="${ctx}/operate/receivedSms">短信回复</a>'></sfTags:pagePermission>
			<p class="f-r btnWrap">
			<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
					<a href="javascript:;" class="sfbtn sfbtn-opt resetSearchBtn" onclick="reset()"><i class="sficon sficon-reset"></i>重置</a>
			</p>
		</div>
			
		<div class="tabCon">
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
				<input type="hidden" name="target" id="target" value="${target}">
								<div class="bk-gray pt-10 pb-5">
					<table class="table table-search">
						<tr>
							<th style="width: 76px;" class="text-r">工单编号：</th>
						<td><input type="text" class="input-text" id="orderNumm" name= "orderNum" value=""/></td>
							<th style="width: 76px" class="text-r">短信类型：</th>
							<td>			
								<span class="select-box">
									<select class="select" name="type">
									<option value="">请选择</option>
							<%--  	<c:forEach items="${templatelist }" var="template">
									<option value="${template.columns.tag }">${template.columns.name }</option>			
									</c:forEach> --%>
									
									<option value="1">自定义短信</option>
									<option value="0">待派工</option>
									<option value="2">工单电话无人接听</option>
									<option value="9">配件电话无人接听</option>
									<option value="3">改约</option>
									<option value="4">缺配件</option>
									<option value="5">服务后</option>
									<option value="6">工单上门前</option>
									<option value="7">工程师催单</option>
									<option value="8">增值产品</option>
										</select>
										</span>	
							</td>
							<th style="width: 76px" class="text-r">手机号：</th>
							<td><input type="text" class="input-text" name= "mobile"  id="mobile"/></td>
							<th style="width: 76px;" class="text-r">发送时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'sendTimeMin\')||\'%y-%M-%d\'}'})" id="sendTimeMin" name="sendTimeMin" value="" class="input-text Wdate w-140" readonly/>
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'sendTimeMax\')}',maxDate:'%y-%M-%d'})" id="sendTimeMax" name="sendTimeMax" value="" class="input-text Wdate w-140" readonly/>
							</td>
						
							</tr>
							</table>
							</div>
								
										<div class="pt-10 pb-5 cl">
				<div class="f-r">
					<sfTags:pagePermission authFlag="OPERATEMGM_SENDSMS_SENDSMS_EXPORT_BTN" html='<a onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
				</div>
			</div>
				<div>
					<table id="table-waitdispatch" class="table"></table>
					<!-- pagination -->
					<div class="cl pt-10">
						<div class="f-l">
						
						</div>
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
	//$("#mobile").val();
	$("#orderNumm").val('${orderNum}');
	$.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
	$.tabfold("#moresearch",".moreCondition",1,"click");
	initSfGrid();
});

//初始化jqGrid表格，传递的参数按照说明
function initSfGrid(){
	var url = "${ctx}/operate/sendedSms/sendedSmslist";
	sfGrid = $("#table-waitdispatch").sfGrid({
		url:url, 
		sfHeader:defaultHeader,
		sfSortColumns:sortHeader,
		postData: $("#searchForm").serializeJson(),
		shrinkToFit: true,
		multiselect: false,
		rownumbers : true,
		gridComplete:function(){
			_order_comm.gridNum();
		}
	});
}



function typeTrans(rowData){	
	if(rowData.type==1){
		return "<span>自定义短信</span>";	
	}else if(rowData.type==2){
		return "<span>工单无人接听</span>";
	}else if(rowData.type==3){
		return "<span>改约</span>";
	}else if(rowData.type==4){
		return "<span>缺配件</span>";
	}else if(rowData.type==5){
		return "<span>服务后</span>";
	}else if(rowData.type==6){
		return "<span>工单上门前</span>";
	}else if(rowData.type==7){
		return "<span>工程师催单</span>";
	}else  if(rowData.type==8){
		return "<span>增值产品</span>";
	}else if(rowData.type==9){
		return "<span>配件无人接听</span>";
	}else if(rowData.type==10){
        return "<span>历史周边用户推送</span>";
	}else if(rowData.type==0){
		return "<span>待派工</span>";
	}else{
		return "<span>自定义短信</span>";
	}
}

function statuTrans(rowData){
	if(rowData.status==0){
		return "<span>未发送</span>";
	}else if(rowData.status==1){
		return "<span>已发送</span>";
	}else if(rowData.status==2){
		return "<span>接收成功</span>";
	}else if(rowData.status==3){
		return "<span>接收失败</span>";
	}else if(rowData.status==4){
		return "<span>已删除</span>";
	}
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

function reset(){
	$("#orderNumm").val("");
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
				 location.href="${ctx}/operate/sendedSms/export?formPath=/a/operate/sendedSms&&maps="+$("#searchForm").serialize();
			 }
	
		});
	}else{
		location.href="${ctx}/operate/sendedSms/export?formPath=/a/operate/sendedSms&&maps="+$("#searchForm").serialize();
	}

}

function numberMat(rowData){
	if(rowData.order_number!=null && $.trim(rowData.order_number)!=""){
		return '<span style="text-align:center;">'+rowData.order_number+'</span>';
	}
	return "";
}
</script>
  </body>
</html>
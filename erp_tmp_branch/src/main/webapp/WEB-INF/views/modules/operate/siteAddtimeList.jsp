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
		<a class="btn-tabBar  " href="${ctx}/operate/SiteManager">服务商管理</a>
		<a class="btn-tabBar  current" href="${ctx}/operate/SiteAddtime/siteAddtimeRecord">添加时长记录</a>
		<sfTags:pagePermission authFlag="SYSTEM_AUTH_USEAGE_STAT_TAB" html='<a class="btn-tabBar " href="${ctx}/statistic/siteLoginStatistic">系统使用统计</a>'/>
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
					<th style="width: 76px;" class="text-r">服务商名称：</th>
							<td>
                              <input type="text" class="input-text" onkeydown="enterEvent(event)" name= "name"/>
							</td>
							<th style="width: 76px;" class="text-r">联系电话：</th>
							<td>
								<input type="text" class="input-text" onkeydown="enterEvent(event)" name= "telephone"/>
							</td>
							<td colspan="6">	
								<label class="text-r lb">添加时间：</label>
								<input type="text" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd'})" id="createTimemin" name="createTimemin"  value="" class="input-text Wdate w-120" style="width:120px">
								至
								<input type="text" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd'})" id="createTimemax" name="createTimemax" value="" class="input-text Wdate w-120" style="width:120px">
							</td>
				</tr>
							</table>
							</div>
							<div class="pt-10 pb-5 cl">
				<div class="f-l">


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
			</form>
		</div>
	</div>
</div>

</div>
</div>











<!--_footer 作为公共模版分离出去-->


<!--_footer 作为公共模版分离出去-->

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
	var url = "${ctx}/operate/SiteAddtime/siteAddtimeRecordList";
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





function siteOper(rowData){	
	return "<span><a class='c-0383dc'>"+rowData.name+"</a></span>";	
}

function addtimeOper(rowData){
	if(parseInt(rowData.time_add)<36500){
		return "<span>"+rowData.time_add+"</span>";	
	}else{
		return "<span>不限</span>";	
	}
}


function jsClearForm() {
	$("#searchForm :input[type='text']").each(function () { 
	$(this).val(""); 
	}); 
	
	$("select").val(""); 
	$(".textbox-value").val("");
	 

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

/*enter查询*/
function enterEvent(event){
	var keyCode = event.keyCode?event.keyCode:event.which?event.which:event.charCode;
	if (keyCode ==13){
		search();
	}
}

</script>
  </body>
</html>
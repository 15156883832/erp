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
<sfTags:pagePermission authFlag="OPERATEMGM_SENDSMS_SENDSMS_TAB" html='<a class="btn-tabBar " href="${ctx}/operate/sendedSms">发送短信记录</a>'></sfTags:pagePermission>
			<sfTags:pagePermission authFlag="OPERATEMGM_SENDSMS_RECEIVEDSMS_TAB" html='<a class="btn-tabBar current  " href="${ctx}/operate/receivedSms">短信回复</a>'></sfTags:pagePermission>
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
				
							<th style="width: 76px" class="text-r">回复内容：</th>
							<td>			
								<span class="select-box">
									<select class="select" name="content">
									<option value="">请选择</option>
									<option value="1">满意</option>
									<option value="2">一般</option>
									<option value="3">不满意</option>
									<option value="4">尚未联系</option>
									<option value="5">正在处理，还未处理好。</option>
									<option value="6">其他</option>
										</select>
										</span>	
							</td>
						 
							<th style="width: 76px;" class="text-r">手机号：</th>
							<td><input type="text" class="input-text" name= "mobile"/></td>
							<th style="width: 76px;" class="text-r">回复时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'receivedTimeMin\')||\'%y-%M-%d\'}'})" id="receivedTimeMin" name="receivedTimeMin" value="" class="input-text Wdate w-140" readonly/>
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'receivedTimeMax\')}',maxDate:'%y-%M-%d'})" id="receivedTimeMax" name="receivedTimeMax" value="" class="input-text Wdate w-140" readonly/>
							</td>
						
							</tr>
							</table>
							</div>
								
										<div class="pt-10 pb-5 cl">
				<div class="f-r">
					
					
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
	$.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
	$.tabfold("#moresearch",".moreCondition",1,"click");
	initSfGrid();
});

//初始化jqGrid表格，传递的参数按照说明
function initSfGrid(){
	var url = "${ctx}/operate/receivedSms/receivedsmslist";
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



function contentTrans(rowData){	
	if(rowData.content==1){
		return "<span>满意</span>";	
	}else if(rowData.content==2){
		return "<span>一般</span>";
	}else if(rowData.content==3){
		return "<span>不满意</span>";
	}else if(rowData.content==4){
		return "<span>尚未联系</span>";
	}else if(rowData.content==5){
		return "<span>正在处理，还未处理好。</span>";
	}else{
		return "<span>"+rowData.content+"</span>";
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
</script>
  </body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
  <head>
    
     <meta name="decorator" content="base"/> 
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->


<%-- <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/bootstrap-Switch/bootstrapSwitch.css" />  --%>
 <script type="text/javascript" src="${ctxPlugin}/lib/bootstrap-Switch/bootstrapSwitch.js" ></script> 

<style type="text/css">
.ui-jqgrid label {
width: 50px;
height: 30px;
background: white;

}
</style><!--改变开关的样式  -->
  </head>
  
  <body>
    <div class="sfpagebg">
	<div class="sfpage bk-gray table-header-settable">
	<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
		<a class="btn-tabBar" href="${ctx}/order/category/headerList">服务品类</a>
			<a class="btn-tabBar " href="${ctx}/order/category/siteBrandRelList">服务品牌</a>
			<a class="btn-tabBar " href="${ctx}/order/orderOrigin">信息来源</a>
			<a class="btn-tabBar " href="${ctx}/order/malfunction">故障类型</a>
			<a class="btn-tabBar current" href="${ctx}/order/commonsetting/settingtable">语音提醒</a>
			<p class="f-r btnWrap">					
				<a href="javascript:search();;" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>					
			</p>				
		</div>
	<div class="tabCon">
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
				<div class="bk-gray pt-10 pb-5">
					<table class="table table-search">
						<tr>
							<th style="width: 76px;" class="text-r">开关类型：</th>
							<td>			
								<span class="select-box">
									<select class="select" name="serviceType">
										<option value="0">pc端语音提醒</option>
										</select>
										</span>	
							</td>
							</tr>
							</table>
							</div>

					<div class="pt-10 pb-5 cl">
					<table id="table-waitdispatch" class="table"></table>
					<!-- pagination -->
					<div class="cl pt-10">
						<div class="f-r">
							<div class="pagination"></div>
						</div>
					</div>
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
	var url = "${ctx}/order/commonsetting/settingList";
	sfGrid = $("#table-waitdispatch").sfGrid({
		url:url, 
		sfHeader:defaultHeader,
		sfSortColumns:sortHeader,
		shrinkToFit: true,
		multiselect: false,
		loadComplete: function(data) {//将checkbox转变为bootstrap的开关按钮
			var rowdata = data.rows;
			for(var i=0;i<rowdata.length;i++) {
				$('#toggle-state-switch' + rowdata[i].id).wrap('<div class="switch"  data-on-label="开" data-off-label="关"  id="'+rowdata[i].id+'"/>').parent().bootstrapSwitch();
			}
			$('.switch').on('switch-change', function (e, data) {
		      var id=$(this).attr("id");
		      if(data.value==true){
		    	  $.ajax({
					   type:"POST",
					   url:"${ctx}/order/commonsetting/updatesettings",
					   data:{"id":id},
					   dataType:"json",
					   success:function(result){
						  layer.msg(result);
					   }
				   }); 
		      }else{
		    	  $.ajax({
					   type:"POST",
					   url:"${ctx}/order/commonsetting/updatesetting",
					   data:{"id":id},
					   dataType:"json",
						   success:function(result){
							   layer.msg(result);
						   }
		    	   }); 
		      }
				});
		}
	});
}


function typeLook(rowData){
	if(rowData.type==0){
		return "<span>pc端语音提醒打开</span>"
	}else{
		return "<span>未定义</span>"
	}
}
function updateOper(rowData){
	 if(rowData.set_value==1){
		 	return '<input id="toggle-state-switch'+rowData.id+'" type="checkbox"  value="'+rowData.id+'" />';
	 }else{
		 	return '<input id="toggle-state-switch'+rowData.id+'" type="checkbox" checked="true"  />';
	 }
}
	function search(){
	    $("#table-waitdispatch").sfGridSearch({
	        postData: $("#searchForm").serializeJson()
	    });
	}
</script>

</body>
  </body>
</html>
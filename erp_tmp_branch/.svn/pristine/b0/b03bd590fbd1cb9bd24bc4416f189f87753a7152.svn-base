
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>

<head>
<meta name="decorator" content="base"/> 
<title>区域管理-区域人员管理</title>
</head>
<body>
<!-- 修改信息来源 -->

<div class="popupBox sysNotice editeNotice" style="z-index: 199;">
	<h2 class="popupHead">
		分享明细
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>

	<div class="popupContainer">
				<div class="popupMain pt-25 pr-25 pb-15">
	<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		
			
		
			<form id="searchForm" method="post">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
				<input type="hidden" name="id" value="${id }">
							
</form>
				<div style="width:670px; height:405px;">
					<table id="table-waitdispatch" class="table"></table>
					<!-- pagination -->
					
					<!-- pagination -->
				</div>
				<div class="cl mt-10">
							<div class="pagination"></div>
					</div>
			
	
		<div class="text-c mt-20">

				<a href="javascript:;" class="sfbtn sfbtn-opt w-70" onclick="closeds()">关闭</a>
			</div>
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
	$('.editeNotice').popup(); 
	initSfGrid();
	$.setPos($('.sysNotice'));

	});
	function closeds(){
		   //window.location.href="${ctx}/order/unit"
		$.closeDiv($('.editeNotice'));
	}
	function initSfGrid(){
		var url = "${ctx}/order/areaManager/siteareaManagerList"
		sfGrid = $("#table-waitdispatch").sfGrid({
			url:url, 	
			sfHeader:defaultHeader,
			sfSortColumns:sortHeader,
			postData:$("#searchForm").serializeJson(),
			//shrinkToFit: true,
			multiselect: false,
            width:950,
            height:350,
		});
	}
	
	function search(){
		
		 $("#table-waitdispatch").sfGridSearch({
		    	postData:$("#searchForm").serializeJson()
		    });
	}




</script> 
</body>
</html> 
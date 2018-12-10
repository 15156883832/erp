
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>

<head>
<meta name="decorator" content="base"/>
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<title>不满意工单详情</title>
</head>
<body>
<!-- 修改信息来源 -->

<div class="popupBox sysNotice editeNotice" style="width:1000px;">
	<h2 class="popupHead">不满意工单详情<a href="javascript:;" class="sficon closePopup"></a></h2>

	<div class="popupContainer">
	<div class="popupMain pr-25 pb-15">
	<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		
			
		
			<form id="searchForm" method="post">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
				<input type="hidden" name="year" value="${year }">
				<input type="hidden" name="month" value="${month }">							
              </form>
              
                <div class="pt-10 pb-5 cl">
				<div class="f-r">
					<a onclick="return exports()"class="sfbtn sfbtn-opt" target="_blank"><i class="sficon sficon-export"></i>导出</a>
				</div>
			     </div>
			     
				<div >
					<table id="table-waitdispatch" class="table"></table>
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
		$.closeDiv($('.editeNotice'));
	}
	
	function initSfGrid(){
		var url = "${ctx}/statistic/bmygdlist";
		sfGrid = $("#table-waitdispatch").sfGrid({
			url:url, 	
			sfHeader:defaultHeader,
			sfSortColumns:sortHeader,
			postData:$("#searchForm").serializeJson(),
			//shrinkToFit: true,
			multiselect: false,
            width:950,
            height:350,
            rownumbers : true,
    		gridComplete:function(){
    			_order_comm.gridNum();
    		}
		});
	}
	
	
	function fmtserviceattr(rowData){
		if(rowData.service_attitude=="1"){
			return "<span>十分不满意</span>"
		}else if(rowData.service_attitude=="2"){
			return "<span>不满意</span>"
		}else{
			return "<span>不满意</span>"
		}
	}
	
	
	function fmtOrderAppliance(rowData){
		if(rowData.appliance_brand!=null&&rowData.appliance_category!=null){
			return rowData.appliance_brand+rowData.appliance_category;
		}else if(rowData.appliance_brand==null){
			return rowData.appliance_category;
		}else{
			return rowData.appliance_brand;
		}
	}
	
	function search() {
		var pageSize = $("#pageSize").val();
		if ($.trim(pageSize) == '' || pageSize == null) {
			$("#pageSize").val(20);
		}
		$("#table-waitdispatch").sfGridSearch({
			postData : $("#searchForm").serializeJson()
		});
	}

	function exports() {
		var idArr = $("#table-waitdispatch").jqGrid('getGridParam', 'records')
		var content = "共" + idArr + "条数据，本次允许导出前10000条，确定继续导出吗？";
		if (idArr > 10000) {
			$('body')
					.popup(
							{
								level : 3,
								title : "导出",
								content : content,
								fnConfirm : function() {
									location.href = "${ctx}/statistic/exportbmygd?formPath=/a/statistic/jumpbmygd&&maps="
											+ $("#searchForm").serialize();
								}
							});
		} else {
			location.href = "${ctx}/statistic/exportbmygd?formPath=/a/statistic/jumpbmygd&&maps="
					+ $("#searchForm").serialize();
		}

	}
</script> 
</body>
</html> 

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>

<head>
<meta name="decorator" content="base"/> 
<title>区域管理-绑定服务商明细</title>
</head>
<body>
<div class="popupBox sysNotice editeNotice " style="z-index: 199;">
	<h2 class="popupHead">
		绑定明细
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>

	<div class="popupContainer">
				<div class="popupMain pt-30 pr-25 pb-15">
	<div class="page-orderWait">
	<a  class="sfbtn sfbtn-opt2 fr" style='position: absolute;top: 0px;right: 36px;margin-top:3px' onclick="return expotrs()" target="_blank"><i class="sficon sficon-export"></i>导出</a>
	<div id="tab-system" class="HuiTab">
		
		
			<form id="searchForm" method="post">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
				<input type="hidden" name="id" value="${id }">
							
</form>
				<div style="width:670px; height:405px;">
					<table id="table-waitdisp" class="table"></table>
					<!-- pagination -->
					
					<!-- pagination -->
				</div>
				<div class="cl mt-10">
							<div class="pagination"></div>
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
	
	 $(window).resize(function(){
		var taheight = $('.popupBox').height()-200;
		var tableereWidth = $('.popupBox').width()-30;
		$("#table-waitdisp").setGridHeight(taheight);
		$("#table-waitdisp").setGridWidth(tableereWidth);
  	});
	  	
	function initSfGrid(){
		var tableereWidth = $('.popupBox').width()-30;
		var taheight = $('.popupBox').height()-150;
		var url = "${ctx}/order/areaManager/bindingsiteList";
		sfGrid = $("#table-waitdisp").sfGrid({
			url:url, 	
			sfHeader:defaultHeader,
			sfSortColumns:sortHeader,
			postData:$("#searchForm").serializeJson(),
			//shrinkToFit: true,
			multiselect: false,
            width:tableereWidth,
            height:taheight,
		});
	}
	
	function expotrs(){
		var idArr=$("#table-waitdisp").jqGrid('getGridParam','records')
		var content="共"+idArr+"条数据，本次允许导出前10000条，确定继续导出吗？";
		if(idArr>10000){
			$('body').popup({
				level:3,
				title:"导出",
				content:content,
				 fnConfirm :function(){
					 location.href="${ctx}/order/areaManager/exports?formPath=/a/order/areaManager/bindingsite&&maps="+$("#searchForm").serialize(); 
				 }
			});
		}else{
			 location.href="${ctx}/order/areaManager/exports?formPath=/a/order/areaManager/bindingsite&&maps="+$("#searchForm").serialize();
		}
	}
	
	
	function search(){
		
		 $("#table-waitdisp").sfGridSearch({
		    	postData:$("#searchForm").serializeJson()
		    });
	}

    //判断版本函数
    function versionOper(rowData) {
        var oDate = new Date();
        if (!rowData.due_time) {
            return "<span>免费版</span>";
        } else {
            var dueTime = new Date(rowData.due_time);
            if (oDate <= dueTime) {
                return "<span>收费版</span>";
            } else {
                return "<span>免费版</span>";
            }
        }
    }


</script> 
</body>
</html> 
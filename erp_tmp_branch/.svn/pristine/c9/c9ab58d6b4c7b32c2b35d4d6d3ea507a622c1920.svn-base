<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>工程师商品领用记录</title>
	<meta name="decorator" content="base"/>
	<script type="text/javascript" src="${ctxPlugin }/lib/Highcharts/4.1.7/js/highcharts.js"></script>
	<script type="text/javascript" src="${ctxPlugin }/lib/Highcharts/4.1.7/js/modules/exporting.js"></script>
</head>
<body>
<div class="sfpagebg bk-gray">
	<div class="sfpage">
		<div class="page-orderWait">
			<div id="tab-system" class="HuiTab">
				<div class="tabBar cl mb-10">
					<sfTags:pagePermission authFlag="STATISTIC_EMPLOYEINDEX_EMPLOYEINDEX_TAB" html='<a class="btn-tabBar " href="${ctx}/statistic/employeIndex">工单统计</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="STATISTIC_EMPLOYEINDEX_EMPLOYECHUKKU_TAB" html='<a class="btn-tabBar current" href="${ctx}/statistic/employeGoodsAnalyse">工程师商品领用记录</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="STATISTIC_SITEINCOMMINGSTATISTIC_TAB" html='<a class="btn-tabBar " style="width:170px;" href="${ctx}/statistic/siteFeeCollection">网点收入盘点统计</a>'></sfTags:pagePermission>
					<p class="f-r btnWrap">
						<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
						<a href="javascript:reset();" class="sfbtn sfbtn-opt"><i class="sficon sficon-reset"></i>重置</a>
					</p>
				</div>
				<div class="tabCon">
					<form action="${ctx}/statistic/employeIndex"  id="cx" method="post">
						<input type="hidden" name="page" id="pageNo" value="1"> 
						<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
						<div class="cl mt-15">
							<div class=" table-search">
								<label class="">出库时间：</label>
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'outstocksTimeMax\')||\'%y-%M-%d\'}'})"  id=outstocksTimeMin name="outstocksTimeMin" value="${outstocksTimeMin }" class="input-text Wdate w-120" style="width:120px">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'outstocksTimeMin\')}',maxDate:'%y-%M-%d'})" id="outstocksTimeMax" name="outstocksTimeMax"  value="${outstocksTimeMax }" class="input-text Wdate w-120" style="width:120px">
								<label class="ml-15">服务工程师：</label>
								<input type="text" class="input-text w-140" name="empName" id="empName" value="">
							</div>
						</div>
					</form>
					<div class="mt-10 text-r">
						<sfTags:pagePermission authFlag="STATISTIC_EMPLOYEINDEX_EMPLOYECHUKKU_EXPORT_BTN" html='<a  onclick="return exports()"class="sfbtn sfbtn-opt2"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
						<%-- <sfTags:pagePermission authFlag="STATISTIC_EMPLOYEINDEX_EMPLOYEINDEX_EXPORT_BTN" html='<a  onclick="return print()" target="_blank" class="sfbtn sfbtn-opt2"><i class="sficon sficon-print"></i>打印</a>'></sfTags:pagePermission>  --%>
					</div>
					<div>
						<table id="table-waitdispatch" class="table">
						</table>
						<div class="cl pt-10">
							<div class="f-r">
								<div class="pagination"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	var sfGrid;
	var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
	var sortHeader = '${headerData.sortHeader}'; //服务商自定义过的表格头部
	  $(function () { 
		  $.Huitab("#tab-system .tabBar span", "#tab-system .tabCon","current", "click", "0");
		  $.tabfold("#moresearch", ".moreCondition", 1, "click");
		  initSfGrid();
      });  
	
	//初始化jqGrid表格，传递的参数按照说明
	function initSfGrid() {
		sfGrid = $("#table-waitdispatch").sfGrid({    
			url : '${ctx}/statistic/employeGoodsAnalyseGrid',
			sfHeader : defaultHeader,
			sfSortColumns : sortHeader,
			shrinkToFit: true,
			multiselect:false,
			postData : $("#cx").serialize(),
			rownumbers : true,
			gridComplete : function() {
				_order_comm.gridNum();
			}
		/* gridComplete:function(){
			if($("#table-waitdispatch").find("tr").length>1){
				$(".ui-jqgrid-hdiv").css("overflow","hidden");
			}else{
				$(".ui-jqgrid-hdiv").css("overflow","auto");
			}
		}, */
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
									location.href = "${ctx}/statistic/exportEmpGoods?formPath=/a/statistic/employeGoodsAnalyse&map="
											+ $("#cx").serialize();
								}

							});
		} else {
			location.href = "${ctx}/statistic/exportEmpGoods?formPath=/a/statistic/employeGoodsAnalyse&map="
					+ $("#cx").serialize();
		}

	}

	function search() {
		var pageSize = $("#pageSize").val();
    	if ($.trim(pageSize) == '' || pageSize == null) {
    		$("#pageSize").val(20);
    	}
		$("#table-waitdispatch").sfGridSearch({
			postData : $("#cx").serializeJson()
		});
	}

	function goodName(rowData) {
		return rowData.brand + rowData.category;
	}

	function reset() {
		$("#outstocksTimeMax").val('');
		$("#outstocksTimeMin").val('');
		$("#empName").val('');
	}

	function print() {
		window.open("${ctx}/statistic/printGoods?map=" + $("#cx").serialize());
	}
</script> 
</body>
</html>
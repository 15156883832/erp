<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
  <head>
    <meta name="decorator" content="base"/>
	  <meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
      <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script> 
  </head>
  <body>
    <div class="sfpagebg bk-gray">
	<div class="sfpage  table-header-settable">
	<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
						<a class="btn-tabBar " href="${ctx}/goods/siteself/goodsAnalyse">商品分析</a>
						<a class="btn-tabBar current " href="${ctx }/fitting/fittingApply/fittingManage">备件分析</a>
						<a class="btn-tabBar " href="${ctx}/operate/ordercount">工单分析</a>
						<a class="btn-tabBar " href="${ctx}/goods/siteself/ewmCollectionHeader">二维码收款分析</a>
						<p class="f-r btnWrap">
							<a href="javascript:search();" class="sfbtn sfbtn-opt"><i
								class="sficon sficon-search"></i>查询</a> <a href="javascript:;"
								class="sfbtn sfbtn-opt resetSearchBtn"><i
								class="sficon sficon-reset"></i>重置</a>
						</p>
		</div>
		<div class="tabCon">
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
				<div class="bk-gray pt-10 pb-5">
								<table class="table table-search">
										<th style="width: 76px;" class="text-r">服务商名称：</th>
										<td>
											<%-- <select class="select w-140" name="siteId">
												<option value="">请选择</option>
											<c:forEach var ="site" items="${siteList }">
												<option value="${site.columns.id }">${site.columns.name }</option>												
											</c:forEach>
											</select> --%>
											<input type="text" class="input-text" onkeydown="enterEvent(event)" name="name" id="name" />
										</td>
										<th style="width: 76px;" class="text-r">时间：</th>
										<td colspan="1">
											<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'createTimeMax\')||\'%y-%M-%d\'}'})"  id=createTimeMin name="startTime" value="" class="input-text Wdate w-120" style="width:120px">
											至
											<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'createTimeMin\')}',maxDate:'%y-%M-%d'})" id="createTimeMax" name="endTime"  value="" class="input-text Wdate w-120" style="width:120px">
										</td>
											<th style="width: 76px;" class="text-r">区域：</th>
							<td>
                               <span class="w-140">
									<select class="select easyui-combobox"  id="statusFlag"  name="area" style="width:100%;height:25px" panelMaxHeight="130px">
									  <option value="" selected="selected">--请选择--</option>
						         	<c:forEach items="${listarea }" var="pro">
						         <option value="${pro.columns.ProvinceName }">${pro.columns.ProvinceName }</option>
						         </c:forEach>
									</select>
								</span>
							</td>
									</tr>
								</table>
							</div>
						</form>

						<div class="pt-10 pb-5 cl">
						<div class="f-r">
					<a onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>
				</div>
						</div>
		<!-- <div class="tabCon">
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
				<div>
					<table id="table-waitdispatch" class="table"></table>
					pagination
					<div class="cl pt-10">
						<div class="f-r">
							<div class="pagination"></div>
						</div>
					</div>
					pagination
				</div>
			</form>
		</div> -->
		<div>
				<table id="table-waitdispatch" class="table"></table>
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
var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部

$(function(){
	$.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
	$.tabfold("#moresearch",".moreCondition",1,"click");
	initSfGrid();
});

//初始化jqGrid表格，传递的参数按照说明
function initSfGrid(){
	var url = "${ctx}/fitting/fittingApply/getFittingManageList";
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

/* function addressFun(row){
	var detailAddress = row.province + row.city + row.area + row.address;
	return 	detailAddress;
} */

function isBlank(val) {
	if(val==null || val=='' || val == undefined) {
		return true;
			}
	return false;
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
				 location.href="${ctx}/fitting/fittingApply/export2?formPath=/a/fitting/fittingApply/fittingManage&&maps="+$("#searchForm").serialize();
			 }
	
		});
	}else{
		location.href="${ctx}/fitting/fittingApply/export2?formPath=/a/fitting/fittingApply/fittingManage&&maps="+$("#searchForm").serialize();
	}

}
</script>
  </body>
</html>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="decorator" content="base"/>
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<script type="text/javascript" src="${ctxPlugin}/lib/formatStatus.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script>  
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>


	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.css">
	<script src="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.js"></script>
		<style>
		.dropdown-display{font-size: 12px}
		.dropdown-selected{margin-top: 4px}
	</style>
  </head>
  
  <body>
    <div class="sfpagebg">
	<div class="sfpage bk-gray table-header-settable">
	<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
		<sfTags:pagePermission authFlag="FITTINGMGM_BALANCE_PAYMENTS_TAB" html='<a class="btn-tabBar " href="${ctx}/fitting/balanceOfPayments">备件收支明细</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="FITTINGMGM_BALANCE_SUMMARY_TAB" html='<a class="btn-tabBar current" href="${ctx}/fitting/fittingRetailvolume">备件收支汇总</a>'></sfTags:pagePermission>
				<p class="f-r btnWrap">
				<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
			</p>
		</div>
		<div class="">
				<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
				<div class="bk-gray pt-10 pb-5">
					<table class="table table-search">
						<tr>
							<th style="width: 76px;" class="text-r">备件条码：</th>
							<td>
								<input type="text" class="input-text" name="code"/>
								<input type="hidden" name="emps" id="emps" class="input-text" />
							</td>
							<th style="width: 76px;" class="text-r">备件名称：</th>
							<td>
								<input type="text" class="input-text" name="name"/>
							</td>
							<th style="width: 80px;" class="text-r">申请人：</th>
							<td id="reloadSpan">
								<span class="w-140 dropdown-sin-2">
									<select class="select " id="employs" multiple name="emps" >
									<c:forEach items="${fns:getEmloyeListForAll(siteId) }" var="emp">
										<c:if test="${emp.columns.status ne 3}">
											<option value="${emp.columns.name }">${emp.columns.name }</option>
										</c:if>
										<c:if test="${emp.columns.status eq 3}">
											<option value="${emp.columns.name }">${emp.columns.name }【离职】</option>
										</c:if>
									</c:forEach>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">明细类型：</th>
							<td>
								<span class="select-box">
									<select class="select" name="verificationType">
										<option value="">请选择</option>
										<option value="1">工单使用</option>
										<option value="2">工单零售</option>
										<option value="3">工程师零售</option>
										<option value="4">网点零售</option>
									</select>
								</span>
							</td>
							</tr>
							<tr>
							<th style="width: 76px;" class="text-r">使用时间：</th>
							<td colspan="3">
							<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'datemax\')||\'%y-%M-%d\'}'})" id="datemmin" name="datemmin" class="input-text Wdate">
							至
							<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'datemmin\')}',maxDate:'%y-%M-%d'})" id="datemax" name="datemax" class="input-text Wdate">
							</td>
						</tr>
					</table>
				</div>
				</form>
			<div class="pt-10 pb-5 cl">
				<!-- <div class="f-l">
					<a class="radiobox  mr-15" onclick="huizong1()"  >提成明细</a>
					<a class="radiobox radiobox-selected"  onclick="huizong()" >汇总</a>
				</div> -->
				<div class="f-r">
					<sfTags:pagePermission authFlag="FITTINGMGM_BALANCE_SUMMARY_EXPORT_BTN" html='<a  onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
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
	
	initTableH();
	initSfGrid();
	$.setPos($('.gcsjsmxhzWrap'));
	$('#employeName').select2();
	$(".selection").css("width","120px");
    $('.dropdown-sin-2').dropdown({
        input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
    });

})

//初始化jqGrid表格，传递的参数按照说明
function initSfGrid(){
	var url = "${ctx}/fitting/fittingRetailvolumeData";
	sfGrid = $("#table-waitdispatch").sfGrid({
		url:url, 
		sfHeader:defaultHeader,
		sfSortColumns:sortHeader,
		postData:$("#searchForm").serializeJson(),
		multiselect: false,
		width:950,
		height:350,
		rownumbers : true,
		gridComplete:function(){
			_order_comm.gridNum();
		}
	});
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

	function initTableH() {
		var h2 = $('#boxWrapTable table').height();
		if (h2 > 470) {
			$('#boxWrapHead').css({
				'padding-right' : '17px'
			});
		}
	}

	function reset() {
		$("#searchForm").get(0).reset();
		var html = '<span class="w-140 dropdown-sin-2">';
		html += '<select class="select-box w-120"  id="employs" style="display:none" multiple  multiline="true" name="emps"  >';
		html += '<c:forEach items="${fns:getEmloyeList(siteId) }" var="emp">';
		html += ' <option value="${emp.columns.name }">${emp.columns.name }</option>';
		html += '</c:forEach>';
		html += '</select>  </span>';
		$("#reloadSpan").html(html);
		$('.dropdown-sin-2').dropdown({
			input : '<input type="text" maxLength="20" placeholder="请输入搜索">',
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
									location.href = "${ctx}/fitting/exportSummary?formPath=/a/fitting/fittingRetailvolume&&maps="
											+ $("#searchForm").serialize();
								}

							});
		} else {
			location.href = "${ctx}/fitting/exportSummary?formPath=/a/fitting/fittingRetailvolume&&maps="
					+ $("#searchForm").serialize();
		}

	}

</script>
  </body>
</html>
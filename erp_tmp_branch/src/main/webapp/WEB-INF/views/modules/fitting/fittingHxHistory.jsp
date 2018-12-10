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
<title>备件申请管理-核销历史记录</title>
</head>
<body>
	<div class="sfpagebg bk-gray"><div class="sfpage">
		<div class="page-orderWait">
			<div class="HuiTab">
				<div class="tabBar cl mb-10">
					<sfTags:pagePermission authFlag="FITTINGMGM_PREVERFICAT_WAITEVERIFICAT_TAB" html='<a class="btn-tabBar " href="${ctx}/fitting/preVerificationList">待核销<sup id="tab_c1">0</sup></a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="FITTINGMGM_PREVERFICAT_VERIFICATHISTORY_TAB" html='<a class="btn-tabBar current" href="${ctx}/fitting/verificationHistoryList">核销历史记录</a>'></sfTags:pagePermission>
					<p class="f-r btnWrap">
						<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
						<a href="javascript:;" class="sfbtn sfbtn-opt moresearch" id="moresearch" ><i class="sficon sficon-moresearch"></i>更多查询</a>
						<a href="javascript:reset();" class="sfbtn sfbtn-opt"><i class="sficon sficon-reset"></i>重置</a>
					</p>
				</div>
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
							<th style="width: 80px;" class="text-r">服务工程师：</th>
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
							<th style="width: 76px;" class="text-r">使用类型：</th>
							<td>
								<span class="select-box">
									<select class="select" name="verificationUsedType">
										<option value="">请选择</option>
										<option value="1">工单使用</option>
										<option value="11">工单零售</option>
										<option value="3">工程师零售</option>
										<option value="4">网点零售</option>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">核销类型：</th>
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
							<th style="width: 76px;" class="text-r">旧件状态：</th>
							<td>
								<span class="select-box">
									<select class="select" name="oldStatus">
										<option value="">请选择</option>
										<option value="0">已登记</option>
										<option value="1">已入库</option>
										<%--<option value="2">已删除</option>--%>
										<option value="3">已返厂</option>
										<option value="4">已报废</option>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">保修类型：</th>
							<td>
								<span class="select-box">
									<select class="select" name="warrantyType">
										<option value="">请选择</option>
										<option value="1">保内</option>
										<option value="2">保外</option>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">工单编号：</th>
							<td>
								<input type="text" class="input-text" name="orderNo"/>
							</td>
							<th style="width: 80px;" class="text-r">联系方式：</th>
							<td>
								<input type="text" class="input-text" name="tel"/>
							</td>
							<th style="width: 76px;" class="text-r">用户姓名：</th>
							<td>
								<input type="text" class="input-text" name= "customerName"/>
							</td>
						</tr>
						<tr class="moreCondition" style="display: none;">
						<th style="width: 76px;" class="text-r">详细地址：</th>
								<td>
									<input type="text" class="input-text" name= "customerAddress"/>
								</td>
							<th style="width: 76px;" class="text-r">备件品牌：</th>
							<td>
								<input type="text" name="fittingBrand" class="input-text" />
							</td>
							<th style="width: 76px;" class="text-r">使用时间：</th>
							<td colspan="3">
							<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'datemax\')||\'%y-%M-%d\'}'})" id="datemmin" name="datemmin" class="input-text Wdate">
							至
							<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'datemmin\')}',maxDate:'%y-%M-%d'})" id="datemax" name="datemax" class="input-text Wdate">
							</td>
							
						</tr>
						<tr class="moreCondition" style="display: none;">
							<th style="width: 76px;" class="text-r">核销时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'hxmax\')||\'%y-%M-%d\'}'})" id="hxmin" name="hxmin" class="input-text Wdate">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'hxmin\')}',maxDate:'%y-%M-%d'})" id="hxmax" name="hxmax" class="input-text Wdate">
							</td>
						</tr>
					</table>
				</div>
				</form>
				<div class="pt-10 pb-5 cl">
					<div class="f-r">
						<sfTags:pagePermission authFlag="FITTINGMGM_FITSTOCK_COMPANYSTOCK_EXPORT_BTN" html='<a  onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
						<sfTags:pagePermission authFlag="FITTINGMGM_PREVERFICAT_VERIFICATHISTORY_SETHEADER_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt2" id="setHeadersBtn"><i class="sficon sficon-setting"></i>表头设置</a>'></sfTags:pagePermission>
					</div>

				</div>
				<div class="mt-10">
					<table id="table-waitdispatch" class="table"></table>
					<div class="cl pt-10">
						<div class="f-r">
							<div class="pagination"></div>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	</div></div>

<script type="text/javascript">

var sfGrid;
var id = '${headerData.id}';
var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部
var defaultId = '${headerData.defaultId}';	
	$(function(){
        $.tabfold("#moresearch",".moreCondition",1,"click");
		$('#setHeadersBtn').click(function(){
			$('.addHeaders').tableHeaderSetting({
				id:id,
				defaultId: defaultId,
				sfHeader: defaultHeader,
				sfSortColumns: sortHeader,
				tableHeaderSaveUrl:'${ctx}/operate/site/saveTableHeader'
			}).popup();
		});
		initGrid();
        $('.dropdown-sin-2').dropdown({
            input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
        });
	});
	
	
	function initGrid() {
		$("#table-waitdispatch").sfGrid({
			url : '${ctx}/fitting/verificationHistoryListData',
			sfHeader : defaultHeader,
			sfSortColumns : sortHeader,
			multiselect : false,
			rownumbers : true,
			gridComplete : function() {
				_order_comm.gridNum();
			}

		});
	}

	function fmtConfirmType(row) {
		if (row.confirmType == '1') {
			return "工单使用";
		} else if (row.confirmType == '2') {
			return "工单零售";
		} else if (row.confirmType == '3') {
			return "工程师零售";
		} else if (row.confirmType == '4') {
			return "网点零售";
		} else if (row.confirmType == '5') {
			return "备件归还";
		}else {
			return "";
		}
	}

	function fmtOrderNo(rowData) {
		var orderId = rowData.order_id || '';
		var orderNo = rowData.order_number || '';
		return '<a href="javascript:showDetail(\'' + orderNo
				+ '\');" class="c-0383dc">' + orderNo + '</a>';
	}

	function showDetail(orderNo) {
		layer.open({
			type : 2,
			content : '${ctx}/order/orderDispatch/orderDetailForm?orderNo='
					+ orderNo,
			title : false,
			area : [ '100%', '100%' ],
			closeBtn : 0,
			shade : 0,
			fadeIn : 0,
			anim : -1
		});
	}

	function search() {
		/* var y =$("#employs").combobox("getValues");
		$("#emps").val(y); */
		var pageSize = $("#pageSize").val();
    	if($.trim(pageSize)=='' || pageSize==null){
    		$("#pageSize").val(20);
    	}
		$("#table-waitdispatch").sfGridSearch({
			postData : $("#searchForm").serializeJson()
		});
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

	$.post("${ctx}/fitting/verificationMarkerCount", function(result) {
		$("#tab_c1").text(result.t1);
		/*$("#tab_c2").text(result.t2);*/
	});

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
									location.href = "${ctx}/fitting/export?formPath=/a/fitting/verificationHistoryList&&maps="
											+ $("#searchForm").serialize();
								}

							});
		} else {
			location.href = "${ctx}/fitting/export?formPath=/a/fitting/verificationHistoryList&&maps="
					+ $("#searchForm").serialize();
		}

	}
</script> 
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="decorator" content="base"/>
<title>全部工单</title>
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script> 
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/>
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>

	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.css">
	<script src="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.fix1.js"></script>
	<style>
		.dropdown-display{font-size: 12px}
		.dropdown-selected{margin-top: 4px}
	</style>
</head>
<body>
<div class="sfpagebg bk-gray">
<div class="sfpage table-header-settable">
<div class="page-orderWait">
		<div class="tabBar cl mb-10">
			<sfTags:pagePermission authFlag="ORDERMGM_HISTORYORDER_ALLORDER_TAB" html='<a class="btn-tabBar " href="${ctx }/order/History">全部工单<sup id="tab_c1">0</sup></a>'></sfTags:pagePermission>
			<sfTags:pagePermission authFlag="ORDERMGM_HISTORYORDER_FINISHORDER_TAB" html='<a class="btn-tabBar current"  href="${ctx }/order/getWwgList/ywc">已完成工单<sup id="tab_c2">0</sup></a>'></sfTags:pagePermission>
			<sfTags:pagePermission authFlag="ORDERMGM_HISTORYORDER_WXORDER_TAB" html='<a class="btn-tabBar " href="${ctx }/order/getWwgList/wxgd">无效工单<sup id="tab_c3">0</sup></a>'></sfTags:pagePermission>
			<p class="f-r btnWrap">
				<a href="javascript:search();;" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt moresearch" id="moresearch" ><i class="sficon sficon-moresearch"></i>更多查询</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
			</p>
		</div>
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
				<input type="hidden" name="ptype" value="${ptype}"/>
				<div class="bk-gray pt-10 pb-5">
					<table class="table table-search">
						<tr>
							<th style="width: 76px;" class="text-r">工单编号：</th>
							<td>
								<input type="text" class="input-text" name= "number"/>
							</td>
							<th style="width: 76px;" class="text-r">用户姓名：</th>
							<td>
								<input type="text" class="input-text" name = "customerName" onkeydown="enterEvent(event)"/>
							</td>
							<th style="width: 76px;" class="text-r">联系方式：</th>
							<td>
								<input type="text" class="input-text" name = "customerMobile" onkeydown="enterEvent(event)"/>
							</td>
							<th style="width: 76px;" class="text-r">用户地址：</th>
							<td>
								<input type="text" class="input-text" name = "customerAddress" onkeydown="enterEvent(event)"/>
								<input type="hidden" class="input-text" id="siteMsgNums"/>
								<input type="hidden" class="input-text" id="wrongNumber"/>
							</td>
							<c:choose>
								<c:when test="${ptype!='2' && not empty cateList}">
									<th style="width: 76px;" class="text-r">家电品类：</th>
									<td>
							               <span class="w-140">
										<select class="select easyui-combobox" id="catgyS" name="applianceCategory"  multiple="true" multiline="false"  style="width:100%;height:25px" panelMaxHeight="300px">
											<option value=""></option>
											     <c:forEach items="${cateList }" var="ca" varStatus="cast">
													 <option value="${ca }">${ca }</option>
												 </c:forEach>
								                </select>
							                    </span>
									</td>
								</c:when>
								<c:otherwise>
									<th style="width: 76px;" class="text-r">家电品类：</th>
									<td>
										<span class="w-140">
										<select class="select easyui-combobox" id="catgyS" name="applianceCategory"  multiple="true" multiline="false"  style="width:100%;height:25px" panelMaxHeight="300px">
											<option value=""></option>
											<c:forEach items="${category }" var="ca" varStatus="cast">
												<option value="${ca.columns.name }">${ca.columns.name }</option>
											</c:forEach>
										</select>
										</span>
									</td>
								</c:otherwise>
							</c:choose>
						</tr>
						<tr>
							<th style="width: 76px;" class="text-r">服务类型：</th>
							<td>
								<span class="select-box">
									<select class="select" name="serviceType">
										<option value="">请选择</option>
										<c:forEach items="${fns:getNewServiceType() }" var="stype">
											<option value="${stype.columns.name }">${stype.columns.name }</option>
										</c:forEach>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">工单来源：</th>
							<td>
								<select class="select" name="orderType" style="width: 140px;">
									<option value="">请选择</option>
									<c:forEach items="${fns:getOrderTypeList() }" var="ot">
										<option value="${ot.columns.id }">${ot.columns.name }</option>
									</c:forEach>
								</select>
							</td>
							<!-- <th style="width: 76px;" class="text-r">工单状态：</th>
							<td>
								<span class="select-box">
									<select class="select" name="status">
										<option value="">请选择</option>
										<option value="0">待接收</option>
										<option value="1">待派工</option>
										<option value="2">服务中</option>
										<option value="3">待回访</option>
										<option value="4">待结算</option>
										<option value="5">已完工</option>
										<option value="6">取消工单</option>
										<option value="7">暂不派工</option>
										<option value="8">无效工单</option>
									</select>
								</span>
							</td> -->
							<th style="width: 76px;" class="text-r">信息来源：</th>
							<td>
								<span class="select-box">
									<select class="select" name="origin">
									<option value="">请选择</option>
									<c:forEach items="${listorigin }" var="lro">
										<option value="${lro.columns.name }">${lro.columns.name }</option>
									</c:forEach>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">服务工程师：</th>
							<td id="reloadSpan">
								<span class="w-140 dropdown-sin-2">
									<select class="select-box w-120"   id="employs"  multiple name="employeNames"  style="width:140px">
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
								<c:choose>
										<c:when test="${ptype!='2' && not empty brandList}">
											<th style="width: 76px;" class="text-r">家电品牌：</th>
											<td>
							                 <span class="select-box">
								              <select class="select easyui-combobox"  id="applianceBrands" multiple="true" multiline="false" name="applianceBrands" style="width:100%;height:25px" panelMaxHeight="300px">
									        	<option value=""></option>
											     <c:forEach items="${brandList }" var="ba" varStatus="brand">
													 <option value="${ba }">${ba }</option>
												 </c:forEach>
								                </select>
									
							                    </span>
											</td>
										</c:when>
										<c:otherwise>
											<th style="width: 76px;" class="text-r">家电品牌：</th>
											<td>
										<span class="w-140">
											<select class="select easyui-combobox"  id="applianceBrands" multiple="true" multiline="false" name="applianceBrands" style="width:100%;height:25px" panelMaxHeight="300px">
											<option value=""> </option>
											<c:forEach items="${brand }" var="mall">
												<option value="${mall.key } ">${mall.key }</option>
											</c:forEach>
											</select>
										</span>
											</td>
										</c:otherwise>
									</c:choose>
						</tr>
						<tr class="moreCondition" style="display: none;">
							<th style="width: 76px;" class="text-r">服务方式：</th>
							<td>
								<span class="select-box">
									<select class="select "  id="serviceMode"  multiline="false" name="serviceMode" style="width:100%;height:25px" panelMaxHeight="300px" >
										<option value="">请选择</option>
										<c:forEach items="${fns:getNewServiceMode() }" var="stype">
									<option value="${stype.columns.name }" >${stype.columns.name }</option>
								</c:forEach>
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
							<th style="width: 76px;" class="text-r">工单收费：</th>
							<td>
								<span class="select-box">
									<select class="select" name="ifReceipt">
									<option value="">请选择</option>
									<option value="0">有</option>
									<option value="1">无</option>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">交单情况：</th>
							<td>
								<span class="select-box">
									<select class="select" name="returnCard">
										<option value="">请选择</option>
										<option value="1">是</option>
										<option value="0">否</option>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">是否交款：</th>
							<td>
								<span class="select-box">
									<select class="select" name="whetherCollection">
										<option value="">请选择</option>
										<option value="1">是</option>
										<option value="0">否</option>
									</select>
								</span>
							</td>
						</tr>
						<tr class="moreCondition" style="display: none;">
							<th style="width: 76px;" class="text-r">登记人：</th>
							<td>
								<input type="text" class="input-text" name="messengerName" />
							</td>
							<th style="width: 76px;" class="text-r">重要程度：</th>
							<td>
								<span class="select-box">
									<select class="select" name="level">
										<option value="">请选择</option>
										<option value="1">紧急</option>
										<option value="2">一般</option>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">家电条码：</th>
							<td>
								<input type="input-text"  name="elictrictyBarcode" value="" class="input-text">
							</td>	
							<!-- <th style="width: 76px;" class="text-r">报修时间：</th> -->
							<th style="width: 76px;" class="text-r">标记类型：</th>
							<td id="reloadSignSpan">
								<span class="w-140 dropdown-sin-2">
									<select class="select-box w-120"  id="signType"  multiple  multiline="true" name="signType"  >
									<c:forEach items="${signList}" var="sign">
										<option value="${sign.columns.id }">${sign.columns.name }</option>
									</c:forEach>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">结算审核：</th>
							<td>
								<span class="select-box">
									<select class="select" name="review">
										<option value="">请选择</option>
										<option value="0">未审核</option>
										<option value="1">审核通过</option>
										<option value="2">审核未通过</option>
									</select>
								</span>
							</td>

						</tr>
						<tr class="moreCondition" style="display: none;">
							<th style="width: 76px;" class="text-r">预约日期：</th>
							<td>
								<input type="text" onfocus="WdatePicker({})" id="promiseTime" name="promiseTime" value="" class="input-text Wdate radius">
							</td>
							<th style="width: 76px" class="text-r">报修时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'repairTimeMax\')||\'%y-%M-%d\'}'})" id="repairTimeMin" name="repairTimeMin"  value="" class="input-text Wdate w-140" style="width:140px">
								至
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'repairTimeMin\')}',maxDate:'%y-%M-%d 23:59:59'})" id="repairTimeMax" name="repairTimeMax"  value="" class="input-text Wdate w-140" style="width:140px">
							</td>
							<th style="width: 76px" class="text-r">派工时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'dispatchTimesMax\')||\'%y-%M-%d\'}'})" id="dispatchTimesMin" name="dispatchTimesMin"  value="" class="input-text Wdate w-120" style="width:140px">
								至
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'dispatchTimesMin\')}',maxDate:'%y-%M-%d 23:59:59'})" id="dispatchTimesMax" name="dispatchTimesMax"  value="" class="input-text Wdate w-120" style="width:140px">
							</td>
						</tr>
						<tr class="moreCondition" style="display: none;">
							<th style="width: 76px" class="text-r">完工时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'endTimeMax\')||\'%y-%M-%d\'}'})"  id="endTimeMin" name="endTimeMin" value="" class="input-text Wdate w-120" style="width:140px">
								至
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'endTimeMin\')}',maxDate:'%y-%M-%d 23:59:59'})" id="endTimeMax" name="endTimeMax"  value="" class="input-text Wdate w-120" style="width:140px">
							</td>
						</tr>
					</table>
				</div>
			</form>
			<div class="pt-10 pb-5 cl">
				<div class="f-l">
					<%-- <sfTags:pagePermission authFlag="ORDERMGM_HISTORYORDER_FINISHORDER_NEWORDER_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt" onclick="addNew();"><i class="sficon sficon-add"></i>新建工单</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="ORDERMGM_HISTORYORDER_FINISHORDER_DISPATCH_BTN" html='<a href="javascript:directDis();" class="sfbtn sfbtn-opt"><i class="sficon sficon-dispatch"></i>派工</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="ORDERMGM_HISTORYORDER_FINISHORDER_ZBDISPATCH_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt"><i class="sficon sficon-notdispatch"></i>暂不派工</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="ORDERMGM_HISTORYORDER_FINISHORDER_WXORDER_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt"><i class="sficon sficon-invalid"></i>无效工单</a>'></sfTags:pagePermission> --%>
					<sfTags:pagePermission authFlag="ORDERMGM_HISTORYORDER_FINISHORDER_QUNFAMSG_BTN" html='<a href="javascript:;" onclick="senMagPopup()" class="sfbtn sfbtn-opt"><i class="sficon sficon-massText"></i>群发短信</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="ORDER_MARKORDER_BTN_OTHERS" html='<a href="javascript:showMarkOrders();" class="sfbtn sfbtn-opt"><i class="sficon sficon-sign"></i>标记工单</a>'></sfTags:pagePermission>
				</div>
				<div class="f-r">
					<a href="javascript:;" class="sfbtn sfbtn-opt2 reloadPageBtn"><i class="sficon sficon-reload"></i>刷新</a>
					<%-- <sfTags:pagePermission authFlag="ORDERMGM_HISTORYORDER_FINISHORDER_IMPORT_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt2"><i class="sficon sficon-import"></i>导入</a>'></sfTags:pagePermission> --%>
					<sfTags:pagePermission authFlag="ORDERMGM_HISTORYORDER_FINISHORDER_EXPORT_BTN" html='<a onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="ORDERMGM_HISTORYORDER_FINISHORDER_TBSETTLE_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt2" id="setHeadersBtn"><i class="sficon sficon-setting"></i>表头设置</a>'></sfTags:pagePermission>
				</div>
								
			</div>
			<div>
				<table id="table-waitdispatch" class="table"></table>
				<div class="cl pt-10">
						<div class="f-l iconsBoxWrap">
								<a class="iconDec">图标注释？</a>
								<div class="iconsBox">
									<div class="iconsBoxBg">
										<div class="cl pl-10 pt-5">
											<span class="oState state-dgbd w-80 mb-5">导购报单</span>
											<span class="oState state-refuse w-80 mb-5">标记工单</span>
											<span class="oState state-verify2nopass mb-5">结算审核未通过</span>
										</div>
									</div>
									
									<span class="iconArrow"></span>
								</div>
						</div>
					<div class="f-r">
						<div class="pagination"></div>
					</div>
				</div>
			</div>
		

</div>

<!-- 表头设置 -->
<div class="">
	<div>
		<h2></h2>
	</div>
</div>
</div>
</div>


<div class="popupBox w-640 jiaodan">
	<h2 class="popupHead">
		交单
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pt-30 pl-20 pr-20 pb-20">
			<p class="text-c f-14 lh-24 showNumsTip" >您共选择了<span class="pl-5 pr-5 va-t f-18 c-fe0101 selectOrderAll">0</span>个工单， <span class="youxiaoOrder">0 </span> 个工单可进行批量交单操作！</p>
			<div class="mt-10 mb-15 bk-gray pd-10 radius cl">
				<div class="f-l w-130 text-c pt-20 pb-20">
					<p class="f-16 lh-24 pt-10"><span class="f-20 c-0e8ee7 va-t payMoneyOrderAll">0</span>元</p>
					<p class="c-666 f-13 lh-24 ">收费总额</p>
				</div>
				<div class="f-l pt-20 pb-20 pl-20 w-430 " style="border-left: 1px dashed #ccc;">
					<div class="cl mb-20">
						<span class="f-l w-90 lh-28 f-14 bg-e2eefc radius text-c">二维码收款</span>
						<span class="f-l ml-10 f-18 nomoneyPay">2000元</span>
						<span class="f-l f-13 c-666">（支付宝：<span class="zfbPayMoney">0</span>元，微信：<span class="wxPayMoney">0</span>元）</span>
					</div>
					<div class="cl">
						<span class="f-l w-90 lh-28 f-14 bg-e2eefc radius text-c">现金收款</span>
						<span class="f-l ml-10 f-18 payFlash">10,000元</span>
					</div>
				</div>
			</div>
			<div class="cl mb-15 f-13 zanshiyincang">
				<label class="label-cbox2 f-l mt-3" id="btn_checkPay">确认已交款</label>
				<div style="display:none;" class="showOrHide">
					<label class="f-l ml-20">实收金额：</label>
					<input type="text" class="input-text w-90 f-l realPayMoney" value="0" />
					<input type="text" hidden="hidden" id="ifSelect" />
					<input type="text" hidden="hidden" id="oneOrMore" />
					<span class="f-l lh-26 pl-5">元</span>
				</div>
			</div>
			<div class="text-c pt-20">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" onclick="clickConfirmRC()">确认交单</a>
				<a onclick="closeJiaodan()" class="sfbtn sfbtn-opt w-70">取消</a>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
var definedContentTz="";
var id = '${headerData.id}';						//服务商表格的ID
var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部
var defaultId = '${headerData.defaultId}';			//系统表格的ID
function numerCheck(){
	$.post("${ctx}/order/getOrderTabCount",{tab:"lsgd"},function(result){
		$("#tab_c1").text(result.c1);
		$("#tab_c2").text(result.c2);
		$("#tab_c3").text(result.c3);
	});
}
$(function(){
	$('.iconDec').showIcons();
	$.post("${ctx}/order/remainMsgNum",{},function(result){
		$("#sign").val(result.columns.sms_sign);
		$("#siteMsgNums").val(result.columns.sms_available_amount);
	});
	numerCheck();

    $('.dropdown-sin-2').dropdown({
        // data: json2.data,
        input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
        choice: function() {
        }
    });

	$.tabfold("#moresearch",".moreCondition",1,"click");
	initSfGrid();
	$("#serviceMode").select2({tags:true});
	 $("#serviceMode").next(".select2").find(".selection").css("width","140px");

	$('#setHeadersBtn').click(function(){
		$('.addHeaders').tableHeaderSetting({
			id:id,
			defaultId: defaultId,
			sfHeader: defaultHeader,
			sfSortColumns: sortHeader,
			tableHeaderSaveUrl:'${ctx}/operate/site/saveTableHeader'
		}).popup();
	});
	$('#btn_checkPay').on('click', function(){
		if($(this).hasClass('label-cbox2-selected')){
			$(this).removeClass('label-cbox2-selected');
		}else{
			$(this).addClass('label-cbox2-selected');
		}
	})
});

window.onload=function(){
    $("#_easyui_combobox_i1_0").remove();
}
$(".resetSearchBtn").on("click",function(){
    $("#catgyS").combobox('clear');
    var html = '<span class="w-140 dropdown-sin-2">';
    html += '<select class="select-box w-120"  id="employs" style="display:none" multiple multiline="true" name="employeNames"  >';
    html += '<c:forEach items="${fns:getEmloyeList(siteId) }" var="emp">';
    html += ' <option value="${emp.columns.name }">${emp.columns.name }</option>';
    html += '</c:forEach>';
    html += '</select>  </span>';
    $("#reloadSpan").html(html);
    var html2 = '<span class="w-140 dropdown-sin-2">';
    html2 += '<select class="select-box w-120"  id="signType" style="display:none" multiple  multiline="true" name="signType" >';
    html2 += '<c:forEach items="${signList}" var="sign">';
    html2 += ' <option value="${sign.columns.id }">${sign.columns.name }</option>';
    html2 += '</c:forEach>';
    html2 += '</select>  </span>';
    $("#reloadSignSpan").html(html2);
    $('.dropdown-sin-2').dropdown({
        input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
    });
});
function initSfGrid(){
	$("#table-waitdispatch").sfGrid({
		url : '${ctx}/order/getOrderMenuList/ywc?ptype='+${ptype},
		sfHeader: eval('${headerData.tableHeader}'),
		sfSortColumns:'${headerData.sortHeader}',
		rownumbers:true,
		gridComplete:function(){
			_order_comm.gridNum();
			if($("#table-waitdispatch").find("tr").length>1){
				$(".ui-jqgrid-hdiv").css("overflow","hidden");
			}else{
				$(".ui-jqgrid-hdiv").css("overflow","auto");
			}
		}
	});
}

function fmtAttitude(row){
	if(row.service_attitude=='1'){
		return "十分不满意";
	}else if(row.service_attitude=='2'){
		return "不满意";
	}else if(row.service_attitude=='3'){
		return "一般 ";
	}else if(row.service_attitude=='4'){
		return "满意 ";
	}else if(row.service_attitude=='5'){
		return "十分满意 ";
	}else if(row.service_attitude=='6'){
        return "无效回访 ";
    }else if(row.service_attitude=='7'){
        return "回访未成功";
    } else{
		return "";
	}
}

function statusFmt(rowId, cellval , colpos){
	if(cellval == 1){
		return "<span>dfdf</span>";
	}
	return "<span>"+colpos.appliance_category+colpos.appliance_brand+"</span>";
}

function addNew(){
	layer.open({
		type : 2,
		content:'${ctx}/order/form',
		title:false,
		area: ['100%','100%'],
		closeBtn:0,
		shade:0,
		anim:-1 
	});
}
function fmtOrderNo(rowData){
	return '<a href="javascript:showDetail(\''+rowData.id+'\');" class="c-0383dc">'+rowData.number+'</a>';
}
function showDetail(id){
	$("#table-waitdispatch").jqGrid('resetSelection');
	 $("#table-waitdispatch").jqGrid('setSelection',id);
	layer.open({
		type : 2,
		content:'${ctx}/order/orderDispatch/historyform?id='+id,
		title:false,
		area: ['100%','100%'],
		closeBtn:0,
		shade:0,
		fadeIn:0,
		anim:-1 
	});
}
function search(){

    var pageSize = $("#pageSize").val();
	if($.trim(pageSize)=='' || pageSize==null){
		$("#pageSize").val(20);
	}
    $("#table-waitdispatch").sfGridSearch({
        postData: $("#searchForm").serializeJson()
    });
}

function exports(){
    var now = new Date();
    var hours = now.getHours();
    var minutes = now.getMinutes();
    var nowM = hours * 60 + minutes;
    var start = 7 * 60 + 30;
    var end = 11 * 60 + 30;
    if (nowM >= start && nowM <= end) {
        layer.msg("温馨提醒：系统使用高峰期7:30-11:30,请在其它时间导入、导出！谢谢！");
        return false;
    }

	var idArr=$("#table-waitdispatch").jqGrid('getGridParam','records')
	var content="共"+idArr+"条数据，本次允许导出前10000条，确定继续导出吗？";
	if(idArr>10000){
		$('body').popup({
			level:3,
			title:"导出",
			content:content,
			 fnConfirm :function(){
				 location.href="${ctx}/order/export?formPath=/a/order/getWwgList/ywc&&maps="+$("#searchForm").serialize(); 
			 },
fnCancel: function () {
				 
             }
	
		});
	}else{
		 location.href="${ctx}/order/export?formPath=/a/order/getWwgList/ywc&&maps="+$("#searchForm").serialize();
		
	}

}

function senMagPopup(){
	var ids=$('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
	if(ids.length > 0){
		layer.open({
	        type : 2,
	        content:'${ctx}/order/sendMsgAccounts?ids=' + ids.join(","),
	        title:false,
	        area: ['100%','100%'],
	        closeBtn:0,
	        shade:0,
	        anim:-1
	    });
	}else{
		layer.msg("请先选择数据！");
	}
}

function isBlank(val){
	if(val==null || $.trim(val)==""){
		return true;
	}
	return false;
}

 function returnMobile(val){
	  var mobile="";
	 if(val!=null && val!=""){
		 var mobiles=val.split(",");
		 mobile=mobiles[0];
	 }
	 return mobile;
 }


function guanbi(){
	$.closeDiv($(".massTextNote"));
	$.closeDiv($(".msgTextQuren"));
	$.closeDiv($(".massText"));
}

function closePopup(){
	$.closeDiv($(".massTextNote"));
	$.closeDiv($(".msgTextQuren"));
	$.closeDiv($(".massText"));
}

function confirmCollection(id){//确认交款
	$('body').popup({
		level:'3',
		type:2,
		content:"您确定要交款吗?",
		fnConfirm:function(){
			$.ajax({
				type:"post",
				traditional:true,
				data:{id:id},
				url:"${ctx}/order/confirmCollection",
				dataType:"JSON",
				success:function(result){
					if(result==true){
						layer.msg("交款成功！");
						window.location.reload(true);
					}else{
						layer.msg("交款失败，请检查！");
					}
				}
			})
		}
	})
}

function confirmCard(id){ //确认交单
	$("#oneOrMore").val('2');
	dealJiaodan(id,'2');
}

/*enter查询*/
function enterEvent(event){
	var keyCode = event.keyCode?event.keyCode:event.which?event.which:event.charCode;
	if (keyCode ==13){
		$("#table-waitdispatch").sfGridSearch({
        postData: $("#searchForm").serializeJson()
    });
	}
}

function cancelQueren(){
	$.closeDiv($(".msgTextQuren"));
}
function showMarkOrders() {
    var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
    if (idArr.length <= 0) {
        layer.msg("请选择需要标记的工单");
        return;
    }

    layer.open({
        type : 2,
        content:'${ctx}/order/showMarkOrders?ids=' + idArr.join(","),
        title:false,
        area: ['100%','100%'],
        closeBtn:0,
        shade:0,
        anim:-1
    });
}

var plIds="";
function dealJiaodan(ids,type){//处理交单
	$(".showOrHide").hide();
	$("#btn_checkPay").removeClass('label-cbox2-selected');
	 //异步获取数据
    $.ajax({
    	type:"post",
    	url:"${ctx}/order/jiaodanPageShow",
    	data:{ids:ids},
    	success:function(data){
    		//type:1批量交单 2 单个交单
   			if(data.count < 1){
   				var msg = "您选择的数据中没有可以确认交单的，请重新选择！";
   				if(type=="2"){
   					msg="该工单已确认交单，请重新选择！";
   				}
       			layer.msg(msg);
       			return;
       		}
   			plIds = data.idss;
   			var result = data.data.columns;
   			$(".youxiaoOrder").text(data.count);//需要交单的工单数
   			$(".nomoneyPay").text((isBlankJd(result.allMoney) ? 0.00 : result.allMoney).toFixed(2));//无现金收款
   			$(".zfbPayMoney").text((isBlankJd(result.zfbMoney) ? 0.00 : result.zfbMoney).toFixed(2));//支付宝收款
   			$(".wxPayMoney").text((isBlankJd(result.wxMoney) ? 0.00 : result.wxMoney).toFixed(2));//微信收款
   			$(".payMoneyOrderAll").text((isBlankJd(result.realPayMoney) ? 0.00 : result.realPayMoney).toFixed(2));//收款总额
   			var flashMy = (parseFloat($(".payMoneyOrderAll").text())-parseFloat($(".nomoneyPay").text())).toFixed(2);
   			if(parseFloat(flashMy) < parseFloat(0)){
   				flashMy=0;
   			}
   			$('#ifSelect').val('2');
   			$(".payFlash").text(flashMy);//现金收款
   			$(".realPayMoney").val((isBlankJd(result.realPayMoney) ? 0.00 : result.realPayMoney).toFixed(2));//实收金额
   			var rpm = $('.realPayMoney');
   			if(type=="2"){//单个交单
   				$(".zanshiyincang").show();
   				$(".showNumsTip").hide();
   				/* rpm.removeClass("readonly");
   				rpm.removeAttr("readonly"); */
   				if(result.whether_collection=="1"){//是否交款,1:已交款
   					$("#btn_checkPay").addClass('label-cbox2-selected');
   					$('#ifSelect').val('1');
   					$(".realPayMoney").val((isBlankJd(result.shishouMoney) ? 0.00 : result.shishouMoney).toFixed(2));//实收金额
   					$(".showOrHide").show();
   				}
   			}
   			if(type=="1"){//批量交单
   				$(".zanshiyincang").hide();
   				$(".showNumsTip").show();
   				/* rpm.addClass("readonly");
   				rpm.attr("readonly","readonly"); */
   			}
   		    $("#btn_checkPay").bind('click',function(){
   		    	var ts = $("#btn_checkPay");
   		    	if(ts.hasClass('label-cbox2-selected')){
   		    		$(".showOrHide").show();
   		    		$('#ifSelect').val('1');
   		    	}else{
   		    		$(".showOrHide").hide();
   		    		$('#ifSelect').val('2');
   		    	}
   		    })
   			
   			$(".jiaodan").popup();
    	}
    })
}

function isBlankJd(num){
	if($.trim(num)=="" || num==null || num==undefined ){
		return true;
	}
	if(parseFloat(num < parseFloat(0))){
		return true;
	}
	return false;
}
var rcClick = false;
function clickConfirmRC(){
	if(rcClick){
		return;
	}
	var relMoney = $('.realPayMoney').val();
	var ifSelect = $('#ifSelect').val();
	var oneOrMore = $('#oneOrMore').val();
	if(ifSelect=="1"){
		if(!checkShiShouMy(relMoney)){
			layer.msg("实收金额格式有误！");
    		return;
    	}
	}
	rcClick=true;
	 $.ajax({
         type:"post",
         traditional:true,
         data:{id:plIds,relMoney:relMoney,ifSelect:ifSelect,oneOrMore:oneOrMore},
         url:"${ctx}/order/confirmCard",
         success:function(result){
             if(result=="ok"){
                 layer.msg("交单成功！");
                 search();
                 $.closeDiv($('.jiaodan'));
             }else if(result=="notExist"){
            	 layer.msg("工单信息信息有误，交单失败！");
            	 return;
             }else{
                 layer.msg("交单失败，请检查！");
                 return ;
             }
             rcClick=false;
         }
     })
}

$(".realPayMoney").blur(function(){
	var blon = checkShiShouMy($.trim($(".realPayMoney").val()));
	if(!blon){
		layer.msg("实收金额格式有误！");
	};
});
function checkShiShouMy(num){
	var money = /^[0-9]+(.[0-9]{1,2}?|)$/;
	return money.test(num);
};

function closeJiaodan(){
	$.closeDiv($('.jiaodan'));
}

//供子页面调用
function getMsgToChildPageArr(id){
	var map = {};
	map.ids = $('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
	map.data = $("#table-waitdispatch").jqGrid('getRowData',id);
	var mark = "2";
	map.mark=mark;
	return map;
}

function fmtRC(rowData) {//交单情况
 	if (rowData.status == "3" || rowData.status == "4" || rowData.status == "5" || rowData.status == "8" ) {
 		if ("0" == rowData.return_card || "2" == rowData.return_card) {
 			if('${fns:checkBtnPermission("ORDERMGM_HISTORYORDER_FINISHORDER_RETURNCARDCONFIRM_BTN")}' === 'true'){
 				return "<a style='color:blue;' onclick='confirmCard(\"" + rowData.id + "\")'>确认</a>";
 			}else{
 				return "否";
 			}
 		} else if ("1" == rowData.return_card) {
 			return "是";
 		} else {
 			return "--";
 		}
 	} else {
 		return "--";
 	}
 }
</script>
	
</body>
</html>
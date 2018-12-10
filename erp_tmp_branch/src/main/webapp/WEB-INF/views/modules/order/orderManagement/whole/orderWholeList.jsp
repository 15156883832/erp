<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta charset="utf-8">
	<title>全部工单</title>
	<meta name="decorator" content="base"/>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/tips_style.css"/>
	<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/>
	<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/>
	<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>

	<%--<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/moreSelect/bootstrap.min.css">--%>
	<!-- <script type="text/javascript" src="mock.js"></script>-->
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.css">
	<script src="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.fix1.js"></script>
	
<script type="text/javascript" src="${ctxPlugin}/lib/lodop/LodopFuncs.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/lodop/base64.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/lodop/printdesign.js"></script>

	<style type="text/css">
		.SelectBG{
			background-color:#ffe6e2;
		}
		.dropdown-display{font-size: 12px}
		.dropdown-selected{margin-top: 4px}
	</style>
</head>
<body>
<div class="sfpagebg bk-gray">
	<div class="sfpage table-header-settable">
		<div class="page-orderWait">
			<div id="tab-system" class="HuiTab">
				<div class="tabBar cl mb-10">

					<sfTags:pagePermission authFlag="ORDERMGM_ALLORDER_ALLORDER_TAB" html='<a class="btn-tabBar current"  href="${ctx }/order/Whole">全部工单</a>'></sfTags:pagePermission><!--orderWholeList -->
					<sfTags:pagePermission authFlag="ORDERMGM_ALLORDER_JRTXBJ_TAB" html='<a class="btn-tabBar"  href="${ctx }/order/jrtxbj">今日提醒标记</a>'></sfTags:pagePermission><!--orderWholeList -->
					<sfTags:pagePermission authFlag="ORDERMGM_HISTORYORDER_WXORDER_TAB" html='<a class="btn-tabBar" href="${ctx }/order/getWwgList/wxgd">无效工单</a>'></sfTags:pagePermission>

					<p class="f-r btnWrap">
						<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
						<a href="javascript:;" class="sfbtn sfbtn-opt moresearch" id="moresearch" ><i class="sficon sficon-moresearch"></i>更多查询</a>
						<a href="javascript:;" onclick="reset()" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
					</p>
				</div>
				<div class="tabCon">
					<form id="searchForm">
						<%-- <input type="hidden" name="createTime" id="createTime" value="${order.createTime }"> --%>
						<input type="hidden" name="page" id="pageNo" value="1">
						<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
						<input type="hidden" name="ptype" value="${ptype}"/>
						<div class="bk-gray pt-10 pb-5 ">
							<table class="table table-search">
								<tr>
									<th style="width: 76px;" class="text-r">工单编号：</th>
									<td>
										<input type="text" class="input-text" name= "number"/>
									</td>
									<th style="width: 76px;" class="text-r">用户姓名：</th>
									<td>
										<input type="text" class="input-text" name = "customerName" id="enterName" onkeydown="enterEvent(event)"/>
									</td>
									<th style="width: 76px;" class="text-r">联系方式：</th>
									<td>
										<input type="text" class="input-text" name = "customerMobile" id="enterMobile" onkeydown="enterEvent(event)"/>
										<input type="hidden" class="input-text" name = "orderStatus" id="orderStatus"/>
									</td>
									<th style="width: 76px;" class="text-r">用户地址：</th>
									<td>
										<input type="text" class="input-text" name = "customerAddress" id="enterAddress" onkeydown="enterEvent(event)"/>
									</td>
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
									<c:choose>
										<c:when test="${ptype!='2' && not empty cateList}">
											<th style="width: 76px;" class="text-r">家电品类：</th>
											<td>
							                <span class="w-140">
										<select class="select easyui-combobox" id="catgyS" name="applianceCategory" multiple="true" multiline="false"  style="width:100%;height:25px" panelMaxHeight="300px">
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
										<select class="select easyui-combobox" id="catgyS" name="applianceCategory" multiple="true" multiline="false"  style="width:100%;height:25px" panelMaxHeight="300px">
											<option value=""></option>
											<c:forEach items="${category }" var="ca" varStatus="cast">
												<option value="${ca.columns.name }">${ca.columns.name }</option>
											</c:forEach>
										</select>
										</span>
											</td>
										</c:otherwise>
									</c:choose>


									<th style="width: 76px;" class="text-r">工单状态：</th>
									<td>
								<span class="w-140">
									<select class="select easyui-combobox"  id="statusFlag" multiple="true" multiline="false" name="statuss" style="width:100%;height:25px" panelMaxHeight="300px">
										<option value="0">待接收</option>
										<option value="1">待派工</option>
										<!-- <option value="9">待接单</option> -->
										<option value="2">服务中</option>
										<option value="3">待回访</option>
										<option value="4">待结算</option>
										<option value="5">已完成</option>
										<option value="6">取消工单</option>
										<option value="7">暂不派工</option>
										<option value="8">无效工单</option>
									</select>
								</span>
									</td>
									<th style="width: 76px;" class="text-r">标记类型：</th>
									<td id="reloadSignSpan">
										<span class="w-140 dropdown-sin-2">
											<select class="select-box w-120"  id="signType" style="display:none" multiple  multiline="true" name="signType"  >
											<c:forEach items="${signList}" var="sign">
												<option value="${sign.columns.id }">${sign.columns.name }</option>
											</c:forEach>
											</select>
										</span>
									</td>

									<th style="width: 76px;" class="text-r">服务工程师：</th>
									<td id="reloadSpan">
										<span class="w-140 dropdown-sin-2">
											<select class="select-box w-120"  id="employs" style="display:none" multiple  multiline="true" name="employeNames"  >
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
								</tr>
								<tr class="moreCondition" style="display: none;">
									<c:choose>
										<c:when test="${ptype!='2' && not empty brandList}">
											<th style="width: 76px;" class="text-r">家电品牌：</th>
											<td>
							                 <span class="select-box">
								               <select class="select" name="applianceBrands">
									        	<option value="">请选择</option>
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

									<th style="width: 76px;" class="text-r">家电型号：</th>
									<td>
										<input type="text" class="input-text" name="applianceModel" />
									</td>
									<th style="width: 76px;" class="text-r">家电条码：</th>
									<td>
										<input type="input-text"  name="elictrictyBarcode" value="" class="input-text">
									</td>
									<th style="width: 76px;" class="text-r">保修类型：</th>
									<td>
								<span class="w-140">
									<select class="select" name="warrantyType">
										<option value="">请选择</option>
										<option value="1">保内</option>
										<option value="2">保外</option>
										<!-- <option value="3">保内转保外</option> -->
									</select>
								</span>
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
										<!-- <input type="text" class="input-text" id="serviceMode" name="serviceMode"/> -->
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
									<th style="width: 76px;" class="text-r">预约日期：</th>
									<td>
										<input type="text" onfocus="WdatePicker({})" id="promiseTime" name="promiseTime"
											   value="" class="input-text Wdate">
									</td>
									<th style="width: 76px;" class="text-r">登记人：</th>
									<td>
										<input type="text" class="input-text" name="messengerName"/>
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
								</tr>
								<tr class="moreCondition" style="display: none;">
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
									<th style="width: 76px;" class="text-r">是否录单：</th>
									<td>
										<span class="select-box">
											<select class="select" name="recordAccount">
												<option value="">请选择</option>
												<option value="1">是</option>
												<option value="0">否</option>
											</select>
										</span>
									</td>
									<td colspan="2">
										<label style="margin-left: -12px">厂家工单编号：</label>
										<input type="text" class="input-text" name= "factorynumber"/>
									</td>
									<th class="text-r">购机商场：</th>
									<td>
										<input type="text" class="input-text" name= "pleaseReferMall"/>
									</td>

								</tr>
								<tr class="moreCondition" style="display: none;">
									<th style="width: 76px;" class="text-r">备注：</th>
									<td>
										<input type="text" class="input-text" name= "remarks"/>
									</td>

									<th style="width: 76px;" class="text-r">派工时间：</th>
									<td colspan="3">
										<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'repairTimeMax\')||\'%y-%M-%d\'}'})"  name="dispatchTimeMin" value="" class="input-text Wdate w-120" style="width:140px">
										至
										<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'repairTimeMin\')}',maxDate:'%y-%M-%d 23:59:59'})" id="dispatchTime" name="dispatchTimeMax"  value="" class="input-text Wdate w-120" style="width:140px">
									</td>

									<td colspan="4">
										<label style="margin-left: -12px">录单操作时间：</label>
										<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'recordDateMax\')||\'%y-%M-%d\'}'})"  id="recordDateMin" name="recordDateMin" value="" class="input-text Wdate w-120" style="width:140px">
										至
										<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'recordDateMin\')}',maxDate:'%y-%M-%d 23:59:59'})" id="recordDateMax" name="recordDateMax"  value="" class="input-text Wdate w-120" style="width:140px">
									</td>
								</tr>
								<tr class="moreCondition" style="display: none;">
									<th style="width: 76px;" class="text-r">是否打印：</th>
									<td>
										<span class="select-box">
											<select class="select" name="isPrintSrue">
												<option value="">请选择</option>
												<option value="1">是</option>
												<option value="0">否</option>
											</select>
										</span>
									</td>

									<th style="width: 76px;" class="text-r">报修时间：</th>
									<td colspan="3">
										<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'repairTimeMax\')||\'%y-%M-%d\'}'})" id="repairTimeMin" name="repairTimeMin" value="" class="input-text Wdate w-140" style="width:140px">
										至
										<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'repairTimeMin\')}',maxDate:'%y-%M-%d 23:59:59'})" id="repairTimeMax" name="repairTimeMax"  value="" class="input-text Wdate w-140" style="width:140px">
									</td>

									<td colspan="4">
										<label style="margin-left: -12px">标记提醒时间：</label>
										<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'alertDateMax\')||\'%y-%M-%d\'}'})"  id="alertDateMin" name="alertDateMin" value="" class="input-text Wdate w-120" style="width:140px">
										至
										<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'alertDateMin\')}',maxDate:'%y-%M-%d 23:59:59'})" id="alertDateMax" name="alertDateMax"  value="" class="input-text Wdate w-120" style="width:140px">
									</td>
								</tr>
								<tr class="moreCondition" style="display: none;">
									<th style="width: 76px;" class="text-r">用户类型：</th>
									<td>
										<span class="select-box">
											<select class="select" name="customerType">
												<option value="">请选择</option>
												 <c:forEach items="${fns:getCustomerType()}" var="to">
								                    <option value="${to.columns.name }">${to.columns.name }</option>
								                 </c:forEach>
											</select>
										</span>
									</td>
									<th style="width: 76px;" class="text-r">完工时间：</th>
									<td colspan="3">
										<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'endTimeMax\')||\'%y-%M-%d\'}'})"  id="endTimeMin" name="endTimeMin" value="" class="input-text Wdate w-120" style="width:140px">
										至
										<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'endTimeMin\')}',maxDate:'%y-%M-%d 23:59:59'})" id="endTimeMax" name="endTimeMax"  value="" class="input-text Wdate w-120" style="width:140px">

									</td>

								</tr>
							</table>
						</div>
					</form>
					<div class="pt-10 cl tableBtns">
						<div class="f-l pb-5">
							<sfTags:pagePermission authFlag="ORDERMGM_ALLORDER_ALLORDER_NEWORDER_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt" onclick="addNew();" id="btnAddnew"><i class="sficon sficon-add"></i>新建工单</a>'></sfTags:pagePermission>
							<sfTags:pagePermission authFlag="ORDERMGM_ALLORDER_RECV_ORDER_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt" onclick="recvOrder();" id="btnRecvOrder"><i class="sficon sficon-jiedan"></i>接单</a>'></sfTags:pagePermission>
							<sfTags:pagePermission authFlag="ORDERMGM_ALLORDER_REFUSE_ORDER_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt" onclick="refuseOrder();" id="btnRefuseOrder"><i class="sficon sficon-judan"></i>拒单</a>'></sfTags:pagePermission>
							<sfTags:pagePermission authFlag="ORDERMGM_ALLORDER_ALLORDER_DISPATCH_BTN" html='<a href="javascript:directDis();" class="sfbtn sfbtn-opt"  id="directpg"><i class="sficon sficon-dispatch"></i>派工</a>'></sfTags:pagePermission>
							<sfTags:pagePermission authFlag="ORDERMGM_ALLORDER_ALLORDER_ZBDISPATCH_BTN" html='<a href="javascript:emporarily();" class="sfbtn sfbtn-opt"><i class="sficon sficon-notdispatch"></i>暂不派工</a>'></sfTags:pagePermission>
							<sfTags:pagePermission authFlag="ORDERMGM_ALLORDER_ALLORDER_PLSETTLE_BTN" html='<a href="javascript:batchJiesuan();" class="sfbtn sfbtn-opt"><i class="sficon sficon-settlement"></i>批量结算</a>'></sfTags:pagePermission>
							<sfTags:pagePermission authFlag="ORDERMGM_ALLORDER_ALLORDER_WXORDER_BTN" html='<a href="javascript:showwxgd();" class="sfbtn sfbtn-opt"><i class="sficon sficon-invalid"></i>无效工单</a>'></sfTags:pagePermission>
							<sfTags:pagePermission authFlag="ORDER_MARKORDER_BTN_OTHERS" html='<a href="javascript:showMarkOrders();" class="sfbtn sfbtn-opt"><i class="sficon sficon-sign"></i>标记工单</a>'></sfTags:pagePermission>
							<sfTags:pagePermission authFlag="ORDERMGM_ALLORDER_ALLORDER_CANCELMARK_BTN" html='<a href="javascript:cancelMarkOrders();" class="sfbtn sfbtn-opt"><i class="sficon sficon-signCancel"></i>取消标记</a>'></sfTags:pagePermission>
							<sfTags:pagePermission authFlag="ORDERMGM_ALLORDER_ALLORDER_BATCHCOPY_BTN" html='<a href="javascript:batchCopy();" class="sfbtn sfbtn-opt"><i class="sficon sficon-plcopy"></i>批量复制</a>'></sfTags:pagePermission>
							<sfTags:pagePermission authFlag="ORDERMGM_ALLORDER_ALLORDER_PLJIAODAN_BTN" html='<a href="javascript:plJiaodan();" class="sfbtn sfbtn-opt"><i class="sficon sficon-pljd"></i>批量交单</a>'></sfTags:pagePermission>
							<sfTags:pagePermission authFlag="ORDERMGM_ALLORDER_ALLORDER_BATCHPRINT_BTN" html='<a href="javascript:batchPrint();" id="repeatOrder"  class="sfbtn sfbtn-opt"><i class="sficon sficon-print"></i>批量打印</a>'></sfTags:pagePermission>
							<sfTags:pagePermission authFlag="ORDERMGM_ALLORDER_ALLORDER_BATCHPRINT_BTN" html='<a href="javascript:batchPrints();" id="repeatOrder_custom"  class="sfbtn sfbtn-opt"><i class="sficon sficon-print" ></i>批量打印</a>'></sfTags:pagePermission>
							<sfTags:pagePermission authFlag="ORDERMGM_ALLORDER_ALLORDER_ERJIDISPATCH_BTN" html='<a href="javascript:erjidirectDis();" class="sfbtn sfbtn-opt"  id="erjidirectpg"><i class="sficon sficon-dispatch"></i>指派给二级网点</a>'></sfTags:pagePermission>

							<c:if test="${siteId eq 'ff80808158e6b8a30158e7b812340028' or
							siteId eq 'ff8080816146aa68016149c7aed61929' or
							siteId eq 'ff8080816224612c0162277451ee5c65' or
							siteId eq 'ff8080816229407401622c665f032071' or
							siteId eq 'ff808081643c337a01644011ab0239f7' or
							siteId eq 'ff80808164dc61410164ea2124ae68bb'}">
								<a href="javascript:printOrderCST();" class="sfbtn sfbtn-opt" style="background: #FF7E76;"  id="erjidirectpg"><i class="sficon sficon-print"></i>自定义工单打印(体验版)</a>
							</c:if>

						</div>
						<div class="f-r pb-5">
							<a href="javascript:;" class="sfbtn sfbtn-opt2 reloadPageBtn"><i class="sficon sficon-reload"></i>刷新</a>
							<%-- <sfTags:pagePermission authFlag="ORDERMGM_ALLORDER_ALLORDER_IMPORT_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt2"><i class="sficon sficon-import"></i>导入</a>'></sfTags:pagePermission> --%>
							<sfTags:pagePermission authFlag="ORDERMGM_ALLORDER_ALLORDER_EXPORT_BTN" html='<a onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
							<sfTags:pagePermission authFlag="ORDERMGM_ALLORDER_ALLORDER_TBSET_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt2" id="setHeadersBtn"><i class="sficon sficon-setting"></i>表头设置</a>'></sfTags:pagePermission>
						</div>

					</div>
					<div>
						<table id="table-waitdispatch" class="table"></table>
						<!-- pagination -->
						<div class="cl pt-10">
							<div class="f-l iconsBoxWrap">
								<a class="iconDec">图标注释？</a>
								<div class="iconsBox">
									<div class="iconsBoxBg">
										<div class="cl pl-10 pt-5">
											<span class="oState state-refuseOrder w-80 mb-5">拒接工单</span>
											<span class="oState state-book w-80 mb-5">今日预约</span>

											<span class="oState state-dgbd w-80 mb-5">导购报单</span>
											<span class="oState state-refuse w-80 mb-5">标记工单</span>

											<span class="oState state-quejian1 w-80 mb-5">缺件中</span>
				                            <span class="oState state-quejian2 w-80 mb-5">缺件在途</span>
				                            <span class="oState state-quejian w-80 mb-5">缺件已到</span>
											<span class="oState state-waitFittings w-80 mb-5">待备件</span>
											<span class="oState state-wxgd2 w-150 mb-5">服务反馈无效</span>
											<span class="oState state-nopass3 w-150 mb-5">结算审核未通过</span>
										</div>
									</div>

									<span class="iconArrow"></span>
								</div>
							</div>
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
<!-- 表头设置 -->
<div class="">
	<div>
		<h2></h2>
	</div>
</div>


<div class="popupBox w-710 dispatchBox1 erjiactiveDispatch" >
	<h2 class="popupHead">
		我要派工
		<a href="javascript:;" class="sficon closePopup" onclick="closeDispatch()"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pd-15" >
			<div class="searchbox mb-10">
				<input type="text" placeholder="请输入二级网点名称、所在地区" id="erjifilterName" class="input-text" />
				<a href="javascript:searchSite('1');" class="btn-search"><i class="Hui-iconfont Hui-iconfont-search2 f-16"></i></a>
			</div>
			<div class="tableWrap mt-10 " style="max-height: 320px; overflow: auto;">
				<table class="erjitable table-bordered table-border table-bg text-c " >
					<thead>
					<tr>
						<th class="w-170 text-c"><strong class="f-13">所在地区</strong> </th>
						<th class="w-170 text-c"><strong class="f-13">二级网点</strong></th>
						<th class="w-170 text-c"><strong class="f-13">品牌品类</strong></th>
						<th class="w-140 text-c"><strong class="f-13">选择</strong></th>
					</tr>
					</thead>
					<tbody id="erjizhijiepaidan">

					</tbody>
				</table>
			</div>
			<div class="mt-20 pt-10 pb-5 bk-gray bg-e8f2fa">
				<div class="pos-r pl-60 pr-80">
					<label class="pos w-60"><em class="c-fe0101">派工至</em>：</label>
					<p class="lh-30"><span id="disPatchSiteName"></span></p>
					<input type="button" class="w-70 sfbtn sfbtn-opt3 pos-a" style="right: 10px;top: 0;" onclick="erjidispa()" value="确认派工" />
					<input type="hidden" id="erjiorderId"/>
				</div>
			</div>


		</div>
	</div>
</div>

<!-- 我要派工 -->
<div class="popupBox dispatch activeDispatch " >
	<h2 class="popupHead">
		我要派工
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain cl" >
			<div class="f-l serversWrap">
				<div class="searchbox">
					<input type="text" placeholder="请输入工程师姓名" class="input-text" id="filterName"/>
					<a href="javascript:;" class="btn-search"><i class="Hui-iconfont Hui-iconfont-search2 f-16"></i></a>
				</div>
				<div class="mt-10 showLatestlook" hidden="hidden">
					<a class="iconDec1"></a>该用户最近一次（30天内）的服务工程师：<span id="latestEmps" style="width: 195px;overflow:hidden;text-overflow: ellipsis;white-space: nowrap;" ></span>
				</div>
				<div class="mt-10 serverlistWrap">
					<div class="tableWrap">
						<table class="table table-border table-bg table-serverlist">
							<thead>
							<th class="w-90" style="border-left: none;">工程师姓名</th>
							<th class="w-100">未完成工单</th>
							<!-- <th class="w-100">今日已完成</th> -->
							<th class="w-100">今日未完工
								 <i class="Hui-iconfont f-20 c-fe0101 mr-5 left_tip_">
											&#xe6cd;
											<span class="tip__" style="width:380px;"><em class="left_tip"></em>统计今日派工且未预约以及预约时间为今日的工程师未完工工单数量</span>
										</i>
								</th>
							<th class="w-100">今日已完工</th> 
							<th class="w-80">选择</th>
							</thead>

							<tbody id="zhijiepaidan">

							</tbody>
						</table>
					</div>
					<div class="serversName">
						<div class="txtwrap1 pos-r">
							<label class="lb lb1"><em class="c-fe0101">派工至</em>：</label>
							<p class="lh-30" id="nameWrap"></p>
							<input type="button" class="w-70 sfbtn sfbtn-opt3" value="确认派工" onclick="dispa()"/>
							<input type="hidden" name= "employeId" id="employeId">
							<input type="hidden" name= "orderId" id="orderId">
						</div>
					</div>
				</div>
			</div>
			<div class="f-r w-460">
				<div class="cl mb-10">
					<div class="f-l w-220 bk-gray" id="dispatch_map_container" style="height: 120px;">
						<!-- 地图 -->
					</div>
					<div class="f-l w-230 ml-10 f-13 pt-10" style="height: 120px;">
						<p class=""><strong class="custNam"></strong></p>
						<p class=""><strong class="custMob"></strong></p>
						<p class="custAddr"></p>
					</div>
				</div>
				<div class="cl mb-10">
					<input type="text"  class="input-text w-330 f-l" id="arroundCustomerAddress" />
					<a class="sfbtn sfbtn-opt f-r" href="javascript:searchArroundCust();"><i class="sficon sficon-search"></i>查看周边用户 </a>
				</div>
				<div class="serverlistWrap">
					<div class="tableWrap" style="height: 195px;">
						<table class="table table-border table-bg table-serverlist" style="table-layout: auto;">
							<thead>
							<th class="w-90" style="border-left: none;">姓名</th>
							<th class="w-100">联系方式</th>
							<th class="w-100">报修家电</th>
							<th class="w-90">报修时间</th>
							<th class="w-80">选择</th>
							</thead>
							<tbody id="arroundUserInfo">
							<tr>
								<%--<td style="border-left: none;">小灰灰</td>
								<td>15656565656</td>
								<td>格力空调</td>
								<td>2018-02-23</td>
								<td>
									<label class="label-cbox3" ><input type="checkbox" name="serverSelected" ></label>
								</td>--%>
							</tr>
							</tbody>
						</table>
					</div>
					<div class="serversName">
						<div class="pos-r pl-15 pr-80">
							<p class="pt-5 pb-5 lh-20" style="min-height: 30px"><%--郑经文、小灰灰、张晓明郑经文、小灰灰、张晓明--%></p>
							<input type="button" class="w-70 sfbtn sfbtn-opt3 " onclick="senMsg()" value="发送短信" />
							<input type="hidden" name="sendMsgOrderId" value="" />
							<input type="hidden" name="customerMobileNow" value="" />
							<input type="hidden" name="sign" id="sign" value="" />
							<input type="hidden" name="siteMsgNums" id="siteMsgNums" value="" />
							<input type="hidden" name="jdTelephone" id="jdTelephone" value="" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 短信群发 -->
<div class="popupBox massTextNote massTextNoteQf">
	<h2 class="popupHead">
		短信群发
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain " >
			<div class="f-14">
				您已发送<strong class="c-005aab" id="sucMsg">0</strong>条，未发送<strong class="c-fd7e2a" id="wroMsg">0</strong>条！
			</div>
			<a id="exportLink" onclick="closePopup()" href="${ctx}/order/exportWrongNumber?formPath=/a/order/History" target="_blank" class="c-0383dc mt-10" style="text-decoration: underline;">查看发送失败的工单</a>
			<div class="text-c mt-20">
				<a  class="sfbtn sfbtn-opt w-70" onclick="guanbi()">关闭</a>
			</div>
		</div>
	</div>
</div>

<!-- 暂不派工提示框 -->
<div class="popupBox notDispatch showzbpgdiv">
	<h2 class="popupHead">
		暂不派工
		<a href="javascript:;" class="sficon closePopup" id="zzbpgCloseXX"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain " >
			<div class="txtwrap1 pos-r mb-30">
				<label class="lb lb1"><em class="mark">*</em>暂不派工理由：</label>
				<textarea id="reasonofzbpg" class="textarea"></textarea>
			</div>
			<div class="text-c pl-30">
				<input onclick="TemporarilyDis()" type="button" class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" />
				<input type="button" class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" onclick="cancelZupg();"/>
			</div>
		</div>
	</div>
</div>
<!-- 无效工单提示框 -->
<div class="popupBox notDispatch showwxgddiv">
	<h2 class="popupHead">
		无效工单
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain " >
			<div class="txtwrap1 pos-r mb-30">
				<label class="lb lb1"><em class="mark">*</em>无效类型：</label>
				<select class="select w-140" id="reasonofwxgdType">
					<option value="">请选择</option>
					<option value="1">无效-重复</option>
					<option value="2">无效-机器已好</option>
					<option value="3">无效-费用高不修</option>
					<option value="4">无效-用户没时间</option>
					<option value="5">无效-其他原因</option>
				</select>
			</div>
			<div class="txtwrap1 pos-r mb-30">
				<label class="lb lb1">无效工单理由：</label>
				<textarea id="reasonofwxgd" class="textarea"></textarea>
			</div>
			<div class="text-c pl-30">
				<input onclick="savewxgd()" type="button" class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" />
				<input type="button" onclick="$.closeDiv($('.showwxgddiv'));" class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" />
			</div>
		</div>
	</div>
</div>

<div class="popupBox copyNums" style="width: 300px">
	<h2 class="popupHead">
		批量复制
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pt-15 pb-15">
			<div class="cl mb-10">
				<label class="f-l w-80">复制数量：</label>
				<div class="priceWrap w-170 f-l">
					<input type="text" class="input-text w-170 f-l" name="nums" value=""/>
					<span class="unit">份</span>
				</div>
			</div>
			<div class="text-c pl-30">
				<input type="hidden" name="orderId" />
				<input onclick="batchCopyNow()" type="button" class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" />
				<input type="button" onclick="$.closeDiv($('.copyNums'));" class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" />
			</div>
		</div>
	</div>
</div>
<form action="${ctx}/print/order" id="printForm" target="_blank" method="post"></form>
<div class="popupBox w-380 confirmAccountpop" >
	<h2 class="popupHead">
		是否录单
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pd-15">
			<div class="cl mb-10 text-c">
				<i class="iconType iconType2"></i>您确定要将该工单确认录单吗？
			</div>
			<div class="cl mb-10">
				<label class="f-l w-120">厂家工单编号：</label>
				<input type="text" class="input-text w-170 f-l" name="factoryNumber" id ="factoryNumber" value=""/>
			</div>
			<div class="text-c pt-15">
				<input type="hidden" name="orderIds" id="orderIds" />
				<input onclick="qurenAccount()" type="button" class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" />
				<input type="button" onclick="quxiaoAccount()" class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" />
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

<!-- 确认收款弹出框 -->
<div class="popupBox w-400 qrskShow">
	<h2 class="popupHead">
		确认收款
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pd-20" >
			<div class="w-200" style="margin:0 auto">
				<!-- <p class="mb-15">
					<i class="iconType iconType2" ></i><span style="font-size:14px;">您确定要交款吗？</span>
				</p> -->
				<p class="mb-15 ml-8" style="margin-left:8px;">
					交款总额：<input type="text" class="input-text w-90 mr-5 readonly" readonly="readonly" id="needConfirmMny" />元
				</p>
				<p class="mb-15 ml-8" style="margin-left:8px;">
					回访总额：<input type="text" class="input-text w-90 mr-5 readonly" readonly="readonly" id="callbackCost" />元
				</p>
				<p class="mb-30">
					<em class="mark">*</em>实收总额：<input type="text" class="input-text w-90 mr-5" id="realConfirmMny" />元
					<input type="hidden" id="hideId" />
				</p>
			</div>
			<div class="text-c ">
				<input onclick="saveConfirmPay()" type="button" class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" />
				<input type="button" onclick="canceConfirmPay()" class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" />
			</div>
		</div>
	</div>
</div>




<input type="hidden" id="settleFlag" name="settleFlag" value="${settleFlag }">
<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef"></script>
<%--<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/amap.js"></script>--%>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript">
    function closeDispatch(){
        $("#secondSiteId").val('');
    }
    AMap.service('AMap.Geocoder', function () {//回调函数
        //实例化Geocoder
        geocoder = new AMap.Geocoder();
    });
    var dispatchMap,dispatchMarker,employeMarker;
    var marker;
    var mark;
    var a = true;
    var num = /^[A-Za-z0-9]{1,18}$/ ;

    var id = '${headerData.id}';						//服务商表格的ID
    var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
    var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部
    var defaultId = '${headerData.defaultId}';			//系统表格的ID

    $(".resetSearchBtn").on("click",function(){
        $('#statusFlag').combobox('setValues',"");
        $(".dropdown-clear-all").trigger("click");
    });

    function numerCheck(){

    }

    function printOrderCST(){
        //如果设置过模板，那么直接调用模板打印，否则弹窗提示
		$.get('${ctx}/operate/site/checkOrderPrintTemplate', {siteId: '${siteId}'}, function(result){
			if(result == "y"){//有模板，直接调用
                var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');

                if (idArr.length <= 0) {
                    layer.msg("请先选择工单!");
                } else {
                    var ids = '';
                    $.each(idArr, function(idx, item){
                        ids += ',' + item;
                    });
                    var siteId = '${siteId}';

                    if($("#sfcstform1").length > 0){
                        $("#sfcstform1").remove();
                    }
                    var html = '<form action="${printServerHost}/print/printByTemplateId" target="_blank" method="post" id="sfcstform1" style="display: none;">' +
                        '<input id="print-ids" name="ids" type="hidden"><input name="siteId" id="print-siteId" value="" type="hidden"></form>';
                    $("body").append(html);
                    $("#print-ids").val(ids);
                    $("#print-siteId").val(siteId);
                    $("#sfcstform1").submit();
                }
			}else{
                layer.msg("请先在[系统设置-设置面板-高级设置-新版工单打印]创建打印模板!");
			}
        });
	}
    
    $(function(){
        $('#erjifilterName').keyup(function(){
            $('#erjizhijiepaidan tr').hide()
                .filter(":contains('" +($(this).val()) + "')").show();
            if(isBlank($(this).val())){
                $('#erjizhijiepaidan tr').show();
            }
        }).keyup();//DOM加载完时，绑定事件完成之后立即触发
    	judgedygd();
        
    	 $("#serviceMode").select2({tags:true});
    	 $("#serviceMode").next(".select2").find(".selection").css("width","140px");

    	
        $('#btnAddnew').goHelp('${ctx}/helpindex/indexHelp?a=xjgd');
        $('#directpg').goHelp('${ctx}/helpindex/indexHelp?a=gdpg');

        $.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
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
        initSfGrid();
        
/*         $("#applianceBrands").select2({tags:true});
        $("#applianceBrands").next(".select2").find(".selection").css("width","140px"); */
        $('#filterName').keyup(function(){
            $('#zhijiepaidan tr').hide()
                .filter(":contains('" +($(this).val()) + "')").show();
            if(isBlank($(this).val())){
                $('#zhijiepaidan tr').show();
            }
        }).keyup();//DOM加载完时，绑定事件完成之后立即触发

        $('.dropdown-sin-2').dropdown({
            input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
        });
        $('.dropdownCategory').dropdown({
            input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
        });

        $('.iconDec').showIcons();
        $('#btn_checkPay').on('click', function(){
			if($(this).hasClass('label-cbox2-selected')){
				$(this).removeClass('label-cbox2-selected');
			}else{
				$(this).addClass('label-cbox2-selected');
			}
		})

        $.post("${ctx}/order/remainMsgNum",{},function(result){
            $("#sign").val(result.columns.sms_sign);
            $("#siteMsgNums").val(result.columns.sms_available_amount);
            $("#jdTelephone").val(result.columns.sms_phone);
        });

    });

    window.onload=function(){
        $("#_easyui_combobox_i1_0").remove();
	}

    function showBatchForm(oIds) {
        batchFormIndex = layer.open({
            type: 2,
            content: '${ctx}/order/settlement/batchNew?oIds=' + oIds,
            title: false,
            area: ['100%', '100%'],
            closeBtn: 0,
            shade: 0,
            fadeIn: 0,
            anim: -1
        });
    }

    function closeBatchForm() {
        layer.close(batchFormIndex);
    }

    var batchJiesuanPopupDiv;
    function batchJiesuan() {
        var settleFlag = $("#settleFlag").val();
        var ids = $('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
        for (var i = 0; i < ids.length; i++) {
            var rowData = $('#table-waitdispatch').jqGrid('getRowData', ids[i]);
            if ($.trim(rowData.status) != "待回访" && $.trim(rowData.status) != "待结算") {
                layer.msg("选择的数据不可操作批量结算！");
                return;
            }
        }
        if (ids == null || ids.length == 0) {
            layer.msg("请选择记录!");
            return;
        }
        var pass = true;
        var dispIds = "";
        var oIds = "";
        for (i = 0; i < ids.length; i++) {
            var rowData = $("#table-waitdispatch").jqGrid('getRowData', ids[i]);
            dispIds += "," + rowData.dispId;
            oIds += "," + rowData.id;
            if (rowData.status == '待回访' && settleFlag == '0') {//用户设置了需要回访才能结算
                pass = false;
                break;
            }
        }
        if (pass) {
            dispIds = dispIds.substring(1);
            oIds = oIds.substring(1);
            $("#dispIds").val(dispIds);
            $.ajax({
                type:"post",
                url:"${ctx}/order/settlement/checkAllowSettle",
                data:{ids:oIds},
                success:function(data){
                    if(data.code=="421"){
                        layer.msg("选择的工单中存在编号为"+data.errMsg+"的工单信息异常的工单，请重新选择！");
                    }else if(data.code=="422"){
                        layer.msg("检测到工单关联了已删除的工程师，请联系平台管理员！");
                    }else if(data.code=="200"){
                        showBatchForm(oIds);
                    }else if(data.code=="430") {
                        layer.msg("编号为"+data.errMsg+"的工单请回访后再进行结算！");
                        return;
                    }else if(data.code=="431") {
                        layer.msg("编号为"+data.errMsg+"的工单交款金额和实收金额不一致，请确认一致后再进行结算！");
                        return;
                    }else if(data.code=="432") {
                        layer.msg("编号为"+data.errMsg+"的工单请回访后再进行结算！");
                        return;
                    }else if(data.code=="433") {
                        layer.msg("编号为"+data.errMsg+"的工单交款金额和实收金额不一致，请确认一致后再进行结算！");
                        return;
                    } else{
                        layer.msg("检验失败，请检查！");
                        return false;
                    }
                }
            })
        } else {
            layer.msg("请先回访工单!");
            return;
        }
    }

    $('select[name="fwjsfa"]').on('change',function(){
        var index = $(this).find("option:selected").val();
        $('.sdefined').hide();
        $('.sdefined'+index).show();
    });

    function changeUnit(obj){
        var oIndex = $(obj).find('option:selected').val();
        $(obj).closest('.jsbox').find('.priceWrap').hide();
        $(obj).closest('.jsbox').find('.jsbox'+oIndex).show();

    }

    function saveBatchSettle(){
        if(!testCash($("#total_cost").val())){
            layer.msg("结算总额格式不正确!");
            return ;
        }
        $("input[name='charge_amount']").each(function(i, item){
            if(isBlank($(this).val())){
                check = false;
                return ;
            }else{
                check = true;
            }
        });
        var postData = $("#settleForm").serializeJson();
        if(check){
            $.post("${ctx}/order/orderSettlemnt/batchSaveSettlement", postData, function(result){
                $.closeDiv(batchJiesuanPopupDiv);
            });
        }else{
            layer.msg("请输入结算金额！");
            return ;
        }

    }
    function closepljs(){
        $.closeDiv($('.settlement'));
    }


    function cancelZupg() {
        $.closeDiv($(".showzbpgdiv"));
    }

    $(".closePopup").on("click",function(){
    });

    //暂不派工
    function emporarily() {
        var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
        if (idArr.length < 1) {
            layer.msg("请选择数据！");
        } else {
            var noPromiseTimeCount = 0;
            for (var i = 0; i < idArr.length; i++) {
                var rowData = $('#table-waitdispatch').jqGrid('getRowData', idArr[i]);
                if ($.trim(rowData.status) != "待派工" && $.trim(rowData.status) != "服务中") {
                    layer.msg("选择的数据有不可操作暂不派工！");
                    return;
                }
                if (isBlank(rowData.promise_time)) {
                    noPromiseTimeCount++;
                }
            }
            if (noPromiseTimeCount > 0) {
                $('body').popup({
                    level: '3',
                    type: 2,  // 提示是否进行某种操作
                    content: '您选择的工单中有' + noPromiseTimeCount + '条工单无预约时间，您确认继续操作暂不派工吗？',
                    fnConfirm: function () {
                        $("#orderId").val(idArr.join(","));
                        $("#reasonofzbpg").val("");
                        $('.showzbpgdiv').popup();
                    },
                    fnCancel: function () {
                    }
                });
            } else {
                $("#orderId").val(idArr.join(","));
                $('.showzbpgdiv').popup();
            }
        }
    }

    var tempDis = false;
    function TemporarilyDis() {
        if (tempDis) {
            return;
        }

        var latest_process = $.trim($("#reasonofzbpg").val());
        if (isBlank(latest_process)) {
            layer.msg("请输入理由!");
            return;
        } else {
            var id = $("#orderId").val();
            tempDis = true;
            $.ajax({
                type: "POST",
                url: "${ctx}/order/orderDispatch/TemporarilyDis",
                data: {
                    id: id,
                    latest_process: latest_process
                },
                success: function (result) {
                    layer.msg("暂不派工更新完毕!", {time: 2000});
                    $.closeDiv($(".showzbpgdiv"));
                    $("#table-waitdispatch").trigger("reloadGrid");
                },
                error: function () {
                    alert("系统繁忙!");
                    return;
                },
                complete: function () {
                    tempDis = false;
                }

            });
        }
    }

    //确认无效
    function savewxgd(){
        var reasonofwxgdType = $.trim($("#reasonofwxgdType").val());
        var latest_process = $.trim($("#reasonofwxgd").val());
        if(isBlank(reasonofwxgdType)){
            layer.msg("请选择无效类型!");
            return;
        }else{
            var id = $("#orderId").val();
            $.ajax({
                type:"POST",
                url:"${ctx}/order/orderDispatch/updateOrderInvalid",
                data:{
                    id:id,
                    latest_process:latest_process,
                    reasonofwxgdType:reasonofwxgdType
                },
                async:false,
                success:function(data){
                    if(data){
                        $.closeDiv($('.showwxgddiv'));
                        layer.msg("无效工单更新完毕!", {time: 2000});
                        search();

                    }else{

                        layer.msg("操作失败!",{time:2000});
                    }
                },
                error:function(){
                    layer.alert("系统繁忙!");
                    return;
                }
            });
        }
    }

    //无效工单
    function showwxgd() {
        var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
        if (idArr.length < 1) {
            layer.msg("请选择数据！");
        } else {
                $.ajax({
                url: '${ctx}/order/canMarkAsInvalid',
                data: {
                    ids: idArr
                },
                success: function (data) {
                    $("#reasonofwxgdType").val("");

                    if (data === "Y") {
                        $("#orderId").val(idArr.join(","));
                        //$('.showwxgddiv').popup();
			        	 var wxMark='0';
			        	 var numbers = '';
			        	 for(var i = 0 ; i < idArr.length; i++){
			                 var rowData = $('#table-waitdispatch').jqGrid('getRowData', idArr[i]);
			                 if(rowData.order_type=='一级网点派工'){
			                	 wxMark='1';
			                	 numbers=rowData.number;
			                 }
			        	 }
			        	 if(wxMark=='1'){
			        		 layer.msg("编号为"+numbers+"的工单为一级网点所派，不能进行无效工单操作，请重新选择！");
			        		 return;
			        	 }
			            var marks = [];
			            gyjqGrid(marks, idArr);
			            $('.showwxgddiv').popup();
                    } else if (data === "N") {
                    	 $('body').popup({
                             level: '3',
                             type: 2,  // 提示是否进行某种操作
                             content: '您选择的工单中有服务完工工单，您确定要操作无效工单吗？',
                             fnConfirm: function () {
                            	 $("#orderId").val(idArr.join(","));
                                 //$('.showwxgddiv').popup();
         			        	 var wxMark='0';
         			        	 var numbers = '';
         			        	 for(var i = 0 ; i < idArr.length; i++){
         			                 var rowData = $('#table-waitdispatch').jqGrid('getRowData', idArr[i]);
         			                 if(rowData.order_type=='一级网点派工'){
         			                	 wxMark='1';
         			                	 numbers=rowData.number;
         			                 }
         			        	 }
         			        	 if(wxMark=='1'){
         			        		 layer.msg("编号为"+numbers+"的工单为一级网点所派，不能进行无效工单操作，请重新选择！");
         			        		 return;
         			        	 }
         			            var marks = [];
         			            gyjqGrid(marks, idArr);
         			            $('.showwxgddiv').popup();
                             }
                    	 })
                    } else if("NN" == data) {
                        layer.msg("您选择的工单中包含厂家工单，不能进行无效工单操作，请重新选择！");
					}
                },
                error: function () {
                }
            });
        }
    }


    function gyjqGrid(marks,idArr){
        var id;
        var name;
        var disId;
        for(var i = 0 ; i < idArr.length; i++){
            var rowData = $('#table-waitdispatch').jqGrid('getRowData', idArr[i]);
            if(isBlank(id)){
                id=idArr[i];
                disId = rowData.disorderId;
                name=rowData.employe_name;
            }else{
                disId =disId+","+rowData.disorderId;
                id=id+","+idArr[i];
                name = name +","+ rowData.employe_name;
            }

            marks.push(rowData.customer_lnglat);
        }
        $("#disorderId").val(disId);
        $("#orderId").val(id);
    }
    //确认派工按钮
    var adpoting = false;

    function dispa() {
        if (adpoting) {
            return;
        }
        var empId = $("#employeId").val();
        var orderId = $("#orderId").val();
        if (isBlank(empId)) {
            layer.msg("请选择服务工程师");
        } else {
            var name = $.trim($("#nameWrap").children('span').html());
            $('body').popup({
                level: '3',
                type: 2,  // 提示是否进行某种操作
                content: '确认派工至' + name + '吗？',
                fnConfirm: function () {
                    adpoting = true;
                    $.ajax({
                        type: "POST",
                        url: "${ctx}/order/orderDispatch/save",
                        data: {
                            orderId: orderId,
                            empId: empId
                        },

                        success: function (data) {
                            if (data) {
                                $.closeDiv($(".activeDispatch"));
                                layer.msg('已派工!');
                                search();
                            } else {
                                layer.msg('派工失败!');
                            }

                        },
                        complete: function () {
                            adpoting = false;
                        }
                    });
                },
                fnCancel: function () {
                }
            });
        }
    }


    function directDis() {
        var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
        if (idArr.length < 1) {
            layer.msg("请选择数据！");
        } else {
            var marks = [];
            var categoryList = [];
            var categorys = "";
            for (var i = 0; i < idArr.length; i++) {
                var rowData = $('#table-waitdispatch').jqGrid('getRowData', idArr[i]);
                if ($.trim(rowData.status) != "待派工" && $.trim(rowData.status) != "暂不派工") {
                    layer.msg("您选择的工单中有不可操作派工的工单，请重新选择！");
                    return;
                }
                if(categorys==""){
                    categorys=rowData.appliance_category;
                }else{
                    categorys=categorys+","+rowData.appliance_category;
                }
                var cat = rowData.appliance_category;
                if ($.inArray(cat, categoryList) == -1) {
                    categoryList.push(cat);
                }
                marks.push(rowData.customer_lnglat);
            }

            $("#arroundUserInfo").empty();
            getsomething(idArr[0]);

            $("#orderId").val(idArr.join(","));
            $('.activeDispatch').popup(); //显示我要派工弹出框和判断高度
            $.selectCheck2("serverSelected");
            if(idArr.length==1){
            	rowData = $('#table-waitdispatch').jqGrid('getRowData', idArr[0]);
            	showLatestEmploye(rowData.customer_mobile);
            }else{
            	$("#latestEmps").text("");
    			$("#latestEmps").attr("title","");
            }
            initDispatchMap(marks);
            employe(categorys);
        }
    }

    function getsomething(orderId){
        $.ajax({
            type : "POST",
            url : "${ctx}/order/getOrderInfoById",
            data : {
                orderId:orderId
            },
            success : function(data) {
                $("input[name='sendMsgOrderId']").val(orderId);
                $("input[name='customerMobileNow']").val(data.columns.customer_mobile);
                $(".custNam").text(data.columns.customer_name);
                $(".custMob").text(data.columns.customer_mobile);
                $(".custAddr").text(data.columns.province+data.columns.city+data.columns.area+data.columns.customer_address);
                $("#arroundCustomerAddress").val(data.columns.customer_address);
            },
        });
	}

    function searchArroundCust(){
        var address = $("#arroundCustomerAddress").val();
        var orderId = $("input[name='sendMsgOrderId']").val();
        var mobile = $("input[name='customerMobileNow']").val();
        if(isBlank(address)){
            layer.msg("请输入地址信息");
		}else if(address.length>=2){
            $.ajax({
                type : "POST",
                url : "${ctx}/order/geteArroundCustInfo",
                data : {
                    address :address,
                    orderId:orderId,
                    mobile:mobile
				},
                success : function(data) {
                    var html='';
                    if(data.length>0){
                        for(var i=0;i<data.length;i++){
                            html+='<tr><td style="border-left: none;">'+data[i].columns.customer_name+'</td>';
                            html+='<td class="customerMobile">'+data[i].columns.customer_mobile+'</td>';
                            html+='<td class="applBranCate">'+data[i].columns.applBranCate+'</td>';
                            html+='<td>'+data[i].columns.repair_time+'</td>';
                            html+='<td><label class="label-cbox3" ><input type="hidden" name="customerTelephone" value="'+data[i].columns.customer_telephone+'"/><input type="hidden" name="customerTelephone2" value="'+data[i].columns.customer_telephone2+'"/><input type="hidden" name="number" value="'+data[i].columns.number+'"/><input type="checkbox" name="serverSelected" ></label></td></tr>';
                        }
                        $("#arroundUserInfo").empty().append(html);

                        $("#arroundUserInfo tr").on('click', function(ev) {
                            var name = ev.target.tagName.toLowerCase();
                            if(name == 'label') return;

                            var flag = $(this).hasClass('checked');
                            if (flag) {
                                $(this).removeClass('checked');
                            } else {
                                $(this).attr("class","checked");
                                $.trim($(this).children('td').eq(0).html())
                            }
                        });
                    }else{
                        layer.msg("该地址暂无周边用户信息！");
                    }
                },
            });
		}else{
		    layer.msg("输入的地址信息需要超过两个字符！");
		}
	}


    function returnMobile(val1,val2,val3){
        var mobile=$.trim(val1);
        if(isBlank(mobile)){
            mobile= $.trim(val2);
        }
        if(isBlank(mobile)){
            mobile= $.trim(val3);
        }
        if(isBlank(mobile)){
            mobile= "";
        }
        return mobile;
    }

    var noRepeateSend=false;
    function senMsg(){ //批量发送短信
        var ids=$("#arroundUserInfo").find(".checked");
        var mobile="";
        var number="";
        var wrongNumber="";

        var sign = $("#sign").val();
        var jsPhone = $("#jdTelephone").val();
        var toAnUrl='${oneHref}';
        var content ="";
        if(ids.length<1){
			layer.msg("您还未选中任何数据！");
			return false;
		}
        for(var i=0;i<ids.length;i++){
            var customer_mobile = $(ids[i]).find(".customerMobile").text();
            var customer_telephone = $(ids[i]).find("input[name='customerTelephone']").val();
            var customer_telephone2 = $(ids[i]).find("input[name='customerTelephone2']").val();
            var numb=$(ids[i]).find("input[name='number']").val();
            var applBranCate=$(ids[i]).find(".applBranCate").text();/*品牌品类*/

            var ph1=returnMobile(customer_mobile,customer_telephone,customer_telephone2);//去空格的mobile
            if($.trim(ph1)=="" || $.trim(ph1)==null){
                layer.msg("选择发送的工单中存在用户手机号为空的工单，请先维护或者重新选择工单！");
                return ;
            }
            if($.trim(ph1).length!=11 || $.trim(ph1).substring(0,1)!="1" ){
                if(wrongNumber==""){
                    wrongNumber=numb;
                }else{
                    wrongNumber=wrongNumber+','+numb;
                }
            }
            if(i==0){
                mobile=$.trim(ph1);
                number=$.trim(numb);
            }else{
                mobile=mobile+','+$.trim(ph1);
                number=number+','+$.trim(numb);
            }

			/*短信模板*/
            content+="尊敬的用户，您好。我们是曾为您服务过的"+sign+"维修部。" +
                "您的"+applBranCate+"产品在上次服务后使用效果是否满意，提醒您定期检查。如果需要服务，" +
                "可以联系我们公司："+jsPhone+"。同时，家用电器用电安全也需要进行关注，" +
                "可以放心点击观看以下用电安全内容（"+toAnUrl+"）。#";

        }
        $("#wrongNumber").val(wrongNumber);//未发送的工单编号
        if(wrongNumber==""){
            var a = document.getElementById("exportLink");
            a.removeAttribute("href");
            a.setAttribute("onclick","tishi()");
        }else{
            $("#exportLink").prop("href", $("#exportLink").prop("href")+"&no="+wrongNumber);
        }

        if($.trim(sign)=="" || sign==null ){
            layer.msg("短信签名不能为空！");
            $("#sign").focus();
            return false;
        }
        if($.trim(sign).length>6 ){
            layer.msg("短信签名过长，最多为6个汉字！");
            $("#sign").focus();
            return false;
        }
        var siteMsgNums = $("#siteMsgNums").val();
        var msgNumbers = mobile.split(",");
        var msgNums = msgNumbers.length;//需要发送短信的工单数

		var message="尊敬的用户，您好。我们是曾为您服务过的"+sign+"维修部。" +
            "您的XXXX产品在上次服务后使用效果是否满意，提醒您定期检查。如果需要服务，" +
            "可以联系我们公司："+jsPhone+"。同时，家用电器用电安全也需要进行关注，" +
            "可以放心点击观看以下用电安全内容（XXXXXX）。";

        $('body').popup({
            level:3,
            title:"短信确认",
            content:message,
            fnConfirm :function(){
                if(noRepeateSend){
                    return;
                }
                noRepeateSend=true;
                layer.msg("短信发送中，请耐心等待...",{time:5000000});
                $.ajax({
                    type:"POST",
                    traditional:true,
                    url:"${ctx }/order/msgNumbers",
                    data:{content:content,
                        sign:sign},
                    success:function(result){
                        if(parseInt(result)*parseInt(msgNums) > parseInt(siteMsgNums)){
                            layer.msg("剩余可发送短信条数不足，请先购买后再发送！");
                        }else{
                            $.ajax({
                                type:"POST",
                                traditional:true,
                                url:"${ctx }/order/sendInDispOrTurnDisp",
                                data:{content:content,
                                    sign:sign,
                                    mobile:mobile,
                                    number:number
                                },
                                success:function(result){
                                    if(result=="noMessage"){
                                        layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
                                    }else{
                                        var n = 0;
                                        for(var j=0;j<msgNumbers.length;j++){
                                            if(msgNumbers[j].length==11 && msgNumbers[j].substring(0,1)=="1" ){
                                                n++;
                                            }
                                        }
                                        $("#sucMsg").text(n);
                                        $("#wroMsg").text(parseInt(msgNumbers.length)-parseInt(n));
                                        layer.msg("发送成功");
                                        search();
                                        numerCheck();
                                        $('.massTextNoteQf').popup({level:2});
                                    }
                                }
                            })
                        }
                    },complete:function(){
                        noRepeateSend=false;
                    }
                })
            },
            fnCancel:function (){

            }
        });
    }

    function guanbi(){
        $.closeDiv($(".massTextNote"));
    }

    function closePopup(){
        $.closeDiv($(".massTextNote"));
    }


    function initDispatchMap(markers) {
        if (!dispatchMap) {
            dispatchMap = new AMap.Map('dispatch_map_container', {
                zoom: 12
            });
            for(var i = 0 ; i < markers.length; i++){
                dispatchMarker = new AMap.Marker({
                    map:dispatchMap,
                    draggable:true
                });
                var la=markers[i];
                if(la) {
                    var lnglats = la.split(",");
                    var position = new AMap.LngLat(lnglats[0], lnglats[1]);
                    dispatchMap.setZoomAndCenter(12, position);
                    dispatchMarker.setPosition(position);
                }
            }
            employeMarker = new AMap.Marker({});
        }
        employeMarker.setMap(null);
    }

    function employe(cat) {
        var lnglat = $("#lnglat").val();
        var lnglat = $("#lnglat").val();
        $.ajax({
            type : "POST",
            url : "${ctx}/operate/employe/dispatchList",
            data : {
                lnglat :lnglat,
                category:cat
            },
            success : function(data) {
                var content = $("#zhijiepaidan");
                content.empty();
                var sites = data;
                var appendHtml = '';
                for (var i = 0; i < sites.length; i++) {
                    var item = sites[i].columns;
                    appendHtml +='<tr>'
                        +'<td style="border-left: none;">'+item.name+'</td>'
                        + '<td>' + item.sywwg + '</td>'
                        +'<td>'+item.wwg+'</td>'
                         +'<td>'+item.jrywg+'</td>' 
                        +'<td><label class="label-cbox3" for="'+item.id+'"><input type="checkbox" name="serverSelected" id="'+item.id+'"></label></td>'
                        +'</tr>';
                }
                if(isBlank(appendHtml)){
                    layer.msg("服务工程师没有维护"+cat+"服务品类，请先维护");
                }
                content.html(appendHtml);

                $("#zhijiepaidan tr").each(function(index) {
                    $(this).data("emp", sites[index].columns);
                });
                $("#zhijiepaidan tr").on('click', function(ev) {
                    var name = ev.target.tagName.toLowerCase();
                    if(name == 'label') return;

                    var flag = $(this).hasClass('checked');
                    if (flag) {
                        $(this).removeClass('checked');
                    } else {
                        $(this).attr("class","checked");
                        $.trim($(this).children('td').eq(0).html())
                    }
                    $("#nameWrap").empty();
                    var name="";
                    var id = "";
                    $("#zhijiepaidan tr").each(function(index) {
                        var flag = $(this).hasClass('checked');
                        if (flag) {
                            if(isBlank(name)){
                                name = $.trim($(this).children('td').eq(0).html());
                            }else{
                                name = name+" "+ $.trim($(this).children('td').eq(0).html());
                            }
                            if(isBlank(id)){
                                id= $.trim($(this).children('td').eq(4).children('label').attr('for'));
                            }else{
                                id= id+","+$(this).children('td').eq(4).children('label').attr('for');
                            }
                        }
                    });
                    $("#nameWrap").append("<span>"+name+"</span>");
                    $("#employeId").val(id);

                });
            }
        });
    }

    function isBlank(val) {
        if(val==null || $.trim(val)=='' || val == undefined || val=='null' ) {
            return true;
        }
        return false;
    }

    function initSfGrid(){
        $("#table-waitdispatch").sfGrid({
            url : '${ctx}/order/getWholeList?ptype='+${ptype},
            sfHeader: defaultHeader,
            sfSortColumns: sortHeader,
            rownumbers:true,
            gridComplete:function(){
            	_order_comm.gridNum();
                var ids = $("#table-waitdispatch").getDataIDs();
                if($("#table-waitdispatch").find("tr").length>1){
                    $(".ui-jqgrid-hdiv").css("overflow","hidden");
                }else{
                    $(".ui-jqgrid-hdiv").css("overflow","auto");
                }
                for(var i=0;i<ids.length;i++){
                    var rowData = $("#table-waitdispatch").getRowData(ids[i]);
                    if(rowData.callback_result==2 && rowData.status.trim()=='服务中'.trim()){//则背景色置灰显示
                        $('#'+ids[i]).find("td").addClass("SelectBG");
                    }
                }
            }
        });
   /*      jQuery("#table-waitdispatch").jqGrid('setGroupHeaders', 
        		{ useColSpanStyle: true, 
        	groupHeaders:[ {startColumnName: 'customer_name', numberOfColumns: 3, titleText: '<em>Price</em>'},
        	{startColumnName: 'service_type', numberOfColumns: 2, titleText: 'Shiping'} 
        	] 
        }); */
    }

    function manyidu(rowData){
        var serviceAt = rowData.service_attitude;
        if(serviceAt=="1"){
            return "十分不满意";
        }
        if(serviceAt=="2"){
            return "不满意";
        }
        if(serviceAt=="3"){
            return "一般";
        }
        if(serviceAt=="4"){
            return "满意";
        }
        if(serviceAt=="5"){
            return "十分满意";
        }
        if(serviceAt=='6'){
            return "无效回访 ";
        }
        if(serviceAt=='7'){
            return "回访未成功";
        }
        return "";
    }

    /* function fmtOrdertype(row){
        if(row == 2){
            return "<span>美的</span>";
        }else if(row == 3){
            return "<span>惠而浦</span>";
        }else if(row == 4){
            return "<span>海信</span>";
        }
        return "<span>自接</span>";
    } */

    function fmtOrderNo(rowData){
        var authFlag = 'true';
        var html = '';
        if(authFlag === 'true'){
            html += '<a href="javascript:showDetail(\''+rowData.id+'\');" class="c-0383dc">'+rowData.number+'</a>';
        }
        return html;
    }

    function showDetail(id){
    	$("#table-waitdispatch").jqGrid('resetSelection');
   	 $("#table-waitdispatch").jqGrid('setSelection',id);
        layer.open({
            type : 2,
            content:'${ctx}/order/orderDispatch/Wholeform?id='+id+'&whereMark=1'+'&map='+$("#searchForm").serialize(),
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            fadeIn:0,
            anim:-1
        });
    }

    function closeBatchForms() {
        layer.close(detailform);
    }
    function search(){
    	var pageSize = $("#pageSize").val();
    	if($.trim(pageSize)=='' || pageSize==null){
    		$("#pageSize").val(20);
    	}
        var val = $('#statusFlag').combobox('getValues');
    /* 	if('${ptype }'!='2'&& '${not empty cateList}' === 'true') {
        } else {
            var valCategory = $('#catgyS').combobox('getValues');
            $("input[name='applianceCategory']").val(valCategory);
        } */
        $("#orderStatus").val(val);
        $("#table-waitdispatch").sfGridSearch({
            postData: $("#searchForm").serializeJson()
        });
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

    function reset(){
        $("#statusFlag").combobox('clear');
        $("#catgyS").combobox('clear');
        var html = '<span class="w-140 dropdown-sin-2">';
        html += '<select class="select-box w-120"  id="employs" style="display:none" multiple  multiline="true" name="employeNames"  >';
        html += '<c:forEach items="${fns:getEmloyeList(siteId) }" var="emp">';
        html += ' <option value="${emp.columns.name }">${emp.columns.name }</option>';
        html += '</c:forEach>';
        html += '</select>  </span>';

        var html2 = '<span class="w-140 dropdown-sin-2">';
        html2 += '<select class="select-box w-120"  id="signType" style="display:none" multiple multiline="true" name="signType" >';
        html2 += '<c:forEach items="${signList}" var="sign">';
        html2 += ' <option value="${sign.columns.id }">${sign.columns.name }</option>';
        html2 += '</c:forEach>';
        html2 += '</select>  </span>';
        $("#reloadSpan").html(html);
        $("#reloadSignSpan").html(html2);

        $('.dropdown-sin-2').dropdown({
            input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
        });
        $("#searchForm").get(0).reset();
    }

    function exports() {
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

        var idArr = $("#table-waitdispatch").jqGrid('getGridParam', 'records');
        var content = "共" + idArr + "条数据，本次允许导出前10000条，确定继续导出吗？";
        if (idArr > 10000) {
            $('body').popup({
                level: '3',
                type: 2,
                title: "导出",
                content: content,
                fnConfirm: function () {
                    location.href = "${ctx}/order/export?formPath=/a/order/Whole&&maps=" + $("#searchForm").serialize();
                },
                fnCancel: function () {
                }
            });
        } else {
            location.href = "${ctx}/order/export?formPath=/a/order/Whole&&maps=" + $("#searchForm").serialize();
        }
    }

    function confirmCard(id){ //确认交单
    	$("#oneOrMore").val('2');
    	dealJiaodan(id,'2');
    }

	/*enter查询*/
    function enterEvent(event){
        var keyCode = event.keyCode?event.keyCode:event.which?event.which:event.charCode;
        if (keyCode ==13){
            var val = $('#statusFlag').combobox('getValues');
            $("#orderStatus").val(val);
            $("#table-waitdispatch").sfGridSearch({
                postData: $("#searchForm").serializeJson()
            });
        }
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
    function cancelMarkOrders() {
        var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
        if (idArr.length <= 0) {
            layer.msg("请选择需要取消标记的工单");
            return;
        }

        $('body').popup({
            level: '3',
            type: 2,
            title:"提示",
            content:"是否要取消已选择工单的标记？",
            fnConfirm :function(){
                $.ajax({
                    url: '${ctx}/order/cancelOrdersMark?ids=' + idArr.join(","),
                    type: 'post',
                    success: function() {
                        layer.msg("取消标记成功");
                        search();
                    }
                });
            }
        });
    }

    function batchCopy() {
        var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
        var rowData = $('#table-waitdispatch').jqGrid('getRowData', idArr);
        if (idArr.length <= 0) {
            layer.msg("请选择需要复制的工单！");
            return;
        } else if (idArr.length > 1) {
            layer.msg("一次只能选择一条数据！");
            return;
        } else if ($.trim(rowData.status) != $.trim('待派工')) {
            layer.msg("只能复制待派工的工单！");
            return;
        }
        /* $('body').popup({
            level: '3',
            type: 2,  // 提示是否进行某种操作
            content: '批量复制工单暂不支持工单编号按日递增，是否继续复制？',
            fnConfirm: function () { */
	        $.ajax({
				url: '${ctx}/order/canBatchCopy',
				data: {
				    ids: idArr
				},
				type: 'post',
				success: function(data) {
				    if("200" === data) {
	                    $(".copyNums").find("input[name='orderId']").val(rowData.id);
	                    $(".copyNums").popup();
	                } else if("422" === data) {
				        layer.msg("只能复制待派工的工单！");
					} else if("423" === data) {
	                    layer.msg("不支持复制一级网点派工的工单");
					} else {
	                    layer.msg("未知错误");
					}
				}
			});
           /*  }
        }) */
    }
    
    function batchPrint(){
    	var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
        var rowData = $('#table-waitdispatch').jqGrid('getRowData', idArr);
        if (idArr.length <= 0) {
            layer.msg("请选择需要打印的工单！");
        } else {
            $("#printForm").empty();
            $.each(idArr, function(index, item){
            	$("#printForm").append('<input type="hidden" name="orderId" value="'+item+'"/>');            	
            });
    		$("#printForm").submit();
        }
    }
    
	//判断是否设置自定义打印模板
	function judgedygd(){
		$.ajax({
			type : 'POST',
			url : "${ctx}/order/printdesign/getOrderPrin",
			data : {},
			datatype:"JSON",
			success : function(data) {
				if(data == "ok"){
					$("#repeatOrder").hide();
					$("#repeatOrder_custom").show();
					return
				}else{
					$("#repeatOrder").show();
					$("#repeatOrder_custom").hide();
				}
			
			}

		});
	}
	
    //自定義批量打印
    function batchPrints(){
    	var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');

        if (idArr.length <= 0) {
            layer.msg("请选择需要打印的工单！");
        } else {
            $("#printForm").empty();
            $.each(idArr, function(index, item){
            	$("#printForm").append('<input type="hidden" name="orderId" value="'+item+'"/>');            	
            });
            dygdcustom();
        }
    }
    
	function dygdcustom(){
		$.ajax({
			type : 'POST',
			url : "${ctx}/order/printdesign/getOrderPrints",
			data : $("#printForm").serialize(),
			datatype:"JSON",
			success : function(data) {
			 	$.each(data, function(index, item){
					prn_Previews(item);
	            });
			}

		});
	}

    function batchCopyNow(){
        var orderId=$(".copyNums").find("input[name='orderId']").val();
        var nums = $(".copyNums").find("input[name='nums']").val();
        var tes=/^[0-9]{1,3}$/;
        if(isBlank(nums)){
            layer.msg("请输入复制的工单数量！");
        } else if(!tes.test(nums)){
            layer.msg("请输入正确的数量格式！");
        } else if(nums==0){
            layer.msg("复制数量不能为0！");
        } else {
            layer.msg("工单生成中，请耐心等待...",{time:5000000});
            $.ajax({
                url: '${ctx}/order/copyOrder',
                type: 'post',
                data:{id:orderId,nums:nums},
                datatype:'text',
                success: function (result) {
                    if(result=='200'){
                        layer.msg("复制成功！");
                        $.closeDiv($(".copyNums"));
                        search();
                    }else if(result=='401'){
                        layer.msg("复制失败，该工单状态为带派工！");
                        $.closeDiv($(".copyNums"));
                    }else if(result=='400'){
                        layer.msg("复制失败，工单编号为空！");
                    }else {
                        layer.msg("复制失败,请联系管理员！");
                    }
                }
            });
        }
    }


    function reAccount(rowData){
        var html = '';
        if(rowData.record_account=='1'){
            html='是';
        }else{
            if('${fns:checkBtnPermission("ORDERMGM_ALLORDER_ALLORDER_CONFIRMACCOUNT_BTN")}' === 'true'){
                return '<a style="color:blue;" onclick="confirmAccount(\''+rowData.id+'\',\''+rowData.factory_number+'\')">确认</a>';
            }else{
                return "否";
            }
        }

        return html;
    }

    var markAccount = false;
    function qurenAccount() {
        if (markAccount) {
            return;
        }
        var factoryNumber = $("#factoryNumber").val();
        var id = $(".confirmAccountpop #orderIds").val();
        if(isBlank(factoryNumber)){
        	layer.msg("请填写工单编号");
        	$("#factoryNumber").focus();
        	return ;
        }
        if (factoryNumber.length > 32) {
            layer.msg("工单编号过长");
            return;
        }
        markAccount = true;
        $.ajax({
            url: '${ctx}/order/confirmAccount?id=' + id + '&&factoryNumber=' + factoryNumber,
            type: 'post',
            success: function (data) {
                markAccount = false;
                if (data.code == "200") {
                    layer.msg("确认录单成功！");
                    search();
                } else if (data.code == "500") {
                    layer.msg("工单编号过长！");
                    return;
                } else {
                    layer.msg("录单失败，请联系管理员！");
                }
                quxiaoAccount();
            }
        });
    }

    function confirmAccount(id,factoryNumber) {
    	$("#factoryNumber").val('');
    	if(!isBlank(factoryNumber)){
    		$("#factoryNumber").val(factoryNumber);
    	}
        $(".confirmAccountpop #orderIds").val(id);
        $('.confirmAccountpop').popup();
    }
    function quxiaoAccount() {
        $("#factoryNumber").val("");
        $.closeDiv($('.confirmAccountpop'));
    }

    function getConditions(){
        return $("#searchForm").serialize();
    }
    
    
    //批量交单
    function plJiaodan(){
    	var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
    	if(idArr.length < 1){
    		layer.msg("请先选择您要确认交单的数据！");
    		return;
    	}
    	$(".selectOrderAll").text(idArr.length);
    	var ids = "";
		for(var i=0;i<idArr.length;i++){
			if(ids==""){
				ids+=idArr[i];
			}else{
				ids+=","+idArr[i];
			}
    	} 
		$("#oneOrMore").val('1');
		dealJiaodan(ids,'1');
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
       			$(".payFlash").text(flashMy);//现金收款
       			$(".realPayMoney").val((isBlankJd(result.realPayMoney) ? 0.00 : result.realPayMoney).toFixed(2));//实收金额
       			$('#ifSelect').val('2');
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
    }
    function closeJiaodan(){
    	$.closeDiv($('.jiaodan'));
    }
    function refuseOrder() {
        var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
        if (idArr.length < 1) {
            layer.msg("请选择数据！");
        } else {
            $('body').popup({
                level: '3',
                type: 2,  // 提示是否进行某种操作
                content: '确定要退回工单吗？',
                fnConfirm: function () {
                    $.ajax({
                        url: "${ctx}/secondOrder/refuseOrders",
                        type: 'post',
                        data: {
                            ids: idArr.join(",")
                        },
                        success: function(data) {
                            if ('500' === data.code) {
                                layer.msg("您选择的工单中有不可退回的工单，不能操作拒单！")
                            } else if('200' === data.code) {
                                layer.msg("退回成功！");
                            } else if('422' === data.code) {
                                layer.msg("工单已被转派！");
                            } else if('423' === data.code) {
                                layer.msg("自建工单不可退回！");
                            }
                            search();
                        },
                        error: function() {
                        }
                    });
                },
                fnCancel: function () {
                }
            });
        }
	}
	function recvOrder() {
        var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
        if (idArr.length < 1) {
            layer.msg("请选择数据！");
        } else {
            $('body').popup({
                level: '3',
                type: 2,  // 提示是否进行某种操作
                content: '确定要接收派工吗？',
                fnConfirm: function () {
                    $.ajax({
						url: "${ctx}/secondOrder/recvOrders",
                        type: 'post',
                        data: {
						    ids: idArr.join(",")
						},
						success: function(data) {
						    if ('500' === data.code) {
						        layer.msg("您选择的工单中有不可接收的工单，不能操作接单！")
							} else if('200' === data.code) {
                                layer.msg("接单成功！")
							} else if('422' === data.code) {
                                layer.msg("工单已被转派！")
                            }
							search();
						},
						error: function() {
						}
					});
                },
                fnCancel: function () {
                }
            });
        }
	}

	function prevOrder(cid) {
        var idArr = $('#table-waitdispatch').jqGrid('getCol', 'id');
        var i,idx=-1;
        for(i=0;i<idArr.length;i++) {
            if(idArr[i]===cid){
                idx = i - 1;
                break
			}
		}
		if (idx <0){
//            idx = 0;
            //the first order has no prev order
			window.top.layer.msg("没有上一条数据了");
		}  else if(idx == -1){
        	$.closeAllDiv();
            showDetail(idArr[0]);
        }else {
		    $.closeAllDiv();
		    showDetail(idArr[idx]);
		}
	}

	function nextOrder(cid) {
        var idArr = $('#table-waitdispatch').jqGrid('getCol', 'id');
        var i,idx=-1;
        for(i=0;i<idArr.length;i++) {
            if(idArr[i]===cid){
                idx = i + 1;
                break
            }
        }
        
        if (idx >=idArr.length){
//            idx = idArr.length-1;
            //the first order has no next order
            window.top.layer.msg("没有下一条数据了");
        } else if(idx == -1){
        	$.closeAllDiv();
            showDetail(idArr[0]);
        }else{
            $.closeAllDiv();
            showDetail(idArr[idx]);
        }
	}

	
	 var erjidisPmark=false;
	function erjidispa(){
        if(erjidisPmark){
            return;
        }
        var sdId = $('.erjitable').find('.radiobox-selected').find("input[name='serverSelected']").val();
        var siteName = $('.erjitable').find('.radiobox-selected').find("input[name='siteName']").val();
        if(isBlank(sdId)){
            layer.msg("请选择您要转派的二级网点！");
            return;
        }
        erjidisPmark=true;
        $.ajax({
            type:"post",
            data:{ids:$("#erjiorderId").val(),secondSiteId:sdId,secondSiteName:siteName},
            url:"${ctx}/order/erjiDispatch",
            success:function(result){
                if(result.code=='200'){
                    parent.layer.msg("派工成功！");
                    search();
                    $.closeDiv($('.erjiactiveDispatch'));
                    //$.closeAllDiv();
                }else if(result.code=='201'){
                    parent.layer.msg("请选择待派工工单！");
                } else if(result.code=='422') {
                    parent.layer.msg("工单编号在目标网点已存在，请勿重复派工！");
				} else{
                    parent.layer.msg("派工失败，请检查！");
                }
                erjidisPmark=false;
                return;
            }
        })
	}

    function isValid(num){
        if($.trim(num)=='' || num==null || num==undefined || num=='undefined'){
            return '';
        }
        return num;
    }
    
    function fmtTotalMoney(rowData){
        return rowData.auxiliary_cost + rowData.serve_cost + rowData.warranty_cost;
    }
    
    function confirmCollection(id,m1,m2,m3,m4){//确认交款
    	$("#hideId").val(id);
    	$("#realConfirmMny").val(parseFloat(m1)+parseFloat(m2)+parseFloat(m3));
    	$("#needConfirmMny").val(parseFloat(m1)+parseFloat(m2)+parseFloat(m3));
    	$("#callbackCost").val(m4);
        $(".qrskShow").popup();
    }
    
    var saveConfirmPays = false;
    function saveConfirmPay(){
    	if(saveConfirmPays){
    		return;
    	}
    	var mnys = $("#realConfirmMny").val();
    	var id = $("#hideId").val();
    	if(isBlank(mnys)){
    		layer.msg("请填写实收总额！！");
    		$("#realConfirmMny").focus();
    		return;
       	}
    	if(!checkShiShouMy(mnys)){
    		layer.msg("实收总额格式有误！");
    		$("#realConfirmMny").focus();
    		return;
    	}
    	saveConfirmPays=true;
   	    $.ajax({
            type:"post",
            traditional:true,
            data:{id:id,mnys:mnys},
            url:"${ctx}/order/confirmCollection",
            dataType:"JSON",
            success:function(result){
                if(result==true){
                    parent.layer.msg("交款成功！");
                    search();
                    canceConfirmPay();
                }else{
                    layer.msg("交款失败，请检查！");
                }
                saveConfirmPays=false;
                return;
            }
        }) 
    }
    
    function canceConfirmPay(){
    	$.closeDiv($('.qrskShow'));
    }
    
  //是否交款
   function fmtWhetherCollection(rowData) {
    	if (rowData.status == "3" || rowData.status == "4" ) {//|| rowData.status == "5"
    		if ("0" == rowData.whether_collection || "2" == rowData.whether_collection) {
    			if('${fns:checkBtnPermission("ORDERMGM_ALLORDER_ALLORDER_RETURNMONEYCONFIRM_BTN")}' === 'true'){
    				return "<a style='color:blue;' onclick='confirmCollection(\"" + rowData.id + "\",\"" + rowData.auxiliary_cost + "\",\"" + rowData.serve_cost + "\",\"" + rowData.warranty_cost + "\",\"" + rowData.callback_cost + "\")'>确认</a>";
    			}else{
     				return "否";
     			}
   			} else if ("1" == rowData.whether_collection) {
   			return "是";
    		} else {
    			return "--";
    		}
    	} else {
    		return "--";
    	}
    }

    function fmtRC(rowData) {//交单情况
    	if (rowData.status == "3" || rowData.status == "4" || rowData.status == "5" || rowData.status == "8" ) {
    		if ("0" == rowData.return_card || "2" == rowData.return_card) {
    			if('${fns:checkBtnPermission("ORDERMGM_ALLORDER_ALLORDER_RETURNCARDCONFIRM_BTN")}' === 'true'){
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
    
    function fmtWxReason(rowData){
    	var type = rowData.disable_type;
    	if(type=='0'){
    		return "";
    	}
		if(type=='1'){
			return "重复";		
    	}
		if(type=='2'){
			return "机器已好";
		}
		if(type=='3'){
			return "费用高不修";
		}
		if(type=='4'){
			return "用户没时间 ";
		}
		if(type=='5'){
			return "其他原因";
		}
		return "";
    }
    
    function showLatestEmploye(mobile){
    	$.ajax({
    		type:"post",
    		url:"${ctx}/order/getLatestEmployesByMobile",
    		data:{mobile:mobile},
    		success:function(data){
    			if(isBlank(data)){
    				$("#latestEmps").text("");
    				$("#latestEmps").attr("title","");
    				$(".showLatestlook").hide();
    				return ;
    			}
    			$("#latestEmps").text(data);
    			$("#latestEmps").attr("title",data);
    			$(".showLatestlook").show();
    			return;
    		}
    	})
    }
    
    //向二级网点派工
    var disPmark=false;
   	function erjidirectDis() {
   		$("#filterName").val('');
   		$("#orderId").val('');
   		var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
   		if (idArr.length < 1) {
   			layer.msg("请选择数据！");
   		} else {
   			var ids="";
   			var selectcategory = "";
   			var selectbrand = "";
   			for(var i = 0; i < idArr.length; i++){
   				var rowData = $('#table-waitdispatch').jqGrid('getRowData', idArr[i]);
   				var sts = $.trim(rowData.status);
   				if(sts=='待派工' || sts=='暂不派工'){
   					selectcategory = rowData.appliance_category;
   					selectbrand = rowData.appliance_brand;
   					if(ids==''){
   						ids=idArr[i];
   					}else{
   						ids=ids+','+idArr[i];
   					}
   				}
   			}
   			if(isBlank(ids)){
   				layer.msg("您选择的工单不能指派给二级网点，请重新选择！");
   				return;
   			}
   			if(ids.split(",").length > 1){//多个工单的话就不匹配品类信息
   				selectcategory = "";
   	   			selectbrand = "";
   			}
   			$("#orderId").val(ids);
   			var searchName = '';
   			var contents = '您选择的'+idArr.length+'条工单中有'+ids.split(",").length+'条可以指派给二级网点，您确定要指派吗？';
   			if(ids.split(",").length==idArr.length){
   				contents = "您确定要将这"+idArr.length+"条工单指派给二级网点吗？";
   			}
	   		$('body').popup({
	             level: '3',
	             type: 2,  // 提示是否进行某种操作
	             content: contents,
	             fnConfirm: function () {
	            	 layer.open({
	        	       		type : 2,
	        	       		content:'${ctx}/secondOrder/toDispatchOrderPage?searchName='+searchName+'&selectcategory='+selectcategory+'&selectbrand='+selectbrand+"&customerMobile="+""+"&orderId="+ids+"&position=1",
	        	       		title:false,
	        	       		area: ['100%','100%'],
	        	       		closeBtn:0,
	        	       		shade:0,
	        	       		anim:-1 
	        	       	});
	             },
	             fnCancel: function () {
	             }
	         });
   	       	
   		}
   	}
</script>

</body>
</html>
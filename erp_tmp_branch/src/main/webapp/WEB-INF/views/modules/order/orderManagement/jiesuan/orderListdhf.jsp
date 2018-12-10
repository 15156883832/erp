<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta charset="utf-8">
	<meta name="decorator" content="base"/>
	<title>全部工单</title>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/tips_style.css"/>
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
			<div id="tab-system" class="HuiTab">
			<div class="tabBar cl mb-10">
				<sfTags:pagePermission authFlag="ORDERMGM_STAYVISTORDER_ALLORDER_TAB" html='<a class="btn-tabBar " href="${ctx }/order/StayVisit">全部工单<sup id="tab_c1">0</sup></a>'></sfTags:pagePermission>
				<sfTags:pagePermission authFlag="ORDERMGM_STAYVISTORDER_STAYVISIT_TAB" html='<a class="btn-tabBar current"  href="${ctx }/order/getWwgList/dhf">待回访<sup id="tab_c2">0</sup></a>'></sfTags:pagePermission>
				<sfTags:pagePermission authFlag="ORDERMGM_STAYVISTORDER_STAYSETTLE_TAB" html='<a class="btn-tabBar " href="${ctx }/order/getWwgList/djs">待结算<sup id="tab_c3">0</sup></a>'></sfTags:pagePermission>
				<p class="f-r btnWrap">
					<a href="javascript:search();;" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
					<a href="javascript:;" class="sfbtn sfbtn-opt moresearch" id="moresearch" ><i class="sficon sficon-moresearch"></i>更多查询</a>
					<a href="javascript:;" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
				</p>
			</div>
			<div class="tabCon">
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
						</tr>
						<tr class="moreCondition" style="display: none;">
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
										<!-- <option value="3">保内转保外</option> -->
									</select>
								</span>
							</td>
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
							<th style="width: 76px;" class="text-r">登记人：</th>
							<td>
								<input type="text" class="input-text" name="messengerName" />
							</td>

						</tr>
						<tr class="moreCondition" style="display: none;">
							<th style="width: 76px;" class="text-r">预约日期：</th>
							<td>
								<input type="text" onfocus="WdatePicker({})" id="promiseTime" name="promiseTime" value="" class="input-text Wdate radius">
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
							<th style="width: 76px;" class="text-r">服务工程师：</th>
							<td id="reloadSpan">
								<span class="w-140 dropdown-sin-2" >
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
						</tr>
						<tr class="moreCondition" style="display: none;">
						<th style="width: 76px;" class="text-r">厂家编号：</th>
							<td >
								
								<input type="text" class="input-text" name= "factorynumber"/>
							</td>
							<th style="width: 76px;" class="text-r">报修时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'repairTimeMax\')||\'%y-%M-%d\'}'})" id="repairTimeMin" name="repairTimeMin"  value="" class="input-text Wdate w-140" style="width:140px">
								至
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'repairTimeMin\')}',maxDate:'%y-%M-%d 23:59:59'})" id="repairTimeMax" name="repairTimeMax"  value="" class="input-text Wdate w-140" style="width:140px">
							</td>
							<th style="width: 76px;" class="text-r">派工时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'dispatchTimeMax\')||\'%y-%M-%d\'}'})" id="dispatchTimeMin" name="dispatchTimeMin"  value="" class="input-text Wdate w-120" style="width:140px">
								至
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'dispatchTimeMin\')}',maxDate:'%y-%M-%d 23:59:59'})" id="dispatchTimeMax" name="dispatchTimeMax"  value="" class="input-text Wdate w-120" style="width:140px">
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
							<td colspan="4">
								<label style="margin-left:-12px;">录单操作时间：</label>
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'recordDateMax\')||\'%y-%M-%d\'}'})"  id="recordDateMin" name="recordDateMin" value="" class="input-text Wdate w-120" style="width:140px">
								至
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'recordDateMin\')}',maxDate:'%y-%M-%d 23:59:59'})" id="recordDateMax" name="recordDateMax"  value="" class="input-text Wdate w-120" style="width:140px">

							</td>
						</tr>
					</table>
				</div>
			</form>
			<div class="pt-10 pb-5 cl">
				<div class="f-l">
					<sfTags:pagePermission authFlag="ORDERMGM_STAYVISTORDER_STAYVISIT_ZJFD_BTN" html='<a href="javascript:showzjfd();" class="sfbtn sfbtn-opt"><i class="sficon sficon-notdispatch"></i>直接封单</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="ORDERMGM_STAYVISTORDER_STAYVISIT_PLSETTLE_BTN" html='<a href="javascript:batchJiesuan();" class="sfbtn sfbtn-opt"><i class="sficon sficon-settlement"></i>批量结算</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="ORDERMGM_DURINGORDER_ALLORDER_WXORDER_BTN" html='<a href="javascript:showwxgd();" class="sfbtn sfbtn-opt"><i class="sficon sficon-invalid"></i>无效工单</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="ORDER_MARKORDER_BTN_OTHERS" html='<a href="javascript:showMarkOrders();" class="sfbtn sfbtn-opt"><i class="sficon sficon-sign"></i>标记工单</a>'></sfTags:pagePermission>
					<%-- <sfTags:pagePermission authFlag="ORDERMGM_STAYVISTORDER_STAYVISIT_PLJIAOKUAN_BTN" html='<a class="sfbtn sfbtn-opt sbtn" value="" type="button" onclick="PLJiaokuan()"><i class="sficon sficon-plfk"></i>批量交款</a>'></sfTags:pagePermission> --%>
					<sfTags:pagePermission authFlag="ORDERMGM_STAYVISTORDER_STAYVISIT_PLJIAODAN_BTN" html='<a class="sfbtn sfbtn-opt sbtn" value="" type="button" onclick="PLJiaoDan()"><i class="sficon sficon-pljd"></i>批量交单</a>'></sfTags:pagePermission>
				</div>
				<div class="f-r">
					<a href="javascript:;" class="sfbtn sfbtn-opt2 reloadPageBtn"><i class="sficon sficon-reload"></i>刷新</a>
					<%-- <sfTags:pagePermission authFlag="ORDERMGM_STAYVISTORDER_STAYVISIT_IMPORT_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt2"><i class="sficon sficon-import"></i>导入</a>'></sfTags:pagePermission> --%>
					<sfTags:pagePermission authFlag="ORDERMGM_STAYVISTORDER_STAYVISIT_EXPORT_BTN" html='<a onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="ORDERMGM_STAYVISTORDER_STAYVISIT_TBSETTLE_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt2" id="setHeadersBtn"><i class="sficon sficon-setting"></i>表头设置</a>'></sfTags:pagePermission>
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
									<span class="oState state-dgbd w-80 mb-5">导购报单</span>
									<span class="oState state-refuse w-80 mb-5">标记工单</span>
									<span class="oState state-wxgd2 w-150 mb-5">服务反馈无效</span>
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
					<input type="text" placeholder="请输入工程师姓名" class="input-text" />
					<a href="javascript:;" class="btn-search"><i class="Hui-iconfont Hui-iconfont-search2 f-16"></i></a>
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
							<th class="w-90">距离</th>
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
						</div>
					</div>
				</div>
			</div>
			<div class="f-r mapWrap" id="dispatch_map_container">

			</div>
		</div>
	</div>
</div>

<!-- 批量结算 -->
<div class="popupBox settlement">
	<h2 class="popupHead">
		批量结算
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer" id="jiesuan_detail_div">
		<form id="settleForm">
			<div class="popupMain pd-10" >
				<div class="pos-r txtwrap1 mt-10">
					<label class="lb lb1">服务结算方案：</label>
					<span class="select-box w-120">
							<select class="select" name="serviceMeasures">
								<option value="1">请选择</option>
							</select>
						</span>
					<span class="c-0383dc"><i class="sficon sficon-whjsfa mr-5"></i>维护结算方案</span>
				</div>
				<div class="cl mt-10">
					<div class="f-l pos-r txtwrap1">
						<label class="lb lb1">服务费结算：</label>
						<div class="priceWrap w-120">
							<input type="text" class="input-text autoCal"  name="serve_cost"/>
							<span class="unit">元</span>
						</div>
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">辅材费结算：</label>
						<div class="priceWrap w-100">
							<input type="text" class="input-text autoCal"  name="auxiliary_cost"/>
							<span class="unit">元</span>
						</div>
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">延保费结算：</label>
						<div class="priceWrap w-100">
							<input type="text" class="input-text autoCal" name="warranty_cost" />
							<span class="unit">元</span>
						</div>
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">其他结算：</label>
						<div class="priceWrap w-100">
							<input type="text" class="input-text autoCal" name="other_cost" />
							<span class="unit">元</span>
						</div>
					</div>
				</div>
				<div class="pos-r txtwrap1 mt-10 cl">
					<label class="lb lb1">结算总额：</label>
					<div class="priceWrap w-120 f-l">
						<input type="text" class="input-text"  id="total_cost" name="total_cost" readonly="readonly"/>
						<span class="unit">元</span>
					</div>
				</div>
				<div class="pos-r txtwrap1 mt-10">
					<label class="lb lb1">备注：</label>
					<textarea class="textarea h-50" name="remarks"></textarea>
				</div>
				<input id="dispIds" name="dispIds" type="hidden">
				<div class="pos-r txtwrap1 mt-10">
					<input type="button" class="w-70 sfbtn sfbtn-opt3" value="保存" onclick="saveBatchSettle();"/>
				</div>
			</div>
		</form>
	</div>
</div>
</div>
<!-- 直接封单提示框 -->
<div class="popupBox notDispatch showzjfddiv">
	<h2 class="popupHead">
		直接封单
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain " >
			<div class="txtwrap1 pos-r mb-30">
				<label class="lb lb1"><em class="mark">*</em>直接封单理由：</label>
				<textarea id="reasonofzjfd" class="textarea"></textarea>
			</div>
			<div class="text-c pl-30">
				<input onclick="savezjfd()" type="button" class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" />
				<input type="button" onclick="cancerBox()" class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" />
			</div>
		</div>
	</div>
</div>

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

<input type="hidden" id="settleFlag" name="settleFlag" value="${settleFlag }">
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
				<p class="mb-15">
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
				<label class="lb lb1" >无效工单理由：</label>
				<textarea id="reasonofwxgd" class="textarea"></textarea>
			</div>
			<div class="text-c pl-30">
			<input type="hidden" name="orderId" id="orderId" />
				<input onclick="savewxgd()" type="button" class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" />
				<input type="button" class="mr-10 w-70 sfbtn sfbtn-opt" onclick="closeDivQu()" value="取消" />
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef"></script>
<script type="text/javascript">
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
    function numerCheck(){
        $.post("${ctx}/order/getOrderTabCount",{tab:"dhj"},function(result){
            $("#tab_c1").text(result.c1);
            $("#tab_c2").text(result.c2);
            $("#tab_c3").text(result.c3);
        });
    }
    $(function(){
        $('.iconDec').showIcons();
        numerCheck();
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
        
        $("#serviceMode").select2({tags:true});
   	 $("#serviceMode").next(".select2").find(".selection").css("width","140px");


        $('.dropdown-sin-2').dropdown({
            // data: json2.data,
            input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
            choice: function() {
            }
        });

        $("input.autoCal").change(function(){
            var sum = 0;
            $("input.autoCal").each(function(){
                if(testCash($(this).val())){
                    sum = numAdd(sum, $(this).val());
                }else if($(this).val() !=''){
                    $(this).val("");
                }
                $("#total_cost").val(sum);
            });
        });
        $('#btn_checkPay').on('click', function(){
			if($(this).hasClass('label-cbox2-selected')){
				$(this).removeClass('label-cbox2-selected');
			}else{
				$(this).addClass('label-cbox2-selected');
			}
		})
    });

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

    window.onload=function(){
        $("#_easyui_combobox_i1_0").remove();
    }

    var batchJiesuanPopupDiv;
    function batchJiesuan(){
        var settleFlag = $("#settleFlag").val();
        var ids=$('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
        if(ids == null || ids.length == 0){
            layer.msg("请选择记录!");
            return ;
        }
        var pass = true;
        var dispIds = "";
        var oIds = "";
        for(var i = 0; i < ids.length; i++){
            var rowData = $("#table-waitdispatch").jqGrid('getRowData',ids[i]);
            dispIds += "," + rowData.dispId;
            oIds += "," + rowData.id;
            if(rowData.status == '3' && settleFlag == '0'){//用户设置了需要回访才能结算
                pass = false;
                break;
            }
        }
        if(pass){
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
        }else{
            layer.msg("请先回访工单!");
            return ;
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
    							layer.msg("无效工单更新完毕!", {time: 2000});
    							search();
    							numerCheck();
    							$.closeDiv($('.showwxgddiv'));
    						}else{
    							
    						layer.msg("操作失败!",{time:2000});
    						}
    					},
    					error:function(){
    						layer.msg("系统繁忙!");
    						return;
    					}
    		});
    	}
    }

  //无效工单
  function showwxgd(){
  	var idArr=$('#table-waitdispatch').jqGrid('getGridParam','selarrrow');
      if (idArr.length < 1) {
          layer.msg("请选择数据！");
          return;
      }
      $.ajax({
          url: '${ctx}/order/canMarkAsInvalid',
          data: {
              ids: idArr
          },
          success: function (data) {
              $("#reasonofwxgdType").val("");
              if (data === "N") {
             	 $('body').popup({
                     level: '3',
                     type: 2,  // 提示是否进行某种操作
                     content: '您确定要操作无效工单吗？',
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
 			        
 			            $('.showwxgddiv').popup();
                     }
            	 })
            }else if("NN" == data) {
                  layer.msg("您选择的工单中包含厂家工单，不能进行无效工单操作，请重新选择！");
  			}
          }
  	});

  }
    
    function saveBatchSettle(){
        if(!testCash($("#total_cost").val())){
            layer.msg("结算总额格式不正确!")
            return ;
        }
        var postData = $("#settleForm").serializeJson();
        $.post("${ctx}/order/orderSettlemnt/batchSaveSettlement", postData, function(result){
            $.closeDiv(batchJiesuanPopupDiv);
        });
    }

    function directDis(){
        var idArr=$('#table-waitdispatch').jqGrid('getGridParam','selarrrow');
        for(var i = 0 ; i < idArr.length; i++){
            var rowData = $('#table-waitdispatch').jqGrid('getRowData', idArr[i]);
        }
        //return ;
        $('.activeDispatch').popup(); //显示我要派工弹出框和判断高度
        $.selectCheck2("serverSelected");
        initDispatchMap();
        employe();
    }

    function initDispatchMap() {
        var markers = [{
            icon: 'http://webapi.amap.com/theme/v1.3/markers/n/mark_b1.png',
            position: [117.2484, 31.843865]
        }, {
            icon: 'http://webapi.amap.com/theme/v1.3/markers/n/mark_b2.png',
            position: [117.231643, 31.832282]
        }, {
            icon: 'http://webapi.amap.com/theme/v1.3/markers/n/mark_b3.png',
            position: [117.237249,31.815086]
        }];
        if (!dispatchMap) {
            dispatchMap = new AMap.Map('dispatch_map_container', {
                zoom: 12
            });

            markers.forEach(function(marker) {
                new AMap.Marker({
                    map: dispatchMap,
                    icon: marker.icon,
                    position: [marker.position[0], marker.position[1]],
                    offset: new AMap.Pixel(-12, -36)
                });
            });
            employeMarker = new AMap.Marker({});

        }
        employeMarker.setMap(null);
    }

    function employe() {
        var lnglat = $("#lnglat").val();
        $.ajax({
            type : "POST",
            url : "${ctx}/operate/employe/dispatchList",
            data : {
                lnglat :lnglat
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
                        +'<td>'+item.distance_formatted+'</td>'
                        +'<td><label class="label-cbox3" for="'+item.id+'"><input type="checkbox" name="serverSelected" id="'+item.id+'"></label></td>'
                        +'</tr>';
                }
                if(isBlank(appendHtml)){
                    layer.msg("无维修"+category+"的工程师");
                }
                content.html(appendHtml);

                $("#zhijiepaidan tr").each(function(index) {
                    $(this).data("emp", sites[index].columns);
                });
                $("#zhijiepaidan tr").on('click', function() {
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
                                id= $.trim($(this).children('td').eq(5).children('label').attr('for'));
                            }else{
                                id= id+","+$(this).children('td').eq(5).children('label').attr('for');
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
        if(val==null || $.trim(val)=='' || val == undefined || val=='null') {
            return true;
        }
        return false;
    }

    function initSfGrid(){
        $("#table-waitdispatch").sfGrid({
            url : '${ctx}/order/getOrderMenuList/dhf?ptype='+${ptype},
            sfHeader: defaultHeader,
            sfSortColumns: sortHeader,
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

    function fmtTotalMoney(rowData){
        return rowData.auxiliary_cost + rowData.serve_cost + rowData.warranty_cost;
    }

    function fmtWC(rowData){
        return rowData.confirm_cost;
    }

    function fmtOrdertype(row){
        if(row == 2){
            return "<span>美的</span>";
        }else if(row == 3){
            return "<span>惠而浦</span>";
        }else if(row == 4){
            return "<span>海信</span>";
        }
        return "<span>自接</span>";
    }

    function fmtOrderNo(rowData){
        return '<a href="javascript:showDetail(\''+rowData.id+'\');" class="c-0383dc">'+rowData.number+'</a>';
    }

    function showDetail(id){
    	$("#table-waitdispatch").jqGrid('resetSelection');
   	 $("#table-waitdispatch").jqGrid('setSelection',id);
        jiesuanFormIndex = layer.open({
            type : 2,
            content:'${ctx}/order/orderDispatch/jiesuanform?id='+id,
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            fadeIn:0,
            anim:-1
        });
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

    function closejisuanform() {
        layer.close(jiesuanFormIndex);
    }



    function fmtStatus(row){
        if(row == 2){
            return "<span>维修中</span>";
        }else if(row == 7){
            return "<span>暂不派工</span>";
        }
        return "<span>待派工</span>";
    }
    function search(){
      /*   if('${ptype }'!='2'&&'${not empty cateList}' === 'true') {
        } else {
            var valCategory = $('#catgyS').combobox('getValues');
            $("input[name='applianceCategory']").val(valCategory);
        } */
    	var pageSize = $("#pageSize").val();
    	if($.trim(pageSize)=='' || pageSize==null){
    		$("#pageSize").val(20);
    	}
        $("#table-waitdispatch").sfGridSearch({
            postData: $("#searchForm").serializeJson()
        });
    }
    function addNew(){
        layer.open({
            type : 2,
            content:'${ctx}/order/orderDispatch/jiesuanform?id='+id,
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            anim:-1
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
                    location.href="${ctx}/order/export?formPath=/a/order/getWwgList/dhf&&maps="+$("#searchForm").serialize();
                },
                fnCancel: function () {

                }

            });
        }else{
            location.href="${ctx}/order/export?formPath=/a/order/getWwgList/dhf"
        }

    }

    function showzjfd(){
        var idArr=$('#table-waitdispatch').jqGrid('getGridParam','selarrrow');
        if(idArr.length > 0){
            $('.showzjfddiv').popup({level:1});
        }else{
            layer.msg("请先选择数据！");
        }
    }

    function savezjfd(){
        var idArr=$('#table-waitdispatch').jqGrid('getGridParam','selarrrow');
        var ids="";
        for(var i=0;i<idArr.length;i++){
            if(i==0){
                ids=idArr[0];
            }else{
                ids=ids+","+idArr[i];
            }
        }
        var latest_process = $.trim($("#reasonofzjfd").val());
        if(isBlank(latest_process)){
            layer.msg("请输入理由!");
            return;
        }else{
            $.ajax({
                type:"POST",
                url:"${ctx}/order/orderDispatch/updateOrderClose",
                data:{
                    id:ids,
                    latest_process:latest_process
                },
                success:function(result){
                    layer.msg("封单成功！");
                    setTimeout(function(){
                        search();
                        numerCheck();
                        $.closeDiv($('.showzjfddiv'));
                        //window.location.reload(true);


                    },500);
					/* window.parent.location.reload(true);
					 window.location.href='${ctx}/operate/site/saveTableHeader';
					 $('#Hui-article-box',window.top.document).css({'z-index':'9'}); */
                },
                error:function(){
                    alert("系统繁忙!");
                    return;
                }/* ,
				 complete:function(){
				 layer.msg("直接封单更新完毕!",{time:2000});
				 setTimeout(function(){location.href="${ctx}/order/StayVisit";},2000);
				 return;
				 } */
            });
        }
    }

    function confirmCollection(id,m1,m2,m3,m4){//确认交款
    	$("#hideId").val(id);
    	$("#realConfirmMny").val(parseFloat(m1)+parseFloat(m2)+parseFloat(m3));
    	$("#needConfirmMny").val(parseFloat(m1)+parseFloat(m2)+parseFloat(m3));
    	$("#callbackCost").val(m4);
        $(".qrskShow").popup();
    }
    function closeBatchForms(){

    }
    function closeBatchForm() {
        layer.close(batchFormIndex);
    }
    function confirmCard(id){ //确认交单
    	$("#oneOrMore").val('2');
    	dealJiaodan(id,'2');
        /* $('body').popup({
            level:'3',
            type:2,
            content:"您确定要交单吗?",
            fnConfirm:function(){
                $.ajax({
                    type:"post",
                    traditional:true,
                    data:{id:id},
                    url:"${ctx}/order/confirmCard",
                    dataType:"JSON",
                    success:function(result){
                        if(result==true){
                            layer.msg("交单成功！");
                            search();
                            numerCheck();
                            //window.location.reload(true);
                        }else{
                            layer.msg("交单失败，请检查！");
                        }
                    }
                })
            }
        }) */
    }

    function cancerBox(){
        $.closeDiv($('.showzjfddiv'));
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

    //批量交款
    function PLJiaokuan(){
        var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
        var ids = "";
        if(idArr.length<1){
            layer.msg("您先选择您要确认交款的工单！");
            return;
        }
        for(var i=0;i<idArr.length;i++){
            var rowData = $('#table-waitdispatch').jqGrid('getRowData', idArr[i]);
            if(rowData.whether_collection=="确认"){
                if(ids==""){
                    ids="'"+rowData.id+"'";
                }else{
                    ids=ids+",'"+rowData.id+"'";
                }
            }
        }
        if($.trim(ids)=="" || ids==null){
            layer.msg("您选择的工单已全部确认交款！");
            return;
        }
        var message = "您选择的"+idArr.length+"工单中有"+ids.split(",").length+"条尚未确认交款，您确定要确认交款吗?";
        if(ids.split(",").length==idArr.length){
            message = "您确定要将选择的"+idArr.length+"工单确认交款吗？";
        }
        $('body').popup({
            level:'3',
            type:2,
            content:message,
            fnConfirm:function(){
                $.ajax({
                    type:"POST",
                    url:"${ctx}/order/orderDispatch/pljk",
                    data:{
                        ids:ids
                    },
                    success:function(result){
                        if(result.code=="200"){
                            layer.msg(ids.split(",").length+"条工单确认交款成功！");
                            search();
                        }else{
                            layer.msg("交款失败，出现未知错误！");
                            return;
                        }
                    }
                })
            }
        })

    }

    //批量交单
    function PLJiaoDan(){
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

//    function reAccount(rowData) {
//        var html = '';
//        if (rowData.record_account == '1') {
//            html = '是';
//        } else {
//            html = '<a style="color:blue;" onclick="confirmAccount(\'' + rowData.id + '\',\''+rowData.factory_number+'\')">确认</a>';
//        }
//        return html;
//    }
    function reAccount(rowData){
        var html = '';
        if(rowData.record_account=='1'){
            html='是';
        }else{
            if('${fns:checkBtnPermission("ORDERMGM_STAYVISTORDER_DHF_CONFIRMACCOUNT_BTN")}' === 'true'){
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
    	if($.trim(num)=="" || num==null || num==undefined  ){
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
    
    function canceConfirmPay(){
    	$.closeDiv($('.qrskShow'));
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
    
  //是否交款
    function fmtWhetherCollection(rowData) {
     	if (rowData.status == "3" || rowData.status == "4" ) {//|| rowData.status == "5"
     		if ("0" == rowData.whether_collection || "2" == rowData.whether_collection) {
     			if('${fns:checkBtnPermission("ORDERMGM_STAYVISTORDER_STAYVISIT_RETURNMONEYCONFIRM_BTN")}' === 'true'){
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
     			if('${fns:checkBtnPermission("ORDERMGM_STAYVISTORDER_STAYVISIT_RETURNCARDCONFIRM_BTN")}' === 'true'){
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
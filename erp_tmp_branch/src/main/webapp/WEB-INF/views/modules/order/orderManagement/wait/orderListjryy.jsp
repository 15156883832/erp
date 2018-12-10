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
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.css">
		<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/>
	<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
	<script src="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.fix1.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script>
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
			<sfTags:pagePermission authFlag="ORDERMGM_WAITDISPATCH_ALLORDER_TAB" html='<a class="btn-tabBar "  href="${ctx }/order/getWwgList">全部工单<sup id="tab_c1">0</sup></a>'></sfTags:pagePermission>
			<sfTags:pagePermission authFlag="ORDERMGM_WAITDISPATCH_ZANBUPAIGONG_TAB" html='<a class="btn-tabBar"  href="${ctx }/order/getWwgList/zbpg">暂不派工<sup id="tab_c2">0</sup></a>'></sfTags:pagePermission>
			<sfTags:pagePermission authFlag="ORDERMGM_WAITDISPATCH_REFUSEORDER_TAB" html='<a class="btn-tabBar " href="${ctx }/order/getWwgList/jjgd">拒接工单<sup id="tab_c3">0</sup></a>'></sfTags:pagePermission>
			<sfTags:pagePermission authFlag="ORDERMGM_WAITDISPATCH_JRYYORDER_TAB" html='<a class="btn-tabBar current" href="${ctx }/order/getWwgList/jryy">今日预约<sup id="tab_c4">0</sup></a>'></sfTags:pagePermission>
			<p class="f-r btnWrap">
				<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt moresearch" id="moresearch" ><i class="sficon sficon-moresearch"></i>更多查询</a>
				<a href="javascript:;" onclick="reset()" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
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
							<th style="width: 76px;" class="text-r">信息来源：</th>
							<td>
								<span class="select-box">
									<select class="select" name="origin">
									<option value="">请选择</option>
									<c:forEach items="${listorigin}" var="lro">
										<option value="${lro.columns.name }">${lro.columns.name }</option>
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
										<option value="2">保外</option>  <!--  <span style="left:20px;padding-left: 50px;">&nbsp;&nbsp;&nbsp;&nbsp;</span> -->
										<!-- <option value="3">保内转保外</option> -->
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
							<th style="width: 76px;" class="text-r">预约日期：</th>
							<td>
								<input type="text" onfocus="WdatePicker({})" id="promiseTime" name="promiseTime"  class="input-text Wdate radius">
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
							<th style="width: 76px;" class="text-r">登记人：</th>
							<td>
								<input type="text" class="input-text" name="messengerName" />
							</td>
							<th style="width: 76px;" class="text-r">家电条码：</th>
							<td>
								<input type="input-text"  name="elictrictyBarcode" value="" class="input-text">
							</td>
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
						</tr>
						<tr class="moreCondition" style="display: none;">
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
							<th style="width: 76px;" class="text-r">报修时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'repairTimeMax\')||\'%y-%M-%d\'}'})" id="repairTimeMin" name="repairTimeMin" value="" class="input-text Wdate w-140">
								至
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'repairTimeMin\')}',maxDate:'%y-%M-%d 23:59:59'})" id="repairTimeMax" name="repairTimeMax" value="" class="input-text Wdate w-140">
							</td>
						</tr>
					</table>
				</div>
			</form>
			<div class="pt-10 pb-5 cl">
				<div class="f-l">
				<sfTags:pagePermission authFlag="ORDERMGM_WAITDISPATCH_JRYYORDER_NEWORDER_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt" onclick="addNew();"><i class="sficon sficon-add"></i>新建工单</a>'></sfTags:pagePermission>
				<sfTags:pagePermission authFlag="ORDERMGM_WAITDISPATCH_JRYYORDER_DISPATCH_BTN" html='<a href="javascript:directDis();" class="sfbtn sfbtn-opt"><i class="sficon sficon-dispatch"></i>派工</a>'></sfTags:pagePermission>
				<sfTags:pagePermission authFlag="ORDERMGM_WAITDISPATCH_JRYYORDER_ZBDISPATCH_BTN" html='<a href="javascript:emporarily();" class="sfbtn sfbtn-opt"><i class="sficon sficon-notdispatch"></i>暂不派工</a>'></sfTags:pagePermission>
				<sfTags:pagePermission authFlag="ORDERMGM_WAITDISPATCH_JRYYORDER_WXORDER_BTN" html='<a href="javascript:showwxgd();" class="sfbtn sfbtn-opt"><i class="sficon sficon-invalid"></i>无效工单</a>'></sfTags:pagePermission>
				<sfTags:pagePermission authFlag="ORDER_MARKORDER_BTN_OTHERS" html='<a href="javascript:showMarkOrders();" class="sfbtn sfbtn-opt"><i class="sficon sficon-sign"></i>标记工单</a>'></sfTags:pagePermission>
				</div>
				<div class="f-r">
					<a href="javascript:;" class="sfbtn sfbtn-opt2 reloadPageBtn"><i class="sficon sficon-reload"></i>刷新</a>
					<%-- <sfTags:pagePermission authFlag="ORDERMGM_WAITDISPATCH_JRYYORDER_IMPORT_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt2"><i class="sficon sficon-import"></i>导入</a>'></sfTags:pagePermission> --%>
					<sfTags:pagePermission authFlag="ORDERMGM_WAITDISPATCH_JRYYORDER_EXPORT_BTN" html='<a onclick="return exports()" class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="ORDERMGM_WAITDISPATCH_JRYYORDER_TBSETTLE_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt2" id="setHeadersBtn"><i class="sficon sficon-setting"></i>表头设置</a>'></sfTags:pagePermission>
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
											<span class="oState state-book w-80 mb-5">今日预约</span>
											<span class="oState state-dgbd w-80 mb-5">导购报单</span>
											<span class="oState state-refuse w-80 mb-5">标记工单</span>
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
<!-- 表头设置 -->
<div class="">
	<div>
		<h2></h2>
	</div>
</div>
</div></div>

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
			<%--<div class="f-r mapWrap" id="dispatch_map_container">
				
			</div>--%>
		</div>
	</div>
</div>

<!-- 短信群发 -->
<div class="popupBox massTextNote massTextNoteQf">
	<h2 class="popupHead">
		短信群发
		<a href="javascript:;" class="sficon closePopup" onclick="guanbi()"></a>
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
		<a href="javascript:;" class="sficon closePopup"></a>
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
				<input type="button" class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" onclick="closeDivQu()"/>
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


function closeDivQu(){
	$.closeDiv($('.showwxgddiv'));
}

$(function(){
	$('.iconDec').showIcons();
	//获取tab页面统计数字
	numerCheck();

    $.post("${ctx}/order/remainMsgNum",{},function(result){
        $("#sign").val(result.columns.sms_sign);
        $("#siteMsgNums").val(result.columns.sms_available_amount);
        $("#jdTelephone").val(result.columns.sms_phone);
    });

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
	$('.dropdown-sin-2').dropdown({
        input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
    });
	initSfGrid();
	
	$("#serviceMode").select2({tags:true});
	 $("#serviceMode").next(".select2").find(".selection").css("width","140px");

	
	$('#filterName').keyup(function(){
		$('#zhijiepaidan tr').hide()     
		.filter(":contains('" +($(this).val()) + "')").show();  
		}).keyup();//DOM加载完时，绑定事件完成之后立即触发  
	
	
});

function numerCheck(){
	$.post("${ctx}/order/getOrderTabCount",{tab:"dpg"},function(result){
		$("#tab_c1").text(result.c1);
		$("#tab_c2").text(result.c2);
		$("#tab_c3").text(result.c3);
		$("#tab_c4").text(result.c4);
	});
}

function cancelZupg() {
	$.closeDiv($(".showzbpgdiv"));
	$('#Hui-article-box',window.top.document).css({'z-index':'9'});
}
//暂不派工
function emporarily(){
	var idArr=$('#table-waitdispatch').jqGrid('getGridParam','selarrrow');
	if(idArr.length<1){layer.msg("请选择数据！");}else{
		var marks= [];
		gyjqGrid(marks,idArr);
		$('.showzbpgdiv').popup();
	}
}

window.onload=function(){
    $("#_easyui_combobox_i1_0").remove();
}

function reset(){
    $("#catgyS").combobox('clear');
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
				search();
				$.closeDiv($(".showzbpgdiv"));
				numerCheck();
				$("#table-waitdispatch").trigger("reloadGrid");
				$('#Hui-article-box', window.top.document).css({'z-index': '9'});
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
						layer.msg("无效工单更新完毕!",{time:2000});
							 window.location.reload(true);
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
            if (data === "Y") {
                if(idArr.length<1){layer.msg("请选择数据！");}else{
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
                    var marks= [];
                    gyjqGrid(marks,idArr);
                    $('.showwxgddiv').popup();
                    /* 	layer.closeAll('dialog');
                    }); */

                }
            } else if("NN" == data) {
                layer.msg("您选择的工单中包含厂家工单，不能进行无效工单操作，请重新选择！");
			}
        }
	});
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
	//$("#empName").html(name);
}
//确认派工按钮
var adpoting = false;
function dispa(){
	if(adpoting) {
	    return;
    }
	var empId= $("#employeId").val();
	var orderId = $("#orderId").val();
	if(isBlank(empId)){
		layer.msg("请选择服务工程师");
	}else{
	var name=$.trim($("#nameWrap").children('span').html());
//	layer.confirm('确认要给工程师'+name+'派工吗？', {
//		  btn: ['确定','取消'] //按钮
//		}, function(){
//			$.ajax({
//				type : "POST",
//				url : "/order/orderDispatch/save",
//				data :{
//					orderId :orderId,
//					empId :empId
//				},
//				success : function(data) {
//					if(data){
//						layer.msg('已派工!');
//					  window.location.reload(true);
//					}else{
//						layer.msg('派工失败!');
//					}
//
//				}
//			});
//
//
//		}, function(){
//			//$("#employeId").val('');
//		});

		$('body').popup({
			level: '3',
			//	 type:1,  // 提示操作成功
			type:2,  // 提示是否进行某种操作
			content: '确认派工至' + name + '吗？',
			fnConfirm: function () {
				adpoting = true;
				$.ajax({
					type : "POST",
					url : "${ctx}/order/orderDispatch/save",
					data :{
						orderId :orderId,
						empId :empId
					},
					success : function(data) {
						if(data){
							layer.msg('已派工!');
							//window.location.reload(true);
							search();
							numerCheck()
							$.closeDiv($('.activeDispatch'));
							$('#Hui-article-box',window.top.document).css({'z-index':'9'});
						}else{
							layer.msg('派工失败!');
						}

					},
		            complete: function() {
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

        var id;
        var marks = [];
        var categorys = "";
        for (var i = 0; i < idArr.length; i++) {
            if (isBlank(id)) {
                id = idArr[i];
            } else {
                id = id + "," + idArr[i];
            }
            var rowData = $('#table-waitdispatch').jqGrid('getRowData', idArr[i]);
            if (categorys == "") {
                categorys = rowData.appliance_category;
            } else {
                categorys = categorys + "," + rowData.appliance_category;
            }
            marks.push(rowData.customer_lnglat);
        }
        $("#arroundUserInfo").empty();
        getsomething(idArr[0]);
        $("#orderId").val(id);
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
                        html+='<td>'+data[i].columns.applBranCate+'</td>';
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
                        layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
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
	    };
		employeMarker = new AMap.Marker({});
	}
	employeMarker.setMap(null);
} 

function employe(category) {
	var lnglat = $("#lnglat").val();
	$.ajax({
		type : "POST",
		url : "${ctx}/operate/employe/dispatchList",
		data : {
			lnglat :lnglat,
			category:category
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
				 layer.msg("无维修的工程师");
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
	if(val==null || val=='' || val == undefined) {
		return true;
	}
	return false;
}

function initSfGrid(){
	$("#table-waitdispatch").sfGrid({
		url : '${ctx}/order/getOrderMenuList/jryy?ptype='+${ptype},
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
	batchFormIndex =layer.open({
		type : 2,
		content:'${ctx}/order/orderDispatch/form?id='+id,
		title:false,
		area: ['100%','100%'],
		closeBtn:0,
		shade:0,
		fadeIn:0,
		anim:-1 
	});
}
function closeBatchForm() {
	layer.close(batchFormIndex);
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
		content:'${ctx}/order/form',
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
    /* if (nowM >= start && nowM <= end) {
        layer.msg("温馨提醒：系统使用高峰期7:30-11:30,请在其它时间导入、导出！谢谢！");
        return false;
    } */

	var idArr=$("#table-waitdispatch").jqGrid('getGridParam','records')
	var content="共"+idArr+"条数据，本次允许导出前10000条，确定继续导出吗？";
	if(idArr>10000){
		$('body').popup({
			level:3,
			title:"导出",
			content:content,
			 fnConfirm :function(){
				 location.href="${ctx}/order/export?formPath=/a/order/getWwgList/jryy&&maps="+$("#searchForm").serialize();
			 },
fnCancel: function () {
				 
             }
	
		});
	}else{
		 location.href="${ctx}/order/export?formPath=/a/order/getWwgList/jryy&&maps="+$("#searchForm").serialize();
	}

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
</script>
	
</body>
</html>
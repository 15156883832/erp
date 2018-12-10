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
		<div class="tabBar cl mb-10">
			<sfTags:pagePermission authFlag="ORDERMGM_ALLORDER_ALLORDER_TAB" html='<a class="btn-tabBar "  href="${ctx }/order/Whole">全部工单</a>'></sfTags:pagePermission><!--orderWholeList -->
			<sfTags:pagePermission authFlag="ORDERMGM_ALLORDER_JRTXBJ_TAB" html='<a class="btn-tabBar"  href="${ctx }/order/jrtxbj">今日提醒标记</a>'></sfTags:pagePermission><!--orderWholeList -->
			<sfTags:pagePermission authFlag="ORDERMGM_HISTORYORDER_WXORDER_TAB" html='<a class="btn-tabBar current" href="${ctx }/order/getWwgList/wxgd">无效工单</a>'></sfTags:pagePermission>
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
							<input type="hidden" class="input-text" id="siteMsgNums"/>
							<input type="hidden" class="input-text" id="wrongNumber"/>
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
									<select class="select-box w-120"  id="employs"  multiple name="employeNames"  style="width:140px">
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
							
							<th style="width: 76px;" class="text-r">预约日期：</th>
							<td>
								<input type="text" onfocus="WdatePicker({})" id="promiseTime" name="promiseTime" value="" class="input-text Wdate radius">
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
							<!-- 
							<td colspan="5">
								<label class="lb text-r">报修时间：</label>
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'repairTimeMax\')||\'%y-%M-%d\'}'})" id="repairTimeMin" name="repairTimeMin"  value="" class="input-text Wdate w-140" style="width:140px">
								至
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'repairTimeMin\')}',maxDate:'%y-%M-%d 23:59:59'})" id="repairTimeMax" name="repairTimeMax"  value="" class="input-text Wdate w-140" style="width:140px">
							</td> -->
						</tr>
						<tr class="moreCondition" style="display: none;">
							
							<td colspan="10">
								<label class="lb text-r">报修时间：</label>
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'repairTimeMax\')||\'%y-%M-%d\'}'})" id="repairTimeMin" name="repairTimeMin"  value="" class="input-text Wdate w-140" style="width:140px">
								至
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'repairTimeMin\')}',maxDate:'%y-%M-%d 23:59:59'})" id="repairTimeMax" name="repairTimeMax"  value="" class="input-text Wdate w-140" style="width:140px">
								<label class="lb text-r">派工时间：</label>
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'dispatchTimesMax\')||\'%y-%M-%d\'}'})" id="dispatchTimesMin" name="dispatchTimesMin"  value="" class="input-text Wdate w-120" style="width:140px">
								至
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'dispatchTimesMin\')}',maxDate:'%y-%M-%d 23:59:59'})" id="dispatchTimesMax" name="dispatchTimesMax"  value="" class="input-text Wdate w-120" style="width:140px">
								<label class="lb text-r">完工时间：</label>
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
					<sfTags:pagePermission authFlag="ORDERMGM_HISTORYORDER_WXORDER_DELETEMORE_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt" onclick="delMore();"><i class="sficon sficon-rubbish"></i>批量删除</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="ORDER_MARKORDER_BTN_OTHERS" html='<a href="javascript:showMarkOrders();" class="sfbtn sfbtn-opt"><i class="sficon sficon-sign"></i>标记工单</a>'></sfTags:pagePermission>
				</div> 
				<div class="f-r">
					<a href="javascript:;" class="sfbtn sfbtn-opt2 reloadPageBtn"><i class="sficon sficon-reload"></i>刷新</a>
					<%-- <sfTags:pagePermission authFlag="ORDERMGM_HISTORYORDER_WXORDER_IMPORT_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt2"><i class="sficon sficon-import"></i>导入</a>'></sfTags:pagePermission> --%>
					<sfTags:pagePermission authFlag="ORDERMGM_HISTORYORDER_WXORDER_EXPORT_BTN" html='<a onclick="return exports()" class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="ORDERMGM_HISTORYORDER_WXORDER_TBSETTLE_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt2" id="setHeadersBtn"><i class="sficon sficon-setting"></i>表头设置</a>'></sfTags:pagePermission>
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

<!-- 短信群发 -->
<div class="popupBox massText">
	<h2 class="popupHead">
		短信群发
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pd-20" >
			<p class="f-14 mb-10">自定义短信编辑：</p>
			<div class="bk-gray pos-r pb-30">
				<textarea class="textarea h-50" id="content" style="border: none;" placeholder="请输入短信内容"></textarea>
				<div class="senderWrap">
					【<input type="text" id="sign" value="" align="center" style="font-align:center" class="input-text" /> 服务】
				</div>
			</div>
			
			<div class="text-c mt-20">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" onclick="senMsg()">确定</a>
				<a  class="sfbtn sfbtn-opt w-70" onclick="cancelMsg()">取消</a>
			</div>
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
	$.post("${ctx}/order/getOrderTabCount",{tab:"lsgd"},function(result){
		$("#tab_c1").text(result.c1);
		$("#tab_c2").text(result.c2);
		$("#tab_c3").text(result.c3);
	});
}
$(function(){
	$.post("${ctx}/order/remainMsgNum",{},function(result){
		$("#sign").val(result.columns.sms_sign);
		$("#siteMsgNums").val(result.columns.sms_available_amount);
	});
	//numerCheck();

    $('.dropdown-sin-2').dropdown({
        // data: json2.data,
        input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
        choice: function() {
        }
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
	
	initSfGrid();
	$("#serviceMode").select2({tags:true});
	 $("#serviceMode").next(".select2").find(".selection").css("width","140px");

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
    html += '<select class="select-box w-120"  id="employs" style="display:none" multiple  multiline="true" name="employeNames"  >';
    html += '<c:forEach items="${fns:getEmloyeList(siteId) }" var="emp">';
    html += ' <option value="${emp.columns.name }">${emp.columns.name }</option>';
    html += '</c:forEach>';
    html += '</select>  </span>';
    $("#reloadSpan").html(html);
    var html2 = '<span class="w-140 dropdown-sin-2">';
    html2 += '<select class="select-box w-120"  id="signType" style="display:none" multiple multiline="true" name="signType" >';
    html2 += '<c:forEach items="${signList}" var="sign">';
    html2 += ' <option value="${sign.columns.id }">${sign.columns.name }</option>';
    html2 += '</c:forEach>';
    html2 += '</select>  </span>';
    $("#reloadSignSpan").html(html2);
    $('.dropdown-sin-2').dropdown({
        input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
    });
});

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
			if(isBlank1(appendHtml)){
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
					$.trim($(this).children('td').eq(0).html());
				} 
				$("#nameWrap").empty();
				var name="";
				var id = "";
				$("#zhijiepaidan tr").each(function(index) {
					var flag = $(this).hasClass('checked');
					if (flag) {
						if(isBlank1(name)){
							name = $.trim($(this).children('td').eq(0).html());
						}else{
							name = name+" "+ $.trim($(this).children('td').eq(0).html());
						}
						if(isBlank1(id)){
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

function isBlank1(val) {
	if(val==null || $.trim(val)=='' || val == undefined) {
		return true;
	}
	return false;
}

function initSfGrid(){
	$("#table-waitdispatch").sfGrid({
		url : '${ctx}/order/getOrderMenuList/wxgd?ptype='+${ptype},
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
function WxRecord(rowData){
	if (rowData.latest_process) {
		var w = rowData.latest_process.indexOf(":");
		var wxrecord = rowData.latest_process.substring(w + 1);
		return '<span>' + wxrecord + '</span>';
	} else {
		return "";
	}
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
		content:'${ctx}/order/form',
		title:false,
		area: ['100%','100%'],
		closeBtn:0,
		shade:0,
		anim:-1 
	});
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
				 location.href="${ctx}/order/export?formPath=/a/order/getWwgList/wxgd&&maps="+$("#searchForm").serialize(); 
			 },
fnCancel: function () {
				 
             }
	
		});
	}else{
		location.href="${ctx}/order/export?formPath=/a/order/getWwgList/wxgd&&maps="+$("#searchForm").serialize();
	}

}

function senMagPopup(){
	$("#content").val('');
	var ids=$('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
	if(ids.length > 0){
		$('.massText').popup();
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

function senMsg(){ //批量发送短信
	var ids=$('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
	var mobile="";
	var number="";
	var wrongNumber="";
	for(var i=0;i<ids.length;i++){
		var rowData = $("#table-waitdispatch").jqGrid('getRowData',ids[i]);
		var ph1=returnMobile(rowData.customer_mobile,rowData.customer_telephone,rowData.customer_telephone2);//去空格的mobile
		if($.trim(ph1)=="" || $.trim(ph1)==null){
			layer.msg("选择发送的工单中存在用户手机号为空的工单，请先维护或者重新选择工单！");
			return ;
		}
		if($.trim(ph1).length!=11 || $.trim(ph1).substring(0,1)!="1" ){
			if(wrongNumber==""){
				wrongNumber=rowData.number;
			}else{
				wrongNumber=wrongNumber+','+rowData.number;
			}
		}
		if(i==0){
			mobile=$.trim(ph1);
			number=$.trim(rowData.number);
		}else{
			mobile=mobile+','+$.trim(ph1);
			number=number+','+$.trim(rowData.number);
		} 
	}
	$("#wrongNumber").val(wrongNumber);//未发送的工单编号
	if(wrongNumber==""){
		var a = document.getElementById("exportLink"); 
		a.removeAttribute("href"); 
		a.setAttribute("onclick","tishi()");
	}else{
		$("#exportLink").prop("href", $("#exportLink").prop("href")+"&no="+wrongNumber);
	}
	var content = $("#content").val();
	var sign = $("#sign").val();
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
					url:"${ctx }/order/sendMsg",
					data:{content:content,
						sign:sign,
						mobile:mobile,
						number:number
						},
					success:function(result){
						var n = 0;
						for(var j=0;j<msgNumbers.length;j++){
							if(msgNumbers[j].length==11 && msgNumbers[j].substring(0,1)=="1" ){
								n++;
							}
						}
						$("#sucMsg").text(n);
						$("#wroMsg").text(parseInt(msgNumbers.length)-parseInt(n));
						//
						layer.msg("发送成功");
						search();
						numerCheck();
						$('.massTextNoteQf').popup({level:2});
					}
				})
			}
		}
	}) 
		
}

function tishi(){
	layer.msg("没有未发送的工单！");
}

function cancelMsg(){
	$.closeDiv($(".massText"));
}

function guanbi(){
	$.closeDiv($(".massTextNote"));
	$.closeDiv($(".massText"));
}

function closePopup(){
	$.closeDiv($(".massTextNote"));
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

var wxgdMark=false;
function delMore(){
	if(wxgdMark){
		return;
	}
	var idArr=$('#table-waitdispatch').jqGrid('getGridParam','selarrrow');
	if(idArr.length < 1){
		layer.msg("请先选择你要删除的数据！");
		return;
	}
	var ids="";
	var idsToDel = [];
	for(var i=0;i<idArr.length;i++){
		var rowData = $('#table-waitdispatch').jqGrid('getRowData', idArr[i]);
		idsToDel.push(rowData.id);
		if(ids==""){
			ids="'"+rowData.id+"'";
		}else{
			ids=ids+",'"+rowData.id+"'";
		}
	}
	
	$('body').popup({
		level:'3',
		type:2,
		content:"您确定要删除这"+idArr.length+"条工单吗?",
		fnConfirm:function(){
			wxgdMark=true;
			$.ajax({
				type:"post",
				url:"${ctx}/order/delWxgd",
                data: {
                    idsToDel: idsToDel,
				    ids: ids
				},
				success:function(data){
					if(data.code=="421"){
						layer.msg("请先选择您要删除的数据");
						return;
					}else if(data.code=="422"){
						layer.msg("你选择的数据信息有误，有些数据可能已被删除，您可以刷新列表后重新选择");
						return;
					}else if(data.code=="200"){
						layer.msg("删除成功");
						search();
					}else{
						layer.msg("删除失败，出现未知错误，请联系管理员");
						return;
					}
				},
				complete:function(){
					wxgdMark=false;
				}
			})
		}
	}) 
	
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
   			$('#ifSelect').val('2');
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

function fmtRC(rowData) {//交单情况
 	if (rowData.status == "3" || rowData.status == "4" || rowData.status == "5" || rowData.status == "8" ) {
 		if ("0" == rowData.return_card || "2" == rowData.return_card) {
 			if('${fns:checkBtnPermission("ORDERMGM_HISTORYORDER_WXORDER_RETURNCARDCONFIRM_BTN")}' === 'true'){
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
</script>
	
</body>
</html>
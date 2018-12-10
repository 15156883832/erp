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
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.css">
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/>
    <script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
	<script src="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.fix1.js"></script>
	<style type="text/css">
		.ordertjbox .ordertxt1{
		    position: relative; 
			padding-left: 60px; 
			display: inline-block;
		}
		.ordertjbox .ordertxt1 .txt{
			line-height: 32px;
			height: 32px;
			padding-left: 15px; 
			font-size: 13px;
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

			<sfTags:pagePermission authFlag="ORDER_PPLATFORM_ORDER_TAB" html='<a id="meidi" class="btn-tabBar current"  href="${ctx }/order/platformOrderList">家电协会</a>'></sfTags:pagePermission>
			<%-- <c:if test="${map.meidi eq  'has'}">
				<sfTags:pagePermission authFlag="ORDERMGM_FOURORDER_HUNDRANDORDER_TAB" html='<a id="meidi" class="btn-tabBar current"  href="${ctx }/order/ChangeSelfOrder/headerList">美的工单</a>'></sfTags:pagePermission>
			</c:if>
			<c:if test="${map.haier eq 'has'}">
				<sfTags:pagePermission authFlag="ORDERMGM_FOURORDER_HAIERORDER_TAB" html='<a id="haier" class="btn-tabBar"  href="${ctx }/order/ChangeSelfOrder/haierHeaderList">海尔工单</a>'></sfTags:pagePermission>
			</c:if>
			<c:if test="${map.haixin eq 'has'}">
				<sfTags:pagePermission authFlag="ORDERMGM_FOURORDER_HAIXINORDER_TAB" html='<a id="haixin" class="btn-tabBar"  href="${ctx }/order/ChangeSelfOrder/haixinHeaderList">海信工单</a>'></sfTags:pagePermission>
			</c:if>
			<c:if test="${map.huierpu eq 'has'}">
				<sfTags:pagePermission authFlag="ORDERMGM_FOURORDER_HUIERPU_TAB" html='<a id="huierpu" class="btn-tabBar"  href="${ctx }/order/ChangeSelfOrder/huierpuHeaderList">惠而浦工单</a>'></sfTags:pagePermission>
			</c:if> --%>

			<p class="f-r btnWrap">
				<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt moresearch" id="moresearch" ><i class="sficon sficon-moresearch"></i>更多查询</a>
				<a href="javascript:;" onclick="reset()" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
			</p>
		</div>
		<div class="tabCon">
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
				<input type="hidden" name="warningType"  value="">
				<div class="bk-gray pt-10 pb-5">
					<table class="table table-search">
						<tr>
							<th style="width: 76px;" class="text-r">工单编号：</th>
							<td>
								<input type="text" class="input-text" name= "number"/>
							</td>
							<th style="width: 76px;" class="text-r">工单状态：</th>
							<td id="reloadSpan">
								<%--<input type="text" class="input-text" name = "status"/>--%>
								<span class="dropdown-sin-2 w-140">
								<select class="select" name="status" id="status" multiple>
										<option value="">请选择</option>
										<option value="0">待接收</option>
										<option value="1">待派工</option>
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
							<th style="width: 76px;" class="text-r">家电品类：</th>
							<td>
                                <select class="select w-140" name="applianceCategory" style="height:26px;">
                                    <option value="">请选择</option>
                                    <c:forEach items="${category }" var="ca">
                                        <option value="${ca.columns.name }">${ca.columns.name }</option>
                                    </c:forEach>
                                </select>
							</td>
							<th style="width: 76px;" class="text-r">家电型号：</th>
							<td>
								<input type="text" class="input-text" name = "applianceModel"/>
							</td>
							<th style="width: 76px;" class="text-r">服务类型：</th>
							<td>
								<%--<input type="text" class="input-text" id="serviceType" name = "serviceType"/>--%>
									<select class="select w-140" name="serviceType">
										<option value="">请选择</option>
										<c:forEach items="${fns:getNewServiceType() }" var="stype">
											<option value="${stype.columns.name }">${stype.columns.name }</option>
										</c:forEach>
									</select>
							</td>

						</tr>
						<tr>
							<th style="width: 76px;" class="text-r">用户姓名：</th>
							<td>
								<input type="text" class="input-text" name = "customerName" onkeydown="enterEvent(event)"/>
							</td>
							<th style="width: 76px;" class="text-r">联系方式：</th>
							<td>
								<input type="text" class="input-text" name = "customerMobile" onkeydown="enterEvent(event)"/>
								<input type="hidden" class="input-text" name = "orderStatus" id="orderStatus"/>
							</td>
							<th style="width: 76px;" class="text-r">用户地址：</th>
							<td>
								<input type="text" class="input-text" name = "customerAddress" onkeydown="enterEvent(event)"/>
							</td>
							<th style="width: 76px;" class="text-r">服务工程师：</th>
							<td>
								<input type="text" class="input-text" name = "employeName"/>
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
							<th style="width: 76px;" class="text-r">报修时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'repairTimeMax\')||\'%y-%M-%d\'}'})" id="repairTimeMin" name="repairTimeMin" value="" class="input-text Wdate w-120" style="width:140px" readonly>
								至
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'repairTimeMin\')}',maxDate:'%y-%M-%d 23:59:59'})" id="repairTimeMax" name="repairTimeMax"  value="" class="input-text Wdate w-120" style="width:140px" readonly>
							</td>

							<th style="width: 76px;" class="text-r">预约时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'promiseTimeMax\')||\'%y-%M-%d\'}'})" id="promiseTimeMin" name="promiseTimeMin"  value="" class="input-text Wdate w-120" style="width:140px" readonly>
								至
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'promiseTimeMin\')}',maxDate:'%y-%M-%d 23:59:59'})" id="promiseTimeMax" name="promiseTimeMax" value="" class="input-text Wdate w-120" style="width:140px" readonly>
							</td>

							<th style="width: 76px;" class="text-r">结算档案：</th>
							<td>
								<select class="select w-140"  id="archive"  name="archive" style="height: 26px;">
									<option value="">请选择</option>
									<option value="0">未录单</option>
									<option value="1">已录单</option>
								</select>
							</td>
						</tr>
						<tr class="moreCondition" style="display: none;">
							<th style="width: 76px;" class="text-r">派工时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'dispatchTimeMax\')||\'%y-%M-%d\'}'})" id="dispatchTimeMin" name="dispatchTimeMin" value="" class="input-text Wdate w-120" style="width:140px" readonly>
								至
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'dispatchTimeMin\')}',maxDate:'%y-%M-%d 23:59:59'})" id="dispatchTimeMax" name="dispatchTimeMax"  value="" class="input-text Wdate w-120" style="width:140px" readonly>
							</td>
							<th style="width: 76px;" class="text-r">完工时间：</th>
							<td colspan="3">
							<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'endTimeMax\')||\'%y-%M-%d\'}'})" id="endTimeMin" name="endTimeMin"  value="" class="input-text Wdate w-120" style="width:140px" readonly>
							至
							<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'endTimeMin\')}',maxDate:'%y-%M-%d 23:59:59'})" id="endTimeMax" name="endTimeMax" value="" class="input-text Wdate w-120" style="width:140px" readonly>
							</td>
						</tr>
					</table>
				</div>
			</form>
			<div class="ordertjbox mt-10 cl">
				<div class="col-4-1 ordertj-item"  style="cursor:pointer;">
					<div class="bk-gray">
						<div class="ordertxt1" onclick="warningOrder(1)">
							<p class="bg bg11"></p>
							<p class="txt">今日工单总数（<span class="f-18 c-0e8ee7 va-t" id="totalCounts">0</span>）</p>
						</div>
						
					</div>
				</div>
				<div class="col-4-1 ordertj-item" style="cursor:pointer;">
					<div class="bk-gray">
						<div class="ordertxt1" onclick="warningOrder(2)">
							<p class="bg bg31 "></p>
							<p class="txt">待接收（<span class="f-18 c-4baf4b va-t" id="djsCount">0</span>）</p>
						</div>
						
					</div>
				</div>
				<div class="col-4-1 ordertj-item"  style="cursor:pointer;">
					<div class="bk-gray">
						<div class="ordertxt1" onclick="warningOrder(3)">
							<p class="bg bg62"></p>
							<p class="txt">超20h预警工单（<span class="f-18 c-f36a5a va-t" id="20hCount">0</span>）</p>
						</div>
					
					</div>
				</div>
				<div class="col-4-1 ordertj-item"  style="cursor:pointer;">
					<div class="bk-gray">
						<div class="ordertxt1" onclick="warningOrder(4)">
							<p class="bg bg42"></p>
							<p class="txt">超24h预警工单（<span class="f-18 c-f36a5a va-t" id="24hCount">0</span>）</p>
						</div>
					</div>
				</div>
			</div>
			<div class="pt-10 pb-5 cl">
				<div class="f-l">
					<sfTags:pagePermission authFlag="ORDER_PPLATFORM_ORDER_RECEIVE_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt" onclick="Receive();"><i class="sficon sficon-jiedan"></i>接收</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="ORDER_PPLATFORM_ORDER_REFUSE_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt" onclick="Tosingle();"><i class="sficon sficon-judan"></i>拒单</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="ORDER_PPLATFORM_ORDER_DISPATCH_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt" onclick="Dispatching();"><i class="sficon sficon-dispatch"></i>派工</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="ORDER_PPLATFORM_ORDER_LURECORD_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt" onclick="repairAccountRecordButton();"><i class="sficon sficon-plcopy"></i>录入结算档案</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="ORDER_PPLATFORM_ORDER_MARK_BTN" html='<a href="javascript:showMarkOrders();" class="sfbtn sfbtn-opt"><i class="sficon sficon-sign"></i>标记工单</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="ORDER_PPLATFORM_ORDER_CANCELMARK_BTN" html='<a href="javascript:cancelMarkOrders();" class="sfbtn sfbtn-opt"><i class="sficon sficon-signCancel"></i>取消标记</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="ORDER_PPLATFORM_ORDER_PLPRINT_BTN" html='<a href="javascript:batchPrint();" id="repeatOrder"  class="sfbtn sfbtn-opt"><i class="sficon sficon-print"></i>批量打印</a>'></sfTags:pagePermission>
				</div>
				<div class="f-r">
					<sfTags:pagePermission authFlag="ORDER_PPLATFORM_ORDER_EXPORT_BTN" html='<a onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="ORDER_PPLATFORM_ORDER_HEADERSET_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt2" id="setHeadersBtn"><i class="sficon sficon-setting"></i>表头设置</a>'></sfTags:pagePermission>
				</div>
								
			</div>
			<div>
				<table id="table-waitdispatch" class="table"></table>
				<!-- pagination -->
					<div class="cl pt-10">
					
						<!-- <div class="f-l">
							<span class="c-f55025">注：</span>
							<span class="oState oState state-yzzj">已转自接</span>
						</div> -->
						<div class="f-l iconsBoxWrap">
								<a class="iconDec">图标注释？</a>
								<div class="iconsBox">
									<div class="iconsBoxBg">
										<div class="cl pl-10 pt-5">
											<span class="oState state-yzzj w-80 mb-5">已转自接</span>
											
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
					<input type="text" placeholder="请输入工程师姓名" class="input-text" id="filterName"/>
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

<input type="hidden" id="settleFlag" name="settleFlag" value="${settleFlag }">
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

$(function(){
	
	$('.iconDec').showIcons();
	
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
    couts();
	initSfGrid();
    $('.dropdown-sin-2').dropdown({input: '<input type="text" maxLength="20" placeholder="请输入搜索">',});
    $("select[name='applianceCategory']").select2();
   // $("#signType").select2();
    $(".selection").css("width","140px");
    $(".select2-selection--single").css("border", "1px solid #ccc");
    $.setGridSize();
});

function isBlank(val) {
	if(val==null || $.trim(val)=='' || val == undefined) {
		return true;
	}
	return false;
}

function couts(){
    $.post("${ctx}/order/getPlatformCount",{orderType:"2"},function(result){
        $("#totalCounts").text(result.jrgdCunt);
        $("#djsCount").text(result.djsCount);
        $("#20hCount").text(result.tyhCount);
        $("#24hCount").text(result.tfhCount);

    });
}

function initSfGrid(){
	$("#table-waitdispatch").sfGrid({
		url : '${ctx}/order/getplatformOrderList',
		sfHeader: defaultHeader,
		sfSortColumns: sortHeader,
		rownumbers:true,
 		loadComplete: function() {
 			_order_comm.gridNum();
		}  
	});
}

function marks(rowData){
    var origin = "";
    if(rowData.flag) {
        var flag = "<span class='oState state-refuse' title='标记工单：" + rowData.flag_desc + "'></span>";
        return flag + origin;
	} else {
        return origin;
	}
}


function servieType(rowData){
	if(rowData.service_type != "" && rowData.service_type != null){
		return '<span>'+rowData.service_type+'</span>';
	}else{
		if(rowData.c_service_type != "null" && rowData.c_service_type != "" && rowData.c_service_type != null){
			return '<span>'+rowData.c_service_type+'</span>';
		}else{
			return '<span></span>';
		}
		
	}
}

function gdbh(rowData){
	return '<a href="javascript:showDetail(\''+rowData.id+'\');" class="c-0383dc">'+rowData.number+'</a>';
}

function showDetail(id){
	$("#table-waitdispatch").jqGrid('resetSelection');
	 $("#table-waitdispatch").jqGrid('setSelection',id);
	layer.open({
		type : 2,
		content:'${ctx}/order/orderDispatch/Wholeform?id='+id+'&newOrder=2',
		title:false,
		area: ['100%','100%'],
		closeBtn:0,
		shade:0,
		fadeIn:0,
		anim:-1
	});
}

function numerCheck(){
}

function employes(rowData){
	var emps="";
	if($.trim(rowData.employe1)!="" && $.trim(rowData.employe1)!=null){
		emps=rowData.employe1;
	}
	if($.trim(rowData.employe2)!="" && $.trim(rowData.employe2)!=null){
		if(emps==""){
			emps=rowData.employe2;
		}else{
			emps=emps+","+rowData.employe2;
		}
	}
	if($.trim(rowData.employe3)!="" && $.trim(rowData.employe3)!=null){
		if(emps==""){
			emps=rowData.employe3;
		}else{
			emps=emps+","+rowData.employe3;
		}
	}
	return emps;
}

function warningOrder(type){
	$("input[name='warningType']").val(type);
	search();
}

function search(){
	var pageSize = $("#pageSize").val();
	if($.trim(pageSize)=='' || pageSize==null){
		$("#pageSize").val(20);
	}
	$("#applianceB").val($('#applianceBrand option:selected').val());
    $("#table-waitdispatch").sfGridSearch({
        postData: $("#searchForm").serializeJson()
    });
}

function reloadGride() {
    $("#table-waitdispatch").trigger("reloadGrid");
}


function reset(){
	//$("#statusFlag").combobox('clear');
	//$("#employs").val("");
	//$('#statusFlag').combobox('setValues',"");
	$("#searchForm").get(0).reset();
    $("#searchForm").find("input").val("");

    var html = '<span class="w-140 dropdown-sin-2">';
    html += '<select class="select-box w-120"  name="status" id="status" style="display:none" multiple  multiline="true"  >';
    html += '<option value="">请选择</option>';
    html += '<option value="0">待接收</option>';
    html += '<option value="1">待派工</option>';
    html += '<option value="2">服务中</option>';
    html += '<option value="3">待回访</option>';
    html += '<option value="4">待结算</option>';
    html += '<option value="5">已完成</option>';
    html += '<option value="6">取消工单</option>';
    html += '<option value="7">暂不派工</option>';
    html += '<option value="8">无效工单</option>';

    html += '</select></span>';
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
				 location.href="${ctx}/order/platformOrder/export?formPath=/a/order/platformOrderList&&maps="+$("#searchForm").serialize();
			 }
		});
	}else{
		 location.href="${ctx}/order/platformOrder/export?formPath=/a/order/platformOrderList&&maps="+$("#searchForm").serialize();
	}

}


function selectStateS(id1, id2){
	$('#'+id1+' .selectLabel').each(function(index){
		$(this).on('click', function(){
			$('#'+id1+' .selectLabel').removeClass('selectedLabel');
			$(this).addClass('selectedLabel');
			if(index == 0){
				$('#'+id2).hide();
			}else{
				$('#'+id2).show();
			}
		});
	})
}

function Receive(){
	var idArr=$('#table-waitdispatch').jqGrid('getGridParam','selarrrow');
	if(idArr.length<1){
		layer.msg("请先选择您要接收的工单！");
		return;
	}else{
        for (var i = 0; i < idArr.length; i++) {
            var rowData = $('#table-waitdispatch').jqGrid('getRowData', idArr[i]);
            if($.trim(rowData.status) !== '待接收') {
                layer.msg("您选择的工单中有不可接收的工单，不能操作接单！");
                return;
			}
        }
		  $('body').popup({
              level: '3',
              type: 2,  // 提示是否进行某种操作
              content: '确定要接收派工吗？',
              fnConfirm: function () {
                  $.ajax({
						url: "${ctx}/order/recvOrdersFac",
                      type: 'post',
                      data: {
						    ids: idArr.join(",")
						},
						success: function(data) {
						    if ('500' === data.code) {
						        layer.msg("您选择的工单中有不可接收的工单，不能操作接单！")
							} else if('200' === data.code) {
                              layer.msg("接单成功！");
							} else if('422' === data.code) {
                              layer.msg("工单已被转派！");
                         	 } else if('201' === data.code || '205' === data.code) {
                              layer.msg("接收失败，请稍后再试！");
                         	 }
							search();
							couts();
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

//拒接
function Tosingle() {
    var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
    if (idArr.length < 1) {
        layer.msg("请选择数据！");
    } else {
        for (var i = 0; i < idArr.length; i++) {
            var rowData = $('#table-waitdispatch').jqGrid('getRowData', idArr[i]);
            if($.trim(rowData.status) !== '待接收') {
                layer.msg("您选择的工单中有不可接收的工单，不能操作接单！");
                return;
            }
        }
        $('body').popup({
            level: '3',
            type: 2,  // 提示是否进行某种操作
            content: '确定要拒接退回工单吗？',
            fnConfirm: function () {
                $.ajax({
                    url: "${ctx}/order/refuseOrders",
                    type: 'post',
                    data: {
                        ids: idArr.join(",")
                    },
                    success: function (data) {
                        if ('422' === data.code) {
                            window.top.layer.msg("您选择的工单中有不可退回的工单，无法操作拒单！")
                        } else if ('200' === data.code) {
                            window.top.layer.msg("退回成功！");
                        } else if ('423' === data.code) {
                            window.top.layer.msg("您选择的工单状态已经更新，请重试！");
                        }
                        search();
                    },
                    error: function () {
                    }
                });
            },
            fnCancel: function () {
            }
        });
    }
}

function Dispatching() {
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
        initDispatchMap(marks);
        employe(categorys);
    }
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
            $(".custAddr").text(data.columns.customer_address);
            splitAddress(data.columns.customer_address);
        }
    });
}

function splitAddress(address) {
    var addressDetail="";
    var sz = [];
    if (address.indexOf("区") > 0 && address.indexOf("县") <= 0 && address.indexOf("市") < 0) {
        sz = address.split("区");
        if (sz.length > 2) {
            var strs = "";
            for (var i = 1; i < sz.length; i++) {
                if (i != sz.length - 1) {
                    strs += sz[i] + "区";
                } else {
                    strs += sz[i];
                }
            }
            addressDetail=strs;
        } else if (1 < sz.length <= 2) {
            addressDetail=sz[1];
        } else {
            addressDetail=sz[0];
        }
    }else if (address.indexOf("县") > 0 && address.indexOf("市") < 0) {
        sz = address.split("县");
        if (sz.length > 2) {
            var strs = "";
            for (var i = 1; i < sz.length; i++) {
                if (i != sz.length - 1) {
                    strs += sz[i] + "县";
                } else {
                    strs += sz[i];
                }
            }
            addressDetail=strs;
        } else if (1 < sz.length <= 2) {
            addressDetail=sz[1];
        } else {
            addressDetail=sz[0];
        }
    }else if(address.indexOf("县") > 0 && address.indexOf("市") > 0){
        var ciAd=address.indexOf("市");
        var xaAd=address.indexOf("县");
        if(parseInt(ciAd) < parseInt(xaAd)){//市在前
            sz = address.split("市");
            if (sz.length > 2) {
                var strs = "";
                for (var i = 1; i < sz.length; i++) {
                    if (i != sz.length - 1) {
                        strs += sz[i] + "市";
                    } else {
                        strs += sz[i];
                    }
                }
                addressDetail=strs;
            } else if (sz.length == 2) {
                addressDetail=sz[1];
            } else {
                addressDetail=sz[0];
            }
        }else if(parseInt(ciAd) > parseInt(xaAd) ){//县在前
            sz = address.split("县");
            if (sz.length > 2) {
                var strs = "";
                for (var i = 1; i < sz.length; i++) {
                    if (i != sz.length - 1) {
                        strs += sz[i] + "县";
                    } else {
                        strs += sz[i];
                    }
                }
                addressDetail=strs;
            } else if (1 < sz.length <= 2) {
                addressDetail=sz[1];
            } else {
                addressDetail=sz[0];
            }
        }
    }else if(address.indexOf("市") > 0 && address.indexOf("区") < 0){
        sz = address.split("市");
        if (sz.length > 2) {
            var strs = "";
            for (var i = 1; i < sz.length; i++) {
                if (i != sz.length - 1) {
                    strs += sz[i] + "市";
                } else {
                    strs += sz[i];
                }
            }
            addressDetail=strs;
        } else if (sz.length == 2) {
            addressDetail=sz[1];
        } else {
            addressDetail=sz[0];
        }
    }else if (address.indexOf("市") > 0 && address.indexOf("区") > 0) {
        var ciAd=address.indexOf("市");
        var quAd=address.indexOf("区");

        if(parseInt(ciAd) < parseInt(quAd)){//市在前
            sz = address.split("市");
            if (sz.length > 2) {
                var strs = "";
                for (var i = 1; i < sz.length; i++) {
                    if (i != sz.length - 1) {
                        strs += sz[i] + "市";
                    } else {
                        strs += sz[i];
                    }
                }
                addressDetail=strs;
            } else if (sz.length == 2) {
                addressDetail=sz[1];
            } else {
                addressDetail=sz[0];
            }
        }else if(parseInt(ciAd) > parseInt(quAd) ){//区在前
            sz = address.split("区");
            if (sz.length > 2) {
                var strs = "";
                for (var i = 1; i < sz.length; i++) {
                    if (i != sz.length - 1) {
                        strs += sz[i] + "区";
                    } else {
                        strs += sz[i];
                    }
                }
                addressDetail=strs;
            } else if (1 < sz.length <= 2) {
                addressDetail=sz[1];
            } else {
                addressDetail=sz[0];
            }
        }
    } else if (address.indexOf("区") <= 0 && address.indexOf("县") <= 0 && address.indexOf("市") <= 0) {
        addressDetail=address;
    }
    $("#arroundCustomerAddress").val(addressDetail);
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

/*维修单*/
function fmtWriteOrder(rowData){
    if(rowData.repair_record_account=='0' || !rowData.repair_record_account){
        if ('${fns:checkBtnPermission("ORDER_PPLATFORM_ORDER_LURECORDONE_BTN")}' === 'true') {
            return '<a href="javascript:repairAccountRecord(\''+rowData.number+'\',\''+rowData.status+'\');" style="color:blue;">录入</a>';
        }
        return "";
    }else if(rowData.repair_record_account=='1'){
        return '已录单';
    }
}


function repairAccountRecordButton(){
    var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
    var rowData = $('#table-waitdispatch').jqGrid('getRowData', idArr[0]);
    var status = $.trim(rowData.status);
    if(idArr.length<1){
        layer.msg("请选择记录");
    }else if(idArr.length>1){
        layer.msg("一次只能选择一条记录");
    }else if(rowData.repair_record_account=="已录单"){
        layer.msg("该记录已操作过录单");
    }else if(status!="已完成"&&status!='待回访'&&status!='待结算'){
        repairAccountRecord(rowData.number,"1");
    }else{
        repairAccountRecord(rowData.number,"3");
    }

}

function repairAccountRecord(number,status){
    if(status=='3' || status=='4' || status=='5'){
        layer.open({
            type: 2,
            content: '${ctx}/order/orderSettlement/reRepairSubmitPage?number=' + number,
            title: false,
            area: ['100%', '100%'],
            closeBtn: 0,
            shade: 0,
            fadeIn: 0,
            anim: -1
        });
    }else{
        layer.msg("该工单尚未完工，不能进行录单操作");
    }
}


/*enter查询*/
function enterEvent(event){
	var keyCode = event.keyCode?event.keyCode:event.which?event.which:event.charCode;
	if (keyCode ==13){
		$("#applianceB").val($('#applianceBrand option:selected').val());
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
//批量打印
function batchPrint(){
	var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
    if (idArr.length <= 0) {
        layer.msg("请选择需要打印的工单！");
    } else {
    	//使用默认
    	window.open("${ctx}/print/order400?orderId="+idArr.join(','));
    }
}
</script>
	
</body>
</html>
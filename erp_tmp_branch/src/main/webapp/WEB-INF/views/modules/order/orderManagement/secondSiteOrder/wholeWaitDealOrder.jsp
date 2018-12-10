<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="decorator" content="base"/>
<title>待处理工单</title>
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
		.webuploader-pick{
			width:44px;
			height:20px;
			line-height:20px;
			padding:0;
			overflow:visible;
		}
		
		.webuploader-pick img{
			width:100%;
			height:100%;
			position:absolute;
			left:0;
			top:0;
		}
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
		
		<sfTags:pagePermission authFlag="SECONDORDER_WAITDEALORDER_ZHIYINGWANGDIAN_TAB" html='<a class="btn-tabBar current"  href="${ctx }/secondOrder/wholeWaitDealOrder">直营网点(<span id="tab_c1" style="color: #f54f25;">0</span>家)</a>'></sfTags:pagePermission>	
		<sfTags:pagePermission authFlag="SECONDORDER_WAITDEALORDER_HEZUOWANGDIAN_TAB" html='<a class="btn-tabBar "  href="${ctx }/secondOrder/wholeWaitDealOrder?type=2">合作网点(<span id="tab_c2" style="color: #f54f25;">0</span>家)</a>'></sfTags:pagePermission>	
			<p class="f-r btnWrap">
				<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt moresearch" id="moresearch" ><i class="sficon sficon-moresearch"></i>更多查询</a>
				<a href="javascript:;" onclick="reset()" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
			</p>
		</div>
		<div class="tabCon">
			<form id="searchForm">
				<input name="secondSiteId" id="secondSiteId" hidden="hidden" />
				<input type="hidden" name= "orderId" id="orderId">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
				<div class="bk-gray pt-10 pb-5">
					<table class="table table-search">
						<tr>
							<th style="width: 76px;" class="text-r">二级网点：</th>
							<td>
								<span class="f-l w-140  readonly" >
									<select class="select w-140" name="secondSiteId" id="secondSiteId">
										<c:forEach items="${listSecondList}" var="lsd" varStatus="status">
											<option value="${lsd.columns.id}" <c:if test="${status.count==1}">selected="selected"</c:if>>${lsd.columns.name}</option>
										</c:forEach>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">工单编号：</th>
							<td>
								<input type="text" class="input-text" name= "number"/>
							</td>
							<th style="width: 76px;" class="text-r">工单状态：</th>
							<td>
							
								<span class="w-140">
									<select class="select easyui-combobox" id="statusFlag" multiple="true"
                                            multiline="false" name="statuss" style="width:100%;height:25px"
                                            panelMaxHeight="160px">
										<option value=""></option>
										<option value="0">待接收</option>
										<option value="1">待派工</option>
										<option value="2">服务中</option>
										<option value="3">待回访</option>
										<option value="4">待结算</option>
										<option value="5">已完成</option>
										<option value="9">网点拒接</option>
										<option value="7">暂不派工</option>
										<option value="8">无效工单</option>

									</select>
								</span>
							</td>
							
							<th style="width: 76px;" class="text-r">服务类型：</th>
							<td>
								<span class="select-box">
									<select class="select" name="serviceType" id="orderServiceType">
										<option value="">请选择</option>
										<%-- <c:forEach items="${fns:getNewServiceType() }" var="stype">
											<option value="${stype.columns.name }">${stype.columns.name }</option>
										</c:forEach> --%>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">工单类型：</th>
							<td>
								<span class="select-box">
									<select class="select" name="parentType">
										<option value="2">指派工单</option>
										<option value="3">自建工单</option>
										<option value="1">全部工单</option>
										
									</select>
								</span>
							</td>
						</tr>
						<tr>
							<th style="width: 76px;" class="text-r">家电品类：</th>
							<td>
								<span class="f-l w-140  readonly" >
									<select class="select w-140" name="applianceCategory" id="applianceCategory">
									<option value="">请选择</option>
										<%-- <c:forEach items="${listSecondList}" var="lsd" varStatus="status">
											<option value="${lsd.columns.id}" <c:if test="${status.count==1}">selected="selected"</c:if>>${lsd.columns.name}</option>
										</c:forEach> --%>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">家电品牌：</th>
							<td>
								<input type="text" class="input-text" name="applianceBrand" />
							</td>
							
							<th style="width: 76px;" class="text-r">家电型号：</th>
							<td>
								<input type="text" class="input-text" name="applianceModel" />
							</td>
							<th style="width: 76px;" class="text-r">服务方式：</th>
							<td>
								<span class="f-l w-140  readonly" >
									<select class="select w-140" name="serviceMode" id="serviceMode">
										<option value="">请选择</option>
										<%-- <c:forEach items="${listSecondList}" var="lsd" varStatus="status">
											<option value="${lsd.columns.id}" <c:if test="${status.count==1}">selected="selected"</c:if>>${lsd.columns.name}</option>
										</c:forEach> --%>
									</select>
								</span>
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
						</tr>
						<tr class="moreCondition" style="display: none;">
							<th style="width: 76px;" class="text-r">用户姓名：</th>
							<td>
								<input type="text" class="input-text" name = "customerName" onkeydown="enterEvent(event)"/>
							</td>
							<th style="width: 76px;" class="text-r">联系方式：</th>
							<td>
								<input type="text" class="input-text" name = "customerMobile" onkeydown="enterEvent(event)"/>
							</td>
							
							<th style="width: 76px;" class="text-r">预约日期：</th>
							<td>
								<input type="text" onfocus="WdatePicker({})" id="promiseTime" name="promiseTime"
									   value="" class="input-text Wdate">
							</td>
							<th style="width: 76px;" class="text-r">标记类型：</th>
							<td id="reloadSignSpan">
								<span class="w-140 dropdown-sin-2">
									<select class="select-box w-120"  id="signType" style="display:none" multiple  multiline="true" name="signType"  >
									<%-- <c:forEach items="${signList}" var="sign">
										<option value="${sign.columns.id }">${sign.columns.name }</option>
									</c:forEach> --%>
									</select>
								</span>
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
							<th style="width: 76px;" class="text-r">服务工程师：</th>
							<td id="reloadSpan">
								<span class="w-140 dropdown-sin-2">
									<select class="select-box w-120"  id="employs" style="display:none" multiple  multiline="true" name="employeNames"  >
									<%-- <c:forEach items="${fns:getEmloyeListForAll(siteId) }" var="emp">
										<c:if test="${emp.columns.status ne 3}">
											<option value="${emp.columns.name }">${emp.columns.name }</option>
										</c:if>
										<c:if test="${emp.columns.status eq 3}">
											<option value="${emp.columns.name }">${emp.columns.name }【离职】</option>
										</c:if>
									</c:forEach> --%>
									</select>
								</span>
							</td>
							
							<th style="width: 76px;" class="text-r">信息来源：</th>
							<td>
								<span class="select-box">
									<select class="select" name="origin" id="orderOrigin">
										<option value="">请选择</option>
										<%-- <c:forEach items="${listorigin }" var="lro">
											<option value="${lro.columns.name }">${lro.columns.name }</option>
										</c:forEach> --%>

									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">家电条码：</th>
							<td>
								<input type="input-text"  name="elictrictyBarcode" value="" class="input-text">
							</td>
							<th style="width: 76px;" class="text-r">登记人：</th>
							<td>
								<input type="text" class="input-text" name="messengerName"/>
							</td>
						</tr>
						
						<tr class="moreCondition" style="display: none;">
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
							<th style="width: 76px;" class="text-r">用户类型：</th>
							<td>
								<span class="select-box">
									<select class="select" name="customerType" id="customerType">
										<option value="">请选择</option>
										 <%-- <c:forEach items="${fns:getCustomerType()}" var="to">
						                    <option value="${to.columns.name }">${to.columns.name }</option>
						                 </c:forEach> --%>
									</select>
								</span>
							</td>
							
							<th style="width: 76px;" class="text-r">报修时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'repairTimeMax\')||\'%y-%M-%d\'}'})" id="repairTimeMin" name="repairTimeMin" value="" class="input-text Wdate w-140" style="width:140px">
								至
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'repairTimeMin\')}',maxDate:'%y-%M-%d 23:59:59'})" id="repairTimeMax" name="repairTimeMax"  value="" class="input-text Wdate w-140" style="width:140px">
							</td>
						</tr>
						
						<tr class="moreCondition" style="display: none;">
							<th style="width: 76px;" class="text-r">派工时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'repairTimeMax\')||\'%y-%M-%d\'}'})"  name="dispatchTimeMin" value="" class="input-text Wdate w-120" style="width:140px">
								至
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'repairTimeMin\')}',maxDate:'%y-%M-%d 23:59:59'})" id="dispatchTime" name="dispatchTimeMax"  value="" class="input-text Wdate w-120" style="width:140px">
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
			<div class="pt-10 pb-5 cl">
				<div class="f-l">
					 <sfTags:pagePermission authFlag="ORDERMGM_WAITDISPATCH_ALLORDER_ZPGEJWD_BTN" html='<a href="javascript:erjidirectDis();" class="sfbtn sfbtn-opt"><i class="sficon sficon-dispatch"></i>指派给二级网点</a>'></sfTags:pagePermission> 
					 <sfTags:pagePermission authFlag="ORDERMGM_WAITDISPATCH_ALLORDER_ZHUANPAI_BTN" html='<a href="javascript:directDisZp();" class="sfbtn sfbtn-opt"><i class="sficon sficon-turnorder"></i>转派</a>'></sfTags:pagePermission> 
					 <sfTags:pagePermission authFlag="ORDERMGM_WAITDISPATCH_ALLORDER_FHYJDPG_BTN" html='<a href="javascript:returnSiteOrder();" class="sfbtn sfbtn-opt"><i class="sficon sficon-invalid"></i>返回一级待派工</a>'></sfTags:pagePermission> 
					 <sfTags:pagePermission authFlag="ORDERMGM_ZYSITE_WXORDER_BTN" html='<a href="javascript:showwxgd();" class="sfbtn sfbtn-opt"><i class="sficon sficon-invalid"></i>无效工单</a>'></sfTags:pagePermission> 
				</div>
				<div class="f-r">
					<a href="javascript:;" class="sfbtn sfbtn-opt2 reloadPageBtn"><i class="sficon sficon-reload"></i>刷新</a>
					<sfTags:pagePermission authFlag="SECONDORDER_WAITDEALORDER_EXPORTSECONDORDER_BTN" html='<a  onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="SECONDORDER_WAITDEALORDER_TITLESETSECONDORDER_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt2" id="setHeadersBtn"><i class="sficon sficon-setting"></i>表头设置</a>'></sfTags:pagePermission>
				</div>
								
			</div>
			<div>
				<table id="table-waitdispatch" class="table"></table>
				<!-- pagination -->
					<div class="cl pt-10">
						<div class="f-l iconsBoxWrap">
							<!-- 	<a class="iconDec">图标注释？</a>
								<div class="iconsBox">
									<div class="iconsBoxBg">
										<div class="cl pl-10 pt-5">
											<span class="oState state-book w-80 mb-5">今日预约</span>
											<span class="oState state-dgbd w-80 mb-5">导购报单</span>
											<span class="oState state-refuse w-80 mb-5">标记工单</span>
										</div>
									</div>
									
								<span class="iconArrow"></span>
							</div> -->
								
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
</div></div>



<div class="popupBox w-710 dispatchBox1 activeDispatch1" >
	<h2 class="popupHead">
		转派
		<a href="javascript:;" class="sficon closePopup" onclick="closeDispatch()"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pd-15" >
			<div class="searchbox mb-10">
				<input type="text" placeholder="请输入二级网点名称、所在地区" id="filterName1" class="input-text" />
				<a href="javascript:searchSite('2');" class="btn-search"><i class="Hui-iconfont Hui-iconfont-search2 f-16"></i></a>
			</div>
			<p class="lh-20"><strong class="c-005aab">当前网点：${siteNow.name }</strong></p> 
			<div class="tableWrap mt-10 " style="max-height: 320px; overflow: auto;">
				<table class="table table-bordered table-border table-bg text-c table1 " >
					<thead>
						<tr>
							<th class="w-170 text-c"><strong class="f-13">所在地区</strong> </th>
							<th class="w-170 text-c"><strong class="f-13">二级网点</strong></th>
							<th class="w-170 text-c"><strong class="f-13">品牌品类</strong></th>
							<th class="w-140 text-c"><strong class="f-13">选择</strong></th>
						</tr>
					</thead>
					<tbody id="zhijiepaidan1">
						
					</tbody>
				</table>
			</div>
			<div class="mt-20 pt-10 pb-5 bk-gray bg-e8f2fa">
				<div class="pos-r pl-70 pr-10 mb-5">
					<label class="w-70 pos"><em class="mark">*</em>转派原因：</label>
					<textarea class="textarea h-40 mustfill" id="zpReson"></textarea>
				</div> 
				<div class="pos-r pl-60 pr-80">
					<label class="pos w-60"><em class="c-fe0101">派工至</em>：</label>
					<p class="lh-30"><span id="disPatchSiteName1"></span></p>
					<input type="button" class="w-70 sfbtn sfbtn-opt3 pos-a" style="right: 10px;top: 0;" onclick="dispa1()" value="确认派工" />
				</div>
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
				<input type="hidden" id="orderIds">
			</div>
			<div class="text-c pl-30">
				<input onclick="savewxgd()" type="button" class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" />
				<input type="button" onclick="$.closeDiv($('.showwxgddiv'));" class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" />
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
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
var uploader;
$(function(){
	$('.iconDec').showIcons();

	$('#btnAddnew').goHelp('${ctx}/helpindex/indexHelp?a=xjgd');
	$('#directpg').goHelp('${ctx}/helpindex/indexHelp?a=gdpg');
	
	//获取tab页面统计数字
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
	$("select[name='secondSiteId']").select2();
	$("select[name='serviceMode']").select2();
	$("select[name='applianceCategory']").select2();
	$(".selection").css("width","140px");
	$('#filterName').keyup(function(){
		$('#zhijiepaidan tr').hide()     
		.filter(":contains('" +($(this).val()) + "')").show();  
		if(isBlank($(this).val())){
			$('#zhijiepaidan tr').show();
		}
		}).keyup();//DOM加载完时，绑定事件完成之后立即触发  
	$('#filterName1').keyup(function(){
		$('#zhijiepaidan1 tr').hide()     
		.filter(":contains('" +($(this).val()) + "')").show();  
		if(isBlank($(this).val())){
			$('#zhijiepaidan1 tr').show();
		}
		}).keyup();//DOM加载完时，绑定事件完成之后立即触发  
		
	$('.dropdown-sin-2').dropdown({
        input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
    });
    $('.dropdownCategory').dropdown({
        input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
    });
    insertIntoChangeConditions();
});


//确认无效
function savewxgd(){
    var reasonofwxgdType = $.trim($("#reasonofwxgdType").val());
    var latest_process = $.trim($("#reasonofwxgd").val());
    if(isBlank(reasonofwxgdType)){
        layer.msg("请选择无效类型!");
        return;
    }else{
        var id = $("#orderIds").val();
        $.ajax({
            type:"POST",
            url:"${ctx}/order/orderDispatch/updateOrderInvalid",
            data:{
                id:id,
                latest_process:latest_process,
                reasonofwxgdType:reasonofwxgdType,
                type:'1'
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
        
       	 $('body').popup({
                level: '3',
                type: 2,  // 提示是否进行某种操作
                content: '您确定要操作无效工单吗？',
                fnConfirm: function () {
               	 $("#orderIds").val(idArr.join(","));
		           $('.showwxgddiv').popup();
                }
       	 })
   
    }
}

window.onload=function(){
    $("#_easyui_combobox_i1_0").remove();
}

//返回一级网点
function returnSiteOrder() {
	 var idArr=$('#table-waitdispatch').jqGrid('getGridParam','selarrrow');
	 if(idArr.length != 1){
         layer.msg("请选择一条记录!");
         return ;
     }
    var orderId = idArr[0];
	 
    if (isBlank(orderId)) {
        layer.msg("数据有误！");
    } else {
	 var rowData = $('#table-waitdispatch').jqGrid('getRowData', orderId);
    	var parenSiteId = rowData.parent_site_id;
    	if(isBlank(parenSiteId)){
    		 layer.msg("自建工单无权限操作!");
             return ;
    	}
    	var parenStatus = rowData.parent_status;
    	if(parenStatus == 4 || parenStatus==5){
    		 layer.msg("已完成的工单不可以操作此功能!");
             return ;
    	}
    	
        $('body').popup({
            level: '3',
            type: 2,  // 提示是否进行某种操作
            content: '确定要返回一级网点待派工吗？',
            fnConfirm: function () {
                $.ajax({
                    url: "${ctx}/secondOrder/returnSiteOrder",
                    type: 'post',
                    data: {
                    	orderId: orderId
                    },
                    success: function(data) {
                        if ('500' === data.code) {
                            layer.msg("工单是不可返回的工单，不能操作返回一级网点！")
                        } else if('200' === data.code) {
                            layer.msg("返回成功！");
                        } else if('422' === data.code) {
                            layer.msg("工单已被转派！");
                        } else if('423' === data.code) {
                            layer.msg("自建工单不可退回！");
                        }
                        search();
                        $.closeAllDiv();
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


function numerCheck(){
	$.post("${ctx}/operate/getSiteMsg/getOrderTabCount",function(result){
		$("#tab_c1").text(result.zy);
		$("#tab_c2").text(result.hz);
	});
}

function reset(){
    $("#catgyS").combobox('clear');
    $("#statusFlag").combobox('clear');
    insertIntoChangeConditions();
    $("select[name='secondSiteId']").select2('val','请选择');
	$("select[name='serviceMode']").select2('val','请选择');
	$("select[name='applianceCategory']").select2('val','请选择');
    $("#searchForm").get(0).reset();
}


function closeAll_(){
	$.closeAllDiv();
}

function isValid(num){
	if($.trim(num)=='' || num==null || num==undefined || num=='undefined'){
		return '';
	}
	return num;
}




function initSecondSiteMsg(){
	var searchName = $("#filterName").val();
	var selectcategory = $("#applianceCategory").val();
	var selectbrand = $("#applianceBrand").val();
	
}


function isBlank(val) {
	if(val==null || $.trim(val)=='' || val == undefined) {
		return true;
	}
	return false;
}

function initSfGrid(){
	$("#table-waitdispatch").sfGrid({
		url : '${ctx}/secondOrder/wholeWaitDealOrderList?type=1',
		sfHeader: defaultHeader,
		sfSortColumns: sortHeader,
		rownumbers:true,
		postData: $("#searchForm").serializeJson(),
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

function fmtOrderNo(rowData){
	return '<a href="javascript:showDetail(\''+rowData.id+'\',\''+rowData.site_id+'\');" class="c-0383dc">'+rowData.number+'</a>';
}

function showDetail(id,siteId){
	$("#table-waitdispatch").jqGrid('resetSelection');
	 $("#table-waitdispatch").jqGrid('setSelection',id);
	batchFormIndex =layer.open({
		type : 2,
		content:'${ctx}/secondOrder/secondWaitDealOrderForm?id='+id+'&siteId='+siteId,
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

function search(){
	insertIntoChangeConditions()
	var pageSize = $("#pageSize").val();
  /*   var valCategory = $('#catgyS').combobox('getValues');
    $("input[name='applianceCategory']").val(valCategory); */
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
		content:'${ctx}/secondOrder/newOrder',
		title:false,
		area: ['100%','100%'],
		closeBtn:0,
		shade:0,
		anim:-1 
	});
}

function exports() {
   /*  var now = new Date();
    var hours = now.getHours();
    var minutes = now.getMinutes();
    var nowM = hours * 60 + minutes;
    var start = 7 * 60 + 30;
    var end = 11 * 60 + 30;
    if (nowM >= start && nowM <= end) {
        layer.msg("温馨提醒：系统使用高峰期7:30-11:30,请在其它时间导入、导出！谢谢！");
        return false;
    } */

    var idArr = $("#table-waitdispatch").jqGrid('getGridParam', 'records');
    var content = "共" + idArr + "条数据，本次允许导出前10000条，确定继续导出吗？";
    if (idArr > 10000) {
        $('body').popup({
            level: 3,
            title: "导出",
            content: content,
            fnConfirm: function () {
                location.href = "${ctx}/secondOrder/export?formPath=/a/secondOrder/wholeWaitDealOrder&&maps=" + $("#searchForm").serialize()+"&type=1";
            },
            fnCancel: function () {
            }
        });
    } else {
        location.href = "${ctx}/secondOrder/export?formPath=/a/secondOrder/wholeWaitDealOrder&&maps=" + $("#searchForm").serialize()+"&type=1";
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

function orderPStatus(rowData){
	var parentstatus = rowData.parent_status;
	var status = rowData.status;
	var parentsiteId = rowData.parent_site_id;
	if(isBlank(parentsiteId)){
		return fmtOrderStatus(rowData);
	}
	if(status == '8'){
	    return "<span title='无效工单' class='oState state-invalid'>无效工单</span>";
	}
		
	if(parentstatus=='1'){
		return "<span class='oState state-waitDispatch'>待指派</span>";
	}
	if(parentstatus=='2'){
		return "<span class='oState state-waitTakeOrder'>待接收</span>";
	}
	if(parentstatus=='3'){
		if(status=='1'){
			return "<span class='oState state-waitDispatch'>待派工 </span>";
        }else if(status=='2'){
        	return "<span class='oState state-serving'>服务中 </span>";
        }else if(status=='7'){
        	return "<span class='oState state-noDispatch'>暂不派工 </span>";
        }
		return "<span class='oState state-serving'>服务中</span>";
		
	}
	if(parentstatus=='4'){
		return $fmtDispStatus(rowData)+"<span class='oState state-waitVisit'>待回访 </span>";
	}
	if(parentstatus=='5'){
		if(status == '4'){
			return $fmtDispStatus(rowData)+"<span class='oState state-waitSettlement'>待结算</span>";
			}
		return $fmtDispStatus(rowData)+"<span class='oState state-finished'>已完成</span>";
	}
	if(parentstatus=='6'){
		return "<span class='oState state-refuseOrder'>拒接</span>";
	}
	if(parentstatus=='7'){
		return "<span class='oState state-noDispatch'>暂不派工</span>";
	}
	if(parentstatus=='8'){
		return "<span class='oState state-canceled'>已取消</span>";
	}
	if(status=='1'){
		return "<span class='oState state-waitDispatch'>待派工</span>";
    }
	if(status=='2'){
		return "<span class='oState state-waitDispatch'>待派工</span>";
    }
	return "<span class='oState state-finished'>已完成</span>";
	
	
}

function closeDispatch(){
	$("#secondSiteId").val('');
}

function showzjfd(){
    var idArr=$('#table-waitdispatch').jqGrid('getGridParam','selarrrow');
    if(idArr.length > 0){
        $('body').popup({
            level: 3,
            title: "提示",
            content: "您确定要将这"+idArr.length+"条工单取消工单吗？",
            fnConfirm: function () {
            	 $('.showzjfddiv').popup({level:1});
            },
            fnCancel: function () {
            }
        });
    }else{
        layer.msg("请先选择数据！");
    }
}


var zjfdMark = false;
function savezjfd(){
	if(zjfdMark){
		return;
	}
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
    	zjfdMark = true;
        $.ajax({
            type:"POST",
            url:"${ctx}/secondOrder/waitDealOrderPlfd",
            data:{
                id:ids,
                latestProcess:latest_process
            },
            success:function(result){
            	if(result=="200"){
            		parent.layer.msg("取消工单成功！");
                    search();
                    numerCheck();
                    $.closeDiv($('.showzjfddiv'));
            	}else{
            		layer.msg("取消工单失败，请检查！");
            	}
            	zjfdMark = false;
            	return;
            },
            error:function(){
                alert("系统繁忙!");
                return;
            }
        });
    }
}

function cancerBox(){
    $.closeDiv($('.showzjfddiv'));
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
				var psts = rowData.parent_status;
				var pSid = rowData.parent_site_id;
				if(!isBlank(pSid)){
					if(psts=='6'){//拒接
						selectcategory = rowData.appliance_category;
						selectbrand = rowData.appliance_brand;
						if(ids==''){
							ids=idArr[i];
						}else{
							ids=ids+','+idArr[i];
						}
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
	
	
	function directDisZp() {
		$("#disPatchSiteName1").text();
		var searchName = $("#filterName1").val();
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
				var pSid = rowData.parent_site_id;
				if(!isBlank(pSid)){
					if(sts=='待派工' || sts=='待接收' || sts=='暂不派工' || sts=='服务中'){//0、1、2、7
						selectcategory = rowData.appliance_category;
						selectbrand = rowData.appliance_brand;
						if(ids==''){
							ids=idArr[i];
						}else{
							ids=ids+','+idArr[i];
						}
					}
				}
			}
			if(isBlank(ids)){
				layer.msg("您选择的工单不能转派给二级网点，请重新选择！");
				return;
			}
			if(ids.split(",").length > 1){//多个工单的话就不匹配品类信息
				selectcategory = "";
	   			selectbrand = "";
			}
			$("#orderId").val(ids);
			var searchName = '';
			var contents = '您选择的'+idArr.length+'条工单中有'+ids.split(",").length+'条可以转派给二级网点，您确定要转派吗？';
			if(ids.split(",").length==idArr.length){
				contents = "您确定要将这"+idArr.length+"条工单转派给二级网点吗？";
			}
			$('body').popup({
	             level: '3',
	             type: 2,  // 提示是否进行某种操作
	             content: contents,
	             fnConfirm: function () {
					layer.open({
				   		type : 2,
				   		content:'${ctx}/secondOrder/toChangeDispatchOrderPage?searchName='+searchName+'&selectcategory='+selectcategory+'&selectbrand='+selectbrand+"&customerMobile="+""+"&orderId="+$("#orderId").val()+"&position=1",
				   		title:false,
				   		area: ['100%','100%'],
				   		closeBtn:0,
				   		shade:0,
				   		anim:-1 
				   	 });
	             }
             })
		}
		
	}
	
	
	function insertIntoChangeConditions(){
		var siteId = $("select[name='secondSiteId']").val();//获取当前选中的siteId
		var category;//获取当前品类
		var sermode;//获取当前服务方式
		var type;//获取当前服务类型
		var origin;//获取当前信息来源
		var custo //获取当前用户类型
		var mark ;//获取当前标记类型
		var empname ;//获取当前标记类型
		category = $("select[name='applianceCategory']").val();
		sermode = $("select[name='serviceMode']").val();
		type = $("select[name='serviceType']").val();
		origin = $("select[name='origin']").val();
		custo = $("select[name='customerType']").val();
		mark = $("select[name='signType']").val();
		empname = $("select[name='employeNames']").val();

		$.ajax({
			type:"post",
			url:"${ctx}/secondOrder/getConditionsDataBySiteId",
			data:{siteId:siteId},
			dataType:"json",
			success:function(data){
				serviceModelList = data.serviceModelList;// 服务类型
				serviceTypeList = data.serviceTypeList;// 服务方式
				employeList = data.employeList;// 服务工程师
				originList = data.originList;// 信息来源
				customerTypeList = data.customerTypeList;// 用户类型
				categoryList = data.categoryList;// 家电品类
				markList = data.markList;// 标记类型
				
				if(!isBlank(serviceModelList)){// 服务类型
					var html = '<option value="">请选择</option>';
					for(var i=0;i<serviceModelList.length;i++){
						if(type == serviceModelList[i].columns.name){
							html += '<option value="'+serviceModelList[i].columns.name+'" selected="selected">'+serviceModelList[i].columns.name+'</option>';
							}else{
							html += '<option value="'+serviceModelList[i].columns.name+'">'+serviceModelList[i].columns.name+'</option>';
							}
					}
					$("#orderServiceType").empty().append(html);
				}
				if(!isBlank(serviceTypeList)){// 服务方式
					var html = '<option value="">请选择</option>';
					for(var i=0;i<serviceTypeList.length;i++){
						if(sermode ==serviceTypeList[i].columns.name ){
							html += '<option value="'+serviceTypeList[i].columns.name+'" selected="selected">'+serviceTypeList[i].columns.name+'</option>';
							}else{
							html += '<option value="'+serviceTypeList[i].columns.name+'">'+serviceTypeList[i].columns.name+'</option>';
							}
					}
					$("#serviceMode").empty().append(html);
				}
				var html1 = '<span class="w-140 dropdown-sin-2">'+
				'<select class="select-box w-120"  id="employs" style="display:none" multiple  multiline="true" name="employeNames"  >';
				if(!isBlank(employeList)){// 服务工程师
					
					for(var i=0;i<employeList.length;i++){
						var emp = employeList[i].columns;
						if(emp.status!='3'){
							if(empname == emp.name){
							html1 += '<option value="'+emp.name+'" selected="selected">'+emp.name+'</option>';
							}else{
							html1 += '<option value="'+emp.name+'">'+emp.name+'</option>';
							}
						}
					}
					for(var i=0;i<employeList.length;i++){
						var emp = employeList[i].columns;
						if(emp.status=='3'){
							if(empname == emp.name){
								html1 += '<option value="'+emp.name+'" selected="selected">'+emp.name+'【离职】</option>';
								}else{
							html1 += '<option value="'+emp.name+'">'+emp.name+'【离职】</option>';
								}
						}
					}
					
					/* $('.dropdown-sin-2').dropdown({
				        input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
				    }); */
				}
				html1 += '</select></span>';
				$("#reloadSpan").empty().append(html1);
				if(!isBlank(originList)){// 信息来源  
					var html = '<option value="">请选择</option>';
					for(var i=0;i<originList.length;i++){
						if(origin == originList[i].columns.name){
							html += '<option value="'+originList[i].columns.name+'" selected="selected">'+originList[i].columns.name+'</option>';
							}else{
							html += '<option value="'+originList[i].columns.name+'">'+originList[i].columns.name+'</option>';
							}
					}
					$("#orderOrigin").empty().append(html);
				}
				if(!isBlank(customerTypeList)){// 用户类型 
					var html = '<option value="">请选择</option>';
					for(var i=0;i<customerTypeList.length;i++){
						if(custo == customerTypeList[i].columns.name){
							html += '<option value="'+customerTypeList[i].columns.name+'" selected="selected">'+customerTypeList[i].columns.name+'</option>';
							}else{
							html += '<option value="'+customerTypeList[i].columns.name+'">'+customerTypeList[i].columns.name+'</option>';
							}
					}
					$("#customerType").empty().append(html);
				}
				if(!isBlank(categoryList)){// 家电品类 
					var html ='<option value="">请选择</option>';
					for(var i=0;i<categoryList.length;i++){
						if(category == categoryList[i].columns.name){
							html += '<option value="'+categoryList[i].columns.name+'" selected="selected">'+categoryList[i].columns.name+'</option>';
							}else{
							html += '<option value="'+categoryList[i].columns.name+'">'+categoryList[i].columns.name+'</option>';
							}
					}
					$("#applianceCategory").empty().append(html);
				}
				var html2 = '<span class="w-140 dropdown-sin-2">'+
				'<select class="select-box w-120"  id="signType" style="display:none" multiple  multiline="true" name="signType"  >';
				if(!isBlank(markList)){// 标记类型
					
					for(var i=0;i<markList.length;i++){
						if(mark == markList[i].columns.id){
							html2 += '<option value="'+markList[i].columns.id+'" selected="selected">'+markList[i].columns.name+'</option>';
								
							}else{
								
							html2 += '<option value="'+markList[i].columns.id+'">'+markList[i].columns.name+'</option>';
							}
					}
					
				}
				html2 += '</select></span>';
				$("#reloadSignSpan").empty().append(html2);
				$('.dropdown-sin-2').dropdown({
			        input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
			    });
			}
		})
	}
</script>
	
</body>
</html>
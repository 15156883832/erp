<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>工单录入</title>
<meta name="decorator" content="base"/>

<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select2.min.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select2.full.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/orderConnectionGoods.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>

<script type="text/javascript" src="${ctxPlugin}/lib/lodop/LodopFuncs.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/lodop/base64.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/lodop/printdesign.js"></script>

<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/jquery.cityselect2.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
<style type="text/css">

/* .spimg1{ border:none;} */
.spimg1 .webuploader-pick{
	width:134px;
	height:134px;
}
</style>
</head>

<body>
<!-- 回访结算工单-工单详情 -->
<div class="popupBox odWrap orderdetailVb" style="width:970px">
	<h2 class="popupHead">
		工单详情
		<a href="javascript:;" class="sficon closePopup" id="closDivPoup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<div class="popupMain pos-r" >
			<div class="pcontent" style="padding-right: 20px">
				<div class="pr-10">
				<div id="detialWd" >
					<div class="tabBarP" style="overflow: visible;">
						<a href="javascript:;" class="tabswitch current">基本信息</a>
						<a href="javascript:;" class="tabswitch ">过程信息</a>
						<c:if test="${count != 0 }">
							<a  class="tooltipLink f-r" onclick="changeStyle('${order.number}')"  >
								<i class="sficon sficon-note"></i>已发送<span class="va-t">${count }</span>条短信
							</a>
						</c:if>
						<c:if test="${order.printTimes != 0 }">
							<a  class="tooltipLink f-r" >
								<i class="sficon sficon-print"></i>已打印<span class="va-t">${order.printTimes }</span>次
							</a>
						</c:if>
					</div>
					<div class="tabCon">
						<div class="cl mb-25 mt-10">
							<div class="f-l pos-r txtwrap1">
								<label class="lb lb1">工单编号：</label>
								<input type="text" id="orderNumber" class="input-text w-160 readonly" readonly="readonly" value="${order.number }"/>
							</div>
							<div class="f-l pos-r pl-100">
								<label class="lb w-100 text-r">服务类型：</label>
								<input type="text" class="input-text w-120 readonly" readonly="readonly" value="${order.serviceType}"/>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">服务方式：</label>
								<input type="text" class="input-text w-120 readonly" readonly="readonly" value="${order.serviceMode }"/>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">信息来源：</label>
								<input type="text" class="input-text w-130 readonly" readonly="readonly" value="${order.origin }"/>
							</div>
						</div>
						<div class="line"></div>
						<div class="cl mt-10">
							<div class="f-l pos-r txtwrap1">
								<label class="lb lb1"><em class="mark hide ">*</em>用户姓名：</label>
								<input id="customerName" type="text" class="input-text w-160 readonly remarkUpdate " readonly="readonly"  value="${order.customerName }"/>
							</div>
							<div class="f-l pos-r pl-100">


									<span id="telTypeChoose" class="lb w-100 text-r" style="display:none;">
										<span class="f-r ">：</span>
										<select id="telType" class="select f-r" style="width:75px">
											<option value="0" <c:if test="${fn:substring(order.customerMobile,0,1) ne '0'}">selected="selected"</c:if>>手机号码</option>
											<option value="1" <c:if test="${fn:substring(order.customerMobile,0,1) eq '0'}">selected="selected"</c:if>>固定电话</option>
										</select>
										<em class="mark f-r pr-5 hide">*</em>
									</span>
									<label class="lb w-100 reLX1" >联系方式1：</label>
								</span>
								<input id="customerMobile" type="text" class="input-text w-120 readonly remarkUpdate " readonly="readonly"  value="${order.customerMobile }"/>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">其他联系方式：</label>
								<input id="customerTelephone" type="text" class="input-text w-120 readonly remarkUpdate" readonly="readonly"  value="${order.customerTelephone }"/>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">联系方式3：</label>
								<input id="customerTelephone2" type="text" class="input-text w-130 readonly remarkUpdate" readonly="readonly" value="${order.customerTelephone2 }"/>
							</div>
						</div>
						<div class="cl mt-10 mb-25">
							<div class="pos-r txtwrap1" id="pcd">
								<label class="lb lb1"><em class="mark hide">*</em>详细地址：</label>
								<input id="customerAddress" type="text" class="input-text w-380 readonly remarkUpdate" readonly="readonly" value="${order.customerAddress }"/>
								<%--<input id="customerAddress2" type="text" class="input-text w-380 readonly remarkUpdate " readonly="readonly" value="${order.customerProvince }${order.customerCity }${order.customerArea }${order.customerAddress }"/>--%>
								<%--<input id="customerAddressRecord" type="hidden" class="input-text w-340 readonly remarkUpdate mustfill" readonly="readonly" value="${order.customerAddress }"/>--%>
								<%--<span id="pro" class="select-box w-90 f-l hide mr-10 mustfill" style="display: none">
									<select id="province" class="prov select" name="customerProvince"></select>
								</span>
								<span id="cit" class="select-box w-90 f-l mr-10 hide mustfill" style="display: none">
									<select class="select city" id="city" name="customerCity"></select>
								</span>
								<span id="are" class="select-box w-90 f-l mr-10 hide mustfill" style="display: none">
									<select class="select dist" id="area" name="customerArea"></select>
								</span>
								<input type="hidden" id="lnglat" name="customerLnglat" value="${order.customerLnglat }"/>
								<input type="hidden" id="employeId" name="employeId"/>--%>
							<%--</span>
									<input type="text" class="input-text w-340 readonly" readonly="readonly" id="customerAddress1" name="customerAddress1" value="${order.customerAddress }"/>
									<input type="hidden" id="customerAddress" name="customerAddress" value="${order.customerAddress}"/>
									<input type="hidden" id="lnglat" name="customerLnglat" value="${order.customerLnglat }"/>--%>
							</div>
						</div>
						<div class="line"></div>
						<div class="cl mt-10">
							<div class="f-l pos-r txtwrap1">
								<label class="lb lb1">家电品牌：</label>
								<input type="text" class="input-text w-160 readonly" readonly="readonly" value="${order.applianceBrand}"/>
							</div>
							<div class="f-l pos-r pl-100">
								<label class="lb text-r w-100">家电品类：</label>
								<input type="text" class="input-text w-120 readonly" readonly="readonly" value="${order.applianceCategory }"/>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">预约日期：</label>
								<input type="text" class="input-text w-120 readonly" readonly="readonly" value="<fmt:formatDate value='${order.promiseTime }' pattern='yyyy-MM-dd'/>"/>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">时间要求：</label>
								<input type="text" class="input-text w-130 readonly" readonly="readonly"  value="${order.promiseLimit }"/>
							</div>
						</div>
						<div class="cl mt-10">
							<div class="f-l pos-r txtwrap1 h-50">
								<label class="lb lb1">服务描述：</label>
								<textarea type="text" class="input-text w-380 h-50 readonly" readonly="readonly">${order.customerFeedback}</textarea>
							</div>
							<div class="f-l pos-r txtwrap2 h-50">
								<label class="lb lb2">备注：</label>
								<textarea type="text" class="input-text h-50 w-340 readonly" readonly="readonly" >${order.remarks}</textarea>
							</div>
						</div>


						<div class="cl mt-10">
							<div class="f-l pos-r txtwrap1">
								<label class="lb lb1">产品型号：</label>
								<input type="text" class="input-text w-160 readonly" readonly="readonly" value="${order.applianceModel}"/>
							</div>
							<div class="f-l pos-r pl-100">
								<label class="lb text-r w-100">产品数量：</label>
								<input type="text" class="input-text w-120 readonly" readonly="readonly" name="applianceNum" value="${order.applianceNum }"/>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">内机条码：</label>
								<input type="text" class="input-text w-120 readonly" readonly="readonly" value="${order.applianceBarcode}" title="${order.applianceBarcode}"/>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">外机条码：</label>
								<input type="text" class="input-text w-130 readonly" readonly="readonly" value="${order.applianceMachineCode}" title="${order.applianceMachineCode}"/>
							</div>

						</div>
						<div class="cl mt-10">
							<div class="f-l pos-r txtwrap1">
								<label class="lb lb1">购买日期：</label>
								<input type="text" class="input-text w-160 readonly" readonly="readonly" value="<fmt:formatDate value='${order.applianceBuyTime }' pattern='yyyy-MM-dd'/>"/>
							</div>
							<div class="f-l pos-r pl-100">
								<label class="lb w-100 text-r">购机商场：</label>
								<input type="text" name="pleaseReferMall" class="input-text w-120 readonly" readonly="readonly" value="${order.pleaseReferMall}">
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">保修类型：</label>
								<select class="select w-120 readonly " name="warrantyType"  disabled="disabled" id="warrantyType">
										<option value="">请选择</option>
										<c:if test="${order.warrantyType eq 1 }">
											<option value="1" selected = "selected">保内</option>
											<option value="2">保外</option>
											<!-- <option value="3">保内转保外</option> -->
										</c:if>
										<c:if test="${order.warrantyType eq 2 }">
											<option value="1">保内</option>
											<option value="2" selected = "selected">保外</option>
											<!-- <option value="3">保内转保外</option> -->
										</c:if>
										<c:if test="${order.warrantyType eq 3 }">
											<option value="1">保内</option>
											<option value="2">保外</option>
											<!-- <option value="3" selected = "selected">保内转保外</option> -->
										</c:if>
										<c:if test="${order.warrantyType ne 1 && order.warrantyType ne 2 && order.warrantyType ne 3}">
											<option value="1">保内</option>
											<option value="2">保外</option>
											<!-- <option value="3">保内转保外</option> -->
										</c:if>
									</select>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">重要程度：</label>
							<select class="select w-130 readonly" name="level"  disabled="disabled">
									<option value="">请选择</option>
									<c:if test="${order.level eq 1}">
										<option value="1" selected ="selected">紧急</option>
										<option value="2">一般</option>
									</c:if>
									<c:if test="${order.level eq 2}">
										<option value="1">紧急</option>
										<option value="2" selected ="selected">一般</option>
									</c:if>
									<c:if test="${order.level ne 1 && order.level ne 2}">
										<option value="1">紧急</option>
										<option value="2">一般</option>
									</c:if>

								</select>
							</div>
						</div>
						<div class="cl mt-10">
							<div class="f-l pos-r txtwrap1">
								<label class="lb lb1">报修时间：</label>
								<input type="text" class="input-text w-160 readonly" readonly="readonly" value="<fmt:formatDate value='${order.repairTime }' pattern='yyyy-MM-dd HH:mm:ss'/>"/>
							</div>
							<div class="f-l pos-r pl-100">
								<label class="lb w-100 text-r">登记人：</label>
								<input type="text" class="input-text w-120 readonly" readonly="readonly" value="${dengjiren}"/>
							</div>
						</div>
					</div>
					<div class="tabCon pt-10">
						<div class="processWrap">
							<c:forEach var="pros" items="${fns:getOrderProcess(order.processDetail)}">
								<p class="processItem">
									<span class="time">${pros.time}</span>
									<span>${pros.content}</span>
								</p>
							</c:forEach>
						</div>
					</div>
				</div>
				<div id="serveFb" class="mt-25">
					<div class="tabBarP">
						<a href="javascript:;" class="tabswitch current">服务反馈</a>
						<a href="javascript:showSQMsg();" class="tabswitch">备件申请</a>
						<a href="javascript:showSYMsg();" class="tabswitch">备件使用</a>
						<a href="javascript:showOldFitting();" class="tabswitch">旧件信息</a>
						<a href="javascript:showHfMsg('hfMsg','${order.id }','${ctx}','1');" class="tabswitch" style="width: 100px">回访信息</a>

						<%--<a href="javascript:;" class="tabswitch">回访</a>--%>
						<%--<a href="javascript:;" class="tabswitch">结算</a>--%>
						<a href="javascript:showOrderJs('jsMsg','${order.number }');" class="tabswitch" style="width: 100px">结算单</a>
						<%--<a href="javascript:showGoodsMsg();" class="tabswitch">商品信息</a>--%>
					</div>
					<div class="tabCon">
						<div class="cl mt-10">
							<div class="f-l pos-r txtwrap1">
								<label class="lb lb1">服务工程师：</label>
								<input type="text" class="input-text w-160 readonly" readonly="readonly"  value="${order.employeName}" title="手机号：${msg2Mobiles}" />
							</div>
							<div class="f-l pos-r pl-100">
								<label class="lb text-r w-100">服务状态：</label>
								<input type="text" class="input-text w-120 readonly" readonly="readonly"  value="${dispStatus}"/>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">故障现象：</label>
								<input type="text" class="input-text w-120 readonly" readonly="readonly"  value="${order.malfunctionType}"/>
							</div>
						</div>
						<div class="cl mt-10">
							<div class="f-l pos-r txtwrap1">
								<label class="lb lb1">收费总额：</label>
								<div class="priceWrap w-140 readonly">
									<input type="text" class="input-text readonly" readonly="readonly"  value="${fns:getOrderTotalFee(order.auxiliaryCost, order.serveCost, order.warrantyCost)}"/>
									<span class="unit">元</span>
								</div>
							</div>
							<div class="f-l pl-10">
								<label class="f-l">（辅材收费：</label>
								<div class="priceWrap w-80 readonly f-l">
									<input type="text" class="input-text readonly" readonly="readonly" value="${order.auxiliaryCost}" />
									<span class="unit">元</span>
								</div>
							</div>
							<div class="f-l pl-10">
								<label class="f-l">服务收费：</label>
								<div class="priceWrap w-80 readonly f-l">
									<input type="text" class="input-text readonly" readonly="readonly" value="${order.serveCost}" />
									<span class="unit">元</span>
								</div>
							</div>
							<div class="f-l pl-10">
								<label class="f-l">延保收费：</label>
								<div class="priceWrap w-80 readonly f-l">
									<input type="text" class="input-text readonly" readonly="readonly" value="${order.warrantyCost}" />
									<span class="unit">元</span>
								</div>
							</div>

							<span class="pd-5 f-l">）</span>
							<c:if test="${not empty collectionslist}">
								<c:forEach items="${collectionslist}" var="col">
									<c:set value="${sum + col.columns.payment_amount}" var="sum"/>
									<%--<c:if test="${col.columns.payment_type=='0'}">
										<c:set value="${sum1 + col.columns.payment_amount}" var="sum1"/>
									</c:if>
									<c:if test="${col.columns.payment_type=='1'}">
										<c:set value="${sum2 + col.columns.payment_amount}" var="sum2"/>
									</c:if>--%>
								</c:forEach>
								<div class="f-l lh-26">
									<div> 无现金收款：${sum}元<%--（
										<span>支付宝：${sum1}元</span>
										<span>微信：${sum2}元</span>）--%>
										<a class="proofImg c-0383dc" id="imgshow">凭证
											<c:forEach items="${collectionslist}" var="col">
												<c:if test="${not empty col.columns.imgs}">
													<img src="${commonStaticImgPath}${col.columns.imgs}"/>
												</c:if>
											</c:forEach>
										</a>
									</div>
										<%--<span><a class="c-0383dc" href="javascript:showPz();">凭证</a></span>--%>
								</div>
							</c:if>
						</div>
						<div class="cl mt-10">
							<div class="pos-r txtwrap1">
								<label class="lb lb1">反馈内容：</label>
								<div class="readonly processWrap2" style="width:807px">
									<c:forEach var="fbItems" items="${feedbackInfo.feedbackResults}">
										<p class="processItem">
											<span class="time">${fbItems.feedbackTime} </span>
											<span>${fbItems.feedbackName }：${fbItems.feedbackResults }</span>
										</p>
									</c:forEach>
								</div>
							</div>
						</div>
						<div class="cl mt-10">
							<div class="pos-r txtwrap1 h-50 " id="Imgprocess2">
								<label class="lb lb1">过程图片：</label>
								<c:forEach var="fbImgItems" items="${feedbackInfo.feedbackImgs}">
									<c:if test="${not empty fbImgItems.fbImgPath }">
										<c:forEach var="fbImgItem" items="${fbImgItems.fbImgPath}">
											<div class="f-l mr-10">
												<div class="imgWrap">
													<img src="${commonStaticImgPath}${fbImgItem}">
													<p class="lh-20">${fbImgItems.fbImgTime}</p>
												</div>
											</div>
										</c:forEach>
									</c:if>
								</c:forEach>
							</div>

						</div>
					</div>
						<div class="tabCon">
						<table id="pjsq" class="table table-border table-bordered table-bg table-relatedorder">
							<caption>工单关联配件申请</caption>
							<thead>
								<tr>
									<th class="w-180">备件条码</th>
									<th class="w-260">备件名称</th>
									<th class="w-120">备件型号</th>
									<th class="w-50">数量</th>
									<th class="w-70">状态</th>
								</tr>
							</thead>

							<!-- <tr>
								<td>201704082214</td>
								<td>(201375600082)室外主板组件(7分钟不检低压保护)(中央)</td>
								<td>×1</td>
								<td>KFR-120W/S-590 </td>
								<td class="c-fe0101"><i class="sficon state-waitVerify"></i>待审核</td>
								<td>2017-04-26  10:01</td>
							</tr> -->
						</table>
						<div class="cl mt-10 pos-r txtwrap1 showimg">
						</div>
					</div>
					<div class="tabCon">
						<div style="width: 920px;overflow: auto;">
						<table id="pjsy" class="table table-border table-bordered table-bg table-relatedorder">
							<caption>工单关联配件使用</caption>
							<thead>
								<tr>
									<th class="w-180">备件条码</th>
									<th class="w-260">备件名称</th>
									<th class="w-120">备件型号</th>
									<th class="w-90">最新入库价格</th>
									<th class="w-80">工程师价格</th>
									<th class="w-70">零售价格</th>
									<th class="w-50">数量</th>
									<th class="w-70">收费金额</th>
									<th class="w-70">状态</th>
								</tr>
							</thead>
						</table>
						</div>
					</div>

					<div class="tabCon">
						<div style="width: 920px;overflow: auto;">
							<table class="table table-border table-bordered table-bg table-relatedorder">
								<caption>工单关联旧件信息</caption>
								<thead>
									<tr>
										<th class="w-160">旧件条码</th>
										<th class="w-150">旧件名称</th>
										<th class="w-160">旧件型号</th>
										<th class="w-70">旧件品牌</th>
										<th class="w-70">是否原配</th>
										<th class="w-70">登记数量</th>
										<th class="w-70">状态</th>
										<th class="w-120">登记时间</th>
									</tr>
								</thead>
								<tbody class="oldtbody">
								</tbody>
							</table>
						</div>
						<div class="cl mt-10 pos-r txtwrap1" id="oldfittingimg">
						</div>
					</div>
					<div class="tabCon" id="hfMsg">
					</div>

					<div class="tabCon">
						<div style="overflow: auto;">
							<table id="jsMsg"  class="table table-border table-bordered table-bg table-relatedorder">
							</table>
						</div>
						<div class="cl mt-10 pos-r txtwrap1" id="settlementInfo">
						</div>
					</div>
				</div>
				</div>
			</div>

		</div>
		
	</div>
</div>

<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef"></script>
<script type="text/javascript">
	var formPosted = false;
    var dispatchMap,dispatchMarker,employeMarker;

	$("#closDivPoup").on("click",function(){
		parent.search();
		$('#Hui-article-box',window.top.document).css({'z-index':'9'});
	});
    $('#imgshow').imgShow();
	$(function(){
		if('${haveData}'=="1"){
			layer.msg("没有上一条数据了");
		}
		if('${haveData}'=="2"){
			layer.msg("没有下一条数据了");
		}
		$('#wxImgList').imgShow();
		$("#orderNumber").prop("disabled",false);
		$("#orderNumber").prop("readonly",true);

		$('#minusWrap').removeClass('minusWrap');
		$('#minusWrap').find('.prefix').hide();

		$('#emp').select2();
		//2.监听父层按钮的动作
		$('#pngfix-nav-btn', parent.document).click(function(){
			//3.给定一个时间点
			setTimeout(function(){
				//4.再次执行全屏
				layer.restore(full_idx);
			},200);
		});
		
	$(".selection").css("width","160px");
		
		
		$("#jiesuan_detail_div").on('blur', 'input', function(){
			if(!testCash($("#total_cost").val())){
				layer.msg("请先维护费用!", {time:1000});
				$(this).val("");
				return ;
			}else{
				var sum = 0;
			    $("#jiesuan_detail_div input").each(function(){
			    	if(testCash($(this).val())){
			       		sum = numAdd(sum, $(this).val());
			      	}else if($(this).val() !=''){
			       		$(this).val(""); 
			      	}  
			    }); 
			    if(sum > $("#total_cost").val()){
			    	layer.msg("提成总额不能大于结算总额!", {time:1000});
			    	$(this).val("");
			    	return;
			    }
			}
		});

		$('#reason').on('change',function(){
			var index = $(this).val();
			if(index == '扣款'){
				$('#minusWrap').addClass('minusWrap');
				$('#minusWrap').find('.prefix').show();
			}else{
				$('#minusWrap').removeClass('minusWrap');
				$('#minusWrap').find('.prefix').hide();
			}
		});

		$("#samount").blur(function () {
			var samount = $.trim($("#samount").val());
			if (samount < 0) {
				layer.msg("请输入正确格式的结算金额");
				return false;
			}
			if (!(/^[1-9]\d*(\.\d{1,2})?$/).test(samount) || !(/^[1-9]\d*(\.\d{1,2})?$/).test(samount)) {
				layer.msg("结算金额要求大于零且最多包含两位小数");
				return false;
			}
		});
		
		$.Huitab("#detialWd .tabBarP .tabswitch","#detialWd .tabCon","current","click","0");
		$.Huitab("#serveFb .tabBarP .tabswitch","#serveFb .tabCon","current","click","0");
		$.Huitab("#fbSettle .tabBarP .tabswitch","#fbSettle .tabCon","current","click","0");
		
		$('.orderdetailVb').popup({fixedHeight:false});
		
		   judgedygd();

        var addr="<c:out value='${order.customerAddress}'/>";
	});
	
	//显示重新结算
	function saveSettlementup(){
		$(".feyon").show();
		$(".jiesuan").hide();
		$("#seltment_form").show();
		$("#seltment_form_up").hide();
		 
	}
	
	$('#btn_showImg').on('click', function(){
		$('#wxImgList img').eq(0).click();
	});

	function updateCallbackBtn() {
	}
	function closeCallbackForm() {
        layer.close(openedCallbackFormIndex);
		window.location.reload(true);
	}
	
	function showCallbackForm() {
		openedCallbackFormIndex = layer.open({
			type: 2,
			content: '${ctx}/order/orderCallback/new?id=${order.id}&espesially='+"fromHistory",
			title: false,
			area: ['100%', '100%'],
			closeBtn: 0,
			shade: 0,
			fadeIn: 0,
			anim: -1
		});
	}
	
	function saveCallback(){
		var postData = $("#callback_form").serializeJson();
		$.post('${ctx}/order/orderCallback/saveCallback', postData, function(result){
		});
	}
	
	function newOrder(id){
		window.location.href="${ctx}/order/newFormFormDetail?id="+id;
	
		/* */
	}
	
  	//显示结算
	function showjiesuan(){
 		$(".feyon").hide();
		$(".jiesuan").show();
	}
	 
	//获取配件信息
	//获取工单关联备件使用信息
	function showSYMsg(){
		var orderNumber = "${order.number}";
		var str="";
		var imgstr="";
		var img = [];
		$.ajax({
			url:"${ctx}/order/showSYMsg",
			data:{orderNumber:orderNumber,remark:'SYMsg'},// 备注信息 wxz 暂时取消，服务中的工单、待回访、待结算的工单中备件信息分为：使用的配件和申请的配件
			dataType:'json',
			async:false,
			success:function(result){
				$("#pjsy").html("<caption>工单关联配件使用</caption>"+
                    "<thead>" +
                    "<tr>" +
                    "<th class='w-180'>备件条码</th>" +
                    "<th class='w-260'>备件名称</th>" +
                    "<th class='w-120'>备件型号</th>" +
                    "<th class='w-90'>最新入库价格</th>" +
                    "<th class='w-80'>工程师价格</th>" +
                    "<th class='w-70'>零售价格</th>" +
                    "<th class='w-50'>数量</th>" +
                    "<th class='w-70'>收费金额</th>" +
                    "<th class='w-100'>使用类型</th>" +
                    "<th class='w-70'>状态</th>" +
                    "</tr>" +
                    "</thead>");
				/* $(".showimg").html("<label class='lb lb1'>备件图片：</label>"); */
				
				if(result.list.length>0){
                    $.each(result.list, function (index, val) {
                        str += "<tr>" +
                            "<td class='w-140'>" + val.columns.fitting_code + "</td>" +
                            "<td class='w-300'>" + val.columns.fitting_name + "</td>" +
                            "<td class='w-120'>" + val.columns.fitting_version + "</td>" +
                            "<td class='w-90'>" + val.columns.site_price + "</td>" +
                            "<td class='w-80'>" + val.columns.employe_price + "</td>" +
                            "<td class='w-70'>" + val.columns.customer_price + "</td>" +
                            "<td class='w-50'>×" + val.columns.used_num + "</td>" +
                            "<td class='w-70'>" + val.columns.collection_money + "</td>";
                        if(val.columns.warranty_type=="1"){
                            str+="<td class='text-c  w-100'>保内使用</td>";
                        }else if(val.columns.warranty_type=="2"){
                            str+="<td class='text-c  w-100'>保外零售</td>";
                        }else{
                            str+="<td class='text-c  w-100'></td>";
                        }
                        if (val.columns.status == "1") {
                            str += "<td class='c-fe0101 w-70'><i class='oState state-verifyPass'></i>待核销</td>";
                        } else if (val.columns.status == "2") {
                            str += "<td class='c-fe0101 w-70'><i class='oState state-waitVerify'></i>已核销</td>";
                        }
				});
				}else{
					$(".showimg").html("");
				}
				
				$("#pjsy").append(str);
				return;
			}
			
		});
	}
	
	//获取工单关联备件申请信息
	function showSQMsg(){
		var orderNumber = "${order.number}";
		var str="";
		var imgstr="";
		var img = [];
		$.ajax({
			url:"${ctx}/order/showSQMsg",
			data:{orderNumber:orderNumber,remark:'SQMsg'},// 备注信息 wxz 暂时取消，服务中的工单、待回访、待结算的工单中备件信息分为：使用的配件和申请的配件
			dataType:'json',
			async:false,
			success:function(result){
				$("#pjsq").html("<caption>工单关联配件申请</caption>"+
						"<thead>"+
						"<tr>"+
							"<th class='w-180'>备件条码</th>"+
							"<th class='w-260'>备件名称</th>"+
							"<th class='w-120'>备件型号</th>"+
							"<th class='w-50'>数量</th>"+
							"<th class='w-70'>状态</th>"+
						"</tr>"+
					"</thead>");
				$(".showimg").html("<label class='lb lb1'>备件图片：</label>");
				
				if(result.list.length>0){
				$.each(result.list,function(index,val){
					str+="<tr>"+
					"<td class='w-140'>"+val.columns.fitting_code+"</td>"+
					"<td class='w-300'>"+val.columns.fitting_name+"</td>"+
					"<td class='w-120'>"+val.columns.fitting_version+"</td>"+
					"<td class='w-50'>×"+val.columns.fitting_apply_num+"</td>";
					if(val.columns.status=="0"){
						str+="<td class='c-fe0101 w-70'><i class='oState state-verifyPass'></i>待审核</td>";
					}else if(val.columns.status=="1"){
						str+="<td class='c-fe0101 w-70'><i class='oState state-waitVerify'></i>缺件中</td>";
					}else if(val.columns.status=="2"){
						str+="<td class='c-fe0101 w-70'><i class='oState state-waitVerify'></i>待出库</td>";
					}else if(val.columns.status=="3"){
						str+="<td class='c-fe0101 w-70'><i class='oState state-waitVerify'></i>待领取</td>";
					}else if(val.columns.status=="4"){
						str+="<td class='c-fe0101 w-70'><i class='oState state-waitVerify'></i>已领取</td>";
					}else if(val.columns.status=="5"){
						str+="<td class='c-fe0101 w-70'><i class='oState state-waitVerify'></i>已取消</td>";
					}else if(val.columns.status=="6"){
						str+="<td class='c-fe0101 w-70'><i class='oState state-waitVerify'></i>未通过</td>";
					}
 					str+="</tr class='w-100'>";
					img = (val.columns.fitting_img).split(",");
					for(var i=0;i<img.length;i++){
						if(img[i]!=""&&img[i]!=null){
							imgstr+=("<div class='f-l mr-10'><div class='imgWrap'><img src='${commonStaticImgPath}"+img[i]+"'></div></div>");
						}
					}
				});	
 					if(imgstr==""){
						imgstr+=("<div class='f-l mr-10'><div class='imgWrap'><img src='${ctxPlugin}/static/h-ui.admin/images/img-default.png'></img></div></div>");
					}
				}else{
					$(".showimg").html("");
				}
				
				$("#pjsq").append(str);
                jQuery.getScript("${ctxPlugin}/static/h-ui.admin/js/imgShow.js", function(data, status, jqxhr) {
                    $(".showimg").append(imgstr);
                    $('.showimg').imgShow();
                });
				return;
			}
			
		});
	}
	//获取工单关联旧件信息
	function showOldFitting(){
		var orderNumber = "${order.number}";
		var str="";
		var imgstr="";
		$.ajax({
			url:"${ctx}/order/showOldFitting",
			data:{orderNumber:orderNumber},
			dataType:'json',
			async:false,
			success:function(result){
				$(".oldtbody").empty();
				$("#oldfittingimg").html("<label class='lb lb1'>旧件图片：</label>");
				if(result.list.length>0){
				$.each(result.list,function(index,val){
					str+="<tr>"+
					"<td class='w-180'>"+val.columns.code+"</td>"+
					"<td class='w-260'>"+val.columns.name+"</td>"+
					"<td class='w-120'>"+val.columns.version+"</td>"+
					"<td class='w-100'>"+val.columns.brand+"</td>";
					if(val.columns.yrpz_flag=="1"){
						str+="<td class='w-70'>是</td>";
					}else if(val.columns.yrpz_flag=="2"){
						str+="<td class='w-70'>否</td>";
					}
					str+= "<td class='w-50'>×"+val.columns.num+"</td>";
					if(val.columns.status=="0"){
						str+="<td class='w-70'>已登记</td>";
					}else if(val.columns.status=="1"){
						str+="<td class='w-70'>已入库</td>";
					}else if(val.columns.status=="3"){
						str+="<td class='w-70'>已返厂</td>";
					}else if(val.columns.status=="4"){
						str+="<td class='w-70'>已报废</td>";
					}
					str+= "<td class='w-50'>"+val.columns.cateTime+"</td>";
 					str+="</tr class='w-100'>";
					
					var images=val.columns.img.split(",");
					for(var i=0;i<images.length;i++){
                        imgstr+= "<div class='f-l mr-10'><div class='imgWrap w-120 text-c'><img src='${commonStaticImgPath}"+images[i]+"'></img>";
                        imgstr+= "<p class='lh-20'>"+val.columns.cateTime+" </p></div></div>";
                    }
				});
 					if(imgstr==""){
						imgstr+=("<div class='f-l mr-10'><div class='imgWrap'><img src='${ctxPlugin}/static/h-ui.admin/images/img-default.png'></img></div></div>");
					}
				}else{
					$("#oldfittingimg").html("");
				}
				
				$(".oldtbody").append(str);
                jQuery.getScript("${ctxPlugin}/static/h-ui.admin/js/imgShow.js", function(data, status, jqxhr) {
                    $("#oldfittingimg").append(imgstr);
                    $('#oldfittingimg').imgShow();
                })
				return;
			}
			
		});
	}
	
	function saveSettlement(){
		var tc_str = "";
		var valid = true;
		var sum = 0;
		$("input[id^=tc_]").each(function(){
			if(testCash($(this).val())){
				tc_str += "," + $(this).attr("id").split("_")[1] + "_" +$(this).val();
				sum = numAdd(sum, $(this).val());
			}else{
				valid = false;
			}
		});
		if($("#jiesuanDetailBtn").attr("checked") && !valid){
			layer.msg("请输入正确的提成金额!");
			return ;
		}
		if(sum > $("#total_cost").val()){
			layer.msg("提成总额不能大于结算总额!");
			return ;
		}
		if(sum > 0){
			$("#emp_tc").val(tc_str.substring(1));
			$("#total_tc").val(sum);
		}
		var postData = $("#seltment_form").serializeJson();
		$.post('${ctx}/order/orderSettlemnt/saveSettlement', postData, function(result){
			 if(result == "ok"){
			    	layer.msg("结算成功！");
			    	$.closeDiv($('.orderdetailVb'));
			    	location.href="${ctx}/order/History";
			    }
		});
	}
	
	function openJiesuanDetail(){
		if($("#jiesuanDetailBtn").attr("checked")){
			$("#jiesuanDetailBtn").parent("label").addClass("label-cbox2-selected")
			$("#jiesuan_detail_div").show();
		}else{
			$("#jiesuanDetailBtn").parent("label").removeClass("label-cbox2-selected")
			$("#jiesuan_detail_div").hide();
			$("#emp_tc").val("");
			$("input[id^=tc_]").val("");
		}
	}

	function addNewSettlementItem(orderId) {
	}

	function cancelJs() {
		$.closeDiv($('.addJsBox'));
	}

	$('#btn-addJs').on('click', function(){
//		$('.addJsBox').popup({level:4});
//		$("#addJsForm").get(0).reset();
		showjiesuanForm();
	});

    function showjiesuanForm() {
        $.ajax({
            url: "${ctx}/order/settlement/canSettlement",
            type: 'post',
            data: {
                orderId: '${order.id}'
            },
            success: function (data) {
                if ("T" === data) {
                    openedJiesuanFormIndex = layer.open({
                        type: 2,
                        content: '${ctx}/order/settlement/edit?id=${order.id}',
                        title: false,
                        area: ['100%', '100%'],
                        closeBtn: 0,
                        shade: 0,
                        fadeIn: 0,
                        anim: -1
                    });
                } else if("delEmpDT" == data) {
                    layer.msg("检测到该工单关联了已删除的工程师，请联系平台管理员！");
                    return;
                } else if ("F" === data) {
                    layer.msg("工单当前工程师信息有误，无法完成结算！");
                } else if ("value0" === data) {
                    layer.msg("请回访后再进行结算！");
                    return;
                } else if ("value1" === data) {
                    layer.msg("工单交款金额和实收金额不一致，请确认一致后再进行结算！");
                    return;
                } else if ("value20" === data) {
                    layer.msg("请回访后再进行结算！");
                    return;
                } else if ("value21" === data) {
                    layer.msg("工单交款金额和实收金额不一致，请确认一致后再进行结算！");
                    return;
                }
            }
        });
    }

	function closeJiesuanForm() {
		layer.close(openedJiesuanFormIndex);
		$("#settlementDetail").load("${ctx}/order/settlement/showHtml?id=${order.id}&v=" + new Date().getTime());
		parent.search();
	}

    function changeStyle(orderNum){
        var bStop = false;
        var bStopIndex = 1;
        var topWindow = $(window.top.document),
            show_navLi = topWindow.find("#min_title_list li");

        show_navLi.each(function() {
            $(this).removeClass('active');
            if($(this).find('span').text() =='短信发送记录'){
                bStopIndex=show_navLi.index($(this));
                bStop=true;
            }
        });
        if(!bStop){
            creatIframe('${ctx }/operate/sendedSms?orderNum='+orderNum,'短信发送记录');
        }else{
            show_navLi.eq(bStopIndex).addClass('active');
            topWindow.find('#iframe_box .show_iframe').hide().eq(bStopIndex).show().find('iframe').attr({'src':'${ctx }/operate/sendedSms?orderNum='+orderNum});
        }
    }

	$(function () {
		var validForm = $('#addJsForm').Validform({
			btnSubmit: "#subBtn",
			tiptype: function (msg, o, cssctl) {
				if (msg) {
					layer.msg(msg);
				}
			},
//			postonce: true,
//			tipSweep: true,
			datatype: {
				"price": /^\d+(\.\d{1,2})?$/
			},
			callback: function (form) {
				if (formPosted) {
					return false;
				}

				var settlementDate = $("#bxdatemax_guishu").val();
				if (!settlementDate) {
					layer.msg("请选择结算归属日期");
					return false;
				}

				var empName = $("#emp").children("option").filter(":selected").text();
				$("#empName").val(empName);
				var reasonVal = $('#reason option:selected') .val();
				if(reasonVal == '扣款') {
					$("#realAmount").val(-1 * $("#samount").val());
				} else {
					$("#realAmount").val($("#samount").val());
				}
				formPosted = true;
				$.ajax({
					url: "${ctx}/order/settlement/addNewSettlementItem",
					data: $(form).serialize(),
					type: 'post',
					success: function () {
						validForm.resetForm();
						$.closeDiv($('.addJsBox'));
						$("#settlementDetail").load("${ctx}/order/settlement/showHtml?id=${order.id}&v=" + new Date().getTime());
					},
					complete: function () {
						formPosted = false;
					}
				});
				return false;
			}
		});
	});

	$("#settlementDetail").load("${ctx}/order/settlement/showHtml?id=${order.id}");
	 $('#Imgprocess2').imgShow();


		function dygd(id){
			//使用默认
			window.open("${ctx}/print/order?orderId="+id);
		}
		
		function dygdcustom(id){
			$.ajax({
				type : 'POST',
				url : "${ctx}/order/printdesign/getOrderKeyName",
				data : {orderId:id},
				datatype:"JSON",
				success : function(data) {
					if(data == null || data.content == null || data.content.length<=0){
						var newTab=window.open('about:blank');
						newTab.location.href="${ctx}/print/order?orderId="+id;
						return
					}
					prn_Preview(data);
				}

			});
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
		
	var chongfu = true;
	//历史工单的修改
	var addressReco = "";
	function updateHistory(id){
        var caozuo = $(".caozuo").val();
        if(caozuo == '修改工单'){
            $(".other").addClass("sfbtn-disabled");
            $(".other").prop("disabled","disabled");
            $(".mark").removeClass("hide");
            $("#pro").css({display:"block"});
            $("#cit").css({display:"block"});
            $("#are").css({display:"block"});
            $("#telTypeChoose").css({display:"block"});
            $(".reLX1").addClass("hide");
            $(".remarkUpdate").prop("readonly",false);
            $(".remarkUpdate").removeClass("readonly");
            $(".goback").removeClass("hide");
            $(".caozuo").val("保存");
            $("#customerMobile").addClass("mustfill");
            $("#customerName").addClass("mustfill");
            $("#customerAddress").addClass("mustfill");
            $("#customerAddress").show();
            $("#customerAddress2").hide();

		}else if(caozuo == '保存'){
            if(chongfu){
                chongfu = false;
                var moliereg=/^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$|(^(1[0-9])\d{9}$)/;
                var mtel=/^([\+][0-9]{1,3}[ \.\-])?([\(]{1}[0-9]{2,6}[\)])?([0-9 \.\-\/]{3,20})((x|ext|extension)[ ]?[0-9]{1,4})?$/;
                //保存操作
				var telType = $("#telType").val();
                var customerName = $("#customerName").val();
                var customerMobile = $("#customerMobile").val();
                var customerTelephone = $("#customerTelephone").val();
                var customerTelephone2 = $("#customerTelephone2").val();
                var customerAddress = $("#customerAddress").val();

                var pro = $("#province").val();
                var city = $("#city").val();
                var area = $("#area").val();
//                addressReco = customerAddress;
//                $("#customerAddressRecord").val(addressReco);
                //yz
                if(customerName == ''){
                    layer.msg("请输入用户姓名");
                    chongfu = true;
                    return;
                }
                if(customerAddress == ''){
                    layer.msg("请输入用户地址");
                    chongfu = true;
                    return;
                }
				if(customerMobile == ''){
				    layer.msg("请输入联系方式1");
                    chongfu = true;
				    return;
				}
                if(telType == '0' && !moliereg.test(customerMobile)){
                    layer.msg("请输入正确联系方式1");
                    chongfu = true;
                    return;
                }else if(telType == '1' && !mtel.test(customerMobile)){
                    layer.msg("请输入正确联系方式1");
                    chongfu = true;
                    return;
				}
                if(customerTelephone != '' && !mtel.test(customerTelephone)){
                    layer.msg("请输入正确联系方式2");
                    chongfu = true;
                    return;
                }
                if(customerTelephone2 != '' && !mtel.test(customerTelephone2)){
                    layer.msg("请输入正确联系方式3");
                    chongfu = true;
                    return;
                }
                if(!pro || !city || !area){
                    layer.msg("省市区为必填项");
                    chongfu = true;
                    return;
                }
                customerAddress = pro+city+area+customerAddress;
                $("#customerAddress2").val(customerAddress);
                $("#customerAddress").hide();
                $("#customerAddress2").show();
                $.ajax({
                    url: "${ctx}/order/orderDispatch/updateHistoryUser",
                    data: {
                        ids: id,
                        customerName: customerName,
                        customerMobile: customerMobile,
                        customerTelephone: customerTelephone,
                        customerTelephone2: customerTelephone2,
                        customerAddress: $("#customerAddress").val(),
                        customerProvince: $("#province").val(),
                        customerCity: $("#city").val(),
                        customerArea: $("#area").val()
                    },
                    dataType: 'text',
                    type: "post",
                    success: function () {
                        chongfu = true;
                        $(".goback").addClass("hide");
                    }
                });

                $("#pro").css({display:"none"});
                $("#cit").css({display:"none"});
                $("#are").css({display:"none"});
                $("#telTypeChoose").css({display:"none"});
                $(".reLX1").removeClass("hide");
                $(".remarkUpdate").prop("readonly",true);
                $(".remarkUpdate").addClass("readonly").removeClass('mustfill');
                $(".other").removeClass("sfbtn-disabled");
                $(".other").removeAttr("disabled");
                $(".mark").addClass("hide");

                $(".caozuo").val("修改工单");
			}else{
				layer.msg("一项操作正在执行");
                return;
			}
		}
	}
	function goback() {
	    $(".goback").addClass("hide");
        $(".remarkUpdate").prop("readonly",true);
        $(".remarkUpdate").addClass("readonly");
        $("#pro").css({display:"none"});
        $("#cit").css({display:"none"});
        $("#are").css({display:"none"});
        $("#telTypeChoose").css({display:"none"});
        $(".reLX1").removeClass("hide");
        $(".mark").addClass("hide");
        $(".other").removeClass("sfbtn-disabled");
        $(".other").removeAttr("disabled");
//        $("#customerAddress").val($("#customerAddressRecord").val());
        $("#customerAddress").removeClass("mustfill");
        $("#customerAddress").removeClass("mustfill");
        $("#customerName").removeClass("mustfill");
        $("#customerMobile").removeClass("mustfill");
        $("#customerAddress").hide();
        $("#customerAddress2").show();
        $(".caozuo").val("修改工单");
    }

    function getDefaultAddress(){
        $.ajax({
            type: "POST",
            url: "${ctx}/order/getDefaultAddress",
            datatype:"text",
            success: function (result) {
                $("#pcd").citySelect({
                    url:'${ctxPlugin}/lib/city.min.js',
                    address:result
                });
                //addressTwo(result);
            },
            error: function () {
                layer.msg("系统繁忙!");
                return;
            },
            complete: function () {

            }

        });
    }
    function addressSplit(str){
        var sz = [];
        if (str.indexOf("区") > 0 && str.indexOf("县") <= 0 && str.indexOf("市") < 0) {
            sz = str.split("区");
            if (sz.length > 2) {
                var strs = "";
                for (var i = 1; i < sz.length; i++) {
                    if (i != sz.length - 1) {
                        strs += sz[i] + "区";
                    } else {
                        strs += sz[i];
                    }
                }
                $("#customerAddress").val(strs);
            } else if (1 < sz.length <= 2) {
                $("#customerAddress").val(sz[1]);
            } else {
                $("#customerAddress").val(sz[0]);
            }
        }else if (str.indexOf("县") > 0 && str.indexOf("市") < 0) {
            sz = str.split("县");
            if (sz.length > 2) {
                var strs = "";
                for (var i = 1; i < sz.length; i++) {
                    if (i != sz.length - 1) {
                        strs += sz[i] + "县";
                    } else {
                        strs += sz[i];
                    }
                }
                $("#customerAddress").val(strs);
            } else if (1 < sz.length <= 2) {
                $("#customerAddress").val(sz[1]);
            } else {
                $("#customerAddress").val(sz[0]);
            }
        }else if(str.indexOf("县") > 0 && str.indexOf("市") > 0){
            var ciAd=str.indexOf("市");
            var xaAd=str.indexOf("县");
            if(parseInt(ciAd) < parseInt(xaAd)){//市在前
                sz = str.split("市");
                if (sz.length > 2) {
                    var strs = "";
                    for (var i = 1; i < sz.length; i++) {
                        if (i != sz.length - 1) {
                            strs += sz[i] + "市";
                        } else {
                            strs += sz[i];
                        }
                    }
                    $("#customerAddress").val(strs);
                } else if (sz.length == 2) {
                    $("#customerAddress").val(sz[1]);
                } else {
                    $("#customerAddress").val(sz[0]);
                }
            }else if(parseInt(ciAd) > parseInt(xaAd) ){//县在前
                sz = str.split("县");
                if (sz.length > 2) {
                    var strs = "";
                    for (var i = 1; i < sz.length; i++) {
                        if (i != sz.length - 1) {
                            strs += sz[i] + "县";
                        } else {
                            strs += sz[i];
                        }
                    }
                    $("#customerAddress").val(strs);
                } else if (1 < sz.length <= 2) {
                    $("#customerAddress").val(sz[1]);
                } else {
                    $("#customerAddress").val(sz[0]);
                }
            }
        }else if(str.indexOf("市") > 0 && str.indexOf("区") < 0){
            sz = str.split("市");
            if (sz.length > 2) {
                var strs = "";
                for (var i = 1; i < sz.length; i++) {
                    if (i != sz.length - 1) {
                        strs += sz[i] + "市";
                    } else {
                        strs += sz[i];
                    }
                }
                $("#customerAddress").val(strs);
            } else if (sz.length == 2) {
                $("#customerAddress").val(sz[1]);
            } else {
                $("#customerAddress").val(sz[0]);
            }
        }else if (str.indexOf("市") > 0 && str.indexOf("区") > 0) {
            var ciAd=str.indexOf("市");
            var quAd=str.indexOf("区");

            if(parseInt(ciAd) < parseInt(quAd)){//市在前
                sz = str.split("市");
                if (sz.length > 2) {
                    var strs = "";
                    for (var i = 1; i < sz.length; i++) {
                        if (i != sz.length - 1) {
                            strs += sz[i] + "市";
                        } else {
                            strs += sz[i];
                        }
                    }
                    $("#customerAddress").val(strs);
                } else if (sz.length == 2) {
                    $("#customerAddress").val(sz[1]);
                } else {
                    $("#customerAddress").val(sz[0]);
                }
            }else if(parseInt(ciAd) > parseInt(quAd) ){//区在前
                sz = str.split("区");
                if (sz.length > 2) {
                    var strs = "";
                    for (var i = 1; i < sz.length; i++) {
                        if (i != sz.length - 1) {
                            strs += sz[i] + "区";
                        } else {
                            strs += sz[i];
                        }
                    }
                    $("#customerAddress").val(strs);
                } else if (1 < sz.length <= 2) {
                    $("#customerAddress").val(sz[1]);
                } else {
                    $("#customerAddress").val(sz[0]);
                }
            }
        } else if (str.indexOf("区") <= 0 && str.indexOf("县") <= 0 && str.indexOf("市") <= 0) {
            $("#customerAddress").val(str);
        }
        var province = $("#province").val();
        var city = $("#city").val();
        var area = $("#area").val();
        if (isBlank(province) || isBlank(city) || isBlank(area)) {
            getDefaultAddress();
        }
    }
    function isBlank(val) {
        if(val==null || val=='' || val == undefined) {
            return true;
        }
        return false;
    }
    function showMarkOrder(id) {
        layer.open({
            type : 2,
            content:'${ctx}/order/showMarkOrders?ids=' + id,
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            anim:-1
        });
    }

    function directDis() {
        var number = $.trim($("#number").val());
        $.ajax({
            type:"post",
            url:"${ctx}/order/checkonumber",
            data:{orderNumber:number},
            success:function(data){
//                if(data=="existNumber"){
//                    layer.msg("工单编号已存在！");
//                    return false;
//                }
                $('.activeDispatch').popup({level:2,closeSelfOnly:true}); //显示我要派工弹出框和判断高度
                $.selectCheck2("serverSelected");
                initDispatchMap();
                employe();
            }
        });
    }

    var confirmpai=false;

    function dispa() {
        if (confirmpai) {
            return;
        }
        var empId = $("#employeId").val();
        if (isBlank(empId)) {
            layer.msg("请选择服务工程师");
        } else {
            var name = $.trim($("#nameWrap").children('span').html());
            $('body').popup({
                level: '3',
                type: 2,  // 提示是否进行某种操作
                content: '确认要给工程师' + name + '派工吗？',
                closeSelfOnly: true,
                fnConfirm: function () {
                    confirmpai = true;
                    $.ajax({
                        url: "${ctx}/order/orderDispatch/wxdRedispatch",
                        type: "POST",
                        data: {
                            id: "${order.id}",
							empId: empId
						},
                        success: function (data) {
                            if(data && "422" === data.code) {
                                window.top.layer.msg("工单编号已存在，无法重新派工。");
							} else {
                                window.top.layer.msg('派单成功');
                            }
                            parent.search();
                            $.closeAllDiv();
                        },
                        complete: function () {
                            confirmpai = false;
                        }
                    });
                },
                fnCancel: function () {
                }
            });
        }
    }

    $('#filterName').keyup(function () {
        $('#zhijiepaidan tr').hide().filter(":contains('" + ($(this).val()) + "')").show();
        if(isBlank($(this).val())){
            $('#zhijiepaidan tr').show();
        }

    }).keyup();//DOM加载完时，绑定事件完成之后立即触发

    function initDispatchMap() {
        if (!dispatchMap) {
            dispatchMap = new AMap.Map('dispatch_map_container', {
                zoom: 12
            });
            dispatchMarker = new AMap.Marker({
                map: dispatchMap,
                draggable: true
            });
            employeMarker = new AMap.Marker({});
            dispatchMarker.setMap(dispatchMap);
        }
        var lnglat = $("#lnglat").val();
        if (!isBlank(lnglat)) {
            var lnglats = lnglat.split(",");
            var position = new AMap.LngLat(lnglats[0], lnglats[1]);
            dispatchMap.setZoomAndCenter(12, position);
            dispatchMarker.setPosition(position);
        }
        employeMarker.setMap(null);
    }

    function employe() {
        var lnglat = $("#lnglat").val();
        var category = $('#applianceCategory').val();
        $.ajax({
            type: "POST",
            url: "${ctx}/operate/employe/dispatchList",
            data: {
                lnglat: lnglat,
                category: category
            },
            //dataType: 'json',
            success: function (data) {
                var content = $("#zhijiepaidan");
                content.empty();
                var sites = data;
                var appendHtml = '';
                for (var i = 0; i < sites.length; i++) {
                    var item = sites[i].columns;
                    appendHtml += '<tr>'
                        + '<td style="border-left: none;">' + item.name + '</td>'
                        + '<td>' + item.wwg + '</td>'
                        + '<td>' + item.jrywg + '</td>'
                        + '<td>' + item.distance_formatted + '</td>'
                        + '<td><label class="label-cbox3" for="' + item.id + '"><input type="checkbox" name="serverSelected" id="' + item.id + '"></label></td>'
                        + '</tr>';
                }
                if (isBlank(appendHtml)) {
                    layer.msg("服务工程师没有维护"+category+"服务品类，请先维护");
                }
                content.html(appendHtml);

                $("#zhijiepaidan tr").each(function (index) {
                    $(this).data("emp", sites[index].columns);
                });
                $("#zhijiepaidan tr").on('click', function (ev) {

                    var name = ev.target.tagName.toLowerCase();
                    if(name == 'label') return;

                    var flag = $(this).hasClass('checked');
                    if (flag) {
                        $(this).removeClass('checked');
                    } else {
                        $(this).attr("class", "checked");
                        $.trim($(this).children('td').eq(0).html())
                    }
                    $("#nameWrap").empty();
                    var name = "";
                    var id = "";
                    $("#zhijiepaidan tr").each(function (index) {
                        var flag = $(this).hasClass('checked');
                        if (flag) {
                            if (isBlank(name)) {
                                name = $.trim($(this).children('td').eq(0).html());
                            } else {
                                name = name + " " + $.trim($(this).children('td').eq(0).html());
                            }
                            if (isBlank(id)) {
                                id = $.trim($(this).children('td').eq(4).children('label').attr('for'));
                            } else {
                                id = id + "," + $(this).children('td').eq(4).children('label').attr('for');
                            }
                        }
                    });
                    $("#nameWrap").append("<span>" + name + "</span>");
                    $("#employeId").val(id);
                });
            }
        });
    }
    
    function toOrderDetail(id,number,previousOrNext){
    	var dtMsg = parent.getConditions();
    	var topWin = window.top;
        parent.search();
        $.closeAllDiv();
    	var $pFrame = $("#Hui-article-box iframe:visible", topWin.document);
        var frameWin = $pFrame.get(0).contentWindow || $pFrame.get(0);
        frameWin.layer.open({
           type : 2,
           content:'${ctx}/order/orderDispatch/Wholeform?map='+dtMsg+'&id='+id+'&previousOrNext='+previousOrNext+'&whereMark=1'+'&parentNumber='+number,
           title:false,
           area: ['100%','100%'],
           closeBtn:0,
           shade:0,
           anim:-1
       });
    }
    function showGoodsMsg(){
    	var orderNumber = "${order.number}";
    	$.ajax({
    		url:"${ctx}/order/showGoodsMsg",
    		data:{orderNumber:orderNumber},
    		dataType:'json',
    		async:false,
    		success:function(data){
    			var html="";
    			if(data.length > 0){
    				for(var i=0;i<data.length;i++){
    					var goods = data[i].columns;
    					html+="<tr>" +
    		                        "<td  title='"+goods.number+"'>"+goods.number+"</td>" +
    		                        "<td  title='"+goods.good_name+"'>"+goods.good_name+"</td>" +
    		                        "<td >"+outStocksType(goods.status,goods.outstock_type)+"</td>" +
    		                        "<td >"+goods.purchase_num+"</td>" +
    		                        "<td >"+goods.good_amount+"</td>" +
    		                        "<td >"+goods.real_amount+"</td>" +
    		                        "<td >"+goods.confirm_amount+"</td>" +
    		                        "<td >"+goods.sales_commissions+"</td>" +
    		                        "<td  title='"+goods.placing_name+"'>"+goods.placing_name+"</td>" +
    		                        "<td >"+formatDate(goods.placing_order_time)+"</td>" +
    		                        "<td  style='color:red;'>"+goodsOrderStatus(goods.status,goods.outstock_type,goods.stocks,goods.purchase_num,goods.outstock_type)+"</td>" +
    	                        "</tr>";
    				}
    				$("#goodsMsg").empty();
    				$("#goodsMsg").append(html);
    			}
    		}
    	})
    }


    //结算信息
    function showOrderJs(obj,number){
        var str="";
        $.ajax({
            url:"${ctx}/order/orderSettlement/showJsMsg",
            data:{number:number},
            dataType:'json',
            async:false,
            success:function(result){
                if(result.code=="200"){
                    $("#"+obj).empty();
                    var tabs = result.data.repairOrderTab;//表头项
                    var detail = result.data.repairOrderDetail;//结算信息

                    if(tabs.length > 0){
                        var html = "<caption>工单结算信息</caption>"+"<thead>" +"<tr>" +"<th class='w-80'>序号</th>" ;
                        var str1 = "";
                        for(var i=0;i < tabs.length;i++){
                            str1 += "<th class='w-150'>"+tabs[i].columns.name+"</th>" ;
                        }
                        str = html + str1 + "</tr>" + "</thead>";
                    }
                    if(detail.length > 0){
                        var htmls = "";
                        for(var i=0;i<detail.length;i++){
                            htmls += "<tr><td class='w-80'>"+(i+1)+"</td>";
                            for(var j=0;j<detail[i].length;j++){
                                htmls += "<td class='w-150'>"+detail[i][j].columns.value+"</td>";
                            }
                            htmls += "</tr>";
                        }
                        str +=htmls;

                    }

                    if (!isBlank(result.data.noPassResource)) {
                        var ht = '<textarea style="width: 770px;height: 60px" class="textarea readonly" readonly>' + result.data.noPassResource + '</textarea>';
                        $("#settlementInfo").html("<label class='lb lb1'>不通过原因：</label>");
                        $("#settlementInfo").append(ht);
                    }
                    $("#"+obj).append(str);
                    return;
				}else if(result.code=="201"){
                    layer.msg(result.msg);
                    return;
				}
            }

        });
    }

</script>
</body>
</html>
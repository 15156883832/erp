<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>工单录入</title>
<meta name="decorator" content="base"/>

<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select2.min.css"/> 
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.cityselect.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
<style>
 	.webuploader-pick{
		background:none;
		color:#22a0e6;
		width:80px;
		padding:0;
		height:80px;
	}
	.webuploader-pick img{
		width:100px;
		height:100px;
		position:absolute;
		left:0;
		top:0;
	}
</style>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.dateformat.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>  
<script type="text/javascript" src="${ctxPlugin}/lib/select2.full.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>


<script type="text/javascript" src="${ctxPlugin}/lib/lodop/LodopFuncs.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/lodop/base64.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/lodop/printdesign.js"></script>
</head>

<body>
<!-- 回访结算工单-工单详情 -->
<div class="popupBox odWrap orderdetailVb" style="width: 970px;">
	<h2 class="popupHead">
		工单详情
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain" >
			<div class="pcontent" style="padding-right: 20px;">
				<div class="tabBarP" style="overflow: visible;">
					<a href="javascript:;" class="tabswitch current">基本信息</a>
					<c:if test="${count != 0 }">
						<a  class="tooltipLink" onclick="changeStyle('${order400.columns.number}')"  >
							<i class="sficon sficon-note"></i>已发送<span class="va-t">${count }</span>条短信
						</a>
					</c:if>
					<c:if test="${order400.columns.print_times != 0 }">
						<a  class="tooltipLink" >
							<i class="sficon sficon-note"></i>已打印<span class="va-t">${order400.columns.print_times }</span>次
						</a>
					</c:if>
					<div class="f-r pos-r" style="bottom:8px;">
						<%--<a href="javascript:;" onclick="senMagPopup('${order400.columns.id }')" class="sfbtn sfbtn-opt w-80 mr-10">短信通知</a>--%>
							<sfTags:pagePermission authFlag="ORDER_2017ORDER_400ORDER_PRINTONE_BTN" html='<a href="javascript:;" onclick="dygd(\'${order400.columns.id }\')" id="repeteWrite"  class="sfbtn sfbtn-opt w-80 mr-10">打印工单</a>'></sfTags:pagePermission>
						<a href="javascript:;" onclick="dygdcustom('${order400.columns.id }')"  id="repeatOrder_custom" style="display: none;" class="sfbtn sfbtn-opt w-80 mr-10">打印工单</a>
						<sfTags:pagePermission authFlag="ORDER_MARKORDER_BTN_OTHERS" html='<a href="javascript:;" onclick="showMarkOrder400(\'${order400.columns.id }\')" class="sfbtn sfbtn-opt w-80 mr-10">标记工单</a>'></sfTags:pagePermission>
					</div>
				</div>
				<div class="cl mt-10">
					<div class="f-l pos-r txtwrap1">
						<label class="lb lb1">工单编号：</label>
						<input type="text" class="input-text w-140 readonly" readonly="readonly" unselectable="on" value="${order400.columns.number }" />
						<input type="hidden" value="${order400.columns.id }" id="order400Id" />
						<input type="hidden" class="input-text w-140" id="sign"   value=""/> 
						<input type="hidden" class="input-text w-140"  id="siteMsgNums" value=""/> 
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">服务类型：</label>
						<input type="text" class="input-text w-140 readonly" readonly="readonly" unselectable="on" value="${order400.columns.service_type }" />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">服务方式：</label>
						<input type="text" class="input-text w-140 readonly" readonly="readonly" unselectable="on" value="${order400.columns.mode }" />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">信息来源：</label>
						<input type="text" class="input-text w-140 readonly" readonly="readonly" unselectable="on" value="${order400.columns.origin }" />
					</div>
				</div>
				<div class="cl mt-10">
					<div class="f-l pos-r txtwrap1">
						<label class="lb lb1">用户姓名：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.customer_name }" />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">联系方式1：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" id="customerMobile" value="${order400.columns.customer_mobile }" />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">联系方式2：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.customer_telephone }" />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">联系方式3：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.customer_telephone2 }" />
					</div>
				</div>
				<div class="cl mt-10">
					<div class="f-l pos-r txtwrap1">
						<label class="lb lb1">详细地址：</label>
						<input type="text" class="input-text readonly" style="width:367px" disabled="disabled"  value="${order400.columns.customer_address }"/>
					</div>
				</div>
				<div class="cl mt-10">
					<div class="f-l pos-r txtwrap1">
						<label class="lb lb1">家电品牌：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled"  value="${order400.columns.appliance_brand }"/>
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">家电品类：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled"  value="${order400.columns.appliance_category }"/>
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">预约日期：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="<fmt:formatDate value="${order400.columns.promise_time }" pattern="yyyy-MM-dd HH:mm:ss"/>"  />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">时间要求：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.promise_limit }" />
					</div>
				</div>
				<div class="cl mt-10">
					<div class="f-l pos-r txtwrap1 h-50">
						<label class="lb lb1">服务描述：</label>
						<textarea type="text" class="input-text h-50 readonly" style="width:367px" disabled="disabled"  value="">${order400.columns.customer_feedback }</textarea>
					</div>
					<div class="f-l pos-r txtwrap2 h-50">
						<label class="lb lb2">备注：</label>
						<textarea type="text" class="input-text h-50 readonly" style="width:370px" disabled="disabled" value="">${order400.columns.remarks }</textarea>
					</div>
				</div>
				<div class="cl mt-10">
					<div class="f-l pos-r txtwrap1">
						<label class="lb lb1">产品型号：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.appliance_model }" />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">产品数量：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.appliance_num }" />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">内机条码：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.appliance_barcode }" />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">外机条码：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.appliance_machine_code }" />
					</div>
				</div>
				<div class="cl mt-10">
					<div class="f-l pos-r txtwrap1">
						<label class="lb lb1">购买日期：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.appliance_buy_time }" />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">保修类型：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.warranty_type }" />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">重要程度：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.important }"  />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">报修时间：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="<fmt:formatDate value="${order400.columns.repair_time }" pattern="yyyy-MM-dd HH:mm:ss"/>" />
					</div>
				</div>
				<div class="cl mt-10">
					<div class="f-l pos-r txtwrap1">
						<label class="lb lb1">登记人：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.create_by }" />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">服务过程：</label>
						<input type="text" class="input-text readonly" style="width: 369px;" disabled="disabled" value="${order400.columns.process_detail }" />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">完工时间：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled"  value="<fmt:formatDate value="${order400.columns.end_time }" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
					</div>
				</div>
				<div id="serveFb" class="mt-25">
				<div class="tabBarP mt-15">
					<a href="javascript:;" class="tabswitch current">派工信息</a>
					<a href="javascript:showSYMsg();" class="tabswitch ">备件使用</a>
					<a href="javascript:showOldFitting();" class="tabswitch">旧件信息</a>
				</div>
				<div class="tabCon" style="height: 250px;overflow: auto">
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">派工时间：</label>
							<input type="text" class="input-text w-140 readonly" disabled="disabled" value="<fmt:formatDate value="${order400.columns.dispatch_time }" pattern="yyyy-MM-dd HH:mm:ss"/>"  />
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">服务工程师：</label>
							<input type="text" class="input-text w-140 readonly" disabled="disabled"  value="${order400.columns.employe1 }${order400.columns.employe2 }${order400.columns.employe3 }"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">工单状态：</label>
							<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.status }"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">故障现象：</label>
							<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.malfunction_type }" />
						</div>
					</div>
					<!-- <div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">收费总额：</label>
							<div class="priceWrap w-140 readonly">
								<input type="text" class="input-text readonly" disabled="disabled" value="" />
								<span class="unit">元</span>
							</div>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">服务收费：</label>
							<div class="priceWrap w-140 readonly">
								<input type="text" class="input-text readonly" disabled="disabled" value="" />
								<span class="unit">元</span>
							</div>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">辅材收费：</label>
							<div class="priceWrap w-140 readonly">
								<input type="text" class="input-text readonly" disabled="disabled"  />
								<span class="unit">元</span>
							</div>
						</div>
						
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">延保收费：</label>
							<div class="priceWrap w-140 readonly">
								<input type="text" class="input-text readonly" disabled="disabled"  />
								<span class="unit">元</span>
							</div>
						</div>
					</div> -->
					<div class="cl mt-10">
						<div class="pos-r txtwrap1 pr-5">
							<label class="lb lb1">反馈内容：</label>
							<div class="readonly processWrap2">
								<p class="processItem">
									<span class="time"><fmt:formatDate value="${order400.columns.feedback_time }" pattern="yyyy-MM-dd HH:mm:ss"/>  </span>
									<span>${order400.columns.feedback }</span>
								</p>
								<!-- <p class="processItem">
									<span class="time">2017-04-26  10:12  </span>
									<span>张三：需要回去拿配件，已和用户沟通过，明天上门维修</span>
								</p> -->
							</div>
						</div>
					</div>
				</div>
				<div class="tabCon" style="height: 250px;overflow: auto">
					<div style="width: 910px;overflow: auto;">
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
				
				<div class="tabCon" style="height: 250px;overflow: auto">
					<div style="width: 800px;">
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
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 待派工工单下和服务中工单下 -->
<div class="popupBox msgText msgText1" style="height:470px;" >
	<h2 class="popupHead">
		发送短信
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer" style="height:430px;overflow:auto;">
		<div class="popupMain pd-20" id="msgWrap" >
			<div class="tabBarP ">
				<a href="javascript:;" class="tabswitch current">模板发送</a>
				<a href="javascript:;" class="tabswitch ">编辑发送</a>
			</div>
			<div class="tabCon">
				<div class="pos-r pl-70 pr-80 mt-10">
					<label class="lb w-70 text-r">选择模板：</label>
					<span class="select-box w-160">
						<select class="select radius h-26" id="select-msgmode" name="selectModel" onchange="selectMsgMould(this)">
							<%-- <c:forEach items="${listModel }" var="lm">
								<c:if test="${lm.columns.tag eq 6 }">
									<option value="${lm.columns.tag }">上门前</option>
								</c:if>
								<c:if test="${lm.columns.tag eq 4 }">
									<option value="${lm.columns.tag }">电话无人接听</option>
								</c:if>
								<c:if test="${lm.columns.tag eq 3 }">
									<option value="${lm.columns.tag }">改约</option>
								</c:if>
								<c:if test="${lm.columns.tag eq 2 }">
									<option value="${lm.columns.tag }">缺件</option>
								</c:if>
								<c:if test="${lm.columns.tag eq 5 }">
									<option value="${lm.columns.tag }">回访</option>
								</c:if>
							</c:forEach> --%>
							
							<c:forEach items="${listModel }" var="lm6">
								<c:if test="${lm6.columns.tag eq 6 }">
									<option value="${lm6.columns.tag }">上门前</option>
								</c:if>
							</c:forEach>
							<c:forEach items="${listModel }" var="lm7">
								<c:if test="${lm7.columns.tag eq 7 }">
									<option value="${lm7.columns.tag }">增值产品</option>
								</c:if>
							</c:forEach>
							<c:forEach items="${listModel }" var="lm4">
								<c:if test="${lm4.columns.tag eq 4 }">
									<option value="${lm4.columns.tag }">电话无人接听</option>
								</c:if>
							</c:forEach>
							<c:forEach items="${listModel }" var="lm4">
								<c:if test="${lm4.columns.tag eq 9 }">
									<option value="${lm4.columns.tag }">配件无人接听</option>
								</c:if>
							</c:forEach>
							<c:forEach items="${listModel }" var="lm3">
								<c:if test="${lm3.columns.tag eq 3 }">
									<option value="${lm3.columns.tag }">改约</option>
								</c:if>
							</c:forEach>
							<c:forEach items="${listModel }" var="lm2">
								<c:if test="${lm2.columns.tag eq 2 }">
									<option value="${lm2.columns.tag }">缺件</option>
								</c:if>
							</c:forEach>
							<c:forEach items="${listModel }" var="lm2">
								<c:if test="${lm2.columns.tag eq 5 }">
									<option value="${lm2.columns.tag }">回访</option>
								</c:if>
							</c:forEach>
							<!-- <option value="0">上门前</option>
							<option value="1">电话无人接听</option>
							<option value="2">改约</option>
							<option value="3">缺件</option>
							<option value="4">缺件</option> -->
						</select>
					</span>
				</div>
				<div class="msgmould">
					<div class="pos-r pl-70 pr-80 mt-10">
						<span class="lb w-70 text-c">发送内容：<span class="c-0383dc">（模板一）</span></span>
						<div class="bk-gray pd-10">
							<input type="text" class="msg-input" id="custName" value="${order400.columns.customer_name }"  onkeyup="inputWidth(this)" />您好，
							您的<input type="text" class="msg-input" id="yw" value="${serviceType }"  onkeyup="inputWidth(this)"/>业务
							<input type="text" class="msg-input" id="siteName" value="${siteName }"  onkeyup="inputWidth(this)"/>已受理，
							<input type="text" class="msg-input" id="emNameMobile" value="${msg1 }" onkeyup="inputWidth(this)"/>，
							将为您提供服务，请保持电话通畅，监督电话：
							<input type="text" class="msg-input" id="jdMobile" value="${jdPhone }" onkeyup="inputWidth(this)"/>。
							【<input type="text" class="msg-input" value="${serviceName }" id="sign1" onkeyup="inputWidth(this)"/>服务】
						</div>	
						<div id="sendModel1">
							
						</div>
					</div>
					<div class="pos-r pl-70 pr-80 mt-10">
						<span class="lb w-70 text-c">发送内容：<span class="c-0383dc">（模板二）</span></span>
						<div class="bk-gray pd-10">
							尊敬的用户：您的信息<input type="text" class="msg-input" id="custNameMobile" value="${siteName }(${jdPhone }) " onkeyup="inputWidth(this)"/>
							已经派工，服务工程师<input type="text" class="msg-input" id="emName" value="${msg2Names }" onkeyup="inputWidth(this)"/>，
							联系电话<input type="text" class="msg-input" id="emMobile" value="${msg2Mobiles }" onkeyup="inputWidth(this)"/>，
							请您对我们的服务进行监督！
							【<input type="text" class="msg-input" value="${serviceName }" id="sign2" onkeyup="inputWidth(this)"/>服务】
						</div>
						<div id="sendModel2">	</div>
					</div>
				</div>
				<div class="msgmould hide">
					<div class="pos-r pl-70 pr-80 mt-10">
						<span class="lb w-70 text-c">发送内容：<span class="c-0383dc">（模板一）</span></span>
						<div class="bk-gray pd-10">
							尊敬的<input type="text" class="msg-input" id="custName" value="${order400.columns.customer_name }"  onkeyup="inputWidth(this)" />您好，
							您的<input type="text" class="msg-input" id="yw" value="${serviceType }"  onkeyup="inputWidth(this)"/>业务，我司已受理，
							指派<input type="text" class="msg-input"  value="${msg1 }" onkeyup="inputWidth(this)"/>为您服务，
							<input type="text" class="msg-input" id="mode1" value="另有安全用电家电伴侣产品等为您提供试用">，详情咨询上门工程师。
							【<input type="text" class="msg-input" value="${serviceName }" id="sign10" onkeyup="inputWidth(this)"/>服务】
						</div>	
						<div id="sendModel7">
							
						</div>
					</div>
					<div class="pos-r pl-70 pr-80 mt-10">
						<span class="lb w-70 text-c">发送内容：<span class="c-0383dc">（模板二）</span></span>
						<div class="bk-gray pd-10">
							尊敬的<input type="text" class="msg-input" id="custName" value="${order400.columns.customer_name }"  onkeyup="inputWidth(this)" />您好，
							您的<input type="text" class="msg-input" id="yw" value="${serviceType }"  onkeyup="inputWidth(this)"/>业务，我司已受理，
							指派<input type="text" class="msg-input"  value="${msg1 }" onkeyup="inputWidth(this)"/>为您服务，
							<input type="text" class="msg-input" id="mode2" value="另有专用自动止水水龙头和底座，可有效防止漏水和延长家电使用寿命">，详情咨询上门工程师。
							【<input type="text" class="msg-input" value="${serviceName }" id="sign11" onkeyup="inputWidth(this)"/>服务】
						</div>	
						<div id="sendModel8">	</div>
					</div>
					<div class="pos-r pl-70 pr-80 mt-10">
						<span class="lb w-70 text-c">发送内容：<span class="c-0383dc">（模板三）</span></span>
						<div class="bk-gray pd-10">
							尊敬的<input type="text" class="msg-input" id="custName" value="${order400.columns.customer_name }"  onkeyup="inputWidth(this)" />您好，
							您的<input type="text" class="msg-input" id="yw" value="${serviceType }"  onkeyup="inputWidth(this)"/>业务，我司已受理，
							指派<input type="text" class="msg-input"  value="${msg1 }" onkeyup="inputWidth(this)"/>为您服务，
							<input type="text" class="msg-input" id="mode3" value="另有安全用电家电伴侣产品等为您提供试用，使您拥有最安心的家电使用体验，">
							<input type="text" class="msg-input" id="mode4" value="洗衣机专用自动止水水龙头和洗衣机底座，可有效防止水淹事故导致财产损失，延长家电安全使用寿命">，详情咨询上门工程师。
							【<input type="text" class="msg-input" value="${serviceName }" id="sign12" onkeyup="inputWidth(this)"/>服务】
						</div>	
						<div id="sendModel9">	</div>
					</div>
				</div>
				
				<div class="hide msgmould">
					<div class="pos-r pl-70 pr-80 mt-10">
						<span class="lb w-70 text-c">发送内容：</span>
						<div class="bk-gray pd-10">
							尊敬的用户，您的电话无法接通状态，请您在方便的时候回复
							<input type="text" class="msg-input" id="siteMobile" value="${jdPhone }" onkeyup="inputWidth(this)"/>
							或服务工程师电话<input type="text" class="msg-input" value="${msg1 }" onkeyup="inputWidth(this)"/>,
							我们将尽快为您提供满意的服务！
							【<input type="text" class="msg-input" value="${serviceName }" id="sign3" onkeyup="inputWidth(this)"/>服务】
						</div>	
						<div id="sendModel3">	</div>
					</div>
				</div>
				<!-- 配件无人接听 -->
				<div class="hide msgmould">
					<div class="pos-r pl-70 pr-80 mt-10">
						<span class="lb w-70 text-c">发送内容：</span>
						<div class="bk-gray pd-10">
							你好，你购买的商品
							<input type="text" class="msg-input" id="goodsTime" value="今天" onkeyup="inputWidth(this)"/>到
							<input type="text" class="msg-input" value="${siteArea }" id="pjArea" onkeyup="inputWidth(this)"/>,联系你电话无人接听，看到短信后请联系
							<input type="text" class="msg-input" value="${siteMobile }" id="pjMobile" onkeyup="inputWidth(this)"/>。
							【<input type="text" class="msg-input" value="${serviceName }" id="sign20" onkeyup="inputWidth(this)"/>服务】
						</div>	
						<div id="sendModel20">	</div>
					</div>
				</div>
				<div class="hide msgmould">
					<div class="pos-r pl-70 pr-80 mt-10">
						<span class="lb w-70 text-c">发送内容：</span>
						<div class="bk-gray pd-10">
							<input type="text" class="msg-input" value="${order400.columns.customer_name }" onkeyup="inputWidth(this)"/>您好，
							您的预约时间已改至<input type="text" class="msg-input" id="proTime" value="${proTime } "  onkeyup="inputWidth(this)"/>，
							<input type="text" class="msg-input" id="promiseLimit" value="${order400.columns.promise_limit }" onkeyup="inputWidth(this)"/>，
							具体上门时间，<input type="text" class="msg-input" value="${msg1}" onkeyup="inputWidth(this)"/>，
							会与您联系的，监督电话：<input type="text" class="msg-input" value="${jdPhone }" onkeyup="inputWidth(this)"/>。
							【<input type="text" class="msg-input" value="${serviceName }" id="sign4" onkeyup="inputWidth(this)"/>服务】
						</div>	
						<div id="sendModel4">	</div>
					</div>
				</div>
				<div class="hide msgmould">
					<div class="pos-r pl-70 pr-80 mt-10">
						<span class="lb w-70 text-c">发送内容：</span>
						<div class="bk-gray pd-10">
							<input type="text" class="msg-input" value="${order400.columns.customer_name }" onkeyup="inputWidth(this)"/>您好，
							因店内配件无库存，现已紧急调度，配件到位后，具体上门时间，
							<input type="text" class="msg-input" value="${msg1}" onkeyup="inputWidth(this)"/>，
							会与您联系的，监督电话：<input type="text" class="msg-input" value="${jdPhone }" onkeyup="inputWidth(this)"/>。
							【<input type="text" class="msg-input" value="${serviceName }" id="sign5" onkeyup="inputWidth(this)"/>服务】
						</div>	
						<div id="sendModel5">	</div>
					</div>
				</div>
				<div class="hide msgmould">
					<div class="pos-r pl-70 pr-80 mt-10">
						<span class="lb w-70 text-c">发送内容：</span>
						<div class="bk-gray pd-10">
							<input type="text" class="msg-input"  value="${order400.columns.customer_name }" onkeyup="inputWidth(this)" />你好，
							<input type="text" class="msg-input"  value="${siteName }${jdPhone }" onkeyup="inputWidth(this)"/>
							诚邀您回复数字对本次服务进行评：1.满意；2.一般；3.不满意；4.尚未联系；5.正在处理中，还未处理好。感谢您的支持！
							【<input type="text" class="msg-input" value="${serviceName }" id="sign6" onkeyup="inputWidth(this)"/>服务】
						</div>	
						<div id="sendModel6">
						</div>
					</div>
				</div>
			</div>
			<div class="tabCon">
				<p class="c-f55025 f-12 lh-30">
					注：自定义文字内容需要人工审核，等待时间较长
				</p>
				<div class="pr-80 pos-r">
					<div class="bk-gray" >
						<textarea class="textarea radius" placeholder="请输入短信内容" id="content" style="border-width: 0; height: 60px;"></textarea>
						<div class="h-26">
							<p class="f-r">【<input type="text" class="msg-input"  value="${serviceName }" id="sign7" onkeyup="inputWidth(this)"/>服务】</p>
						</div>
					</div>
					<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg  " onclick="sendMsg()">发送</a>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="popupBox msgText msgTextQuren" >
	<h2 class="popupHead">
		短信确认
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pd-20"  >
			<div class="lh-26">
				<div>您确定给<span id="peoples" style="color: #999;" class="f-14"></span>发送</div>
				<div style="min-height:100px; text-indent:2em;color: #999;" id="sendContent" ></div> 
			</div>
			<div class="text-c mt-25 " id="clickSend">
				
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef" ></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript">
var definedContentTz="";
var orderMsgId="";
var orderMsgMobile="";
var mark = '${msg4}';
$(function(){
	var content1="@您好，您的@业务@已受理，@，将为您提供服务，请保持电话通畅，监督电话：@。【@服务】";
	var content2="尊敬的用户：您的信息@已经派工，服务工程师@，联系电话@，请您对我们的服务进行监督！【@服务】";
	$("#sendModel1").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick=sendModel1("2","6","'+content1+'") >发送</a>');
	$("#sendModel2").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick=sendModel1("3","6","'+content2+'") >发送</a>');
	if($.trim('${order400.columns.customer_mobile}')!=null && $.trim('${order400.columns.customer_mobile}')!="" ){
		orderMsgMobile=$.trim('${order400.columns.customer_mobile}');
	} 
	orderMsgId='${order400.columns.id}';
	$.post("${ctx}/order/remainMsgNum",{},function(result){
		$("#sign").val(result.columns.sms_sign);//签名
		$("#siteMsgNums").val(result.columns.sms_available_amount);//服务商剩余可发送短信总数
	});
	$.Huitab("#serveFb .tabBarP .tabswitch","#serveFb .tabCon","current","click","0");
	$('.orderdetailVb').popup({fixedHeight:false});
	
	  judgedygd();
});
	
function zzj(){
	var id = $("#order400Id").val();
	layer.open({
		type : 2,
		content:'${ctx}/order/ChangeSelfOrder/oneZzj?id='+id,
		title:false,
		area: ['100%','100%'],
		closeBtn:0,
		shade:0,
		anim:-1 
	});
}

								/*短信通知*/
 function openSendMsg(orderId){
		orderMsgId = orderId;
		$.Huitab("#msgWrap .tabBarP .tabswitch","#msgWrap .tabCon","current","click","0");
		$('.msg-input').each(function(){
			inputWidth(this);
		});
		$('.msgText1').popup({level:4,closeSelfOnly:true});
	}
	
 function inputWidth(obj){
		var textValue = obj.value,
			textLength = textValue.length,
			charCode = -1;
		var charLen = textValue.replace(/[^\x00-\xff]/g,"**").length;

		var minWidth = charLen*7 >10?charLen*7 : 10;
		minWidth = minWidth>448?448:minWidth;
		$(obj).css({'width':minWidth + 'px'});
	}
 
	// 下拉框切换模板
	function selectMsgMould(obj){
		var tag;
		var aDiv = $('.msgText1 .msgmould');
		var index = obj.selectedIndex;
		var tag = $('#select-msgmode option:selected') .val();
		$.ajax({
			type:"POST",
			url:"${ctx }/order/getTag",
			data:{tag:tag},
			success:function(result){
				if(tag==6){
						if(result[0].columns.id==2){
							$("#sendModel1").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" >发送</a>');
						}else{
							$("#sendModel2").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[1].columns.id+'\',\''+result[1].columns.tag+'\',\''+result[1].columns.content+'\',3)" >发送</a>');
						}
						if(result[1].columns.id="2"){
							$("#sendModel1").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[1].columns.id+'\',\''+result[1].columns.tag+'\',\''+result[1].columns.content+'\',3)" >发送</a>');
						}else{
							$("#sendModel2").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" >发送</a>');
						}
				}else if(tag==4){
					$("#sendModel3").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" >发送</a>');
				}else if(tag==3){
					$("#sendModel4").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" >发送</a>');
				}else if(tag==2){
					$("#sendModel5").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" >发送</a>');
				}else if(tag==5){
					$("#sendModel6").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" >发送</a>');
				}else if(tag==7){
					//$("#mode1").text('另有安全用电家电伴侣产品等为您提供试用');
					//$("#mode2").text('另有专用自动止水水龙头和底座，可有效防止漏水和延长家电使用寿命');
					$("#sendModel7").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',1)" >发送</a>');
					$("#sendModel8").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',2)" >发送</a>');
					$("#sendModel9").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',0)" >发送</a>');
				}else if(tag==9){
					$("#sendModel20").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" >发送</a>');
				}else if(tag==11){
					
				}
			}
		});
		aDiv.hide().eq(index).show();
	}
	
	var afl = false;
	function sendModel1(id,tag,content,mode){
		$("#clickSend").empty();
		if(afl) {
		    return;
	    }
		var siteMsgNums = $("#siteMsgNums").val();//服务商已购还有短信数
		var custName = $("#custName").val();
		var mode1 = $("#mode1").val();
		var mode2 = $("#mode2").val();
		var mode3 = $("#mode3").val();
		var mode4 = $("#mode4").val();
		var goodsTime = $("#goodsTime").val();
		var pjArea = $("#pjArea").val();
		var pjMobile = $("#pjMobile").val();
		var yw = $("#yw").val();
		var siteName = $("#siteName").val();
		var jdMobile = $("#jdMobile").val();
		var emName = $("#emName").val();//工程师集合
		var emMobile = $("#emMobile").val();//电话集合
		var proTime = $("#proTime").val();
		var promiseLimit = $("#promiseLimit").val();
		var siteMobile = $("#siteMobile").val();
		var custNameMobile = $("#custNameMobile").val();
		var customerMobile = $("#customerMobile").val();//用户联系方式
		var sign = $.trim($("#sign").val());
		var emNameMobile = $("#emNameMobile").val();//工程师、加电话集合
		// 查询出"@"的所有位置
        var path_1 = content.indexOf("@");// 第一个位置
        var path_2 = path_1 + content.substring(path_1 + 1).indexOf("@") + 1;// 第二个位置
        var path_3 = path_2 + content.substring(path_2 + 1).indexOf("@") + 1;// 第三个位置
        var path_4 = path_3 + content.substring(path_3 + 1).indexOf("@") + 1;// 第四个位置
        var path_5 = path_4 + content.substring(path_4 + 1).indexOf("@") + 1;// 第四个位置
        var path_6 = path_5 + content.substring(path_5 + 1).indexOf("@") + 1;// 第四个位置
        var s_temp;
		if(id==2){//模板一
			if(mark=="no"){
				layer.msg("工单中没有维护的服务工程师，请先到运营管理下的员工信息管理页面维护！");
				return;
			}
			if($.trim($("#sign1").val())=="" || $("#sign1").val()==null){
				layer.msg("短信签名不能为空！");
				$("#sign1").focus();
				return;
			}
			if($.trim($("#sign1").val()).length>6){
				layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
				$("#sign1").focus();
				return;
			}
			sign=$.trim($("#sign1").val());
			s_temp = content.substring(0, path_1) + custName
            + content.substring(path_1 + 1, path_2) + yw
            + content.substring(path_2 + 1, path_3) + siteName
            + content.substring(path_3 + 1, path_4) + emNameMobile
            + content.substring(path_4 + 1, path_5) + jdMobile
            + content.substring(path_5 + 1, path_6) + sign
            + content.substring(path_6 + 1);
			
		}else if(id==3){//模板二
			if(mark=="no"){
				layer.msg("工单中没有维护的服务工程师，请先到运营管理下的员工信息管理页面维护！");
				return;
			}
			if($.trim($("#sign2").val())=="" || $("#sign2").val()==null){
				layer.msg("短信签名不能为空！");
				$("#sign2").focus();
				return;
			}
			if($.trim($("#sign2").val()).length>6){
				layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
				$("#sign2").focus();
				return;
			}
			sign=$.trim($("#sign2").val());
			s_temp = content.substring(0, path_1) + custNameMobile 
            + content.substring(path_1 + 1, path_2) + emName
            + content.substring(path_2 + 1, path_3) + emMobile
            + content.substring(path_3 + 1, path_4) + sign
            + content.substring(path_4 + 1);
			
		}else if(id==4){//无法接通
			if(mark=="no"){
				layer.msg("工单中没有维护的服务工程师，请先到运营管理下的员工信息管理页面维护！");
				return;
			}
			if($.trim($("#sign3").val())=="" || $("#sign3").val()==null){
				layer.msg("短信签名不能为空！");
				$("#sign3").focus();
				return;
			}
			if($.trim($("#sign3").val()).length>6){
				layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
				$("#sign3").focus();
				return;
			}
			sign=$.trim($("#sign3").val());
			s_temp = content.substring(0, path_1) + siteMobile
            + content.substring(path_1 + 1, path_2) + emNameMobile
            + content.substring(path_2 + 1, path_3) + sign
            + content.substring(path_3 + 1);
			
		}else if(id==12){//配件无法接通
			/* if(mark=="no"){
				layer.msg("工单中没有维护的服务工程师，请先到运营管理下的员工信息管理页面维护！");
				return;
			} */
			if($.trim(pjMobile)=="" || pjMobile==null){
				layer.msg("联系电话不能为空！");
				$("#pjMobile").focus();
				return;
			}
			if($.trim($("#sign20").val())=="" || $("#sign20").val()==null){
				layer.msg("短信签名不能为空！");
				$("#sign20").focus();
				return;
			}
			if($.trim($("#sign20").val()).length>6){
				layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
				$("#sign20").focus();
				return;
			}
			sign=$.trim($("#sign20").val());
			s_temp = content.substring(0, path_1) + goodsTime
            + content.substring(path_1 + 1, path_2) + pjArea
            + content.substring(path_2 + 1, path_3) + pjMobile
            + content.substring(path_3 + 1, path_4) + sign
            + content.substring(path_4 + 1);
		}else if(id==5){//改约
			if(mark=="no"){
				layer.msg("工单中没有维护的服务工程师，请先到运营管理下的员工信息管理页面维护！");
				return;
			}
			if($.trim($("#sign4").val())=="" || $("#sign4").val()==null){
				layer.msg("短信签名不能为空！");
				$("#sign4").focus();
				return;
			}
			if($.trim($("#sign4").val()).length>6){
				layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
				$("#sign4").focus();
				return;
			}
			sign=$.trim($("#sign4").val());
			s_temp = content.substring(0, path_1) + custName
            + content.substring(path_1 + 1, path_2) + proTime
            + content.substring(path_2 + 1, path_3) + promiseLimit
            + content.substring(path_3 + 1, path_4) + emNameMobile
            + content.substring(path_4 + 1, path_5) + jdMobile
            + content.substring(path_5 + 1, path_6) + sign
            + content.substring(path_6 + 1);
			
		}else if(id==6){//缺件
			if(mark=="no"){
				layer.msg("工单中没有维护的服务工程师，请先到运营管理下的员工信息管理页面维护！");
				return;
			}
			if($.trim($("#sign5").val())=="" || $("#sign5").val()==null){
				layer.msg("短信签名不能为空！");
				$("#sign5").focus();
				return;
			}
			if($.trim($("#sign5").val()).length>6){
				layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
				$("#sign5").focus();
				return;
			}
			sign=$.trim($("#sign5").val());
			s_temp = content.substring(0, path_1) + custName
            + content.substring(path_1 + 1, path_2) + emNameMobile
            + content.substring(path_2 + 1, path_3) + jdMobile
            + content.substring(path_3 + 1, path_4) + sign
            + content.substring(path_4 + 1);
		}else if(id==7){
			if($.trim($("#sign6").val())=="" || $("#sign6").val()==null){
				layer.msg("短信签名不能为空！");
				$("#sign6").focus();
				return;
			}
			if($.trim($("#sign6").val()).length>6){
				layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
				$("#sign6").focus();
				return;
			}
			sign=$.trim($("#sign6").val());
			s_temp = content.substring(0, path_1) + custName
	        + content.substring(path_1 + 1, path_2) + siteName+jdMobile
	        + content.substring(path_2 + 1, path_3) + sign
	        + content.substring(path_3 + 1);
		}else if(id==9){
			if(mode=="1"){
				if($.trim($("#sign10").val())=="" || $("#sign10").val()==null){
					layer.msg("短信签名不能为空！");
					$("#sign10").focus();
					return;
				}
				if($.trim($("#sign10").val()).length>6){
					layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
					$("#sign10").focus();
					return;
				}
				sign=$.trim($("#sign10").val());
				s_temp = content.substring(0, path_1) + custName
	            + content.substring(path_1 + 1, path_2) + yw
	            + content.substring(path_2 + 1, path_3) + emNameMobile
	            + content.substring(path_3 + 1, path_4) + mode1
	            + content.substring(path_4 + 1, path_5) + sign
	            + content.substring(path_5 + 1);
			}else if(mode=="2"){
				if($.trim($("#sign11").val())=="" || $("#sign11").val()==null){
					layer.msg("短信签名不能为空！");
					$("#sign11").focus();
					return;
				}
				if($.trim($("#sign11").val()).length>6){
					layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
					$("#sign11").focus();
					return;
				}
				sign=$.trim($("#sign11").val());
				s_temp = content.substring(0, path_1) + custName
	            + content.substring(path_1 + 1, path_2) + yw
	            + content.substring(path_2 + 1, path_3) + emNameMobile
	            + content.substring(path_3 + 1, path_4) + mode2
	            + content.substring(path_4 + 1, path_5) + sign
	            + content.substring(path_5 + 1);
			}else{
				if($.trim($("#sign12").val())=="" || $("#sign12").val()==null){
					layer.msg("短信签名不能为空！");
					$("#sign12").focus();
					return;
				}
				if($.trim($("#sign12").val()).length>6){
					layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
					$("#sign12").focus();
					return;
				}
				sign=$.trim($("#sign12").val());
				s_temp = content.substring(0, path_1) + custName
	            + content.substring(path_1 + 1, path_2) + yw
	            + content.substring(path_2 + 1, path_3) + emNameMobile
	            + content.substring(path_3 + 1, path_4) + mode3+mode4
	            + content.substring(path_4 + 1, path_5) + sign
	            + content.substring(path_5 + 1);
			}
		}
		if($.trim(customerMobile).length==11 && $.trim(customerMobile).substring(0,1)=="1"){
			afl = true;
			$.ajax({//check短信为几条，并对比看服务商已购买短信够不够发送
				type:"POST",
				//traditional:true,
				url:"${ctx }/order/msgNumbers",
				data:{content:s_temp,
					sign:sign},
				success:function(result){
					if(parseInt(result)>parseInt(siteMsgNums)){//发送短信数大于购买数
						layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
					}else{
						$("#peoples").html('${order400.columns.customer_name}');
						$("#sendContent").text("“"+s_temp+"”？");
						$("#clickSend").append('<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70  " onclick="sendConfirmMsgModel(\''+id+'\',\''+sign+'\',\''+s_temp+'\',\''+tag+'\',\''+orderMsgId+'\',\''+customerMobile+'\')" >确定</a>&nbsp;&nbsp;'+
								'<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="cancelQuren" onclick="cancelQueren()">取消</a>');
						$(".msgTextQuren").popup({level:5,closeSelfOnly:true});
					}
				},
	            complete: function() {
	                afl = false;
	            }
			})
		}else if($.trim(customerMobile)==""){
			layer.msg("请填写用户的手机号码！");
		}else{
			layer.msg("用户的手机号码格式不正确，请重新填写！");
		}
	}
	
	var  aflModel = false;
	function sendConfirmMsgModel(id,sign,s_temp,tag,orderMsgId,customerMobile){
		if(aflModel){
			return;
		}
		aflModel = true;;
		$.ajax({
			type:"POST",
			url:"${ctx }/order/fwzSendmsgModel",
			data:{temId:id,
				sign:sign,
				content:s_temp,
				extno:tag,
				orderId:orderMsgId,
				customerMobile:customerMobile
				},
			success:function(result){
				if(result=="ok"){
					layer.msg("发送成功!");
					$.closeDiv($(".msgText1"));
					window.location.reload();
				}else if(result=="noMessage"){
					layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
					return;
				} else{
					layer.msg("发送失败，请稍后重试!");
				}
			},
            complete: function() {
            	aflModel = false;
            }
		})
	}
	
	function inputWidth(obj){
		var textValue = obj.value,
			textLength = textValue.length,
			charCode = -1;
		var charLen = textValue.replace(/[^\x00-\xff]/g,"**").length;

		var minWidth = charLen*7 >10?charLen*7 : 10;
		minWidth = minWidth>448?448:minWidth;
		$(obj).css({'width':minWidth + 'px'});
	}
	

	function dygd(id){
		//使用默认
		window.open("${ctx}/print/order400For2017?orderId="+id);
	}

	function dygdcustom(id){
		$.ajax({
			type : 'POST',
			url : "${ctx}/order/printdesign/getOldOrderKeyName400",
			data : {orderId:id},
			datatype:"JSON",
			success : function(data) {
				if(data == null || data.content == null || data.content.length<=0){
					var newTab=window.open('about:blank');
					newTab.location.href="${ctx}/print/order400For2017?orderId="+id;
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
					$("#repeteWrite").hide();
					$("#repeatOrder_custom").show();
					return
				}else{
					$("#repeteWrite").show();
					$("#repeatOrder_custom").hide();
				}
			
			}

		});
	}
	
	var afs= false;
	function sendMsg(){
		if(afs) {
		    return;
	    }
		var siteMsgNums = $("#siteMsgNums").val();//服务商已购还有短信数
		var sign = $.trim($("#sign").val());
		
		if($.trim($("#sign7").val())=="" || $("#sign").val()==null){
			layer.msg("短信签名不能为空！");
			$("#sign7").focus();
			return;
		}
		if($.trim($("#sign7").val()).length>6){
			layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
			$("#sign7").focus();
			return;
		}
		sign=$.trim($("#sign7").val());
		var customerMobile = $("#customerMobile").val();//用户联系方式
		if($.trim(customerMobile).length==11 && $.trim(customerMobile).substring(0,1)=="1"){
			//自定义模板
			var content = $("#content").val();
			if($.trim(content)=="" || content==null){
				layer.msg("自定义发送短信内容不能为空");
				$("#content").focus();
				return;
			}
			afs = true;
			$.ajax({//check短信为几条，并对比看服务商已购买短信够不够发送
				type:"POST",
				//traditional:true,
				url:"${ctx }/order/msgNumbers",
				data:{content:content,
					sign:sign},
				success:function(result){
					if(parseInt(result)>parseInt(siteMsgNums)){//发送短信数大于购买数
						layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
					}else{
						$("#peoples").html('${order400.columns.customer_name}');
						definedContentTz=content;
						$("#sendContent").text("“"+$("#content").val()+"”？");
						$("#clickSend").append('<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70  " onclick="sendMsgNoModel(\''+sign+'\',\''+orderMsgMobile+'\',\''+orderMsgId+'\')" >确定</a>&nbsp;&nbsp;'+
								'<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="cancelQuren" onclick="cancelQueren()">取消</a>');
						$(".msgTextQuren").popup({level:5,closeSelfOnly:true});	
					}
				},
	            complete: function() {
	                afs = false;
	            }
				
			});
		}else if($.trim(customerMobile)==""){
			layer.msg("请填写用户的手机号码！");
		}else{
			layer.msg("用户的手机号码格式不正确，请重新填写！");
		}
	}
	
	var afsNoModel=false;
	function sendMsgNoModel(sign,orderMsgMobile,orderMsgId){
		if(afsNoModel){
			return;
		}
		afsNoModel=true;
		$.ajax({
			type:"POST",
			url:"${ctx }/order/fwzSendmsg",
			data:{content:definedContentTz,
				sign:sign,
				orderMsgMobile:orderMsgMobile,
				orderMsgId:orderMsgId
				},
			success:function(result){
				if(result=="ok"){
					layer.msg("发送成功!");
					$.closeDiv($(".msgText1"));
					window.location.reload();
				}else if(result=="noMessage"){
					layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
					return;
				} else{
					layer.msg("发送失败，请稍后重试!");
				}
			},
            complete: function() {
            	afsNoModel = false;
            }
		});
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
            creatIframe('${ctx }/operate/sendedSms?orderNum='+orderNum+'&target=2','短信发送记录');
        }else{
            show_navLi.eq(bStopIndex).addClass('active');
            topWindow.find('#iframe_box .show_iframe').hide().eq(bStopIndex).show().find('iframe').attr({'src':'${ctx }/operate/sendedSms?orderNum='+orderNum+'&target=2'});
        }
	}
	
	//获取工单关联备件使用信息
	function showSYMsg(){
		fittingApply("pjsy");
	}
	
	function fittingApply(id){
		var orderId = "${order400.columns.id}";
		var str="";
		var imgstr="";
		var img = [];
		$.ajax({
			type:"post",
			url:"${ctx}/order/showSYMsg400",
			data:{orderId:orderId,remark:'SYMsg'},// 备注信息 wxz 暂时取消，服务中的工单、待回访、待结算的工单中备件信息分为：使用的配件和申请的配件
			//dataType:'json',
			//async:false,
			success:function(result){
                $("#" + id).html("<caption>工单关联配件使用</caption>" +
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
				$.each(result.list,function(index,val){
                    str += "<tr>" +
                        "<td class='text-c w-140'>" + val.columns.fitting_code + "</td>" +
                        "<td class='text-c w-300'>" + val.columns.fitting_name + "</td>" +
                        "<td class='text-c w-120'>" + val.columns.fitting_version + "</td>" +
                        "<td class='text-c  w-90'>" + val.columns.site_price + "</td>" +
                        "<td class='text-c  w-80'>" + val.columns.employe_price + "</td>" +
                        "<td class='text-c  w-70'>" + val.columns.customer_price + "</td>" +
                        "<td class='text-c w-50'>×" + val.columns.used_num + "</td>" +
                        "<td class='text-c w-70'>" + val.columns.collection_money + "</td>";
//                    if(val.columns.warranty_type=="1"){
//                        str+="<td class='text-c  w-100'>保内使用</td>";
//                    }else if(val.columns.warranty_type=="2"){
//                        str+="<td class='text-c  w-100'>保外零售</td>";
//                    }else{
//                        str+="<td class='text-c  w-100'></td>";
//                    }
                    str+="<td class='text-c  w-100'>"+val.columns.use_type+"</td>";
					if(val.columns.status=="1"){
						str+="<td class='text-c c-fe0101 w-70'><i class='oState state-verifyPass'></i>待核销</td>";
					}else if(val.columns.status=="2"){
						str+="<td class='text-c c-fe0101 w-70'><i class='oState state-waitVerify'></i>已核销</td>";
					}
				});	
				}else{
					//$(".showimg").html("");
				}
				
				$("#"+id).append(str);
				return;
			}
			
		});
	}
	
	//获取工单关联旧件信息
	function showOldFitting(){
		var orderId = "${order400.columns.id}";
		var str="";
		var imgstr="";
		$.ajax({
			type:"post",
			url:"${ctx}/order/showOldFitting400",
			data:{orderId:orderId},
			//dataType:'json',
			//async:false,
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
						str+="<td class='w-30'>是</td>";
					}else if(val.columns.yrpz_flag=="2"){
						str+="<td class='w-30'>否</td>";
					}
					str+= "<td class='w-30'>×"+val.columns.num+"</td>";
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
 				
				}else{
					$("#oldfittingimg").html("");
				}
				
				$(".oldtbody").append(str);
                jQuery.getScript("${ctxPlugin}/static/h-ui.admin/js/imgShow.js", function(data, status, jqxhr) {
                    $("#oldfittingimg").append(imgstr);
                    $('#oldfittingimg').imgShow();
                });
				return;
			}
			
		});
	}

	function cancelQueren(){
		$.closeDiv($(".msgTextQuren"),true);
	}

function showMarkOrder400(id) {
    layer.open({
        type: 2,
        content: '${ctx}/order/showMarkOrdersFor2017?ids=' + id + "&type=400",
        title: false,
        area: ['100%', '100%'],
        closeBtn: 0,
        shade: 0,
        anim: -1
    });
}

function senMagPopup(id){
	layer.open({
        type : 2,
        content:'${ctx}/order/sendMsgAccounts400One?ids=' + id + '&type=1',
        title:false,
        area: ['100%','100%'],
        closeBtn:0,
        shade:0,
        anim:-1
    });
}
	
</script> 
</body>
</html>
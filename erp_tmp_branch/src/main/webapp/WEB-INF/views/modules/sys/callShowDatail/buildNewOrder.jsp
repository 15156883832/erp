<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui/css/H-ui.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/style.css" />

<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
<title>新建工单</title>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/sfskin_blue.css" />
	<meta name="decorator" content="base"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select2.min.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select2.full.min.js"></script>  
<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.cityselect.js"></script>
	<style type="text/css">
		.errorwran{
			display: none;
		}
		.Validform_wrong{
			display: block;
		}
		.Validform_right{
			display: none;
		}
	</style>
</head>

<body>

<!-- 新建工单 -->
<div class="tppage" style="width: 1000px; margin: 0 auto ;">
		<div class="popupMain pos-r" >
			<form id="neworderForm"  action="" method="post" >
			<div class="cl mt-10 mb-10">
				<div class="text-l f-l">
				</div>
				<div class="text-r f-r">
				<c:if test="${returnModel ne 1 }">
					<a href="javascript:;" onClick="javascript:history.back(-1);" class="sfbtn sfbtn-opt3 w-100">返回</a>
				</c:if>
					<a href="javascript:;" class="sfbtn sfbtn-opt3  w-100" id="btnNewOrder">保存</a>
					<input class="sfbtn sfbtn-opt3 w-100" value="重置" type="button" onclick="resetOrderForm();"/>
					<input class="sfbtn sfbtn-opt3 w-100"  value="直接派单" type="button" onclick="directDis()"/>
					<input class="sfbtn sfbtn-opt3 w-100" value="保存并打印" type="button" onclick="printView()"/>
					<input id="seriNo" name="seriNo" type="hidden" value="${seriNo }"/>
					<input id="telephone" name="telephone" type="hidden" value="${telephone }"/>
				</div>
			</div>
				<h3 class="modelHead">工单信息</h3>
				<div class="mt-10 cl h-50">	
					<c:if test="${orderNumSet != '200' }">
						<div class="f-l">
							<label class=""><em class="mark">*</em>工单编号：</label>
							<input type="text" class="input-text w-140 " maxlength="20" id="number" name="number" value="${number }" datatype="zimu" nullmsg = "请输入工单编号！" errormsg="格式错误！" ajaxurl="${ctx}/main/redirect/checkOrderNo"/>
							<p class="errorwran"></i>请输入有效的工单编号</p>
						</div>
						<div class="f-l">
							<label class="f-l w-100 text-r"><em class="mark">*</em>服务类型：</label>
							
							<select class="select w-140 mustfill" name="serviceType" id="serviceType" datatype="*" errormsg="请选择服务类型" nullmsg="请选择服务类型">
								<option value="">请选择</option>
								<c:forEach items="${ServiceType }" var="stype">
											<option value="${stype.columns.name }" ${order.serviceType eq stype.columns.name ?'selected':''} >${stype.columns.name }</option>
								</c:forEach>
							</select>
							
							<p class="errorwran ml-100">请选择服务类型</p>
							
						</div>
					</c:if>
					<c:if test="${orderNumSet == '200' }">
						<div class="f-l">
							<label class=""><em class="mark">*</em>服务类型：</label>
							
							<select class="select w-140 mustfill" name="serviceType" id="serviceType" datatype="*" errormsg="请选择服务类型" nullmsg="请选择服务类型">
								<option value="">请选择</option>
								<c:forEach items="${ServiceType }" var="stype">
											<option value="${stype.columns.name }" ${order.serviceType eq stype.columns.name ?'selected':''} >${stype.columns.name }</option>
								</c:forEach>
							</select>
							<p class="errorwran ml-100">请选择服务类型</p>
						</div>
					</c:if>
					<div class="f-l">
						<label class="f-l w-100 text-r"><em class="mark">*</em>服务方式：</label>
						<select class="select w-140 mustfill" name="serviceMode" id="serviceMode" datatype="*" errormsg="请选择服务方式" nullmsg="请选择服务方式">
							<option value="">请选择</option>
							<c:forEach items="${getServiceMode }" var="stype">
									<option value="${stype.columns.name }" ${order.serviceMode eq stype.columns.name ?'selected':''} >${stype.columns.name }</option>
							</c:forEach>
						</select>
						<p class="errorwran ml-100">请选择服务方式</p>
					</div>
					<div class="f-l">
						<label class="f-l w-100 text-r"><c:if test="${mustfill.columns.origin}"><em class="mark">*</em></c:if>信息来源：</label>
						<select class="select w-140 ${mustfill.columns.origin?'mustfill':''}" <c:if test="${mustfill.columns.origin}">datatype="*" nullmsg="请选择信息来源"</c:if> size="1" name="origin" id="origin">
							<option value="">请选择</option>
								<c:forEach items="${listorigin }" var="otype">
								<option value="${otype.columns.name }">${otype.columns.name }</option>
								</c:forEach>
						</select>
						<p class="errorwran ml-100">请选择信息来源/p>
					</div>
				</div>
				<h3 class="modelHead">用户信息</h3>
				<div class="pt-10 mb-15">
					<div class="cl mb-10">
						<div class="f-l ">
							<label class=""><em class="mark">*</em>用户姓名：</label>
							<input type="text" class="input-text w-140 mustfill" name="customerName" id="customerName" datatype="*" errormsg="用户姓名格式不正确" nullmsg="请输入用户姓名" value="${order.customerName }"/>
							<p class="errorwran ml-70">请输入用户姓名</p>
							<c:if test="${cusTypecount > 0 }">
							<span class="select-box w-100 ">
		                    <select class="select ${mustfill.columns.customerType ?'mustfill':''}" id="customerType" name="customerType" <c:if test="${mustfill.columns.customerType}">datatype="*" nullmsg="请选择用户类型"</c:if>>
			                    <option value="">选择类型</option>
			                    <c:forEach items="${getCustomerType}" var="to">
			                    <option value="${to.columns.name }" ${to.columns.name eq order.customerType ?'selected':''}>${to.columns.name }</option>
			                    </c:forEach>
		                    </select>
							</span>
							</c:if>
						</div>
						<div class="f-l">
							<label class="f-l w-100 text-r">
								<span class="f-r pr-5">:</span>
								<select class="lb-sel f-r select" style="width:75px">
									<option value="1" <c:if test="${telorMob eq 'mob' }">selected="selected" </c:if> >手机号码</option>
									<option value="2" <c:if test="${telorMob eq 'tel' }">selected="selected" </c:if>  >固定电话</option>
								</select>
							</label>
							<input type="text" class="input-text w-140 mustfill" name="customerMobile" id="customerMobile" datatype="dh" errormsg="手机号码格式不正确" nullmsg="请输入联系方式" value="${order.customerMobile }"/>
							<p class="errorwran">请输入联系电话</p>
						</div>
						<div class="f-l">
							<label class="f-l w-100 text-r">其他联系方式：</label>
							<input type="text" class="input-text w-120" id="customerTelephone" name="customerTelephone" ignore="ignore" datatype="mtel" errormsg="格式错误" value="${order.customerTelephone }"/>
							<p class="errorwran"></p>
						</div>
						<div class="f-l pos-r" style="padding-left: 15px;">
							<!-- <label class="f-l w-100 text-r">联系方式3：</label> -->
							<input type="text" class="input-text w-120" id="customerTelephone2" name="customerTelephone2" ignore="ignore" datatype="mtel" errormsg="格式错误" value="${order.customerTelephone2 }"/>
							<p class="errorwran"></p>
						</div>
					</div>
					<div class="cl" id="pcd">
					
						<label class="f-l" ><em class="mark">*</em>详细地址：</label>
						<span class="select-box w-90 f-l ml-5">
							<select class="prov select" id="province" name="province">
								<c:if test="${not empty order.province}">
									<c:forEach items="${provincelist }" var="pro">
											<option value="${pro.columns.ProvinceName }" <c:if test="${pro.columns.ProvinceName==order.province }">selected="selected"</c:if>>${pro.columns.ProvinceName }</option>
									</c:forEach>
								</c:if>
									<c:if test="${empty order.province && not empty site.province}">
										<c:forEach items="${provincelist }" var="pro">
											<option value="${pro.columns.ProvinceName }" <c:if test="${pro.columns.ProvinceName==site.province }">selected="selected"</c:if>>${pro.columns.ProvinceName }</option>
										</c:forEach>
									</c:if>
							</select>
						</span>
						<span class="select-box w-90 f-l ml-5">
							<select class="city select" id="city" name="city">
								<c:if test="${not empty order.city}">
									<c:forEach items="${cities }" var="cs">
											<option value="${cs.columns.CityName }" <c:if test="${cs.columns.CityName==order.city }">selected="selected"</c:if>>${cs.columns.CityName }</option>
									</c:forEach>
								</c:if>
									<c:if test="${empty order.city && not empty site.city}">
										<c:forEach items="${cities }" var="cs">
											<option value="${cs.columns.CityName }" <c:if test="${cs.columns.CityName==site.city }">selected="selected"</c:if>>${cs.columns.CityName }</option>
										</c:forEach>
									</c:if>
							</select>
						</span>
						<span class="select-box w-90 f-l ml-5 ">
							<select class="dist select" id="area" name="area">
								<c:if test="${not empty order.area}">
									<c:forEach items="${districts }" var="ds">
											<option value="${ds.columns.DistrictName }" <c:if test="${ds.columns.DistrictName==order.area }">selected="selected"</c:if>>${ds.columns.DistrictName }</option>
									</c:forEach>
								</c:if>
									<c:if test="${empty order.area && not empty site.area}">
										<c:forEach items="${districts }" var="ds">
											<option value="${ds.columns.DistrictName }" <c:if test="${ds.columns.DistrictName==site.area }">selected="selected"</c:if>>${ds.columns.DistrictName }</option>
										</c:forEach>
									</c:if>
							</select>
						</span>
						
						<c:if test="${wnsize > 0 }">
						<span class="select-box f-l w-90 ml-10">
	                    <select class="select" id="township" name="township">
	                    <option value="">乡/镇选择</option>
	                    <c:forEach items="${township }" var="to">
	                    <option value="${to.columns.name }">${to.columns.name }</option>
	                    </c:forEach>
	                    </select>
						</span>
						</c:if>
						<input type="text" class="input-text w-260 mustfill f-l ml-10" id="customerAddress1" name="customerAddress1" id="customerAddress1" placeholder="详细地址" datatype="*" errormsg="格式错误" nullmsg="请输入详细地址" value="${order.customerAddress }"/>
						<input type="hidden" class="input-text w-260 f-l " id="customerAddress" name="customerAddress"  value="${order.customerAddress }"/>
						<p class="errorwran f-l ml-10">请输入详细地址</p>
							<input type="hidden" name="customerLnglat" readonly="true" id="lnglat" value="${order.customerLnglat }"/>
					</div>	
				</div>
				<h3 class="modelHead">服务信息</h3>
				<div class="pt-10">
					<div class="cl mb-10">
						<div class="f-l">
							<label class=""><em class="mark">*</em>家电品牌：</label>
								<select class="select w-140 mustfill" name="applianceBrand" id="applianceBrand" datatype="*" nullmsg="请选择家电品牌！" >
									<option value="">请选择</option>				
									<c:forEach items="${brand }" var="ba" varStatus="sta">
									 <option value="${ba.key }" ${ba.key eq order.applianceBrand ?'selected':''}>${ba.value }</option>
									</c:forEach>
								</select>
							<p class="errorwran ml-70">请选择家电品牌</p>
						</div>
						<div class="f-l">
							<label class="f-l w-100 text-r"><em class="mark">*</em>家电品类：</label>
								<select class="select w-140 mustfill" name="applianceCategory" id="applianceCategory" datatype="*" nullmsg="请选择家电品类！">
										<option value="">请选择</option>				
								<c:forEach items="${category }" var="ca" varStatus="cast">
									 <option value="${ca.columns.name }" ${ca.columns.name eq order.applianceCategory ? 'selected':''}>${ca.columns.name }</option>
								</c:forEach>
								</select>
							<p class="errorwran ml-100">请选择家电品类</p>
						</div>
						<div class="f-l">
							<label class="f-l w-100 text-r"><c:if test="${mustfill.columns.promiseTime}"><em class="mark">*</em></c:if>预约日期：</label>
							<input type="text" onfocus="WdatePicker({minDate: '%y-%M-%d' })" id="promiseTime" name="promiseTime" class="input-text Wdate w-140 ${mustfill.columns.promiseTime?'mustfill':''}">
							<p class="errorwran ml-100">请选择预约日期</p>
						</div>
						<div class="f-l">
							<label class="f-l w-100 text-r"><c:if test="${mustfill.columns.promiseLimit}"><em class="mark">*</em></c:if>时间要求：</label>
								<select class="select w-140 ${mustfill.columns.promiseLimit?'mustfill':''}" <c:if test="${mustfill.columns.promiseLimit}">datatype="*" nullmsg="请选择时间要求"</c:if> name="promiseLimit" id="promiseLimit">
									<option value="">请选择</option>
								</select>
							<p class="errorwran ml-100">请选择时间要求</p>
						</div>
					</div>
					<div class="cl mb-10">
						<div class="f-l">
							<label class="va-t"><c:if test="${mustfill.columns.customerFeedback}"><em class="mark">*</em></c:if>服务描述：</label>
							<textarea type="text" class="textarea w-380 h-50 ${mustfill.columns.customerFeedback ?'mustfill':''}" <c:if test="${mustfill.columns.customerFeedback}">datatype="*" nullmsg="请输入服务描述"</c:if>  name="customerFeedback" id="customerFeedback">${order.customerFeedback}</textarea>
							<p class="errorwran ml-70">请输入服务描述</p>
						</div>
						<div class="f-l">
							<label class="f-l w-100 text-r"><c:if test="${mustfill.columns.remarks}"><em class="mark">*</em></c:if>备注：</label>
							<textarea type="text" class="textarea h-50 w-380 f-l ${mustfill.columns.remarks?'mustfill':''}" <c:if test="${mustfill.columns.remarks}">datatype="*" nullmsg="请输入备注"</c:if> id="remarks" name="remarks">${order.remarks}</textarea>
							<p class="errorwran ml-70">请输入备注</p>
						</div>
					</div>
					
					<div class="cl mb-10">
						<div class="f-l">
							<label class=""><c:if test="${mustfill.columns.applianceModel}"><em class="mark">*</em></c:if>产品型号：</label>
							<input type="text" class="input-text w-140 ${mustfill.columns.applianceModel ?'mustfill':''}" <c:if test="${mustfill.columns.applianceModel}">datatype="*" nullmsg="请输入产品型号"</c:if> id="applianceModel" name="applianceModel" value="${order.applianceModel}"/>
							<p class="errorwran ml-70">请输入产品型号</p>
						</div>

						<div class="f-l">
							<c:choose>
								<c:when test="${not empty malllist}">
									<label class="f-l w-100 text-r"><c:if test="${mustfill.columns.pleaseReferMall}"><em class="mark">*</em></c:if>购机商场：</label>
									<span class="w-140">
									<select class="select ${mustfill.columns.pleaseReferMall ?'mustfill':''}"  id="pleaseReferMall"  multiline="false" name="pleaseReferMall" style="width:100%;height:25px" panelMaxHeight="300px" <c:if test="${mustfill.columns.pleaseReferMall}">datatype="*" nullmsg="请选择购机商场"</c:if>>
										<option value="">请选择</option>
										<c:forEach items="${malllist }" var="mall">
											<option value="${mall.columns.mall_name } ">${mall.columns.mall_name }</option>
										</c:forEach>
									</select>
								</span>
								</c:when>
								<c:otherwise>
									<label class="f-l w-100 text-r"><c:if test="${mustfill.columns.pleaseReferMall}"><em class="mark">*</em></c:if>购机商场：</label>
									<input type="text" value="${order.pleaseReferMall}" name="pleaseReferMall" class="input-text w-140 ${mustfill.columns.pleaseReferMall?'mustfill':''}" <c:if test="${mustfill.columns.pleaseReferMall}">datatype="*" nullmsg="请输入购机商场"</c:if>>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="f-l">
							<label class="f-l w-100 text-r"><c:if test="${mustfill.columns.applianceNum}"><em class="mark">*</em></c:if>产品数量：</label>
							<input type="text" value="1" class="input-text w-140 ${mustfill.columns.applianceNum?'mustfill':''}" name="applianceNum" id="applianceNum" <c:if test="${mustfill.columns.applianceNum}">datatype="anum" errormsg="产品数量格式不正确" nullmsg="请输入产品数量"</c:if>/>
						</div>

						<div class="f-l">
							<label class="f-l w-100 text-r"><c:if test="${mustfill.columns.applianceBuyTime}"><em class="mark">*</em></c:if>购买日期：</label>
							<input type="text" onfocus="WdatePicker({maxDate: '%y-%M-%d' })"  id="applianceBuyTime" name="applianceBuyTime" class="input-text Wdate w-140 ${mustfill.columns.applianceBuyTime?'mustfill':''}" readonly value="${order.applianceBuyTime}">
							<p class="errorwran ml-70">请选择购买时间</p>
						</div>
					</div>
					<div class="cl mb-10">
						<div class="f-l">
							<label class=""><c:if test="${mustfill.columns.applianceBarcode}"><em class="mark">*</em></c:if>内机条码：</label>
							<input type="text" class="input-text w-140 ${mustfill.columns.applianceBarcode?'mustfill':''}" name="applianceBarcode" id="applianceBarcode" <c:if test="${mustfill.columns.applianceBarcode}">datatype="*" nullmsg="请输入内机条码"</c:if> value="${order.applianceBarcode}"/>
							<p class="errorwran ml-70">请输入内机条码</p>
						</div>
						<div class="f-l">
							<label class="f-l w-100 text-r"><c:if test="${mustfill.columns.applianceMachineCode}"><em class="mark">*</em></c:if>外机条码：</label>
							<input type="text" class="input-text w-140 ${mustfill.columns.applianceMachineCode?'mustfill':''}" <c:if test="${mustfill.columns.applianceMachineCode}">datatype="*" nullmsg="请输入外机条码"</c:if> name="applianceMachineCode" id="applianceMachineCode" value="${order.applianceMachineCode}"/>
							<p class="errorwran ml-70">请输入外机条码</p>
						</div>
						<div class="f-l">
							<label class="f-l w-100 text-r"><c:if test="${mustfill.columns.warrantyType}"><em class="mark">*</em></c:if>保修类型：</label>
							<select class="select w-140 ${mustfill.columns.warrantyType?'mustfill':''}" <c:if test="${mustfill.columns.warrantyType}">datatype="*" nullmsg="请选择保修类型"</c:if> id="warrantyType" name="warrantyType">
								<option value="">请选择</option>
								<option value="1" ${order.warrantyType eq 1 ?'selected':''}>保内</option>
								<option value="2" ${order.warrantyType eq 2 ?'selected':''}>保外</option>
								<!-- <option value="3">保内转保外</option> -->
							</select>
							<p class="errorwran ml-70">请选择保修类型</p>
						</div>
						<div class="f-l">
							<label class="f-l w-100 text-r"><c:if test="${mustfill.columns.level}"><em class="mark">*</em></c:if>重要程度：</label>
							<select class="select  w-140 ${mustfill.columns.level?'mustfill':''}" <c:if test="${mustfill.columns.level}">datatype="*" nullmsg="请选择重要程度"</c:if> id="level" name="level">
								<option value="">请选择</option>
								<option value="1">重要</option>
								<option value="2" selected>一般</option>
							</select>
							<p class="errorwran ml-70">请选择重要程度</p>
						</div>

					</div>
					<div class="mb-10 cl">
						<div class="f-l">
							<label class="">报修时间：</label>
							<input type="text" id="repairTime" name="repairTime" value ="<fmt:formatDate value="${curDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" readonly="readonly" class="input-text  w-140 readonly">
						</div>
						<div class="f-l">
							<label class="f-l w-100 text-r"><em class="mark">*</em>登记人：</label>
							<select class="select w-140 mustfill"  name= "messengerId" id="messengerId" datatype="*" nullmsg="请选择登记人！">
								<option value="">请选择</option>
								<c:forEach var="man" items="${infomans }">
									<option value="${man.columns.id }">${man.columns.name }</option>
								</c:forEach>	
							</select>
							<p class="errorwran ml-70">请选择登记人</p>
							<%-- <input type="text" class="input-text w-140 readonly" name="messengerName" value="${sitename}" readonly="readonly" /> --%>
						</div>
					</div>
				</div>
				
				<input type="hidden" id="messengerName" name="messengerName">
				<input type="hidden" name= "employeId" id="employeId">
			</form>
		</div>
	</div>


	<div id="map-container" style="display: none;">
				
	</div>		

<!-- 我要派工 -->
<div class="popupBox dispatch activeDispatch " >
	<h2 class="popupHead">
		我要派工
		<a href="javascript:;" class="sficon closePopup" onclick="closeParent()"></a>
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
								<th class="w-100">今日已完成</th>
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
<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/city.union.js"></script>
<script type="text/javascript">
var ctx='${ctx}';

AMap.service('AMap.Geocoder', function () {//回调函数
    //实例化Geocoder
    geocoder = new AMap.Geocoder();
});
var dispatchMap,dispatchMarker,employeMarker;
	var marker;
	var mark;
	var a = true;
	var num = /^[A-Za-z0-9]{1,20}$/ ;

var orderTimer = null;
$(function(){
	
	var mobile='${order.customerMobile }';
	if(mobile.length>11){
		var tou=mobile.substring("0","4");
		var wei=mobile.substring("4",mobile.length);
		var mob=tou+"-"+wei;
		$("#customerMobile").val(mob);
	}
	$("#number").focus();

	$("#number").blur();
	
	$("#applianceMachineCode").focus(function(){
		var nei = $("#applianceBarcode").val();
		if(isBlank(nei)){
			layer.msg("请先填写内机条码！");
		}
	});	
	
	$('#filterName').keyup(function(){
		$('#zhijiepaidan tr').hide()     
		.filter(":contains('" +($(this).val()) + "')").show();  
		}).keyup();//DOM加载完时，绑定事件完成之后立即触发  
	
	// 当预约时间没选择时给出提示
		var limit ="";
	 $.post("${ctx}/main/redirect/getproLimitList",function(result){
		    $.each(result, function(){
		    	var value= this;
		    	limit = limit + '<option value="'+value+'">'+value+'</option>';
		    });
		});
	$("#promiseLimit").focus(function(){
		$("#promiseLimit").empty();
		var html ="";
		if(isBlank($("#promiseTime").val())){
			layer.msg("请选择预约时间");
			html ='<option value="">请选择</option>';
		}else{
			html ='<option value="">请选择</option>';
				html = html+limit;
		}
			$("#promiseLimit").append(html);	
	});


	// 选择品类时获取服务商维护对应的品牌
	$("#applianceCategory").change(function () {
		var brand = $("#applianceBrand").val();
		var cate = $("#applianceCategory").val();
		var seriNo=$("#seriNo").val();
		//if(!isBlank(cate)){
		$.ajax({
			type: "post",
			url:"${ctx}/main/redirect/getBrand",
			data: {
				category: cate,
				seriNo:seriNo
			},
			dataType: "json",
			success: function (data) {
				var obj = eval(data);
				if (obj.count == 2) {
					layer.msg("没有相关品牌，请维护");
					$("#applianceBrand").empty();
				} else {
					$("#applianceBrand").empty();
					var HTML = " <option value=''>请选择</option> ";
					$.each(obj.brand, function (key, values) {
						if (brand == values) {
							HTML += '<option value="' + values + '" selected = "selected" >' + key + '</option>';
						} else {
							HTML += '<option value="' + values + '">' + key + '</option>';
						}
					});
					$("#applianceBrand").append(HTML);
				}
			}
		});
	});

	// 选择品牌时获取服务商维护对应的品类
	$("#applianceBrand").change(function () {
		var cate = $("#applianceCategory").val();
		// if(isBlank(cate)){
		var brand = $("#applianceBrand").val();
		var seriNo=$("#seriNo").val();
		//if(!isBlank(brand)){
		$.ajax({
			type: "post",
			url:"${ctx}/main/redirect/getCategory",
			data: {
				brand: brand,
				seriNo:seriNo
			},
			dataType: "json",
			success: function (data) {
				var obj = eval(data);
				$("#applianceCategory").empty();
				if (obj.count == 2) {
					layer.msg("没有相关品类，请维护");
				} else {
					var HTML = " <option value=''>请选择</option> ";
					$.each(obj.cate, function (key, values) {
						if (cate == values) {
							HTML += '<option value="' + values + '" selected = "selected" >' + key + '</option>';
						} else {
							HTML += '<option value="' + values + '">' + key + '</option>';
						}

					});
					$("#applianceCategory").append(HTML);
				}
			}
		});
	});
});

function resetOrderForm() {
    window.location.reload();
	/*$("#neworderForm").get(0).reset();*/
}

// 验证手机号
function isPhoneNo(phone) { 
	var pattern = /^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$|(^(1[0-9])\d{9}$)/;
	return pattern.test($.trim(phone));
}
	
	function initDispatchMap() {
		if (!dispatchMap) {
			dispatchMap = new AMap.Map('dispatch_map_container', {
				zoom: 12
			});
			dispatchMarker = new AMap.Marker({
				 map:dispatchMap,
		    	 draggable:true
			});
			employeMarker = new AMap.Marker({});
			dispatchMarker.setMap(dispatchMap);
		}
		 var lnglat = $("#lnglat").val();
		if(!isBlank(lnglat)) {
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
	var seriNo=$("#seriNo").val();
	$.ajax({
		type : "POST",
		url : "${ctx}/main/redirect/dispatchList",
		data : {
			lnglat :lnglat,
			category:category,
			seriNo:seriNo
			
		},
		//dataType: 'json',
		success : function(data) {
			var content = $("#zhijiepaidan");
			content.empty();
			var sites = data;
			var appendHtml = '';
			for (var i = 0; i < sites.length; i++) {
				var item = sites[i].columns;
				appendHtml +='<tr>'
				+'<td style="border-left: none;">'+item.name+'</td>'
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

	 $('#neworderForm').Validform({
			btnSubmit: "#btnNewOrder",
			tiptype:function(msg, o, cssctl) {
				var objtip;
				objtip=o.obj.siblings(".errorwran");
						
				if(o.type =="3"){
                    layer.msg(msg);
				}else{
				    o.obj.removeClass('mustfill');
					$(".errorwran").hide();
				}

			},
			postonce : true,
			datatype:{
				"m":  /^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$|(^(1[0-9])\d{9}$)/,				
				"dh": /^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$|(^(1[0-9])\d{9}$)/,
                "anum":/^[0-9]{0,4}$/,
				"z46":/^[^\%\'\"\?]{1,20}$/,
				"zimu":/^[A-Za-z0-9]{1,20}$/,
				"mtel": /^([\+][0-9]{1,3}[ \.\-])?([\(]{1}[0-9]{2,6}[\)])?([0-9 \.\-\/]{3,20})((x|ext|extension)[ ]?[0-9]{1,4})?$/
				},
		    beforeSubmit:function(curform){
		    	var messId = $("#messengerId").val();
		    	
		    	var messname = $("#messengerId").find("option:selected").text();
		    	console.log(messname)
		    	$("#messengerName").val(messname);
                var promiseTime = '${mustfill.columns.promiseTime}';
                var applianceBuyTime = '${mustfill.columns.applianceBuyTime}';
                var jurisdiction=false+","+promiseTime+","+false+","+false+","+false+","+false+","+false+","+false+","+false+","+applianceBuyTime+","+false+","+false+","+false+","+false;
                var promiseTimev= $("#promiseTime").val();
                var applianceBuyTimev= $("#applianceBuyTime").val();
               // var jurisdictionvalue=null+"(**..)"+promiseTimev+"(**..)"+null+"(**..)"+null+"(**..)"+null+"(**..)"+null+"(**..)"+null+"(**..)"+null+"(**..)"+null+"(**..)"+applianceBuyTimev+"(**..)"+null+"(**..)"+null+"(**..)"+null;

                var array=new Array();
                array[0]=null;
                array[1]=promiseTimev;
                array[2]=null;
                array[3]=null;
                array[4]=null;
                array[5]=null;
                array[6]=null;
                array[7]=null;
                array[8]=null;
                array[9]=applianceBuyTimev;
                array[10]=null;
                array[11]=null;
                array[12]=null;
                array[13]=null;

                return checkMustFill(jurisdiction,array);
			},
			callback: function(form) {
					var town =$("#township").val()||'';
					var customerAddress1=$("#customerAddress1").val();
					$("input[name='customerAddress']").val(town+customerAddress1);
					var seriNo=$("#seriNo").val();
					var telephone=$("#telephone").val();
					
				 	$.ajax({
					url: "${ctx}/main/redirect/save",
					//dataType: 'json',
					type: "POST",
					data: form.serialize(),
					success: function(data) {
						if(data=='420'){
							layer.msg("工单编号已被使用！");
							return;
						}
						resetOrderForm();
						layer.msg('保存成功'); 
						window.location.href="${ctx}/main/redirect/telephoneNotifyOrder?tel="+telephone+"&serialNo="+seriNo;
					}
				});   
				return false;
			}
		});
		function isBlank(val) {
			if(val==null || val=='' || val == undefined) {
				return true;
			}
			return false;
		}



/*获取必填项设置参数*/
function getJurisdiction(){
    var promiseTime = '${mustfill.columns.promiseTime}';
    var applianceBuyTime = '${mustfill.columns.applianceBuyTime}';
    var origin = '${mustfill.columns.origin}';
    var promiseLimit = '${mustfill.columns.promiseLimit}';
    var remarks = '${mustfill.columns.remarks}';
    var applianceModel = '${mustfill.columns.applianceModel}';
    var applianceNum = '${mustfill.columns.applianceNum}';
    var applianceBarcode = '${mustfill.columns.applianceBarcode}';
    var applianceMachineCode = '${mustfill.columns.applianceMachineCode}';
    var pleaseReferMall = '${mustfill.columns.pleaseReferMall}';
    var warrantyType = '${mustfill.columns.warrantyType}';
    var level = '${mustfill.columns.level}';
    var customerFeedbackJuris = '${mustfill.columns.customerFeedback}';
    var customerType = '${mustfill.columns.customerType}';
	/*拼接顺序不能改变*/
    var jurisdiction=origin+","+promiseTime+","+promiseLimit+","+customerFeedbackJuris+","+remarks+","+applianceModel+","+applianceNum+","+applianceBarcode+","+applianceMachineCode+","+applianceBuyTime+","+pleaseReferMall+","+warrantyType+","+level+","+customerType;
    return jurisdiction;
}
/*获取参数*/
function getJurisdisctionValue(){
    var originv= $("#origin").val();
    var promiseTimev= $("#promiseTime").val();
    var promiseLimitv= $("#promiseLimit").val();
    var customerFeedbackv= $("#customerFeedback").val();
    var remarksv= $("#remarks").val();
    var applianceModelv= $("#applianceModel").val();
    var applianceNumv=$("#applianceNum").val();
    var applianceBarcodev= $("#applianceBarcode").val();
    var applianceMachineCodev= $("#applianceMachineCode").val();
    var applianceBuyTimev= $("#applianceBuyTime").val();
    var pleaseReferMallv=$("#pleaseReferMall").val();
    var warrantyTypev= $("#warrantyType").val();
    var levelv= $("#level").val();
    var customerType= $("#customerType").val();

    var array=new Array();
    array[0]=originv;
    array[1]=promiseTimev;
    array[2]=promiseLimitv;
    array[3]=customerFeedbackv;
    array[4]=remarksv;
    array[5]=applianceModelv;
    array[6]=applianceNumv;
    array[7]=applianceBarcodev;
    array[8]=applianceMachineCodev;
    array[9]=applianceBuyTimev;
    array[10]=pleaseReferMallv;
    array[11]=warrantyTypev;
    array[12]=levelv;
    array[13]=customerType;


    /*拼接顺序不能改变*/
    //var jurisdictionvalue=originv+"(**..)"+promiseTimev+"(**..)"+promiseLimitv+"(**..)"+customerFeedbackv+"(**..)"+remarksv+"(**..)"+applianceModelv+"(**..)"+applianceNumv+"(**..)"+applianceBarcodev+"(**..)"+applianceMachineCodev+"(**..)"+applianceBuyTimev+"(**..)"+pleaseReferMallv+"(**..)"+warrantyTypev+"(**..)"+levelv;
    return array;
}


		var markOrder = false;
		function printView(){
			if(markOrder){
				return;
			}
			var number = $.trim($("#number").val());
			var serviceType = $("#serviceType").val();
			var serviceMode = $("#serviceMode").val();
			var name = $("#customerName").val();
			var customerMobile = $("#customerMobile").val();
			var add = $("#customerAddress1").val();

			var selectcategory = $("#applianceCategory").val();
			var selectbrand = $("#applianceBrand").val();
			var customerFeedback = $("#customerFeedback").val();
			var messId = $("#messengerId").val();
			var codeSet = '${orderNumSet}';
			if(codeSet!='200'){
				if (isBlank(number)) {
					layer.msg("请输入工单编号");
					return;
				} else if (!num.test(number)) {
					layer.msg("请输入正确的工单编号");
					return;
				}
			}
			if (isBlank(serviceType)) {
				layer.msg("请选择服务类型");
			} else if (isBlank(serviceMode)) {
				layer.msg("请选择服务方式");
			} else if (isBlank(name)) {
				layer.msg("请输入用户姓名！");
			} else if (isBlank(customerMobile)) {
				layer.msg("请输入联系方式");
			} else if (!isPhoneNo($.trim(customerMobile)) ) {
				layer.msg("手机号码格式不正确");
			} else if (isBlank(add)) {
				layer.msg("请输入详细地址");
			}else if (isBlank(selectbrand)) {
				layer.msg("请选择家电品牌！");
			} else if (isBlank(selectcategory)) {
				layer.msg("请选择家电品类！");
			} else if (isBlank(messId)) {
				layer.msg("请选择登记人！");
			} else {
				var messname = $("#messengerId").find("option:selected").text();
		    	$("#messengerName").val($("#messname").text());
                var result=checkMustFill(getJurisdiction(),getJurisdisctionValue());
                if(!result){
                    return;
                } else {
                	var customerAddress1=$("#customerAddress1").val();
                	$("input[name='customerAddress']").val(($("#township").val()||'')+customerAddress1);

                    markOrder = true;
                    $.ajax({
                        url: "${ctx}/main/redirect/save",
                        type: "POST",
                        data: $("#neworderForm").serialize(),
                        success: function (data) {
                            markOrder = false;
                            if (data == '420') {
                                layer.msg("工单编号已被使用！");
                                return;
                            }
                            $("#printForm").find("input").each(function () {
                                var attrName = $(this).attr("name");
                                $("#pt-" + attrName).val($("#neworderForm input[name='" + attrName + "']").val());
                            });
                            $("#pt-applianceCategory").val($("#selectcategory").val());
                            $("#pt-applianceBrand").val($("#selectbrand").val());
                            $("#pt-serviceMode").val($("#serviceMode").val());
                            $("#pt-serviceType").val($("#serviceType").val());
                            $("#pt-origin").val($("#origin").val());
                            $("#pt-level").val($("#level").val());
                            $("#pt-promiseLimit").val($("#promiseLimit").val());
                            $("#pt-customerFeedback").val($("#customerFeedback").val());
                            $("#pt-remarks").val($("#remarks").val());

                            $("#printForm").submit();
                        },
                        complete: function () {
                            markOrder = false;
                        }
                    });
                }
            }
		}


function directDis() {
    var number = $("#number").val();
    var serviceType = $("#serviceType").val();
    var serviceMode = $("#serviceMode").val();
    var name = $("#customerName").val();
    var customerMobile = $("#customerMobile").val();
    var add = $("#customerAddress1").val();

    var selectcategory = $("#applianceCategory").val();
    var selectbrand = $("#applianceBrand").val();
    var customerFeedback = $("#customerFeedback").val();
	var messId = $("#messengerId").val();
	
    var codeSet = '${orderNumSet}';
    if (codeSet != '200') {
        if (isBlank(number)) {
            layer.msg("请输入工单编号");
            return;
        } else if (!num.test(number)) {
            layer.msg("请输入正确的工单编号");
            return;
        }
    }
    if (isBlank(serviceType)) {
        layer.msg("请选择服务类型");
    } else if (isBlank(serviceMode)) {
        layer.msg("请选择服务方式");
    } else if (isBlank(name)) {
        layer.msg("请输入用户姓名！");
    } else if (isBlank(customerMobile)) {
        layer.msg("请输入联系方式");
    } else if (isPhoneNo(customerMobile) == false) {
        layer.msg("手机号码格式不正确");
    } else if (isBlank(add)) {
        layer.msg("请输入详细地址");
    } else if (isBlank(selectbrand)) {
        layer.msg("请选择家电品牌！");
    } else if (isBlank(selectcategory)) {
        layer.msg("请选择家电品类！");
    }else if(isBlank(messId)){
        layer.msg("请选择登记人！");
    } else {

        var customerAddress1=$("#customerAddress1").val();
        $("input[name='customerAddress']").val(($("#township").val()||'')+customerAddress1);

    	var messname = $("#messengerId").find("option:selected").text();
    	$("#messengerName").val(messname);
        var result = checkMustFill(getJurisdiction(), getJurisdisctionValue());
        if (!result) {
            return;
        } else {
            $('.activeDispatch').popup(); //显示我要派工弹出框和判断高度
            $('.activeDispatch').css({'z-index': '199'});
            $.selectCheck2("serverSelected");
            initDispatchMap();
            employe();
        }
    }
}

		//直接派工中点击派工按钮
		var confirmPai=false;
		function dispa() {
            if(confirmPai){
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
					fnConfirm: function () {
                        confirmPai=true;
						$("#neworderForm").submit();
						//$("#shadeBg_3").remove();
						//$('#Hui-article-box',window.top.document).css({'z-index':'9'});
                        confirmPai=false;
					},
					fnCancel: function () {
					}
				});
				$('.promptBox').css({'z-index':'399'})
			}
		}

</script>
<form id="printForm" action="${ctx}/main/redirect/order" style="display: none;" target="_blank" method="post">
	<input type="hidden" name="number" id="pt-number">
	<input type="hidden" name="serviceType" id="pt-serviceType">
	<input type="hidden" name="serviceMode" id="pt-serviceMode">
	<input type="hidden" name="origin" id="pt-origin">
	<input type="hidden" name="customerName" id="pt-customerName">
	<input type="hidden" name="customerMobile" id="pt-customerMobile">
	<input type="hidden" name="customerTelephone" id="pt-customerTelephone">
	<input type="hidden" name="customerTelephone2" id="pt-customerTelephone2">
	<input type="hidden" name="customerAddress" id="pt-customerAddress">
	<input type="hidden" name="applianceBrand" id="pt-applianceBrand">
	<input type="hidden" name="applianceCategory" id="pt-applianceCategory">
	<input type="hidden" name="promiseTime" id="pt-promiseTime">
	<input type="hidden" name="promiseLimit" id="pt-promiseLimit">
	<input type="hidden" name="customerFeedback" id="pt-customerFeedback">
	<input type="hidden" name="remarks" id="pt-remarks">
	<input type="hidden" name="applianceModel" id="pt-applianceModel">
	<input type="hidden" name="applianceBarcode" id="pt-applianceBarcode">
	<input type="hidden" name="applianceMachineCode" id="pt-applianceMachineCode">
	<input type="hidden" name="applianceBuyTime" id="pt-applianceBuyTime">
	<input type="hidden" name="warrantyType" id="pt-warrantyType">
	<input type="hidden" name="level" id="pt-level">
	<input type="hidden" name="repairTime" id="pt-repairTime">
	<input type="hidden" name="messengerName" id="pt-messengerName">
	
	<input type="hidden" name="siteName" id="pt-siteName">
</form>
</body>
</html>
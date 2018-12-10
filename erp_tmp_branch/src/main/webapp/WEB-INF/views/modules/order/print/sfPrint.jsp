<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<%--<meta name="decorator" content="base"/>--%>
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
	<meta http-equiv="Cache-Control" content="no-siteapp" />

	<title>工单录入</title>

	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/print_sf.css"/>
	<script src="${ctxPlugin}/static/h-ui.admin/js/jquery-1.8.3.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/jquery-migrate-1.4.1.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/jquery.jqprint-0.3.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/sifang.js"></script>
	<style>
	</style>
	<script type="text/javascript">
		$(function(){
			$('#btn').goHelp('${ctx}/helpindex/indexHelp?a=gddy');

		});

		function printOrder() {
//			document.getElementById("btn").style.display="none";
            var number='${order.number}';
			$.ajax({url:"${ctx}/print/writePrintTimes", type:"post", data:{number:number}, success:function(result){}});

            $("#btn-wrapper-print").hide();
			$(".btnHelplink").hide();
			$(".printpage").jqprint({
				debug: false, //如果是true则可以显示iframe查看效果（iframe默认高和宽都很小，可以再源码中调大），默认是false
				importCSS: true, //true表示引进原来的页面的css，默认是true。（如果是true，先会找$("link[media=print]")，若没有会去找$("link")中的css文件）
				printContainer: true, //表示如果原来选择的对象必须被纳入打印（注意：设置为false可能会打破你的CSS规则）。
				operaSupport: true//表示如果插件也必须支持歌opera浏览器，在这种情况下，它提供了建立一个临时的打印选项卡。默认是true
			});
		}


	</script>
</head>
<body>

<div class="printpage wrap" style="position:relative;">
	<h2 class="title" style="text-align:center;font-size: 22px">${rd.columns.siteName }</h2>
	<div class="cl" style="font-size: 20px;overflow: hidden">
		<div class="f-l">工单编号：${order.number }</div>
		<div class="f-r" style="float: right">派工时间：<span style="  display: inline-block;width: 180px;"> <fmt:formatDate value="${rd.columns.dispatch_time }" pattern="yyyy-MM-dd hh:mm"/></span></div>
	</div>
	<table class="printTable"style="margin-top:8px">
		<caption style="text-align:left;">用户信息</caption>
		<tr>
			<td style="width: 33%;">用户姓名：${order.customerName }</td>
			<td style="width: 33%;"  colspan="2">
				<c:if test="${!empty order.customerMobile && empty order.customerTelephone && empty order.customerTelephone2}">
						联系方式：${order.customerMobile }
					</c:if>
					<c:if test="${empty order.customerMobile && ! empty order.customerTelephone && empty order.customerTelephone2 }">
						联系方式：${order.customerTelephone }
					</c:if>
					<c:if test="${empty order.customerMobile && empty order.customerTelephone  && !empty order.customerTelephone2}">
						联系方式：${order.customerTelephone2 }
					</c:if>
					<c:if test="${! empty order.customerMobile && ! empty order.customerTelephone && empty order.customerTelephone2}">
						联系方式：${order.customerMobile },${order.customerTelephone }
					</c:if>
					<c:if test="${! empty order.customerMobile && empty order.customerTelephone && ! empty order.customerTelephone2}">
						联系方式：${order.customerMobile },${order.customerTelephone2 }
					</c:if>
					<c:if test="${empty order.customerMobile && ! empty order.customerTelephone && ! empty order.customerTelephone2}">
						联系方式：${order.customerTelephone },${order.customerTelephone2 }
					</c:if>
					<c:if test="${not empty order.customerMobile && ! empty order.customerTelephone && ! empty order.customerTelephone2}">
						联系方式：${order.customerMobile },${order.customerTelephone },${order.customerTelephone2 }
					</c:if>
					<c:if test="${ empty order.customerMobile && empty order.customerTelephone && empty order.customerTelephone2}">
						联系方式:
					</c:if>
                   <%--<c:if test="${order.customerMobile }!=null&&${order.customerTelephone }==null&&${order.customerTelephone2 }==null">
					   联系方式：${order.customerMobile }
				   </c:if>
				<c:if test="${order.customerMobile }==null&&${order.customerTelephone }!=null&&${order.customerTelephone2 }==null">
					联系方式：${order.customerTelephone }
				</c:if>
				<c:if test="${order.customerMobile }==null&&${order.customerTelephone }==null&&${order.customerTelephone2 }!=null">
					联系方式：${order.customerTelephone2 }
				</c:if>
				<c:if test="${order.customerMobile }!=null&&${order.customerTelephone }!=null&&${order.customerTelephone2 }==null">
					联系方式：${order.customerMobile },${order.customerTelephone }
				</c:if>
				<c:if test="${order.customerMobile }!=null&&${order.customerTelephone }==null&&${order.customerTelephone2 }!=null">
					联系方式：${order.customerMobile },${order.customerTelephone2 }
				</c:if>
				<c:if test="${order.customerMobile }==null&&${order.customerTelephone }!=null&&${order.customerTelephone2 }!=null">
					联系方式：${order.customerTelephone },${order.customerTelephone2 }
				</c:if>

				<c:if test="${order.customerMobile }!=null&&${order.customerTelephone }!=null&&${order.customerTelephone2 }!=null">
					联系方式：${order.customerMobile },${order.customerTelephone },${order.customerTelephone2 }
				</c:if>
	<c:if test="${ empty order.customerMobile }&&${empty order.customerTelephone }&&${empty order.customerTelephone2 }">
		联系方式:
	</c:if>--%>
			</td>

		</tr>
		<tr>
			<c:if test="${order.province eq order.city}">
				<td colspan="2">详细地址：${order.city}${order.area}${order.customerAddress}</td>
			</c:if>
			<c:if test="${order.province ne order.city}">
				<td colspan="2">详细地址：${order.province}${order.city}${order.area}${order.customerAddress}</td>
			</c:if>
			<td style="width: 34%;">受理时间：<fmt:formatDate value="${order.createTime }" pattern="yyyy-MM-dd hh:mm"/></td>
		</tr>
	</table>

	<table class="printTable"style="margin-top:8px">
		<caption style="text-align:left;">家电信息</caption>
		<tr>
			<td style="width: 33%;">报修家电：${order.applianceBrand }${order.applianceCategory }</td>
			<td style="width: 33%;">家电数量：${order.applianceNum }</td>
			<td style="width: 34%;">购买时间：<fmt:formatDate value="${order.applianceBuyTime }" pattern="yyyy-MM-dd"/></td>
		</tr>
		<tr>
			<td>产品型号：${order.applianceModel }</td>
			<td >内机条码：${order.applianceBarcode }</td>
			<td >外机条码：${order.applianceMachineCode }</td>
		</tr>
	</table>

	<table class="printTable"style="margin-top:8px">
		<caption style="text-align:left;">服务信息</caption>
		<tr>
			<td style="width: 33%;">
				服务类型：${order.serviceType }
			</td>
			<td style="width: 33%;">服务方式：${order.serviceMode }</td>
			<td style="width: 34%;">预约时间：<fmt:formatDate value="${order.promiseTime }" pattern="yyyy-MM-dd"/>${order.promiseLimit }</td>
		</tr>
		<tr>
			<td>保修类型：<c:if test="${order.warrantyType eq '1'}">保内</c:if>
				<c:if test="${order.warrantyType eq '2'}">保外</c:if>
				<c:if test="${order.warrantyType eq '3'}">保外转保内</c:if>
			</td>
			<td>信息来源：${order.origin }</td>
			<td>重要程度：<c:if test="${order.level eq '1'}">紧急</c:if><c:if test="${order.level eq '2'}">一般</c:if></td>
		</tr>
		<tr>
			<td colspan="2">服务描述：${order.customerFeedback }</td>
			<td>信息备注：${order.remarks }</td>
		</tr>
	</table>
	<table class="printTable" style="margin-top:8px">
		<caption style="text-align:left;">其他信息</caption>
		<tr>
			<td style="width: 33%;">服务费：<c:if test="${order.serveCost != '0.0' && order.serveCost != '' }">${order.serveCost }</c:if></td>
			<td style="width: 33%;">材料费: <c:if test="${order.auxiliaryCost != '0.0' && order.auxiliaryCost != ''}">${order.auxiliaryCost }</c:if></td>
			<td style="width: 34%;">延保费: <c:if test="${order.warrantyCost != '0.0' && order.warrantyCost != '' }">${order.warrantyCost }</c:if></td>
		</tr>
		<tr>
			<td>合计金额：<c:if test="${order.confirmCost != '0.0' && order.confirmCost != ''  }">${order.confirmCost }</c:if></td>
			<td colspan="2">备注：</td>
		</tr>
		<tr>
			<td>完工时间：<fmt:formatDate value="${rd.columns.end_time }" pattern="yyyy-MM-dd hh:mm"/></td>
			<td>评价：<c:if test="${rd.columns.service_attitude eq '1'}">十分不满意</c:if>
				<c:if test="${rd.columns.service_attitude eq '2'}">不满意</c:if>
				<c:if test="${rd.columns.service_attitude eq '3'}">一般</c:if>
				<c:if test="${rd.columns.service_attitude eq '4'}">满意</c:if>
				<c:if test="${rd.columns.service_attitude eq '5'}">十分满意</c:if>
			</td>
			<td>用户签字：</td>
		</tr>
		<tr>
			<td >服务商：${order.siteName}</td>
			<td>监督电话：${rd.columns.sms_phone}</td>
			<td >服务工程师：${order.employeName}</td>
		</tr>
	</table>

	<div style="padding-top:50px; text-align:center;" id="btn-wrapper-print">
		<input type="button" value="打印" id="btn" onclick="printOrder();" class="btn-print" style="width:100px;height:30px; line-height:30px;" data-type="print" />
	</div>

</div>


</body>

</html>
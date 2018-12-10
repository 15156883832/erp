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
            var numbers='${numbers}';
            $.ajax({url:"${ctx}/print/writeMorePrintTimesForOld400", type:"post", data:{numbers:numbers}, success:function(result){}});

//			document.getElementById("btn").style.display="none";
            $("#btn-wrapper-print").hide();
			$(".btnHelplink").hide();
			$("#printContainer").jqprint({
				debug: false, //如果是true则可以显示iframe查看效果（iframe默认高和宽都很小，可以再源码中调大），默认是false
				importCSS: true, //true表示引进原来的页面的css，默认是true。（如果是true，先会找$("link[media=print]")，若没有会去找$("link")中的css文件）
				printContainer: true, //表示如果原来选择的对象必须被纳入打印（注意：设置为false可能会打破你的CSS规则）。
				operaSupport: true//表示如果插件也必须支持歌opera浏览器，在这种情况下，它提供了建立一个临时的打印选项卡。默认是true
			});
		}


	</script>
</head>
<body>
<div style="padding-top:50px; text-align:center;" id="btn-wrapper-print">
	<input type="button" value="打印" id="btn" onclick="printOrder();" class="btn-print" style="width:100px;height:30px; line-height:30px;" data-type="print" />
</div>
<div id="printContainer">
<c:forEach items="${orders}" var="order" varStatus="stat">
<div class="printpage wrap" style="position:relative;">
	<h2 class="title" style="text-align:center;">${site.name }</h2>
	<div class="cl" style="font-size: 1.2em;overflow: hidden">
		<div class="f-l">工单编号：${order.columns.number }</div>
		<div class="f-r" style="float: right">派工时间：<span style="  display: inline-block;width: 150px;"> <fmt:formatDate value="${order.columns.dispatch_time }" pattern="yyyy-MM-dd hh:mm"/></span></div>
	</div>
	<table class="printTable"style="margin-top:5px">
		<caption style="text-align:left;">用户信息</caption>
		<tr>
			<td style="width: 33%;">用户姓名：${order.columns.customer_name }</td>
			<td style="width: 33%;"  colspan="2">
				<c:if test="${!empty order.columns.customer_mobile && empty order.columns.customer_telephone && empty order.columns.customer_telephone2}">
						联系方式：${order.columns.customer_mobile }
					</c:if>
					<c:if test="${empty order.columns.customer_mobile && ! empty order.columns.customer_telephone && empty order.columns.customer_telephone2 }">
						联系方式：${order.columns.customer_telephone }
					</c:if>
					<c:if test="${empty order.columns.customer_mobile && empty order.columns.customer_telephone  && !empty order.columns.customer_telephone2}">
						联系方式：${order.columns.customer_telephone2 }
					</c:if>
					<c:if test="${! empty order.columns.customer_mobile && ! empty order.columns.customer_telephone && empty order.columns.customer_telephone2}">
						联系方式：${order.columns.customer_mobile },${order.columns.customer_telephone }
					</c:if>
					<c:if test="${! empty order.columns.customer_mobile && empty order.columns.customer_telephone && ! empty order.columns.customer_telephone2}">
						联系方式：${order.columns.customer_mobile },${order.columns.customer_telephone2 }
					</c:if>
					<c:if test="${empty order.columns.customer_mobile && ! empty order.columns.customer_telephone && ! empty order.columns.customer_telephone2}">
						联系方式：${order.columns.customer_telephone },${order.columns.customer_telephone2 }
					</c:if>
					<c:if test="${not empty order.columns.customer_mobile && ! empty order.columns.customer_telephone && ! empty order.columns.customer_telephone2}">
						联系方式：${order.columns.customer_mobile },${order.columns.customer_telephone },${order.columns.customer_telephone2 }
					</c:if>
					<c:if test="${ empty order.columns.customer_mobile && empty order.columns.customer_telephone && empty order.columns.customer_telephone2}">
						联系方式:
					</c:if>

			</td>

		</tr>
		<tr>
			<td colspan="2">详细地址：${order.columns.customer_address}</td>
			<td style="width: 34%;">受理时间：<fmt:formatDate value="${order.columns.create_time }" pattern="yyyy-MM-dd hh:mm"/></td>
		</tr>
	</table>

	<table class="printTable"style="margin-top:5px">
		<caption style="text-align:left;">家电信息</caption>
		<tr>
			<td style="width: 33%;">报修家电：${order.columns.appliance_brand }${order.columns.appliance_category }</td>
			<td style="width: 33%;">家电数量：${order.columns.appliance_num }</td>
			<td style="width: 34%;">购买时间：<fmt:formatDate value="${order.columns.appliance_buy_time }" pattern="yyyy-MM-dd"/></td>
		</tr>
		<tr>
			<td>产品型号：${order.columns.appliance_model }</td>
			<td >内机条码：${order.columns.appliance_barcode }</td>
			<td >外机条码：${order.columns.appliance_machine_code }</td>
		</tr>
	</table>

	<table class="printTable"style="margin-top:5px">
		<caption style="text-align:left;">服务信息</caption>
		<tr>
			<td style="width: 33%;">
				服务类型：${order.columns.service_type }
			</td>
			<td style="width: 33%;">服务方式：${order.columns.service_mode }</td>
			<td style="width: 34%;">预约时间：<fmt:formatDate value="${order.columns.promise_time }" pattern="yyyy-MM-dd"/>${order.columns.promise_limit }</td>
		</tr>
		<tr>
			<td>保修类型：<c:if test="${order.columns.warranty_type eq '1'}">保内</c:if>
				<c:if test="${order.columns.warranty_type eq '2'}">保外</c:if>
				<c:if test="${order.columns.warranty_type eq '3'}">保外转保内</c:if>
			</td>
			<td>信息来源：${order.columns.origin }</td>
			<td>重要程度：<c:if test="${order.columns.level eq '1'}">紧急</c:if><c:if test="${order.columns.level eq '2'}">一般</c:if></td>
		</tr>
		<tr>
			<td colspan="2">服务描述：${order.columns.customer_feedback }</td>
			<td>信息备注：${order.columns.remarks }</td>
		</tr>
	</table>
	<table class="printTable" style="margin-top:5px">
		<caption style="text-align:left;">其他信息</caption>
		<%-- <tr>
			<td style="width: 33%;">服务费：<c:if test="${order.columns.serveCost != '0.0' && order.serveCost != '' }">${order.serveCost }</c:if></td>
			<td style="width: 33%;">材料费: <c:if test="${order.columns.auxiliaryCost != '0.0' && order.auxiliaryCost != ''}">${order.auxiliaryCost }</c:if></td>
			<td style="width: 34%;">延保费: <c:if test="${order.columns.warrantyCost != '0.0' && order.warrantyCost != '' }">${order.warrantyCost }</c:if></td>
		</tr>
		<tr>
			<td>合计金额：<c:if test="${order.columns.confirmCost != '0.0' && order.columns.confirmCost != ''  }">${order.columns.confirmCost }</c:if></td>
			<td colspan="2">备注：</td>
		</tr> --%>
		<tr>
			<td>完工时间：<fmt:formatDate value="${order.columns.end_time }" pattern="yyyy-MM-dd hh:mm"/></td>
			<td>评价：<%-- <c:if test="${order.columns.service_attitude eq '1'}">十分不满意</c:if>
				<c:if test="${order.columns.service_attitude eq '2'}">不满意</c:if>
				<c:if test="${order.columns.service_attitude eq '3'}">一般</c:if>
				<c:if test="${order.columns.service_attitude eq '4'}">满意</c:if>
				<c:if test="${order.columns.service_attitude eq '5'}">十分满意</c:if> --%>
			</td>
			<td>用户签字：</td>
		</tr>
		<tr>
			<td >服务商：${site.name}</td>
			<td>监督电话：${site.telephone}</td>
			<td >服务工程师：${order.columns.employe1}  ${order.columns.employe2}  ${order.columns.employe3}</td>
		</tr>
	</table>

	

</div>
<c:if test="${!stat.last}" >
	<div style="page-break-after:always;"></div>
</c:if>
</c:forEach>
</div>


</body>

</html>
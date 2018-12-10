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
            $.ajax({url:"${ctx}/print/writeMorePrintTimes", type:"post", data:{numbers:numbers}, success:function(result){}});
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
	<input type="button" value="打印" id="btn" onclick="printOrder();" class="btn-print" style="width:100px;height:30px; padding: 0;font-size: 14px;background: none;border: 1px solid #ccc;" data-type="print" />
</div>
<div id="printContainer">
	<c:forEach items="${orders}" var="order" varStatus="stat">
		<div class="printpage printpage2">
			<h2 class="title" style="font-size: 32px;">365家电派工单</h2>
			<div class="cl" style="margin-top: 10px;font-size: 22px;">
				<div class="f-l" style="width: 33%;">品牌：${order.columns.appliance_brand }</div>
				<div class="f-l"style="width: 34%;">类别：${order.columns.appliance_category }</div>
				<div class="f-l"style="width: 30%;">派单号：${order.columns.number }</div>
			</div>
			<table class="printTable" style="font-size: 20px;">
				<tr>
					<td style="width: 33%;">用户姓名：${order.columns.customer_name }</td>
					<td style="width: 34%;">联系电话：${order.columns.customer_mobile }</td>
					<td >报修时间：<fmt:formatDate value="${order.columns.create_time }" pattern="yyyy-MM-dd hh:mm"/></td>
				</tr>
				<tr>
						<c:if test="${order.columns.province eq order.columns.city}">
							<td colspan="2">用户地址：${order.columns.city}${order.columns.area}${order.columns.customer_address}</td>
						</c:if>
						<c:if test="${order.columns.province ne order.columns.city}">
							<td colspan="2">用户地址：${order.columns.city}${order.columns.area}${order.columns.customer_address}</td>
						</c:if>
					<%--<td >购机日期：<fmt:formatDate value="${order.applianceBuyTime }" pattern="yyyy-MM-dd"/></td>--%>
					<td>故障：${order.columns.customer_feedback}</td>
				</tr>
				<tr>
					<td colspan="3" class="cl">
						<span style="width:200px">型号： ${order.columns.appliance_model }</span>
						<c:if test="${not empty order.columns.appliance_barcode &&  not empty order.columns.appliance_machine_code}">
						<span style="margin-left: 15px;">机号： ${order.columns.appliance_barcode }，${order.columns.appliance_machine_code }</span>
						</c:if>
						<c:if test="${not empty order.columns.appliance_barcode  && empty order.columns.appliance_machine_code}">
						<span style="margin-left: 15px">机号： ${order.columns.appliance_barcode }</span>
						</c:if>
						<c:if test="${ empty order.columns.appliance_barcode &&  not empty order.columns.appliance_machine_code}">
						<span style="margin-left: 15px">机号： ${order.columns.appliance_machine_code }</span>
						</c:if>
						<c:if test="${ empty order.columns.appliance_barcode && empty order.columns.appliance_machine_code}">
						<span style="margin-left: 15px">机号：</span>
						</c:if>
						<span style="margin-right: 20px" class="f-r">商场： ${order.columns.origin }</span>
						<span style="margin-right: 15px; " class="f-r">购机日期：<fmt:formatDate value="${order.columns.appliance_buy_time }" pattern="yyyy-MM-dd hh:mm"/> </span>
						<span style="margin-right: 15px" class="f-r">发票号码： </span>
					</td>
				</tr>
				<%--<tr>--%>
					<%--<td colspan="3">故障：${order.customerFeedback}</td>	--%>
				<%--</tr>--%>
				<%--<tr>--%>
					<%--<td >商场：${order.origin }</td>--%>
					<%--<td >型号：${order.applianceModel }</td>--%>
					<%--<td >机号：${order.applianceBarcode }，${order.applianceMachineCode }</td>--%>
				<%--</tr>--%>
				<tr>
				<c:choose>
					<c:when test="${order.columns.warranty_type eq '1'}">
					<td>保修：保内</td>
				</c:when>
					<c:when test="${order.columns.warranty_type eq '2'}">
					<td>保修：保外</td>
				</c:when>
				<c:otherwise>
				<td>保修：</td>
				</c:otherwise>
				</c:choose>		
					<td >上门费：</td>
			
					<td>备注：${order.columns.remarks }</td>
				</tr>
				<tr>
					<td colspan="3">
						服务满意度：1. 非常满意【无罚】；&nbsp;&nbsp;2. 满意【罚20】；&nbsp;&nbsp;3. 一般【罚50】；&nbsp;&nbsp;4. 不满意【罚100】
					</td>
				</tr>
				<tr>
					<td colspan="3">服务规范：
					1. 是、否穿工作服；&nbsp;&nbsp;2. 是、否带工牌（监督卡）；&nbsp;&nbsp;3. 是、否及时上门；&nbsp;&nbsp;4. 是、否试机；&nbsp;&nbsp;5. 是、否测电
					</td>
				</tr>
				<tr>
					<td colspan="2">
						经检查：（1）我家的水龙头存在漏（跑）水危险。（2）插座没有有效接地线。我承诺将请相关专业人员整改后，再使用贵公司产品。
						安装提供附件收费（底座，水龙头，进水管，机罩等）用户自备水龙头不负责安装，若出现问题用户自行解决。
						
					</td>
					<td colspan="1">
						<div style="height: 60px;">用户签名及日期：</div>
					</td>
				</tr>
				<tr>
					<td colspan="3" style="padding: 0;">
						<div class="f-l text-c" style="width: 10%;padding: 5px; line-height: 110px;">服务过程</div>
						<div class="f-l" style="width: 90%;border-left: 1px solid #000;">
							<div class="cl" style="border-bottom: 1px solid #000;">
								<div class="f-l" style="width: 50%; height: 80px; padding: 5px;">
									首次上门：
								</div>
								<div class="f-l" style="border-left: 1px solid #000;width: 50%; height: 80px;padding: 5px;">
									二次上门：
								</div>
							</div>
							<div class="cl">
								<div class="f-l" style="width: 50%; height: 80px;padding: 5px;">
									三次上门
								</div>
								<div class="f-l" style="border-left: 1px solid #000;width: 50%; height: 80px;padding: 5px;">
									四次上门：
								</div>
								
							</div>
						</div>	
					</td> 
					
				</tr>
				<tr>
					<td colspan="3">
						<div class="f-l" style="height: 40px;">用户签名及日期：</div>
						<div class="f-r" style="height: 40px;">工程师签字：<span style="width: 150px;"></span></div>
					</td>
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
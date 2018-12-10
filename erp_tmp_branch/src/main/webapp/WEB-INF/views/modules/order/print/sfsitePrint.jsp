<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<%--<meta name="decorator" content="base"/>--%>
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
	<meta http-equiv="Cache-Control" content="no-siteapp" />

	<title>工单打印</title>

	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/print_site_style.css"/>
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
<h4>广远家电维修服务中心服务工单</h4>
<p>
<span>工单编号：${order.number }</span>
<span class="times">派单时间：</span>
</p>
<table border="1" cellpadding="0" cellspacing="0" >
    <thead>
    <tr>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td>用户姓名：</td>
        <td colspan="2">${order.customerName }</td>
        <td>详细地址：</td>
        <td colspan="5">
        <c:if test="${order.province eq order.city}">
				详细地址：${order.city}${order.area}${order.customerAddress}
			</c:if>
			<c:if test="${order.province ne order.city}">
				${order.province}${order.city}${order.area}${order.customerAddress}
			</c:if>
        </td>
    </tr>
    <tr>
        <td>联系电话1：</td>
        <td colspan="2">${order.customerMobile }</td>
        <td>联系电话2：</td>
        <td colspan="2">${order.customerTelephone }</td>
        <td>联系电话3：</td>
        <td colspan="2">${order.customerTelephone2 }</td>
    </tr>
    <tr>
        <td>服务类型：</td>
        <td colspan="2">${order.serviceType }</td>
        <td>服务方式:</td>
        <td colspan="2">${order.serviceMode }</td>
        <td>保修类型：</td>
        <td colspan="2"><c:if test="${order.warrantyType eq '1'}">保内</c:if>
				<c:if test="${order.warrantyType eq '2'}">保外</c:if>
				<c:if test="${order.warrantyType eq '3'}">保外转保内</c:if></td>
    </tr>

    <tr>
        <td>家电品牌：</td>
        <td colspan="2">${order.applianceBrand }</td>
        <td>家电品类：</td>
        <td colspan="2">${order.applianceCategory }</td>
        <td>家电数量：</td>
        <td colspan="2">${order.applianceNum }</td>
    </tr>
    <tr>
        <td>产品型号：</td>
        <td colspan="2">${order.applianceModel }</td>
        <td>内机条码：</td>
        <td colspan="2">${order.applianceBarcode }</td>
        <td>外机条码：</td>
        <td colspan="2">${order.applianceMachineCode }</td>
    </tr>
    <tr>
        <td>受理时间：</td>
        <td colspan="2"><fmt:formatDate value="${order.createTime }" pattern="yyyy-MM-dd hh:mm"/></td>
        <td>购买时间：</td>
        <td colspan="2"><fmt:formatDate value="${order.applianceBuyTime }" pattern="yyyy-MM-dd"/></td>
        <td>完工时间：</td>
        <td colspan="2"><fmt:formatDate value="${rd.columns.end_time }" pattern="yyyy-MM-dd hh:mm"/></td>
    </tr>
    <tr>
        <td>信息描述：</td>
        <td colspan="8">${order.customerFeedback }  ${order.remarks }</td>
    </tr>
    <tr>
        <td colspan="9"><p style=" height: 60px;margin-top: 5px;">实际服务内容：</p></td>
    </tr>

    <tr>
        <td>材料明细：</td>
        <td colspan="2"></td>
        <td>服务费：</td>
        <td align="center"></td>
        <td>材料费：</td>
        <td align="center"></td>
        <td>费用合计：</td>
        <td align="center"></td>
    </tr>
    <tr>
        <td>接单员：</td>
        <td colspan="2">${order.xm}</td>
        <td>服务评价：</td>
        <td colspan="5">
        <label><input type="checkbox" />满意</label>
        <label><input type="checkbox" />一般</label>
        <label><input type="checkbox" />不满意</label>
        </td>
    </tr>
    <tr>
        <td colspan="9">
        <p class="fu"><span>服务人员:${order.employeName}</span><span>用户签名:</span></p></td>
    </tr>
    <tr>
        <td colspan="9" id="fs-12" style="height: 50px;">尊敬的用户：感谢您长期对我们的支持与信赖，如服务过程中服务人员不按标准规范操作、乱收取费用、服务态度不佳等问题请来电来函投诉，我们一经查实将对相关人员作出严肃处理，请您给予监督！服务电话0571-63719636</td>
    </tr>
    </tbody>
</table>

</div>
</body>

</html>
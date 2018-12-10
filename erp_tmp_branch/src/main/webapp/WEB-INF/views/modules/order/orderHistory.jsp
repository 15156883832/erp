<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>工单录入</title>
<meta name="decorator" content="base"/>

<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/formatStatus.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/dateUtils.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.cityselect.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script> 

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
<div class="popupBox historyOrder">
	<h2 class="popupHead">
		历史工单
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pb-60 pos-r">
		<div class="popupMain ">
			<div class="tableWrap text-c">
				<table class="table table-bg table-border table-bordered table-sdrk">
					<thead>
					<tr>
						<th style="width:50px;">序号</th>
						<th class="w-170">工单编号</th>
						<th class="w-100">工单状态</th>
						<th class="w-100">用户姓名</th>
						<th class="w-100">联系电话</th>
						<th class="w-200">详细地址</th>
						<th class="w-100">家电品牌</th>
						<th class="w-100">家电品类</th>
						<th class="w-100">家电型号</th>
						<th class="w-100">内机条码</th>
						<th class="w-100">外机条码</th>
						<th class="w-150">购机时间</th>
						<th class="w-100">保修类型</th>
						<th class="w-150">报修时间</th>
						<th class="w-100">服务工程师</th>
						<th class="w-150">完工时间</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach items="${orders}" var="order" varStatus="obs">
						<tr>
							<td title="${obs.index + 1}">${obs.index + 1}</td>
							<td title="${order.columns.number}">${order.columns.number}</td>
							<td title="${order.columns.stas }">${order.columns.stas }</td>
							<td title="${order.columns.customer_name}">${order.columns.customer_name}</td>
							<td title="${order.columns.customer_mobile}">${order.columns.customer_mobile}</td>
							<td title="${order.columns.province}${order.columns.city}${order.columns.area}${order.columns.customer_address}">${order.columns.province}${order.columns.city}${order.columns.area}${order.columns.customer_address}</td>
							<td title="${order.columns.appliance_brand}">${order.columns.appliance_brand}</td>
							<td title="${order.columns.appliance_category}">${order.columns.appliance_category}</td>
							<td title="${order.columns.appliance_model}">${order.columns.appliance_model}</td>
							<td title="${order.columns.appliance_barcode}">${order.columns.appliance_barcode}</td>
							<td title="${order.columns.appliance_machine_code}">${order.columns.appliance_machine_code}</td>
							<td title="${order.columns.buyTime}">${order.columns.appliance_buy_time}</td>
							<td title="${order.columns.typ}">${order.columns.typ}</td>
							<td title="${order.columns.repairTime}">${order.columns.repair_time}</td>
							<td title="${order.columns.employe_name}">${order.columns.employe_name}</td>
							<td title="${order.columns.endTime}">${order.columns.end_time}</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<div class="text-c btnWrap">
			<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" id="closPop">关闭</a>
		</div>
	</div>
</div>

<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script>
	$(function() {
	    $(".historyOrder").popup();
	});
    $('#closPop').on('click',function(){
        $.closeDiv($(".historyOrder"), true);
    });
</script>
</body>
</html>

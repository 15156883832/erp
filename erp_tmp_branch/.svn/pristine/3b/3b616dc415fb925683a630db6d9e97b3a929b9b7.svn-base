<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<title>全部工单</title>
<meta name="decorator" content="base" />
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
  <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script> 
<style type="text/css">
	#imageShow{
		width:456px;
		height:456px;
		text-align:center;
	}
	#imageShow img{ max-width:100%;}
	.divcss5{ height:1px; width:100%; border-bottom:1px dashed #000;margin-bottom: 8px;background-color:#e0e0e0}
</style>
</head>
<body>

<!-- 确认出库 -->
<div class="popupBox spqrck" style="width:600px;">
	<h2 class="popupHead" >
		<span id="querenchuku">确认发货</span>
		<a href="javascript:guanbi();" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<div class="popupMain " style=" max-height:500px;overflow:auto;">
			<h3 class="modelHead mb-10">订单信息</h3>
			<div class="cl mb-10">
				<label class="f-l w-80">订单编号：</label>
				<input type="text" class="input-text w-170 f-l readonly" name="orderNumber" readonly="readonly"
					   value="${order.columns.number }"/>
				<label class="f-l w-100 text-r">订单状态：</label>
				<input type="text" class="input-text w-170 f-l readonly" name="createName" readonly="readonly"
					   value="${order.columns.wStatus }"/>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-80 text-r">投保时间：</label>
				<input type="text" class="input-text w-170 f-l readonly" name="goodName" readonly="readonly"
					   value="<fmt:formatDate value='${order.columns.payment_time }' pattern='yyyy-MM-dd HH:mm'/>"/>
				<label class="f-l w-100 text-r">数据同步状态：</label>
				<input type="text" class="input-text w-170 f-l readonly" name="createName" readonly="readonly"
					   value="${order.columns.wSStatus }"/>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-80 text-r">保单类型：</label>
				<input type="text" class="input-text w-170 f-l readonly" name="payType" readonly="readonly" value="${order.columns.wType }"/>
				<label class="f-l w-100 text-r">付款金额：</label>
				<div class="priceWrap w-170 readonly f-l readonly">
					<input type="text" class="input-text w-120 f-l readonly" name="payAmount" readonly="readonly" value="${order.columns.logistics_price }"/>
					<span class="unit">元</span>
				</div>
			</div>
			<div class="divcss5"></div>
			<div class="cl mb-10">
				<label class="f-l w-80 text-r">投保人：</label>
				<input type="text" class="input-text w-170 f-l readonly" name="recipients" readonly="readonly" value="${order.columns.customer_name }"/>
				<label class="f-l w-100 text-r">投保电话：</label>
				<input type="text" class="input-text w-170 f-l readonly" name="mobile" readonly="readonly" value="${order.columns.customer_contact }"/>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-80 text-r">投保地址：</label>
				<input type="text" class="input-text f-l readonly" style="width: 440px" name="receiverAddress" readonly="readonly" value="${order.columns.province }${order.columns.city }${order.columns.area }${order.columns.customer_address }"/>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-80 text-r">家电品类：</label>
				<input type="text" class="input-text w-170 f-l readonly" name="recipients" readonly="readonly" value="${order.columns.good_category }"/>
				<label class="f-l w-100 text-r">家电品牌：</label>
				<input type="text" class="input-text w-170 f-l readonly" name="mobile" readonly="readonly" value="${order.columns.good_brand }"/>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-80 text-r">购机时间：</label>
				<input type="text" class="input-text w-170 f-l readonly" name="recipients" readonly="readonly" value="<fmt:formatDate value='${order.columns.buy_time }' pattern='yyyy-MM-dd'/>"/>
				<label class="f-l w-100 text-r">购机价格：</label>
				<div class="priceWrap w-170 readonly f-l readonly">
					<input type="text" class="input-text w-120 f-l readonly" name="payAmount" readonly="readonly" value="${order.columns.good_amount }"/>
					<span class="unit">元</span>
				</div>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-80 text-r">家电条码：</label>
				<input type="text" class="input-text w-170 f-l readonly" name="recipients" readonly="readonly" value="${order.columns.applicance_barcode }"/>
			</div>
			<c:if test="${order.columns.warranty_type=='1' }">
				<div class="divcss5"></div>
				<div class="cl mb-10" >
					<label class="f-l w-80 text-r">物流名称：</label>
					<span class="w-170 f-l">
							<select class="select " name="logisticsName1" id="logisticsName1" style="width:100%;height:25px" panelMaxHeight="130px">
								  <option value="中通快递" selected="selected">中通快递</option>
								  <option value="顺丰速运">顺丰速运</option>
								  <option value="EMS">EMS</option>
								  <option value="申通快递">申通快递</option>
								  <option value="圆通快递">圆通快递</option>
								  <option value="韵达快递">韵达快递</option>
								  <option value="百世汇通快递">百世汇通快递</option>
								  <option value="天天快递">天天快递</option>
								  <option value="德邦物流">德邦物流</option>
								  <option value="全一快递">全一快递</option>
								  <option value="全峰快递">全峰快递</option>
								  <option value="盛辉物流">盛辉物流</option>
								  <option value="中铁快运">中铁快运</option>
							</select>
						</span>
						<label class="f-l w-100 text-r">物流单号：</label>
						<input type="text" class="input-text w-170 f-l "  id="logisticsNo"  value="${order.columns.logistics_no }"/>
				</div>
			</c:if>
		</div>
		<div class="text-c pb-10" id="xiangqingon" style="direction: none;">
			<input type="text" hidden="hidden" class="input-text w-370 f-l readonly" id="id" readonly="readonly" value="${order.columns.id }" />
			<c:if test="${order.columns.warranty_type=='1' }">
				<c:if test="${order.columns.status=='1' }">
					<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-10" onclick = "printOrder('${order.columns.id }')">打印</a>
					<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-10" onclick = "outStockConfirm('${order.columns.id }')">发货</a>
				</c:if>
			</c:if>
			<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="guanbi()">关闭</a>
		</div>
		
	</div>
</div>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript">
var name = '${order.columns.logistics_name }';
$(function(){
	$(".spqrck").popup();
	$("#logisticsName1").find("option").each(function(){
		var val = $(this).text();
		if(!isBlank(val)){
			if(name==val){
				$(this).attr("selected",true);
			}
		}
	})
})

function guanbi(){
	$.closeAllDiv();
	
}

function isBlank(val) {
    if(val==null || val=='' || val == undefined) {
        return true;
    }
    return false;
}
var outMark = false;
function outStockConfirm(id){
	if(outMark){
		return;
	}
	var logisticsName = $("#logisticsName1").val();
	var logisticsNo = $("#logisticsNo").val();
	if(isBlank(logisticsName)){
		layer.msg("请选择物流名称！");
		return;
	}
	if(isBlank(logisticsNo)){
		layer.msg("请选择物流单号！");
		return;
	}
	outMark = true;
	$.ajax({
		type:"post",
		data:{id:$("#id").val(),logisticsName:logisticsName,logisticsNo:logisticsNo},
		url:"${ctx}/goods/platform/outStockWarranty",
		success:function(data){
			outMark = false;
			if(data=='200'){
				layer.msg("发货成功！");
				window.location.parent.search();
				guanbi();
			}else{
				layer.msg("发货失败！");
			}
			return;
		},
		error:function(){
			layer.msg("发货失败！");
			outMark = false;
			return;
		}
	})
}

function printOrder(id){
   	window.open("${ctx}/goods/platform/printOrder?id="+id);
}
</script>

</body>
</html>
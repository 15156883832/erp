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
</style>
</head>
<body>
	<div class="sfpagebg bk-gray">
		<div class="sfpage">
			<div class="page-orderWait">
				<div id="tab-system" class="HuiTab">
					<div class="tabBar cl mb-10">
						<a class="btn-tabBar current" href="${ctx }/goods/platform/getPublicNumberOrdersHead">公众号订单</a>
						<a class="btn-tabBar " href="${ctx }/goods/platform/getWarrantyOrderHeader">无忧保订单</a>
						<p class="f-r btnWrap">
							<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
							<a href="javascript:;" class="sfbtn sfbtn-opt moresearch" id="moresearch" ><i class="sficon sficon-moresearch"></i>收起</a>
							<a href="javascript:;" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
						</p>
					</div>
					<div class="tabCon">
						<form id="searchForm">
							<input type="hidden" name="page" id="pageNo" value="1">
							<input type="hidden" name="rows" id="pageSize" value="20">
							<div class="bk-gray pt-10 pb-5 moreCondition mb-10">
								<table class="table table-search">
									<tr class="moreCondition" style="">
										<th style="width: 76px;" class="text-r">订单编号：</th>
										<td>
											<input type="text" class="input-text" value="" name="number" id="number" />
										</td>
										<th style="width: 76px;" class="text-r">订单状态：</th>
										<td>
											<span class="select-box">
												<select class="select" name="orderStatus">
													<option value="">请选择</option>
													<option value="1">待出库</option>
													<option value="2">已出库</option>
													<option value="3">已完成</option>
													<option value="4">用户取消</option>
												</select>
											</span>
										</td>
										<th style="width: 76px;" class="text-r">下单人：</th>
										<td>
											<input type="text" class="input-text" value="" onkeydown="enterEvent(event)" name="placeOrderBy" id="placeOrderBy" />
										</td>
										<th style="width: 76px;" class="text-r">商品编号：</th>
										<td>
											<input type="text" class="input-text" name = "goodNumber"/>
										</td>
										<th style="width: 76px;" class="text-r">商品名称：</th>
										<td>
											<input type="text" class="input-text" name = "goodName"/>
										</td>



									</tr>
									<tr class="moreCondition" style="">
										<th style="width: 76px;" class="text-r">支付方式：</th>
										<td>
											<span class="select-box">
												<select class="select" name="paymentType">
													<option value="">请选择</option>
													<option value="0">微信</option>
													<option value="1">支付宝</option>
												</select>
											</span>
										</td>
									<!-- 	<th style="width: 76px;" class="text-r">出库方式：</th>
										<td>
											<span class="select-box">
												<select class="select" name="outStockType">
													<option value="">请选择</option>
													<option value="0">公司库存</option>
													<option value="1">厂家库存</option>
												</select>
											</span>
										</td> -->

										<th style="width: 76px;" class="text-r">下单时间：</th>
										<td colspan="5">
											<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'createTimeMax\')||\'%y-%M-%d\'}'})"  id=createTimeMin name="createTimeMin" value="" class="input-text Wdate w-120" style="width:120px">
											至
											<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'createTimeMin\')}',maxDate:'%y-%M-%d'})" id="createTimeMax" name="createTimeMax"  value="" class="input-text Wdate w-120" style="width:120px">
											<lable style="width: 76px;" class="text-r">出库时间：</lable>
											<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'outTimeMax\')||\'%y-%M-%d\'}'})"  id=outTimeMin name="outTimeMin" value="" class="input-text Wdate w-120" style="width:120px">
											至
											<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'outTimeMin\')}',maxDate:'%y-%M-%d'})" id="outTimeMax" name="outTimeMax"  value="" class="input-text Wdate w-120" style="width:120px">
										</td>
									</tr>
								</table>
							</div>

						</form>
						<div class="pb-5 cl">
							<div class="f-r">
								<a  class="sfbtn sfbtn-opt2" onclick="return expotrs()" target="_blank"><i class="sficon sficon-export"></i>导出</a>
							</div>
											
						</div>
						<div class="mt-10">
							<table id="table-waitdispatch" class="table"></table>
							<!-- pagination -->
							<div class="cl pt-10">
								<div class="f-l">
								
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

	<!-- 不通过 -->
	<div class="popupBox shfkbox butongguoyuanyin">
		<h2 class="popupHead">
			不通过原因
			<a href="javascript:closeNoPass();" class="sficon closePopup" ></a>
		</h2>
		<div class="popupContainer">
			<div class="popupMain pd-20">
				<textarea class="textarea" placeholder="请填写不通过原因" id="reason"></textarea>
				<div class="text-c mt-25">
					<a href="javascript:noPassSubmitNow();" class="sfbtn sfbtn-opt3 w-70 mr-5">发送</a>
					<a href="javascript:closeNoPass();" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
				</div>

			</div>
		</div>
	</div>

	<div class="popupBox shfkbox shfkboxjj shfkboxjjbtg" style="width: 560px">
		<h2 class="popupHead">
			审核
			<a href="javascript:closeDivApp1();" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer">
			<div class="popupMain pt-15 pb-15">
				<h3 class="modelHead mb-10">订单信息</h3>
				<div class="cl mb-10">
					<label class="f-l w-80">订单编号：</label>
					<input type="text" class="input-text w-170 f-l readonly" name="orderNumber" readonly="readonly" value=""/>
					<label class="f-l w-100 text-r">下单人：</label>
					<input type="text" class="input-text w-170 f-l readonly" name="createName" readonly="readonly" value=""/>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-80 text-r">商品名称：</label>
					<input type="text" class="input-text w-170 f-l readonly" name="goodName" readonly="readonly" value=""/>
					<label class="f-l w-100 text-r">购买数量：</label>
					<div class="priceWrap w-170 readonly f-l readonly">
						<input type="text" class="input-text readonly" name="goodNum" readonly="readonly" value=""/>
						<span class="unit">个</span>
					</div>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-80 text-r">支付金额：</label>
					<div class="priceWrap w-140 readonly f-l readonly">
						<input type="text" class="input-text w-120 f-l readonly" name="payAmount" readonly="readonly" value=""/>
						<span class="unit">元</span>
					</div>
					<span class="f-l proofImg" id="aIdentity"><a class="c-0383dc">凭证</a> <img src=""/> </span>
					<label class="f-l w-90 text-r">付款方式：</label>
					<input type="text" class="input-text w-170 f-l readonly" name="payType" readonly="readonly" value=""/>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-80 text-r">收件人：</label>
					<input type="text" class="input-text w-170 f-l readonly" name="recipients" readonly="readonly" value=""/>
					<label class="f-l w-100 text-r">联系方式：</label>
					<input type="text" class="input-text w-170 f-l readonly" name="mobile" readonly="readonly" value=""/>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-80 text-r">收货地址：</label>
					<input type="text" class="input-text f-l readonly" style="width: 440px" name="receiverAddress" readonly="readonly" value=""/>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-80 text-r">备注：</label>
					<input type="text" class="input-text f-l" style="width: 440px" value="" name="remark"/>
				</div>
				<div class="text-c mt-20">
					<input type="hidden" class="input-text w-380 f-l" value="" name="id"/>
					<a href="javascript:javascript:pass();" class="sfbtn sfbtn-opt3 w-70 mr-5">通过</a>
					<a href="javascript:javascript:noPassSubmit();" class="sfbtn sfbtn-opt3 w-70 mr-5">不通过</a>
					<a href="javascript:javascript:closeDivApp1();" class="sfbtn sfbtn-opt3 w-70 mr-5">关闭</a>
				</div>
			</div>
		</div>
	</div>

<!-- 确认出库 -->
<div class="popupBox spqrck" style="width:600px;">
	<h2 class="popupHead" >
		<span id="querenchuku">确认出库</span>
		<a href="javascript:guanbi();" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<div class="popupMain " style=" max-height:500px;overflow:auto;">
			<h3 class="modelHead mb-10">订单信息</h3>
			<div class="cl mb-10">
				<label class="f-l w-80">订单编号：</label>
				<input type="text" class="input-text w-170 f-l readonly" name="orderNumber" readonly="readonly"
					   value=""/>
				<label class="f-l w-100 text-r">下单人：</label>
				<input type="text" class="input-text w-170 f-l readonly" name="createName" readonly="readonly"
					   value=""/>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-80 text-r">商品名称：</label>
				<input type="text" class="input-text w-170 f-l readonly" name="goodName" readonly="readonly"
					   value=""/>
				<label class="f-l w-100 text-r">购买数量：</label>
				<div class="priceWrap w-170 readonly f-l readonly">
					<input type="text" class="input-text readonly" name="goodNum" readonly="readonly" value=""/>
					<span class="unit">个</span>
				</div>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-80 text-r">支付金额：</label>
				<div class="priceWrap w-170 readonly f-l readonly">
					<input type="text" class="input-text w-120 f-l readonly" name="payAmount" readonly="readonly" value=""/>
					<span class="unit">元</span>
				</div>
				<label class="f-l w-100 text-r">支付方式：</label>
				<input type="text" class="input-text w-170 f-l readonly" name="payType" readonly="readonly" value=""/>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-80 text-r">收件人：</label>
				<input type="text" class="input-text w-170 f-l readonly" name="recipients" readonly="readonly" value=""/>
				<label class="f-l w-100 text-r">联系方式：</label>
				<input type="text" class="input-text w-170 f-l readonly" name="mobile" readonly="readonly" value=""/>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-80 text-r">收货地址：</label>
				<input type="text" class="input-text f-l readonly" style="width: 440px" name="receiverAddress" readonly="readonly" value=""/>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-80 text-r">备注：</label>
				<input type="text" class="input-text f-l readonly" readonly="readonly" style="width: 440px" value="" name="remark"/>
			</div>
			<div class="cl mb-10" >
				<label class="f-l w-80 text-r">出库方式：</label>
				<div class="f-l pt-5 w-170" id="outtyOut">
					<label class="f-l mr-10 radiobox radiobox-selected" id="manageOut">
						<input type="radio" value="0"/>公司库存
					</label>
					<label class="f-l radiobox " id="factoryOut">
						<input type="radio" value="1"/>厂家库存
					</label>
				</div>
				<label class="f-l w-100 text-r">出库数量：</label>
				<div class="priceWrap w-170 f-l">
					<input type="text" class="input-text w-120 f-l" name="outAmount" value=""/>
					<span class="unit">个</span>
				</div>
			</div>
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
			</div>
			<div class=" pos-r pl-80">
				<label class="pos w-80 text-r">物流单号：</label>
				<div class="cl logisticsNosWrap" id="logisticsNosWrap">
					<div class="f-l w-220 mb-10">
						<input type="text" class="input-text w-170 f-l" name="logisticsNo1" id="logisticsNo1" value=""/>
						<!-- <a class="sficon sficon-add2 ml-5 mt-3 f-l addLogisticsNo" id="addLogisticsNo"></a> -->
					</div>
				</div>
			</div>
		</div>
		<div class="text-c pb-10" id="xiangqingon" style="direction: none;">
			<input type="text" hidden="hidden" class="input-text w-370 f-l readonly" id="id1" readonly="readonly" value="" />
			<input type="text" hidden="hidden" class="input-text w-370 f-l readonly" id="goodId1" readonly="readonly" value="" />
			<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" onclick = "outStockConfirm()">出库</a>
			<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="guanbi()">关闭</a>
		</div>
		
	</div>
</div>

<div class="popupBox w-580 orderxq">
	<h2 class="popupHead">
		订单详情
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pt-15 pb-15">
			<h3 class="modelHead mb-10">订单信息</h3>
			<div class="cl mb-10">
				<label class="f-l w-80">订单编号：</label>
				<input type="text" class="input-text w-170 f-l readonly" name="orderNumber" readonly="readonly"
					   value=""/>
				<label class="f-l w-100 text-r">下单人：</label>
				<input type="text" class="input-text w-170 f-l readonly" name="createName" readonly="readonly"
					   value=""/>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-80 text-r">商品名称：</label>
				<input type="text" class="input-text w-170 f-l readonly" name="goodName" readonly="readonly"
					   value=""/>
				<label class="f-l w-100 text-r">购买数量：</label>
				<div class="priceWrap w-170 readonly f-l readonly">
					<input type="text" class="input-text readonly" name="goodNum" readonly="readonly" value=""/>
					<span class="unit">个</span>
				</div>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-80 text-r">支付金额：</label>
				<div class="priceWrap w-170 readonly f-l readonly">
					<input type="text" class="input-text w-120 f-l readonly" name="payAmount" readonly="readonly" value=""/>
					<span class="unit">元</span>
				</div>
				<label class="f-l w-100 text-r">付款方式：</label>
				<input type="text" class="input-text w-170 f-l readonly" name="payType" readonly="readonly" value=""/>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-80 text-r">收件人：</label>
				<input type="text" class="input-text w-170 f-l readonly" name="recipients" readonly="readonly" value=""/>
				<label class="f-l w-100 text-r">联系方式：</label>
				<input type="text" class="input-text w-170 f-l readonly" name="mobile" readonly="readonly" value=""/>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-80 text-r">收货地址：</label>
				<input type="text" class="input-text f-l readonly" style="width: 440px" name="receiverAddress" readonly="readonly" value=""/>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-80 text-r">备注：</label>
				<input type="text" class="input-text f-l readonly" readonly="readonly" style="width: 440px" value="" name="remark"/>
			</div>

			<div class="cl mb-10" >
				<label class="f-l w-80 text-r">出库方式：</label>
				<div class="f-l pt-5 w-170" id="outtyOut2">
					<label class="f-l mr-10 radiobox radiobox-selected" id="manageOut2">
						<input type="radio" value="0"/>公司库存
					</label>
					<label class="f-l radiobox " id="factoryOut2">
						<input type="radio" value="1"/>厂家库存
					</label>
				</div>
				<label class="f-l w-100 text-r">出库数量：</label>
				<div class="priceWrap w-170 f-l">
					<input type="text" class="input-text w-120 f-l readonly" name="outAmount" readonly="readonly" value=""/>
					<span class="unit">个</span>
				</div>
			</div>
			<div class="cl mb-10" >
				<label class="f-l w-80 text-r">物流名称：</label>
				<input type="text" class="input-text w-170 f-l readonly" name="logisticsName" readonly="readonly" value=""/>
				<label class="f-l w-100 text-r">物流单号：</label>
				<input type="text" class="input-text w-170 f-l readonly" name="logisticsNo" readonly="readonly"  value=""/>
			</div>
			<div class="text-c mt-20">
				<input type="hidden" id="goodsId">
<!-- 				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" onclick="Reexamination()" id="chongxinshenhe" style="display: none;">重新审核</a>
				<a href="javascript:javascript:updateOrder();" id="updateord" class="sfbtn sfbtn-opt3 w-70 mr-5">修改订单</a> -->
				<a href="javascript:javascript:closeDivApp2();" class="sfbtn sfbtn-opt3 w-70 mr-5">关闭</a>
			</div>
		</div>
	</div>
</div>

	<div class="popupBox w-600 updateOrder">
		<h2 class="popupHead">
			修改订单
			<a href="javascript:;" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer">
			<div class="popupMain pd-15" style=" max-height:500px;overflow:auto;">
				<h3 class="modelHead mb-10">订单信息</h3>
				<div class="cl mb-10">
					<label class="f-l w-80">订单编号：</label>
					<input type="text" class="input-text w-170 f-l readonly" name="orderNumber" readonly="readonly"
						   value=""/>
					<label class="f-l w-100 text-r">下单人：</label>
					<input type="text" class="input-text w-170 f-l readonly" name="createName" readonly="readonly"
						   value=""/>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-80 text-r">商品名称：</label>
					<input type="text" class="input-text w-170 f-l readonly" name="goodName" readonly="readonly"
						   value=""/>
					<label class="f-l w-100 text-r">购买数量：</label>
					<div class="priceWrap w-170 readonly f-l readonly">
						<input type="text" class="input-text readonly" name="goodNum" readonly="readonly" value=""/>
						<span class="unit">个</span>
					</div>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-80 text-r">支付金额：</label>
					<div class="priceWrap w-170 readonly f-l readonly">
					<input type="text" class="input-text w-120 f-l readonly" name="payAmount" readonly="readonly" value=""/>
					<span class="unit">元</span>
				</div>
					<label class="f-l w-100 text-r">付款方式：</label>
					<div class="w-170 f-l">
						<select name="payType" class="select w-170">
							<option value="0">微信</option>
							<option value="1">支付宝</option>
						</select>
					</div>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-80 text-r">收件人：</label>
					<input type="text" class="input-text w-170 f-l readonly" name="recipients" readonly="readonly" value=""/>
					<label class="f-l w-100 text-r">联系方式：</label>
					<input type="text" class="input-text w-170 f-l readonly" name="mobile" readonly="readonly" value=""/>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-80 text-r">收货地址：</label>
					<input type="text" class="input-text f-l readonly" style="width: 440px" name="receiverAddress" readonly="readonly" value=""/>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-80 text-r">备注：</label>
					<input type="text" class="input-text f-l "  style="width: 440px" value="" name="remark"/>
				</div>
				<div class="cl mb-10" id="logisticsInfoTwo">
					<label class="f-l w-80 text-r">出库方式：</label>
					<div class="f-l pt-5 w-170" id="outty">
						<label class="f-l mr-10 radiobox radiobox-selected" id="manage">
							<input type="radio" value="0"/>公司库存
						</label>
						<label class="f-l radiobox " id="factory">
							<input type="radio" value="1"/>厂家库存
						</label>
					</div>
					<label class="f-l w-100 text-r">出库数量：</label>
					<div class="priceWrap w-170 f-l">
						<input type="text" class="input-text w-120 f-l" name="outAmount" value=""/>
						<span class="unit">个</span>
					</div>
				</div>
				<div class="cl mb-10 logisticsInfo">
					<label class="f-l w-80 text-r">物流名称：</label>
					<span class="w-170 f-l">
						<select class="select " name="logisticsName" style="width:100%;height:25px" panelMaxHeight="130px">
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
					<!-- <label class="f-l w-100 text-r">物流单号：</label>
					<input type="text" class="input-text w-170 f-l" name="logisticsNo" value=""/> -->
				</div>
				<div class=" pos-r pl-80 logisticsInfo">
					<label class="pos w-80 text-r">物流单号：</label>
					<div class="cl logisticsNosWrap" id="">
						<div class="f-l w-220 mb-10">
							<input type="text" class="input-text w-170 f-l" name="logisticsNo1" id="logisticsNo" value=""/>
							<a class="sficon sficon-add2 ml-5 mt-3 f-l addLogisticsNo" ></a>
						</div>
					</div>
				</div>
			</div>	
			<div class="text-c pb-10">
				<a href="javascript:javascript:updateOrderNow();" class="sfbtn sfbtn-opt3 w-70 mr-5">保存</a>
				<a href="javascript:javascript:closeUpdate();" class="sfbtn sfbtn-opt3 w-70 mr-5">关闭</a>
			</div>
			
		</div>
	</div>

<div class="popupBox promptBox1" style="width:400px;">
	<h2 class="popupHead">提示<a href="javascript:;" class="sficon closePopup"></a></h2>
	<div class="popupContainer">
		<div class="popupMain  f-14" >
			<p class="text-c">
				<i class="iconType iconType2"></i>
				重新审核订单信息？
			</p>
			<div class="text-c mt-25 ">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 mr-10 " onclick="continueConfirm()">审核通过</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70" onclick="cancelFendan()">不通过</a>
			</div>
		</div>
	</div>
</div>
	
	<script type="text/javascript">
	var noPassId;
	var outStockId;
	var orderStatus;
	var sfGrid;
	var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
	var sortHeader = '${headerData.sortHeader}'; //服务商自定义过的表格头部
		$(function() {
			$.Huitab("#tab-system .tabBar span", "#tab-system .tabCon","current", "click", "0");
			$.tabfold("#moresearch", ".moreCondition", 1, "click");
			initSfGrid();
            $('#aIdentity').imgShow();
		});
	
/* 		$('.addLogisticsNo').on('click', function(){
			var logNo = $(this).prev('input').val();
			if(isBlank(logNo)){
				layer.msg("请输入单号！");
				return
			}
			$(this).prev('input').val('');
			var html='<div class="f-l w-220 mb-10 LogisNoBox">'+
				'<input type="text" class="input-text w-170 f-l readonly" name="logisticsNo1" value="'+logNo+'"/>'+
				'<a class="sficon sficon-reduce2 ml-5 mt-3 f-l delLogis"></a>'+
				'</div>';
			$(this).closest('.logisticsNosWrap').append(html);
		}); */
		
		$('.logisticsNosWrap').on('click','.delLogis', function(){
			$(this).parent('.LogisNoBox').remove();
		});
		

		//初始化jqGrid表格，传递的参数按照说明
		   function initSfGrid() {
				sfGrid = $("#table-waitdispatch").sfGrid({
					url : '${ctx}/goods/platform/getPublicNumberOrders',
					sfHeader : defaultHeader,
					sfSortColumns : sortHeader,
					multiselect:false,
                    rownumbers: true,
            		gridComplete:function(){
            			_order_comm.gridNum();
						if($("#table-waitdispatch").find("tr").length>1){
							$(".ui-jqgrid-hdiv").css("overflow","hidden");
						}else{
							$(".ui-jqgrid-hdiv").css("overflow","auto");
						}
					},
					loadComplete:function(){
                        $('.frozen-bdiv .proofImg').each(function(){
                            $(this).imgShow({hasIframe:true});
                        });
                    }
				});
			}

		function closeNoPass(){
		       $.closeDiv($(".butongguoyuanyin"));
		}

       //判断版本函数
    function versionOper(rowData) {
        var oDate = new Date();
        if (!rowData.due_time) {
            return "<span>免费版</span>";
        } else {
            var dueTime = new Date(rowData.due_time);
            if (oDate <= dueTime) {
                return "<span>收费版</span>";
            } else {
                return "<span>免费版</span>";
            }
        }
    }

		function search(){
			var pageSize = $("#pageSize").val();
			if ($.trim(pageSize) == '' || pageSize == null) {
				$("#pageSize").val(20);
			}
		    $("#table-waitdispatch").sfGridSearch({
		        postData: $("#searchForm").serializeJson()
		    });
		}
		
		function noPass(id){
			noPassId=id;
			$("#reason").val('');
            confirmOrder(id)
		}

		var updateRe=false;
		function updateOrderNow(){
		    if(updateRe){
		        return;
			}
            var payType=$(".updateOrder").find("select[name='payType']").val();//支付方式
            var outAmount=$(".updateOrder").find("input[name='outAmount']").val();//出库数量
            var outType=$("#outty").find(".radiobox-selected").children().val();//出库方式
            var logisticsName=$(".updateOrder").find("select[name='logisticsName']").val();//物流名称
            var remark=$(".updateOrder").find("input[name='remark']").val();//物流单号
			var orderId=$("#goodsId").val();
          //  var logisticsNo=$(".updateOrder").find("input[name='logisticsNo']").val();//物流单号
            var logisticsNo = "";
            $(".updateOrder").find("input[name='logisticsNo1']").each(function(index,items){
				if(isBlank(logisticsNo)){
					logisticsNo = $(this).val();
				}else{
					logisticsNo =logisticsNo+","+ $(this).val();
				}
            })
		 	if(orderStatus=='0' || orderStatus=='1'){
                $.ajax({
                    type:"post",
                    url:"${ctx}/goods/nanDao/updateOrderForPlatform",
                    data:{
                        orderId:orderId,
                        payType:payType,
                        outAmount:outAmount,
                        outType:outType,
                        logisticsName:logisticsName,
                        logisticsNo:logisticsNo,
                        remark:remark
                    },
                    dataType:"text",
                    success:function(result){
                        if(result=="200"){
                            layer.msg("修改成功！");
                            closeUpdate();
                            $("#table-waitdispatch").trigger("reloadGrid");
                        }else if(result=="403"){
                            layer.msg("库存数量已不足！");
						}else if(result=="401"){
                            layer.msg("该历史订单的出库表中无订单id！");
                        }else{
                            layer.msg("修改失败！");
                            closeUpdate();
                            $("#table-waitdispatch").trigger("reloadGrid");
                        }
                    }
                })
			}else{
                var tes=/^[0-9]{1,5}$/;
                if(isBlank(outAmount)){
                    layer.msg("请输入出库数量！");
                }else if(!tes.test(outAmount)){
                    layer.msg("请输入正确的出库数量格式！");
                }else if(outAmount==0){
                    layer.msg("出库数量不能为0！");
                }else{
                    $.ajax({
                        type:"post",
                        url:"${ctx}/goods/nanDao/updateOrder",
                        data:{
                            orderId:orderId,
                            payType:payType,
                            outAmount:outAmount,
                            outType:outType,
                            logisticsName:logisticsName,
                            logisticsNo:logisticsNo,
                            remark:remark
                        },
                        dataType:"text",
                        success:function(result){
                            if(result=="200"){
                                layer.msg("修改成功！");
                                closeUpdate();
                                $("#table-waitdispatch").trigger("reloadGrid");
                            }else if(result=="403"){
                                layer.msg("库存数量已不足！");
                            }else if(result=="401"){
                                layer.msg("该历史订单的出库表中无订单id！");
                            }else{
                                layer.msg("修改失败！");
                                closeUpdate();
                                $("#table-waitdispatch").trigger("reloadGrid");
                            }
                        }
                    })
                }
            } 
		}

    function isBlank(val) {
        if(val==null || val=='' || val == undefined) {
            return true;
        }
        return false;
    }

    function noPassSubmit(){
        $(".butongguoyuanyin").popup({level:2});
	}

		var mark1 = false;
		function noPassSubmitNow(){
			if(mark1){
                return ;
            }
            var id=$(".shfkboxjjbtg").find("input[name='id']").val();
            var reason = $("#reason").val();
            var remark = $(".shfkboxjjbtg").find("input[name='remark']").val();
			if($.trim(reason)=="" || reason==null ){
				layer.msg("请输入不通过原因！");
				$("input[name='shfkboxjjbtg']").focus();
				return false;
			}
			mark1=true;
			$.ajax({
				type:"post",
				url:"${ctx}/goods/nanDao/noPassForPlatform",
				data:{noPassId:id,reason:reason,remark:remark},
				success:function(result){
					if(result=="ok"){
						layer.msg("提交成功！");
						//$.closeAllDiv();
						//此处重新刷新整个页面避免预览图片出现双图片叠加无法关闭问题
						window.location.reload();
                        //$("#table-waitdispatch").trigger("reloadGrid");
					}else{
						layer.msg("提交失败，请检查！");
						return false;
					}
				},
				complete:function(){
					mark1=false;
				}
			})
		}

		function closeUpdate(){
            $.closeDiv($(".updateOrder"));
		}

		function closeDivApp1(){
			$.closeDiv($(".shfkboxjjbtg"));
			//search();
		}

		function fmtOutType(rowData){
		    if(rowData.out_stock_type=='0'){
				return "公司库存";
			}else if(rowData.out_stock_type=='1'){
                return "厂家库存";
			}else{
			    return "";
			}
		}


		function outStock(id){
			outStockId=id;
			$.ajax({
				type:"post",
				url:"${ctx}/goods/nanDao/publicNumberformDetail",
				data:{id:id},
				success:function(data){
                    if(data!=null && data !=""){
                        $(".spqrck").find("input[name='orderNumber']").val(data.columns.number);
                        $(".spqrck").find("input[name='createName']").val(data.columns.siteName);
                        $(".spqrck").find("input[name='goodName']").val(data.columns.good_name);
                        $(".spqrck").find("input[name='goodNum']").val(data.columns.purchase_num);
                        $(".spqrck").find("input[name='payAmount']").val(data.columns.good_amount);

                        if(data.columns.payment_type=='0'){
                            $(".spqrck").find("input[name='payType']").val("微信");
                        }else{
                            $(".spqrck").find("input[name='payType']").val("支付宝");
						}

                        $(".spqrck").find("input[name='recipients']").val(data.columns.customer_name);
                        $(".spqrck").find("input[name='mobile']").val(data.columns.customer_contact);
                        $(".spqrck").find("input[name='receiverAddress']").val(data.columns.province+data.columns.city+data.columns.area+data.columns.customer_address);
                        $(".spqrck").find("input[name='id']").val(data.columns.id);
                        $(".spqrck").find("input[name='remark']").val(data.columns.remark);
                        $(".spqrck").find("input[name='outAmount']").val(data.columns.purchase_num);
                        $("#id1").val(data.columns.id);
                        $("#goodId1").val(data.columns.good_id);
                        $(".spqrck").find("select[name='logisticsName']").val("");
                        $(".spqrck").find("input[name='logisticsNo']").val("");
                    	$(".spqrck").find('.LogisNoBox').remove();
                    }
                    $(".spqrck").popup();
				}
			})
			
		}

		$("#manage").on("click",function(){
		    $(this).next().removeClass("radiobox-selected");
		    $(this).addClass("radiobox-selected");
		});
		$("#factory").on("click",function(){
		    $(this).prev().removeClass("radiobox-selected");
		    $(this).addClass("radiobox-selected");
		});

		$("#manageOut").on("click",function(){
		    $(this).next().removeClass("radiobox-selected");
		    $(this).addClass("radiobox-selected");
		});
		$("#factoryOut").on("click",function(){
		    $(this).prev().removeClass("radiobox-selected");
		    $(this).addClass("radiobox-selected");
		});

		function guanbi(){
			$("#number1").val('');
			$("#placingOrderBy1").val('');
			$("#goodName1").val('');
			$("#purchaseNum1").val('');
			$("#customerName1").val('');
			$("#customerContact1").val('');
			$("#customerAddress1").val('');
			$("#id1").val('');
			$("#goodId1").val('');
			$("#unit1").text('');
			$("#logisticsName1").val('');
			$("#logisticsNo1").val('');
			$.closeDiv($(".spqrck"));
			//window.location.reload(true);
           // initSfGrid();
            search();
		}

		function updateOrder(){
			var id=$("#goodsId").val();
            $.ajax({
                type:"post",
                url:"${ctx}/goods/nanDao/publicNumberformDetail",
                data:{id:id},
                success:function(data){
                    if(data!=null && data !=""){
                        if(data.columns.status != '0' && data.columns.status != '1'){
                           $(".logisticsInfo").show();
                           $("#logisticsInfoTwo").show();
						}else{
                            $(".logisticsInfo").hide();
                            $("#logisticsInfoTwo").hide();
						}
                        $(".updateOrder").find("input[name='orderNumber']").val(data.columns.number);
                        $(".updateOrder").find("input[name='createName']").val(data.columns.siteName);
                        $(".updateOrder").find("input[name='goodName']").val(data.columns.good_name);
                        $(".updateOrder").find("input[name='goodNum']").val(data.columns.purchase_num);
                        $(".updateOrder").find("input[name='payAmount']").val(data.columns.good_amount);
						$(".updateOrder").find("select[name='payType']").val(data.columns.payment_type);
                        $(".updateOrder").find("input[name='recipients']").val(data.columns.customer_name);
                        $(".updateOrder").find("input[name='mobile']").val(data.columns.customer_contact);
                        $(".updateOrder").find("input[name='receiverAddress']").val(data.columns.province+data.columns.city+data.columns.area+data.columns.customer_address);
                        $(".updateOrder").find("input[name='id']").val(data.columns.id);
                        $(".updateOrder").find("input[name='remark']").val(data.columns.remark);
                        if(isBlank(data.columns.amount)){
                            $(".updateOrder").find("input[name='outAmount']").val(data.columns.purchase_num);
						}else{
                            $(".updateOrder").find("input[name='outAmount']").val(data.columns.amount);
                        }

		        		$(".updateOrder").find('.LogisNoBox').remove();
                        $(".updateOrder").find("select[name='logisticsName']").val(data.columns.logistics_name);
                        var logistics = data.columns.logistics_no;
                        var logs = logistics.split(",");
                        $.each(logs, function (index, value) {
                        	if(index ==0){
                       			 $(".updateOrder").find("input[name='logisticsNo1']").val(value);
                        	}else{
		                		var html='<div class="f-l w-220 mb-10 LogisNoBox">'+
		        				'<input type="text" class="input-text w-170 f-l readonly" name="logisticsNo1" value="'+value+'"/>'+
		        				'<a class="sficon sficon-reduce2 ml-5 mt-3 f-l delLogis"></a>'+
		        				'</div>';
		        				 $(".updateOrder").find('.logisticsNosWrap').append(html);	
                        	}
                        	
                        })
                        orderStatus=data.columns.status;

                        if(data.columns.out_stock_type=='0'){
							$("#manage").addClass("radiobox-selected");
                            $("#factory").removeClass("radiobox-selected");
						}else{
                            $("#factory").addClass("radiobox-selected");
                            $("#manage").removeClass("radiobox-selected");
						}
						if(isBlank(data.columns.out_stock_type)){
                            $("#manage").addClass("radiobox-selected");
                            $("#factory").removeClass("radiobox-selected");
						}
                    }
                    $.closeDiv($(".orderxq"));
                    $(".updateOrder").popup();
                }
            })
		}

		var mark2 = false;
		function outStockConfirm(){
			if(mark2==true){
				return ;
			}
			var id = $("#id1").val();
			var goodId = $("#goodId1").val();
			var logisticsName = $("#logisticsName1").val();
			var logisticsNo = "";
			$(".spqrck").find("input[name='logisticsNo1']").each(function(index,items){
				if(isBlank(logisticsNo)){
					logisticsNo = $(this).val();
				}else{
					logisticsNo =logisticsNo+","+ $(this).val();
				}
            });
            var outAmount=$(".spqrck").find("input[name='outAmount']").val();//出库数量
            var outType=$("#outtyOut").find(".radiobox-selected").children().val();//出库方式
            var tes=/^[0-9]{1,5}$/;
            if(isBlank(outAmount)){
                layer.msg("请输入出库数量！");
            }else if(!tes.test(outAmount)){
                layer.msg("请输入正确的出库数量格式！");
            }else if(outAmount==0){
                layer.msg("出库数量不能为0！");
            }else if($.trim(logisticsName)=="" || logisticsName==null){
				layer.msg("请填写物流名称！");
			}else if($.trim(logisticsNo)=="" || logisticsNo==null){
				layer.msg("请填写物流单号！");
			}else{
                mark2=true;
                 $.ajax({
                    type:"post",
                    url:"${ctx}/goods/nanDao/outStockConfirmForPlatform",
                    data:{
                        id:id,
                        logisticsName:logisticsName,
                        logisticsNo:logisticsNo,
                        goodId:goodId,
                        outAmount:outAmount,
                        outType:outType,
                        goodType : "1"
                    },
                    success:function(result){
                        if(result=='ok'){
                            layer.msg("出库成功！");
                            guanbi();
                            search();
                        }else if(result=='405'){
                            layer.msg("库存数量不足！");
                            return ;
						}else if(result=='555'){
                            layer.msg("该商品不是待出库状态，请刷新页面后再看看！");
                            return ;
						}else{
                            layer.msg("出库失败，请检查！");
                            return ;
                        }

                    },
                    complete:function(){
                        mark2=false;
                    }
                }) 
            }
		}

		function mianLogisticsPrice(rowData){
		    if(rowData.had_logistics_price=='0'){
    			return "免运费";
			}else if(rowData.had_logistics_price=='1'){
                return "不免运费";
			}else{
                return "";
			}
		}

		var mark3 = false;
		function updatelogistics(){
			if(mark3==true){
				return ;
			}
			var id = $("#id1").val();
			var logisticsName = $("#logisticsName1").val();
			var logisticsNo = $("#logisticsNo1").val();
			if($.trim(logisticsName)=="" || logisticsName==null){
				layer.msg("请填写物流名称！");
				$("#logisticsName1").focus();
				return;
			}
			if($.trim(logisticsNo)=="" || logisticsNo==null){
				layer.msg("请填写物流单号！");
				$("#logisticsNo1").focus();
				return;
			}
			mark3=true;
			 $.ajax({
				type:"post",
				url:"${ctx}/goods/nanDao/updatelogisticsForPlat",
				data:{id:id,logisticsName:logisticsName,logisticsNo:logisticsNo},
				success:function(result){
					if(result=='ok'){
						layer.msg("出库成功！");
						guanbi();
                        search();
					}else{
						layer.msg("出库失败，请检查！");
						return ;
					}
					
				},
				complete:function(){
					mark3=false;
				}
			}) 
		}
		
		
		function fmtOper(rowData){//操作
            var html="<span  class='c-0383dc'>--</span>";
             if(rowData.status=='1'){
                html ="<span><a onclick='outStock(\""+rowData.id+"\")' class='c-0383dc' ><i class='sficon sficon-ck '></i>出库</a></span>";
            }else if(rowData.status=='2' || rowData.status=='4' || rowData.status=='3'){
                html = "<span  class='c-0383dc'><a href='javascript:logsitDetail(\"" + rowData.id+"\");' class='c-0383dc'>物流信息</a></span>";
            }
			return html;
		}
		function goodAmount(rowData){//商品金额
            var html="<span  class='c-0383dc'>"+(rowData.good_amount * 1.0).toFixed(2)+"</span>";
			return html;
		}
		function Amountpayment(rowData){//付款金额
            var count=0;
		var goodAmount = rowData.good_amount;
		var purchase_num = rowData.purchase_num;
		var logistics_price = rowData.logistics_price;
		 count  = (goodAmount*purchase_num)+logistics_price;
			return count;
		}

		


		function closeDivApp2(){
			$.closeDiv($(".orderxq"));
		}

		function continueConfirm(){
			$.closeDiv($(".promptBox1"));
		}

		//物流信息
		function logsitDetail(id){
			pardetaile=layer.open({
				type : 2,
				content:'${ctx}/goods/nanDao/logsitDetailforPlat?id='+id,
				title:false,
				area: ['100%','100%'],
				closeBtn:0,
				shade:0,
				anim:-1 
			});
		}
		function zfpz(rowData){//支付凭证
			return html='<span class="proofImg"><a class="c-0383dc">凭证</a> <img src="${commonStaticImgPath}'+rowData.pay_confirm+'" /> </span>';
		}
		
		function detail(rowData){//订单编号
			return html="<span  class='c-0383dc'><a class='c-0383dc' onclick='showDetail(\""+rowData.id+"\")'>"+rowData.number+"</a> </span>"; 
		}
		
		function showDetail(orderId){
			$.ajax({
				type:"post",
                url:"${ctx}/goods/nanDao/publicNumberformDetail",
				data:{"id":orderId},
				success:function(data){
					if(data!=null && data !=""){
                        if(data.columns.status == "2"){
                            $("#chongxinshenhe").show();
                        }else{
                            $("#chongxinshenhe").hide();
                        }
                        if(data.columns.status == "5" || data.columns.status == "6"){
                            $("#updateord").hide();
                        }else{
                            $("#updateord").show();
                        }
                        $(".orderxq").find("input[name='orderNumber']").val(data.columns.number);
                        $(".orderxq").find("input[name='createName']").val(data.columns.siteName);
                        $(".orderxq").find("input[name='goodName']").val(data.columns.good_name);
                        $(".orderxq").find("input[name='goodNum']").val(data.columns.purchase_num);
                        $(".orderxq").find("input[name='payAmount']").val(data.columns.good_amount);
                        if(data.columns.payment_type == '0'){
                            $(".orderxq").find("input[name='payType']").val("微信");
                        }else if(data.columns.payment_type == '1'){
                            $(".orderxq").find("input[name='payType']").val("支付宝");
                        }
                        $(".orderxq").find("input[name='recipients']").val(data.columns.customer_name);
                        $(".orderxq").find("input[name='mobile']").val(data.columns.customer_contact);
                        $(".orderxq").find("input[name='receiverAddress']").val(data.columns.province+data.columns.city+data.columns.area+data.columns.customer_address);
                        $("#goodsId").val(orderId);
                        $(".orderxq").find("input[name='remark']").val(data.columns.remark);

						if(data.columns.out_stock_type=='0'){
                            $(".orderxq").find("#manageOut2").addClass("radiobox-selected");
                            $(".orderxq").find("#factoryOut2").removeClass("radiobox-selected");
                        }else if(data.columns.out_stock_type=='1'){
                            $(".orderxq").find("#manageOut2").removeClass("radiobox-selected");
                            $(".orderxq").find("#factoryOut2").addClass("radiobox-selected");
						}

                        if(isBlank(data.columns.out_stock_type)){
                            $(".orderxq").find("#manageOut2").addClass("radiobox-selected");
                            $(".orderxq").find("#factoryOut2").removeClass("radiobox-selected");
                        }

                        if(isBlank(data.columns.amount)){
                            $(".orderxq").find("input[name='outAmount']").val(data.columns.purchase_num);
                        }else{
                            $(".orderxq").find("input[name='outAmount']").val(data.columns.amount);
                        }

                        $(".orderxq").find("input[name='logisticsName']").val(data.columns.logistics_name);
                        $(".orderxq").find("input[name='logisticsNo']").val(data.columns.logistics_no);


					}
					$(".orderxq").popup();
				}
			})
		}
		
		function statusOne(rowData){//订单状态
			var html="---";
			
			if(rowData.status=='1'){
				html = "待出库";
			}
			if(rowData.status=='3'){
				html = "已完成";
			}
			if(rowData.status=='2'){
				html = "已出库";
			}
			if(rowData.status=='4'){
				html = "已取消";
			}
			return html; 
		}
		
		function timeFormat(rowData){
			if(rowData.status==4){
				return rowData.sendgood_time;
			}else if(rowData.status==6){
				if(rowData.no_pass_time!=null && rowData.no_pass_time!="null" ){
					return rowData.no_pass_time;
				}
			}else if(rowData.status==5){
				if(rowData.no_pass_time!=null && rowData.no_pass_time!="null" ){
					return rowData.no_pass_time;
				}
			}else{
				return "";
			} 
			return "";
		}
		
		function codeColor(rowData){
			return html="<span  class='c-0383dc'>"+rowData.good_number+"</span>"; 
		}
		
		function expotrs(){
			var idArr=$("#table-waitdispatch").jqGrid('getGridParam','records')
			var content="共"+idArr+"条数据，本次允许导出前10000条，确定继续导出吗？";
			if(idArr>10000){
				$('body').popup({
					level:3,
					title:"导出",
					content:content,
					 fnConfirm :function(){
						 location.href="${ctx}/goods/nanDao/exportForPlat?formPath=/a/goods/platform/getPublicNumberOrdersHead&&goodType=1&&maps="+$("#searchForm").serialize();
					 }
				});
			}else{
				 location.href="${ctx}/goods/nanDao/exportForPlat?formPath=/a/goods/platform/getPublicNumberOrdersHead&&goodType=1&&maps="+$("#searchForm").serialize();
			}
		}
		
		function fpGoods(rowData){
			var html=rowData.distributionType;
			if(rowData.distributionType=='1'){
				html = "自动分配";
			}
			if(rowData.distributionType=='2'){
				html = "手动分配";
			}
			return html;
		}
		
		 function getDateTime(date) {
			    var year = date.getFullYear();
			    var month = date.getMonth() + 1;
			    var day = date.getDate();
			    var hh = date.getHours();
			    var mm = date.getMinutes();
			    var ss = date.getSeconds();
			    return year + "-" + month + "-" + day + " " + hh + ":" + mm + ":" + ss; 
			}


    function paType(rowData){
        if(rowData.payment_type=="0"){
            return "微信";
        }
        if(rowData.payment_type=="1"){
            return "支付宝";
        }
        return "---";
    }
    
    /*enter查询*/
    function enterEvent(event){
    	var keyCode = event.keyCode?event.keyCode:event.which?event.which:event.charCode;
    	if (keyCode ==13){
    		search();
    	}
    }

	</script>
	
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>我的商品-短信购买弹屏</title>
<meta name="decorator" content="base"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
</head>
<body>

<!-- 购买短信 -->
<div class="popupBox spbuybox spbuymsg">
	<h2 class="popupHead">
		购买
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain">
			<!--
			<div class="cl mb-10">
				<label class="f-l w-100 text-r"><em class="mark">*</em>收件人：</label>
				<input type="text" class="input-text f-l w-140" />
				<label class="f-l w-100 text-r"><em class="mark">*</em>联系方式：</label>
				<input type="text" class="input-text f-l w-140" />
			</div>
			<div class="cl mb-10">
				<label class="f-l w-100 text-r"><em class="mark">*</em>详细地址：</label>
				<input type="text" class="input-text f-l w-380" />
			</div>
			<div class="line-dashed mb-10"></div>
			-->

			<div class="mb-10 cl f-13">
				<label class="w-100 f-l f-13">购买产品：</label>
				<p class="f-l lh-24 ">短信</p>
			</div>

			<form id="orderForm">
			<input type="hidden" name="pid" value="${platform.columns.id }"/>
			<input type="hidden" name="payType" value="alipay"/>
			<div class="cl mb-10">
				<label class="w-100 f-l"><em class="mark">*</em>购买数量：</label>
				<div class="f-l mt-3">
					<label class="radiobox radiobox-selected mr-10" for="count00">
						<input type="radio" name="msgCount" id="count00" value="1000" onclick="yiClick();" checked>1000条
					</label>
					<label class="radiobox radiobox-selected mr-10" for="count01">
						<input type="radio" name="msgCount" id="count01" value="2000" onclick="erClick();" checked>2000条
					</label>
					<label class="radiobox radiobox-selected mr-10" for="count1">
						<input type="radio" name="msgCount" id="count1" value="5000" onclick="wuClick();" checked>5000条
					</label>
					<label class="radiobox mr-10" for="count2">
						<input type="radio" name="msgCount" id="count2" value="10000" onclick="wanClick();"/>10000条
					</label>
					<label class="radiobox" for="count3">
						<input type="radio" name="msgCount" id="count3" value="20000" onclick="wwanClick();"/>20000条
					</label>
				</div>
			</div>
			<div class="cl mb-10">
				<label class="w-100 f-l"><em class="mark">*</em>支付金额：</label>
				<div class="priceWrap w-140 f-l readonly">
					<input type="text" id="zong" class="input-text readonly" readonly="readonly" value="500.00" />
					<span class="unit">元</span>
				</div>
			</div>

			<div class="cl mb-10">
				<label class="w-100 f-l"><em class="mark">*</em>支付方式：</label>
				<a class="paywapWrap f-l payCurrent pay-by-zfb">
					<i class="icon-pay icon-zfb mr-5"></i>
					支付宝
				</a>
				<a class="paywapWrap f-l pay-by-wx">
					<i class="icon-pay icon-wx mr-5"></i>
					微信
				</a>
			</div>
			<div class="text-c mt-20">
				<a id="immPay" href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5">立即支付</a>
				<a href="javascript:closeDiv();" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
			</div>
			</form>
		</div>

	</div>
</div>

<div class="popupBox spPayWrap">
	<h2 class="popupHead">
		支付
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain">
			<h3 class="payTitle">
				收银台
			</h3>
			<div class="payOrder cl">
				<div class="f-l f-13">
					<p >订单编号：<span id="orderNo"></span></p>
					<p>商品名称：${platform.columns.name}</p>
				</div>
				<p class="f-r mt-15 f-14">
					<span>应付金额：</span><span>￥</span><span class="f-20" id="payAmount1">78.0</span>
				</p>
			</div>

			<!-- 支付二维码部分-->
			<div class="payment " id="paymentPart">
				<div class="payWrap">
					<div class="payWrapTitle">
						支付<span class="c-fd7e2a pl-5 pr-5" id="payAmount2">78.34</span>元
					</div>
					<div class="cl">
						<div class="payCode">
							<%--<img src="static/h-ui.admin/images/code.jpg" />--%>
							<!-- 二维码 -->
						</div>
						<div class="payNote"></div>
					</div>
				</div>
			</div>

			<!-- 支付结果（成功） -->
			<div class="pd-25 text-c payResultS hide">
				<i class="prnote mr-10"></i>
				<span class="text-l pt-10">
					<strong class="f-18">您已成功付款</strong><br>
					<span class="c-888 f-13">对方将立即收到您的付款。</span>
				</span>
			</div>
			<!-- 支付结果（失败） -->
			<div class="pd-25 text-c payResultF hide" >
				<i class="prnote mr-10"></i>
				<span class="text-l pt-10">
					<strong class="f-18">支付失败</strong>
				</span>
			</div>

		</div>
		<div class="text-c mt-10 mb-10">
			<a href="javascript:cancelPay();" class="sfbtn sfbtn-opt w-70 mr-5">关闭</a>
		</div>
	</div>
</div>

<script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/unipay/unipay.js"></script>
 
<script type="text/javascript">
	var payType = "alipay";
	var formPosted = false;

	$(function () {
		$('.spbuymsg').popup();
		wuClick();

		$("a.paywapWrap").bind('click', function () {
			$("a.paywapWrap").removeClass("payCurrent");
			$(this).addClass("payCurrent");
		});
		$(".pay-by-zfb").bind('click', function () {
			payType = "alipay";
			$("input[name='payType']").val("alipay");
		});
		$(".pay-by-wx").bind('click', function () {
			payType = "wx";
			$("input[name='payType']").val("wx");
		});
		$("#immPay").bind('click', function () {
			checkout();
		});
		$(".closePopup").bind('click', function () {
//			cancelPay();
			$.closeAllDiv();
		});
	});

	function closeDiv() {
		$.closeDiv($(".spbuymsg"));
	}
	function yiClick() {
		var z = $("#zong").val(Math.round(1000 * 0.1).toFixed(2));
		$(".radiobox").removeClass("radiobox-selected");
		$("label.radiobox").eq(0).addClass("radiobox-selected").prop("checked", true);
	}
	function erClick() {
		var z = $("#zong").val(Math.round(2000 * 0.1).toFixed(2));
		$(".radiobox").removeClass("radiobox-selected");
		$("label.radiobox").eq(1).addClass("radiobox-selected").prop("checked", true);
	}
	function wuClick() {
		var z = $("#zong").val(Math.round(5000 * 0.1).toFixed(2));
//		var z = $("#zong").val(0.01);
		$(".radiobox").removeClass("radiobox-selected");
		$("label.radiobox").eq(2).addClass("radiobox-selected").prop("checked", true);
	}
	function wanClick() {
		var z = $("#zong").val(Math.round(10000 * 0.08).toFixed(2));
		$(".radiobox").removeClass("radiobox-selected");
		$("label.radiobox").eq(3).addClass("radiobox-selected").prop("checked", true);
	}
	function wwanClick() {
		var z = $("#zong").val(Math.round(20000 * 0.07).toFixed(2));
		$(".radiobox").removeClass("radiobox-selected");
		$("label.radiobox").eq(4).addClass("radiobox-selected").prop("checked", true);
	}
	function cancelPay() {
		$.closeDiv($('.spPayWrap'));
		//window.location.parent.reload(true);
        //window.location.parent().reload();//window.location.href='${ctx}/goods/sitePlatformGoods/getSitePlatformAssistant';
		$('#Hui-article-box',window.top.document).css({'z-index':'9'});
		if(monitor) {
			monitor.stop();
		}
	}
	function closePay() {
		cancelPay();
	}
	
	function checkout() {
		if(formPosted) {
			return false;
		}
		formPosted = true;

		var index = layer.load(0, {shade: false});
		$.ajax({
			url: "${ctx}/goods/sitePlatformGoods/createSmsOrder",
			type: "POST",
			data: $("#orderForm").serialize(),
			success: function(data) {
				if (data.code == "200") {
					var qrCodeUrl = data.data[0];
					$('.payCode').qrcode({width: 150, height: 150, text: qrCodeUrl});
					var totalAmount = $("#zong").val();
					$("#payAmount1").text(totalAmount);
					$("#payAmount2").text(totalAmount);
					$("#orderNo").text(data.data[2]);

					var desk = $('.spPayWrap');
					if (payType == "wx") {
						desk.removeClass("zfbPay wxPay").addClass("wxPay");
					} else if (payType == "alipay") {
						desk.removeClass("zfbPay wxPay").addClass("zfbPay");
					} else {
						return;
					}

					$(".spbuymsg").hide();
					desk.popup();
					unipay.config({
						cancelPath: "${ctx}/pay/cancel",
						queryOrderStatusPath: "${ctx}/pay/status"
					});
					monitor = new unipay.Monitor(payType, data.data[1], {
						onPaySuccess: function() {
							window.top.getMessageCount();
							$(".payResultS").show();
							$("#paymentPart").hide();
						},
						onPayTimeout: function () {
							layer.msg("支付超时");
							closePay();
						}
					});
					monitor.start();
				} else if (data.code == "422") {
					layer.msg("订单提交失败");
				}
			},
			error: function() {
				layer.msg("订单提交失败");
			},
			complete: function () {
				formPosted = false;
				layer.close(index);
			}
		});
	}
 
</script> 
</body>
</html>

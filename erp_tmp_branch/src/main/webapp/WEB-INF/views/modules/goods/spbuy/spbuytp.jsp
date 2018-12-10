<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>我的商品-购买弹屏</title>
<meta name="decorator" content="base"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
</head>
<body>
<div class="popupBox spbuybox spbuytp">
	<h2 class="popupHead">
		提示
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain">
			<div class="cl mb-10">
				来电弹屏设备功能简介：<br>
				1、支持用户来电，在电脑中间弹屏提示功能；<br>
				2、以来电手机号关联查询系统内工单，提示来电用户是否有报修记录，并详细显示历史报修信息；<br>
				3、用户首次来电，支持在线录入用户报修信息，保存后直接在系统内生成一条待派工工单，防止报修信息遗漏；<br>
				4、支持来电、去电录音，录音文件可记录下来电号码、录音时间、录音类型（来电、去电），并可手动设置录音文件保存地址，方便查看。<br><br>

				注：想了解弹屏相关细则可拨打电话：0551-66686515，或添加思方工作人员QQ：387808217     2573046379
			</div>
			<div class="text-c mt-20">
				<a href="javascript:cancelShowDesk();" class="sfbtn sfbtn-opt w-70 mr-5">关闭</a>
			</div>
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
			<%--<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5">重新支付</a>--%>
			<%--<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5">确定</a>--%>
			<a href="javascript:cancelPay();" class="sfbtn sfbtn-opt w-70 mr-5">关闭</a>
		</div>
	</div>
</div>

<script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/unipay/unipay.js"></script>

<script type="text/javascript">
	var payType = "alipay";
	var monitor;
	var formPosted = false;
	var isVIP=${isVIP};
	$(function(){
        if(!isVIP){
            $("#zong").val("278.00");
            $("input[name='price']").val("278.00");
        }
		$('.spbuytp').popup();
		$('#orderForm').Validform({
			btnSubmit:"#immPay",
			tiptype: function(msg, o, cssctl) {
				if (msg != "") {
					layer.msg(msg);
				}
			},
			callback: function (form) {
				checkout();
				return false;
			}
		});


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
		$(".closePopup").bind('click', function () {
//			cancelPay();
			$.closeAllDiv();
		});
	});

	function closeDiv(){
		$.closeDiv($(".spbuytp"));
	}
	
	$("#adj_num").blur(function(){
		var num=$("#adj_num").val();
		var price=$("input[name='price']").val();
		var z=num*price;
		$("#zong").val(z);
	});

	function subNum() {
		var price = $("input[name='price']").val();
		var counter = $("#adj_num");
		var num = parseInt(counter.val());
		if (num > 1) {
			num--;
		}
		counter.val(num);
		$("#zong").val((num * parseFloat(price)).toFixed(2));
	}
	function addNum() {
		var price = $("input[name='price']").val();
		var counter = $("#adj_num");
		var num = parseInt(counter.val());
		num++;
		counter.val(num);
		$("#zong").val((num * parseFloat(price)).toFixed(2));
	}

function checkout() {
	if(formPosted) {
		return false;
	}

	formPosted = true;
	var index = layer.load(0, {shade: false});
	$.ajax({
		url: "${ctx}/goods/sitePlatformGoods/createTpOrder",
		type: "POST",
		data: $("#orderForm").serialize(),
		success: function(data) {
			if (data.code == "200") {
				var qrCodeUrl = data.data[0];
				$('.payCode').qrcode({width: 150, height: 150, text: qrCodeUrl});
				var price = $("input[name='price']").val();
				var num = $("#adj_num").val();
				var totalAmount = (num * parseFloat(price)).toFixed(2);
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

				$(".spbuytp").hide();
				desk.popup();
				unipay.config({
					cancelPath: "${ctx}/pay/cancel",
					queryOrderStatusPath: "${ctx}/pay/status"
				});
				monitor = new unipay.Monitor(payType, data.data[1], {
					onPaySuccess: function() {
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
function cancelPay() {
	$.closeDiv($('.spPayWrap'));
	//window.location.href='${ctx}/goods/sitePlatformGoods/getSitePlatformAssistant';
	//window.location.href='${ctx}/goods/sitePlatformGoods/getSitePlatformAssistant';
	$('#Hui-article-box',window.top.document).css({'z-index':'9'});
	if(monitor) {
		monitor.stop();
	}
}
function closePay() {
	cancelPay();
}
function cancelShowDesk() {
	$.closeDiv($(".spbuytp"));
	window.location.parent.reload(true);
}
</script>
</body>
</html>
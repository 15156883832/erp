<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta name="decorator" content="base"/>
<title>VIP会员购买</title>
</head>
<body>
<!-- 历史订单 -->
<div class="shadeBg" style="z-index:9999;"></div>
<div class="vipOpenBox" style="width: 960px;">
	<a href="javascript:;" class="sficon sficon-close_white btnClose" onclick="closeBox(false);"></a>
	<div class="vipInfoBox" style="padding-right: 25px; padding-left: 25px;">
		<div class="cl mb-30">
			<div class="f-l w-280 vipType vipType1">
				<p class="f-14 text-c lh-22"><strong><span>开通系统</span><span class="c-fd6e32">所有</span><span>功能模块</span></strong></p>
			</div>
			<div class="f-l w-280 ml-20 vipType vipType2 ">
				<p class="f-14 text-c lh-22"><strong>授权管理厂家账号</strong></p>
			</div>
			<div class="f-l w-280 ml-20 vipType vipType3 ">
				<p class="f-14 text-c lh-22"><strong><span>自营商品</span><span class="c-fd6e32">添加不限</span></strong></p>
			</div>
		</div>
		<div class="cl mb-30 vipPriceW">
			<div class="f-l w-160 pb-5 mr-15 vipPrice pr-30">
				<p class="mt-15 h-40">
					<strong class="f-28">300<sub class="f-14">元/月</sub></strong>
					<input value="1" name="gmMonth" hidden="hidden">
					<input value="300" name="countMoneyAll" hidden="hidden" />
				</p>
				<p class="lh-20">&nbsp;</p>
				<p class="lh-20"></p>
				<div class="line-dashed"></div>
				<div class="lh-22">
					<span>原价：300元</span></span>
				</div>
				<div class="vipPriceLable pt-20">无<br>优<br>惠</div>
				<i class="iconChoice"></i>
			</div>
			<div class="f-l w-160 pb-5 mr-15 vipPrice pr-30">
				<p class="mt-15 h-40">
					<strong class="f-28">1620<sub class="f-14">元/半年</sub></strong>
					<input value="6" name="gmMonth" hidden="hidden">
					<input value="1620" name="countMoneyAll" hidden="hidden" />
				</p>
				<p class="lh-20">&nbsp;</p>
				<div class="line-dashed"></div>
				<div class="lh-22">
					<span>原价：1825元</span></span>
				</div>
				<div class="vipPriceLable pt-20">9<br>折<br>优<br>惠</div>
				<i class="iconChoice"></i>
			</div>
			<div class="f-l w-170 pb-5 mr-15 vipPrice vipCur pr-30">
				<span class="sficon-yhTxt"></span>
				<p class="mt-15  h-40">
					<strong class="f-28 c-fd6e32">${fee}<sub class="f-14">元/年</sub></strong>
					<input value="12" name="gmMonth" hidden="hidden">
					<input value="${fee}" name="countMoneyAll" hidden="hidden" />
				</p>
				<p class="lh-18 mr-5 ml-5  pos-r delLine">
					<span class="va-m">现价：2920元</span><span class="c-fd6e32 va-m">（8折）</span>
				</p>
				<div class="line-dashed"></div>
				<div class="lh-22">
					<span>原价：3650元</span>
				</div>
				<div class="vipPriceLable pt-15"><strong class="c-fd6e32 f-14">限<br>时</strong><br>优<br>惠</div>
				<i class="iconChoice"></i>
			</div>
			
			<div class="f-l w-170 pb-5 mr-15 vipPrice pr-30">
				<span class="sficon-yhTxt"></span>
				<p class="mt-15  h-40">
					<strong class="f-28 ">${fee*2}<sub class="f-14">元/两年</sub></strong>
					<input value="24" name="gmMonth" hidden="hidden">
					<input value="${fee*2}" name="countMoneyAll" hidden="hidden" />
				</p>
				<p class="lh-18 mr-5 ml-5  pos-r delLine">
					<span class="va-m">现价：5110元</span><span class="c-fd6e32 va-m">（7折）</span>
				</p>
				<div class="line-dashed"></div>
				<div class="lh-22">
					<span>原价：7300元</span></span>
				</div>
				<div class="vipPriceLable pt-15"><strong class="c-fd6e32 f-14">限<br>时</strong><br>优<br>惠</div>
				<i class="iconChoice"></i>
			</div>
			<div class="f-l w-170 pb-5  vipPrice pr-30">
				<span class="sficon-yhTxt"></span>
				<p class="mt-15  h-40">
					<strong class="f-28 ">${fee*3}<sub class="f-14">元/三年</sub></strong>
					<input value="36" name="gmMonth" hidden="hidden">
					<input value="${fee*3}" name="countMoneyAll" hidden="hidden" />
				</p>
				<p class="lh-18 mr-5 ml-5  pos-r delLine">
					<span class="va-m">现价：6570元</span><span class="c-fd6e32 va-m">（6折）</span>
				</p>
				<div class="line-dashed"></div>
				<div class="lh-22">
					<span>原价：10950元</span></span>
				</div>
				<div class="vipPriceLable pt-15"><strong class="c-fd6e32 f-14">限<br>时</strong><br>优<br>惠</div>
				<i class="iconChoice"></i>
			</div>
		</div>
		<div class="cl mb-15 vipPriceW">
			<span class="f-l f-14 lh-30 pt-10 pb-10">支付方式：</span>
			<div class="f-l ml-5">
				<div class="w-150 pt-10 pb-10 f-l f-14 mr-10 vipPrice vipCur">
					<i class="sficon-pay sficon-pay_zfb mr-5"></i>支付宝
					<i class="iconChoice"></i>
					<input hidden="hidden" name="zfbWx" value="zfb"/>
				</div>
				<div class="w-150 pt-10 pb-10 f-l f-14 vipPrice">
					<i class="sficon-pay sficon-pay_wx mr-5"></i>微信支付
					<i class="iconChoice"></i>
					<input hidden="hidden" name="zfbWx" value="wx"/>
				</div>
			</div>
		</div>
		<p class="note ml-70">在会员到期前续费才享受特惠价哦!</p>
		<div class="text-c mt-25">
			<a href="javascript:;" class="btnOpenVip " onclick="zfPage();"></a>
		</div>
	</div>
</div>

<!-- 立即支付跳转 -->
<div class="shadeBg hide payshadeBg" style="z-index:9999"></div>
<div class="popupBox spPayWrap zfbPay lizf" id="lizf" style="z-index:9999;">
	<h2 class="popupHead">
		支付
		<a href="javascript:;" class="sficon closePopup" onclick="qquxiaozhifu()"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain">
			<h3 class="payTitle">
				思方收银台
			</h3>
			<div class="payOrder cl">
				<div class="f-l f-13">
					<p >订单编号：<span id="orderNo"></span></p>
					<p>商品信息：思方erp VIP会员 <span id="limitDate"></span><span class="c-666" id="dateRange"></span></p>
				</div>
				<p class="f-r mt-15 f-14">
					<span>应付金额：</span><span class="f-20">￥<span id="yfMoney"></span></span>
				</p>
			</div>

			<!-- 支付二维码部分-->
			<div class="payment hide1" id="paymentPart">
				<div class="payWrap">
					<div class="payWrapTitle">
						支付<span class="c-fd7e2a pl-5 pr-5"><span id="zfbWxMoney"></span></span>元
					</div>
					<div class="cl">
						<div class="payCode">
							<!-- <img src="static/h-ui.admin/images/code.jpg" /> -->
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
					<strong class="f-18">您已成功付款</strong>
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
			<a href="javascript:;" onclick="qquxiaozhifu()" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
		</div>
	</div>
</div>

<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/unipay/unipay.js"></script>
<script type="text/javascript">
	
	$(function(){
		$('#Hui-article-box',window.top.document).css({'z-index':'1999'});
		$.setPos($('.vipOpenBox'));
	});
	
	$('.vipPrice').on('click', function(){
		$(this).closest('.vipPriceW').find('.vipPrice').removeClass('vipCur');
		$(this).addClass('vipCur');
	});
	
	$('.btnAgreenment').on('click', function(){
		var tagI = $(this).find('i');
		if(tagI.hasClass('label-cbox4-selected')){
			tagI.removeClass('label-cbox4-selected');
		}else{
			tagI.addClass('label-cbox4-selected');
			
		}
	});
	
//	$('.btnClose').on('click', closeBox);
//	$('.btnOpenVip').on('click', closeBox);
	
	function closeBox(soft){
	    var topWin = window.top;
		$('.shadeBg').hide();
		$('.vipOpenBox').hide();
        if (typeof soft !== 'undefined' && soft === false) {
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
            parent.layer.close(index);
        }
		$('#Hui-article-box',topWin.document).css({'z-index':'9'});
        $("div.loadBg", $(topWin.document)).remove();
	}

    var formPosted = false;
    function zfPage(){
        if(formPosted) {
            return false;
        }
        closeBox();
        formPosted = true;
        $(".payCode").empty();
        var gmMonth = $(".vipCur input[name='gmMonth']").val();
        var zfType = $(".vipCur input[name='zfbWx']").val() || 'zfb';//支付宝：zfb；微信：wx;
        var countMoney = $(".vipCur input[name='countMoneyAll']").val();
        $.ajax({
            type: "POST",
            url: "${ctx}/goods/sitePlatformGoods/scPlatOrder?type=xufei",
            data: {
                countMoney:countMoney,
                zfType: zfType,
                gmMonth: gmMonth
            },
            success: function (data) {
                if (data.result.code == "200") {
                    var qrCodeUrl = data.result.data[0];
                    $('.payCode').qrcode({width: 150, height: 150, text: qrCodeUrl});
                    if (zfType == "zfb") {
                        $(".lizf").removeClass("wxPay").addClass("zfbPay");
                    } else if (zfType == "wx") {
                        $(".lizf").removeClass("zfbPay").addClass("wxPay");
                    }
                    $("#yfMoney").text(countMoney);
                    $("#zfbWxMoney").text(countMoney);
                    $("#orderNo").text(data.result.data[2]);
                    $("#dateRange").text("(" + data.timeList[0].start + "-" + data.timeList[0].end + ")");
                    var sbJect = "";
                    if (gmMonth == "1") {//
                        sbJect = "一个月";
                    } else if (gmMonth == "6") {
                        sbJect = "半年";
                    } else if (gmMonth == "12") {
                        sbJect = "一年";
                    } else if (gmMonth == "24") {
                        sbJect = "两年";
                    } else if (gmMonth == "36") {
                        sbJect = "三年";
                    }
                    $("#limitDate").text(sbJect);
                    $(".zfbCheck").addClass("vipCur");
                    $(".wxCheck").removeClass("vipCur");
                    $.setPos($('.spPayWrap'));
                    $('.payshadeBg').show();
                    $('.spPayWrap').show();

                    unipay.config({
                        cancelPath: "${ctx}/pay/cancel",
                        queryOrderStatusPath: "${ctx}/pay/status"
                    });
                    var payType = "";
                    if (zfType == "zfb") {
                        payType = "alipay";
                    } else {
                        payType = "wx";
                    }
                    monitor = new unipay.Monitor(payType, data.result.data[1], {
                        onPaySuccess: function () {
                            $(".payResultS").show();
                            $("#paymentPart").hide();
                        },
                        onPayTimeout: function () {
                            layer.msg("支付超时");
                            qquxiaozhifu();
                        }
                    });
                    monitor.start();
                } else {
                    layer.msg("支付失败，请检查！");
                }
            },
            error: function(a, b, c) {
            },
            complete: function () {
                formPosted = false;
            }
        })
    }

    function qquxiaozhifu() {
        window.parent.location.reload(true);
        $('#loadBg', window.parent.document).remove();
        parent.layer.closeAll();
        $(".spPayWrap").removeClass("wxPay").addClass("zfbPay");
        $('.payshadeBg').hide();
        $('.spPayWrap').hide();

        if (monitor) {
            monitor.stop();
        }
    }

</script> 
</body>
</html>
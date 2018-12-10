<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="decorator" content="base" />
<style type="text/css">

</style>
</head>
<body>
<div class="shadeBg hide vipshadeBg" style="z-index:9999"></div>

<div class="vipOpenBox ">
	<a href="javascript:;" class="sficon sficon-close_white btnClose"></a>
	<div class="vipInfoBox">
		<div class="cl mb-30">
			<div class="f-l w-230 vipType vipType1">
				<p class="f-14 text-c lh-22"><strong><span>开通系统</span><span class="c-fd6e32">所有</span><span>功能模块</span></strong></p>
			</div>
			<div class="f-l w-230 ml-10 vipType vipType2 ">
				<p class="f-14 text-c lh-22"><strong>授权管理厂家账号</strong></p>
			</div>
			<div class="f-l w-230 ml-10 vipType vipType3 ">
				<p class="f-14 text-c lh-22"><strong><span>自营商品</span><span class="c-fd6e32">添加不限</span></strong></p>
			</div>
		</div>
		<div class="cl mb-30 vipPriceW">
			<div class="f-l w-130 pb-5 mr-15 vipPrice">
				<p class="mt-15 lh-30">
					<strong class="c-fd6e32 f-20">300元/</strong>
					<span class="lh-30">一月</span>
					<input value="300" name="countMoneyAll" hidden="hidden" />
					<input value="1" name="gmMonth" hidden="hidden" />
				</p>
				<p class="lh-20 c-666"><del>（原价300元）</del></p>
				<div class="line-dashed"></div>
				<div class="lh-22 ">
					仅需10 元/天
				</div>
				<i class="iconChoice"></i>
			</div>
			<div class="f-l w-130 pb-5 mr-15 vipPrice">
				<p class="mt-15 lh-30">
					<strong class="c-fd6e32 f-20">1620元/</strong>
					<span class="lh-30">半年</span>
					<input value="1620" name="countMoneyAll" hidden="hidden" />
					<input value="6" name="gmMonth" hidden="hidden" />
				</p>
				<p class="lh-20 c-666"><del>（原价1825元）</del></p>
				<div class="line-dashed"></div>
				<div class="lh-22">
					仅需9 元/天
				</div>
				<i class="iconChoice"></i>
			</div>
			<div class="f-l w-130 pb-5 mr-15 vipPrice vipCur">
				<span class="sficon-recomendTxt"></span>
				<p class="mt-15 lh-30">
					<strong class="c-fd6e32 f-20">2920元/</strong>
					<span class="lh-30">一年</span>
					<input value="2920" name="countMoneyAll" hidden="hidden" />
					<input value="12" name="gmMonth" hidden="hidden" />
				</p>
				<p class="lh-20 c-666"><del>（原价3650元）</del></p>
				<div class="line-dashed"></div>
				<div class="lh-22">
					仅需8元/天
				</div>
				<i class="iconChoice"></i>
			</div>
			<div class="f-l w-130 pb-5 mr-15 vipPrice" >
			<input type="hidden" class="moneyType" value="2">
				<p class="mt-15 lh-30">
					<strong class="c-fd6e32 f-20">5110元/</strong>
					<span class="lh-30">二年</span>
					<input value="5110" name="countMoneyAll" hidden="hidden" />
					<input value="24" name="gmMonth" hidden="hidden" />
				</p>
				<p class="lh-20 c-666"><del>（原价7300元）</del></p>
				<div class="line-dashed"></div>
				<div class="lh-22">
					仅需7 元/天
				</div>
				<i class="iconChoice"></i>
			</div>
			<div class="f-l w-130 pb-5 vipPrice " >
			<input type="hidden" class="moneyType" value="2">
				<p class="mt-15 lh-30">
					<strong class="c-fd6e32 f-20">6570元/</strong>
					<span class="lh-30">三年</span>
					<input value="6570" name="countMoneyAll" hidden="hidden" />
					<input value="36" name="gmMonth" hidden="hidden" />
				</p>
				<p class="lh-20 c-666"><del>（原价10950元）</del></p>
				<div class="line-dashed"></div>
				<div class="lh-22">
					仅需6 元/天
				</div>
				<i class="iconChoice"></i>
			</div>
		</div>
		<div class="cl mb-20 vipPriceW">
			<span class="f-l f-14 lh-30 pt-10 pb-10">支付方式：</span>
			<div class="f-l ml-5">
				<div class="w-120 pt-10 pb-10 f-l f-14 mr-10 vipPrice vipCur zfbCheck">
					<input hidden="hidden" name="zfbWx" value="zfb"/>
					<i class="sficon-pay sficon-pay_zfb mr-5"></i>支付宝
					<i class="iconChoice"></i>
				</div>
				<div class="w-120 pt-10 pb-10 f-l f-14 vipPrice wxCheck">
					<input hidden="hidden" name="zfbWx" value="wx"/>
					<i class="sficon-pay sficon-pay_wx mr-5"></i>微信支付
					<i class="iconChoice"></i>
				</div>
			</div>
		</div>
		<div class="text-c">
			<!-- <span class="ml-70 pl-5 cPointer btnAgreenment">
				<i class="label-cbox4 label-cbox4-selected va-t agreeThis" id="agreeThis"></i>
				同意
			</span>
			<a href="javascript:;" class="c-0e8ee7" style="text-decoration: underline;">《思方VIP会员服务协议》</a> -->
			<%-- <a href="#" onclick="return zfPage();" class="btnOpenVip ml-15"></a>--%>
			<span onclick="zfPage();" class="btnOpenVip"></span>
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
			<!-- <a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" style="display: none;" >重新支付</a>
			<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" style="display: non/e;">确定</a> -->
			<a href="javascript:;" onclick="qquxiaozhifu()" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
		</div>
	</div>
</div>


	<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${ctxPlugin}/lib/jqGrid_5.2/plugins/jquery.contextmenu.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/unipay/unipay.js"></script>
<script type="text/javascript">
 var dueTime="";
 var monitor;
 var formPosted = false;
		$(function() {
			$.post("${ctx}/goods/sitePlatformGoods/getSite",function(data){
				dueTime=data.columns.due_time;
			})
			openVIP();
		});
		$('.vipPrice').on('click', function(){
			$(this).closest('.vipPriceW').find('.vipPrice').removeClass('vipCur');
			$(this).addClass('vipCur');
			var moneytype =$(this).find('.moneyType').val();
			if(moneytype == 2){
				$('.wxCheck').hide();
			}else{
				$('.wxCheck').show();
			}
		})
		
		$('.btnAgreenment').on('click', function(){
			var tagI = $(this).find('i');
			if(tagI.hasClass('label-cbox4-selected')){
				tagI.removeClass('label-cbox4-selected');
			}else{
				tagI.addClass('label-cbox4-selected');
				
			}
		})
		
		$('.btnClose').on('click', closeBox);
		$('.btnOpenVip').on('click', closeBox1);
		
		function closeBox(){
			$('.vipshadeBg').hide(); 
			$('.vipOpenBox').hide();
			$('#Hui-article-box',window.top.document).css({'z-index':'9'});
			
			$('#loadBg',window.parent.document).remove();
			parent.layer.closeAll();
		};
		
		function closeBox1(){
			/* if($("#agreeThis").hasClass("label-cbox4-selected")==false){
				return false;
			} */
			$('.vipshadeBg').hide(); 
			$('.vipOpenBox').hide();
			$('#Hui-article-box',window.top.document).css({'z-index':'9'});
			
			//$('#loadBg',window.parent.document).remove();
			//parent.layer.closeAll();
		};
				
		function openVIP(){
			$('#Hui-article-box',window.top.document).css({'z-index':'1999'});
			$.setPos($('.vipOpenBox'));
			$('.vipshadeBg').show();
			$('.vipOpenBox').show();
		}
		
		function zfPage(){
			if(formPosted) {
				return false;
			}
			formPosted = true;
			var index = layer.load(0, {shade: false});
			$(".payCode").empty();
			var countMoney = $(".vipCur input[name='countMoneyAll']").val();
			var gmMonth = $(".vipCur input[name='gmMonth']").val();
			var zfType = $(".vipCur input[name='zfbWx']").val();//支付宝：zfb；微信：wx;
			$.ajax({
				type:"POST",
				url:"${ctx}/goods/sitePlatformGoods/scPlatOrder",
				data:{countMoney:countMoney,
					 zfType:zfType,
					 gmMonth:gmMonth},
				success:function(data){
					if (data.result.code == "200") {
						var qrCodeUrl = data.result.data[0];
						$('.payCode').qrcode({width: 150, height: 150, text: qrCodeUrl});
						if(zfType=="zfb"){
							$(".lizf").removeClass("wxPay").addClass("zfbPay");
						}else if(zfType=="wx"){
							$(".lizf").removeClass("zfbPay").addClass("wxPay");
						}
						$("#yfMoney").text(countMoney);
						$("#zfbWxMoney").text(countMoney);
						$("#orderNo").text(data.result.data[2]);
						var startTime;
						var endTime;
						var date =  new Date();
						if(dueTime==null || dueTime==""){
							startTime="";
							endTime = "";
						}else{
							startTime="";
							endTime="";
						}
						$("#dateRange").text("("+data.timeList[0].start +"-"+data.timeList[0].end+")");
						var sbJect = "";
						if(gmMonth=="1"){//
							sbJect="一个月";
						}else if(gmMonth=="6"){
							sbJect="半年";
						}else if(gmMonth=="12"){
							sbJect="一年";
						}else if(gmMonth=="24"){
							sbJect="两年";
						}else if(gmMonth=="36"){
							sbJect="三年";
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
						var payType="";
						if(zfType=="zfb"){
							payType="alipay";
						}else{
							payType="wx";
						}
						monitor = new unipay.Monitor(payType, data.result.data[1], {
							onPaySuccess: function() {
								$(".payResultS").show();
								$("#paymentPart").hide();
							},
							onPayTimeout: function () {
								layer.msg("支付超时");
								qquxiaozhifu();
							}
						});
						monitor.start();
					}else{
						layer.msg("支付失败，请检查！");
					}
				},
				error: function(a, b, c) {
				},
				complete: function () {
					formPosted = false;
					layer.close(index);
				}
			}) 
		}
		
		function qquxiaozhifu(){
			//$('#loadBg',window.parent.document).remove();
			window.parent.location.reload(true);
			$('#loadBg',window.parent.document).remove();
			parent.layer.closeAll();
			/* $('#loadBg',window.parent.document).remove();
			parent.layer.closeAll(); */
			$(".spPayWrap").removeClass("wxPay").addClass("zfbPay");
			$('.payshadeBg').hide();
			$('.spPayWrap').hide(); 
			
			if(monitor) {
				monitor.stop();
			}
		}
		
	</script>
</body>
</html>
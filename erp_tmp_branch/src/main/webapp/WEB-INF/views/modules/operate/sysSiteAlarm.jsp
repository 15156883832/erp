<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<title>预警统计</title>
<meta name="decorator" content="base"/>
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
</head>
<body>
<div class="sfpagebg bk-gray"><div class="sfpage">
		<div class="page-orderWait cautionStatistic">
			<div class="tabBar cl mb-10">
			<sfTags:pagePermission authFlag="OPERATEMGM_SYSALARMMSG_ALARMCOUNT_TAB" html='<a class="btn-tabBar current" href="${ctx }/operate/siteAlarm/alarmCount">预警统计</a>'></sfTags:pagePermission>
			<sfTags:pagePermission authFlag="OPERATEMGM_SYSALARMMSG_ALARMDETAIL_TAB" html='<a class="btn-tabBar" href="${ctx }/operate/siteAlarm/headerList">预警明细</a>'></sfTags:pagePermission>
			</div>
			<div class="mt-20">
				<div id="xinxi">
					<%-- <dl class="mb-20 cl csWrap text-c">
						<dt class="csWrap_dt">工单超时预警</dt>
						<dd class="csWrap_dd">
							<div class="f-l w-120">
								<span class="orderCount">${employeCount }</span>
								<p class="lh-26"><a href="${ctx }/operate/siteAlarm/headerList?type=1" class="c-f55025 f-14">派工</a><span class="f-14">超时</span></p>
							</div>
							<div class="f-l w-120">
								<span class="orderCount">${finishedCount }</span>
								<p class="lh-26"><a href="${ctx }/operate/siteAlarm/headerList?type=2" class="c-f55025 f-14">服务完工</a><span class="f-14">超时</span></p>
							</div>
						</dd>
					</dl>
					<div class="line mb-20"></div> --%>
				</div>
				
				<div id="peijian">
					<%-- <dl class="mb-20 cl csWrap text-c" >
						<dt class="csWrap_dt">备件预警</dt>
						<dd class="csWrap_dd">
							<div class="f-l w-120">
								<span class="orderCount">${storeCount }</span>
								<p class="lh-26"><a href="${ctx }/operate/siteAlarm/headerList?type=3" class="c-f55025 f-14">库存</a><span class="f-14">预警</span></p>
							</div>
							<div class="f-l w-120">
								<span class="orderCount">${shortCount }</span>
								<p class="lh-26"><a href="${ctx }/operate/siteAlarm/headerList?type=4" class="c-f55025 f-14">缺件</a><span class="f-14">预警</span></p>
							</div>
						</dd>
					</dl>
					<div class="line mb-20"></div> --%>
				</div>
			</div>
		</div>
	</div></div>
	
	<div class="popupBox w-320 vipPromptBox">
	<h2 class="popupHead">
		提示
	</h2>
	<div class="popupContainer">
		<div class="popupMain text-c pt-30 pb-20">
			<div class="">
				<i class="iconType iconType2"></i>
				<strong class="f-16">VIP会员功能</strong>
			</div>
			<p class="c-666 lh-26">
				抱歉，此功能需要<span class="c-bb3906">开通VIP会员</span>后才能使用！
			</p>
			<div class="text-c mt-30">
				<%-- <a  href="#" onclick="jumpToVIP();return false;" class="sfbtn sfbtn-opt3 w-100">开通VIP会员</a>--%>
				<span class="sfbtn sfbtn-opt3 w-100" onclick="jumpToVIP();">开通VIP会员</span>
			</div>
		</div>
	</div>
</div>
	
<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef"></script>
<script type="text/javascript">
	var employeCount = '${employeCount }';
	var finishedCount = '${finishedCount }';
	var storeCount = '${storeCount }';
	var shortCount = '${shortCount }';
	var peiJian = '${peiJian }';
	var xinXi = '${xinXi }';
	
	$(function(){
		$.post("${ctx}/goods/sitePlatformGoods/distinct",function(result){
			if(result=="showPopup"){
				
				$(".vipPromptBox").popup();
				$('#Hui-article-box',window.top.document).css({'z-index':'9'});
			}
		});
		if(xinXi=="true"){
			$("#xinxi").append(
			'<dl class="mb-20 cl csWrap text-c">'+
				'<dt class="csWrap_dt">工单超时预警</dt>'+
				'<dd class="csWrap_dd">'+
					'<div class="f-l w-120">'+
						'<span class="orderCount">'+employeCount+'</span>'+
						'<p class="lh-26"><a href="${ctx }/operate/siteAlarm/headerList?type=1" class="c-f55025 f-14">派工</a><span class="f-14">超时</span></p>'+
					'</div>'+
					'<div class="f-l w-120">'+
						'<span class="orderCount">'+finishedCount+'</span>'+
						'<p class="lh-26"><a href="${ctx }/operate/siteAlarm/headerList?type=2" class="c-f55025 f-14">服务完工</a><span class="f-14">超时</span></p>'+
					'</div>'+
				'</dd>'+
			'</dl>'+
			'<div class="line mb-20"></div>');
		} 
		if(peiJian=="true"){
			$("#peijian").append(
			'<dl class="mb-20 cl csWrap text-c" >'+
				'<dt class="csWrap_dt">备件预警</dt>'+
				'<dd class="csWrap_dd">'+
					'<div class="f-l w-120">'+
						'<span class="orderCount">'+storeCount+'</span>'+
						'<p class="lh-26"><a href="${ctx }/operate/siteAlarm/headerList?type=3" class="c-f55025 f-14">库存</a><span class="f-14">预警</span></p>'+
					'</div>'+
					'<div class="f-l w-120">'+
						'<span class="orderCount">'+shortCount+'</span>'+
						'<p class="lh-26"><a href="${ctx }/operate/siteAlarm/headerList?type=4" class="c-f55025 f-14">缺件</a><span class="f-14">预警</span></p>'+
					'</div>'+
				'</dd>'+
			'</dl>'+
			'<div class="line mb-20"></div>');
			
		}
		
		
		
	})
	
function jumpToVIP(){
	layer.open({
		type : 2,
		content:'${ctx}/goods/sitePlatformGoods/jumpVIP',
		title:false,
		area: ['100%','100%'],
		closeBtn:0,
		shade:0,
		anim:-1 
	});
}

</script>
	
</body>
</html>
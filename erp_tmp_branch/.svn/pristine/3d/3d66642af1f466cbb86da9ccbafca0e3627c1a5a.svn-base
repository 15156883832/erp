<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select2.min.css"/> 
<html>
<head>
<meta name="decorator" content="base"/>
<title>平台商品-系统服务助手</title>
</head>
<body>
	<div class="sfpagebg bk-gray"><div class="sfpage">
		<div class="page-orderWait">
			<div id="tab-system" class="HuiTab">
				<div class="tabBar cl mb-10">
					<sfTags:pagePermission authFlag="GOODSMGM_PLATEFORMGOODS_PLATEFORMJOINGOODS_TAB" html='<a class="btn-tabBar " href="${ctx}/goods/sitePlatformGoods/getSitePlatformGoodslist">平台合作商品</a> '></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="GOODSMGM_PLATEFORMGOODS_GOODSBUYRECORD_TAB" html=' <a class="btn-tabBar current" href="${ctx}/goods/sitePlatformGoods/getSitePlatformAssistant">系统服务助手</a> '></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="GOODSMGM_PLATEFORMGOODS_SYSSERVE_TAB" html='<a class="btn-tabBar" href="${ctx}/goods/sitePlatformGoods/list">商品购买记录</a> '></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="GOODSMGM_PLATEFORMGOODS_LBRECORD_TAB" html='<a class="btn-tabBar" href="${ctx}/goods/nanDao/list">漏保购买记录</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="GOODSMGM_PLATEFORMGOODS_MJLORDERECORD_TAB" html='<a class="btn-tabBar " href="${ctx}/goods/mjl/list">美洁力购买记录</a>'></sfTags:pagePermission>
					<p class="f-r btnWrap">
						<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
						<a href="javascript:;" class="sfbtn sfbtn-opt"><i class="sficon sficon-reset"></i>重置</a>
					</p>
				</div>
				
				<div class="bk-gray pt-15 pb-15 cl">
					<label class="f-l w-80 text-r">商品编号：</label>
					<input type="text" class="input-text f-l w-140" />
					<label class="f-l w-100 text-r">商品名称：</label>
					<input type="text" class="input-text f-l w-140" />
				</div>
				<div class="mt-10 tableWrap">
					<table class="table table-border table-bordered table-bg table-sp" style="table-layout: fixed;">
						<thead>
							<tr class="text-c">
								<th style="width: 22%;">助手名称</th>
								<th style="width: 50%;">产品介绍</th>
								<th style="width: 20%;">产品功能</th>
								<th style="width: 8%;">购买</th>
							</tr>
						</thead>
						<tr>
							<td >
								<img src="${ctxPlugin}/static/h-ui.admin/images/icon_msg.png" class="f-l mr-15" />
								<p class="">短信</p>
								<p class="c-fe0101 ">（按条计费）</p>
							</td>
							<td>
								<p class="mb-5"> 购买价格</p>
								<div class="cl priceInfo">
									<div class="f-l">
										<p class="lb">1万条以内</p>
										<p>0.1元 / 条</p>
									</div>
									<div class="f-l">
										<p class="lb">1-2万条</p>
										<p>0.08元 / 条</p>
									</div>
									<div class="f-l">
										<p class="lb">2万条及以上</p>
										<p>0.07元 / 条</p>
									</div>
								</div>
							</td>
							<td>

							</td>
							<td class="text-c">
								<a href="javascript:buyMessage('${message.id }');" class="c-0e8ee7">
									<i class="sficon sficon-spcar"></i>购买 
								</a>
							</td>
						</tr>
						<tr>
							<td>
								<%-- <c:forEach items = "${str2 }" var = "s2"> --%>
									<img src="${ctxPlugin}/static/h-ui.admin/images/icon_tp.png" class="f-l mr-15"  />
								<%-- </c:forEach> --%>
								<!-- <img src="static/h-ui.admin/images/icon_tp.png" class="f-l mr-15" /> -->
								<p class="">来电工单弹屏设备</p>
								<p class="c-fe0101 ">（质保一年）</p>
								<p class=" ">普通会员价：￥278</p>
								<p class=""><span class="c-666 ">VIP会员价：</span><span class="c-fe0101 f-16">￥198</span></p>
							</td>
							<td >
								<%--<p class="lh-18">${view.description }</p>--%>
								<div class="cl">
									<%-- <c:forEach items = "${str1 }" var = "s1">
										<img src="${commonStaticImgPath}${s1}" class="f-l mr-15" style="width:40px;height:40px" />
									</c:forEach> --%>
									<div id="ImgprocessPJ1">
										<img src="${ctxPlugin}/static/h-ui.admin/images/banner1.png" class="f-l mr-15" style="width:80px;height:80px;"/>
										<img src="${ctxPlugin}/static/h-ui.admin/images/banner2.png" class="f-l mr-15" style="width:80px;height:80px;"/>
										<img src="${ctxPlugin}/static/h-ui.admin/images/banner3.png" class="f-l mr-15" style="width:80px;height:80px;"/>
									</div>
									<%--<div class="f-l mt-50">
										<span class="f-26 c-fe0101">￥${view.sitePrice}</span>
										<del class="f-14 c-666 mt-5 ml-5">原价：￥298</del>
									</div>--%>
								</div>
							</td>
							<td>
								<%--<p>1. 有新工单时，第一时间弹屏通知</p>
								<p></p>
								<p></p>--%>
							</td>
							<td class="text-c">
							<sfTags:pagePermission authFlag="GOODSMGM_PLATEFORMGOODS_SYSSERVE_BUY_BTN" html='<a href="javascript:showBuy(\'${view.id }\');" class="c-0e8ee7"><i class="sficon sficon-spcar"></i>购买 </a>  '></sfTags:pagePermission>
								
							</td>
						</tr>

						<tr>
							<td>
								<%-- <c:forEach items = "${str2 }" var = "s2"> --%>
									<img src="${ctxPlugin}/static/h-ui.admin/images/code_01.jpg" class="f-l mr-15"  style="width:80px;height:80px;"/>
								<%-- </c:forEach> --%>
								<!-- <img src="static/h-ui.admin/images/icon_tp.png" class="f-l mr-15" /> -->
								<p class="">电子名片</p>
								<p class=""><span class="c-666 ">普通会员价：</span><span class="f-14">￥279</span></p>
								<p class=""><span class="c-666 ">VIP会员价：</span><span class="c-fe0101 f-16">￥199</span></p>
								<%--<p class="c-fe0101 ">（质保一年）</p>--%>
							</td>
							<td >
								<%--<p class="lh-18">${view.description }</p>--%>
								<div class="cl ">
									<%-- <c:forEach items = "${str1 }" var = "s1">
										<img src="${commonStaticImgPath}${s1}" class="f-l mr-15" style="width:40px;height:40px" />
									</c:forEach> --%>
									<div id="ImgprocessPJ2">
										<img src="${ctxPlugin}/static/h-ui.admin/images/code_02.png" class="f-l mr-15" style="width:80px;height:80px;"/>
										<img src="${ctxPlugin}/static/h-ui.admin/images/code_03.png" class="f-l mr-15" style="width:80px;height:80px;"/>
										<img src="${ctxPlugin}/static/h-ui.admin/images/code_04.png" class="f-l mr-15" style="width:80px;height:80px;"/>
										<img src="${ctxPlugin}/static/h-ui.admin/images/code_05.png" class="f-l mr-15" style="width:80px;height:80px;"/>
										<img src="${ctxPlugin}/static/h-ui.admin/images/code_06.jpg" class="f-l mr-15" style="width:80px;height:80px;"/>
									</div>
									<%--<div class="f-l mt-50">
										<span class="f-26 c-fe0101">￥${icoCode.sitePrice}</span>
										<del class="f-14 c-666 mt-5 ml-5">原价：￥279</del>
									</div>--%>
								</div>
								<p >规格：每包70张，每张54个二维码，一包3780个不同的二维码</p>
							</td>
							<td>
								<%--<p>1. 有新工单时，第一时间弹屏通知</p>
								<p></p>
								<p></p>--%>
							</td>
							<td class="text-c" >
							<sfTags:pagePermission authFlag="GOODSMGM_PLATEFORMGOODS_SYSSERVE_BUY_BTN" html='<a href="javascript:showBuyCode(\'${icoCode.id }\');" class="c-0e8ee7"><i class="sficon sficon-spcar"></i>购买 </a>  '></sfTags:pagePermission>

							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div></div>
 
<script type="text/javascript" src="${ctxPlugin}/lib/select2.full.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
<script type="text/javascript">
	$(function(){
		$('#ImgprocessPJ1').imgShow({hasIframe:true});
		$('#ImgprocessPJ2').imgShow({hasIframe:true});
	});
	
	
	window.onresize = function(){
		initTableH();
	};
	
	function initTableH(){
		var tHeight = $('.sfpagebg').height()-200;
		$('.tableWrap').css({
			'max-height':tHeight,
			'overflow':'auto'
		});
	}

	//购买
	function showBuy(id){
		layer.open({
			 type : 2,
			 content:'${ctx}/goods/sitePlatformGoods/showBuy?id='+id,
			 title:false,
			 area: ['100%','100%'],
			 closeBtn:0,
			 shade:0,
			 fadeIn:0,
			 anim:-1 
		});
	}

	//购买
	function showBuyCode(id){
		layer.open({
			 type : 2,
			 content:'${ctx}/goods/sitePlatformGoods/showBuyCode?id='+id,
			 title:false,
			 area: ['100%','100%'],
			 closeBtn:0,
			 shade:0,
			 fadeIn:0,
			 anim:-1
		});
	}

	function buyMessage(id){
		layer.open({
			 type : 2,
			 content:'${ctx}/goods/sitePlatformGoods/showBuyMessage?id='+id,
			 title:false,
			 area: ['100%','100%'],
			 closeBtn:0,
			 shade:0,
			 fadeIn:0,
			 anim:-1 
		});
	}
	
</script> 
</body>
</html>
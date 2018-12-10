<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="decorator" content="base" />
<style type="text/css">
body{
 background:#e4e6eb;
 min-width:1440px;
}
.msgbox-mgtop{
	margin-top: -5px;
}
</style>
</head>
<body>
	<header class="navbar-wrapper navbarHeader">
		<div class="navbar navbar-sflogo">
		<div class="container-fluid cl ">
			<a class="logo navbar-logo" href="#"></a>

			<nav id="Hui-userbar" class="navbar-userbar userbar-sf f-r">
				<ul class="cl">
					<li class="">
						<c:if test="${dict eq 1 }">
							<c:if test="${not empty site.id }">
								<c:if test="${xufeiRemindDock}">
									<a class="openVipR" href="javascript:;" onclick="showXuFei()">
										<i class="sficon sficon-role0"></i>续费VIP会员
									</a>
								</c:if>
								<c:if test="${not xufeiRemindDock}">
									<c:if test="${mark == 'wkt' }">
										<a class="openVipR" href="javascript:;" onclick="jumpToVIP()">
											<i class="sficon sficon-role0"></i>开通VIP会员
										</a>
									</c:if>
									<c:if test="${mark == 'gq' }">
										<a class="openVipR" href="javascript:;" onclick="jumpToVIP()">
											<i class="sficon sficon-role0"></i>续费VIP会员
										</a>
									</c:if>
									<c:if test="${mark == 'ok' }">
										<a class="openVipR"  href="javascript:;" onclick="jumpToVIP()">
											<i class="sficon sficon-renew"></i>续费VIP会员
										</a>
									</c:if>
								</c:if>
							</c:if>
						</c:if> 
					</li>
					<li class="">
						<a class="helpLink btn-help" href="${ctx}/helpindex/indexHelp?a=gdztsm" target="_blank" >
							<i class="sficon sficon-help"></i>帮助中心
						</a>
					</li>
					<li class="dropDown dropDown_hover right">
						<a class="helpLink btn-help" href="#" >
							<i class="sficon sficon-skin"></i>换肤
						</a>
						<ul class="dropDown-menu menu box-shadow w-170 " style="border-top: 1px solid #0e8ee7;">
							<li class="skinbox">
								<div class="skinbox_title">皮肤选择</div>
								<div class="skinbox_con" id="skinbox_con">
									<span class="sfskin_blue"><input type="hidden" value="blue"></span>
									<span class="sfskin_cyan"><input type="hidden" value="cyan"></span>
									<span class="sfskin_orange"><input type="hidden" value="orange"></span>
									<span class="sfskin_green"><input type="hidden" value="green"></span>
								</div>
							</li>
						</ul>
					</li>
					<li class="borderl">
						<span class="bl"></span>
					</li>
					<li class="dropDown dropDown_hover right">
						<a href="#" class=" ">
                            <i class="sficon sficon-role${level.count}"></i>
							<span class="username va-t">${userName }</span>
							<i class="sficon sficon-arrowdown2"></i>
						</a>
						<ul class="dropDown-menu menu radius box-shadow w-200" style="border-top: 1px solid #0e8ee7;">
							<li id="jumpToYunying"><a href="javascript:;"><i class="sficon sficon-role mr-5"></i>${usertype }</a></li>
							<li><a href="javascript:;"><i class="sficon sficon-role${level.count} mr-5 "></i>${level.name}</a></li>
							<li id="goToGoods"><a href="javascript:;"><i class="sficon sficon-mgs mr-5"></i>可使用短信（<span class="c-f55025 f-13" id="msgCount">0条</span>）</a></li>
							<li><a href="${ctx}/logout"><i class="sficon sficon-exit mr-5"></i>退出</a></li>
						</ul>
					</li>
				</ul>
			</nav>
			<c:if test="${xufeiInfo.remindIcon == 1 and xufeiRemindDock}">
				<a class="f-r mr-10 btndis btndis${xufeiInfo.discount}" onclick="xfRemind();"></a>
			</c:if>
		</div>
	</div>
		<div class="navbar navbar-sf pt-10">
			<nav class="breadcrumb f-l c-white  mt-5">
				<i class="sficon sficon-location"></i>当前位置： <a
					href="javascript:;" class="c-white"><span id="module_span">工单管理</span></a> <a href="javascript:;"
					class="c-white"><span class="en">&gt;</span><span id="sub_module_span">首页</span></a>
			</nav>
			<nav class="navbar f-r navbar-sfbar">
				<ul class="cl" id="sf_top_menu">
					<li><a href="${ctx}" class="sf_top_menu_item current"><i class="mr-5 sfnav sfnav1 "></i>首页</a></li>
					<c:set var="firstMenu" value="true"/>
					<c:forEach items="${fns:getMenuList()}" var="menu" varStatus="idxStatus">
						<c:if test="${menu.parent.id eq '1' && menu.isShow eq '1'}">
							<c:if test="${fns:checkTopMenuAuth(menu.id)}">
								<li>
									<a href="javascript:;" class="sf_top_menu_item" onclick="init_left_menu('${menu.id}','${menu.name }','${fn:substring(menu.icon, 4, fn:length(menu.icon))}');" 
										name="guidemenu"  menuid="${menu.id}" ><i class="mr-5 sfnav ${menu.icon}"></i>${menu.name}</a>
								</li>
								<c:if test="${firstMenu}">
									<c:set var="firstMenuId" value="${menu.id}"/>
									<c:set var="firstMenuName" value="${menu.name}"/>
									<c:set var="firstMenuCount" value="${fn:substring(menu.icon, 4, fn:length(menu.icon))}"/>
								</c:if>
								<c:set var="firstMenu" value="false"/>
							</c:if>
						</c:if>
					</c:forEach>
				</ul>
			</nav>
		</div>
	</header>
	<aside class="Hui-aside" id="Hui-aside" style="display: none;">
		<input type="hidden" id="firstMenuId" value="${firstMenuId }">
		<input type="hidden" id="firstMenuName" value="${firstMenuName }">
		<input type="hidden" id="firstMenuCount" value="${firstMenuCount }">
		<div class="menu_dropdown bk_2">
			<dl id="menu-orders" class="menu-orders">
				<dd>
					<ul id="orderMe"></ul>
				</dd>
			</dl>
		</div>
	</aside>

	<section class="Hui-article-box" id="Hui-article-box">
		<div id="iframe_box" class="Hui-article">
			<div class="show_iframe">
				<div style="display: none" class="loading"></div>
				<iframe scrolling="yes" frameborder="0" src="${ctx}/main/redirect/welcome" allowtransparency="yes"></iframe>
			</div>
		</div>
	</section>

	<div class="contextMenu" id="Huiadminmenu">
		<ul>
			<li id="closethis">关闭当前</li>
			<li id="closeall">关闭全部</li>
		</ul>
	</div>

	<!-- <div class="rbLayerbox msgbox" id="msgNewOrderBox" style="display: none;">
		<h2 class="layer-title">
			消息提示
			<a href="javascript:closeMsgBox();" class="sficon f-r closeW"></a>
		</h2>
		<div class="msgmain">
			<p class="txt">单号：<span id="msgBox_orderNo" class="msgbox-mgtop">WX20160704055525</span></p>
			<p class="txt msgbox-mgtop">服务工程师<span id="msgBox_empName" class="msgbox-mgtop">张三</span><span id="msgBox_content" class="msgbox-mgtop">有新的反馈！</span></p>
			<div class="text-r">
				<a href="javascript:closeMsgBox();" class="btn-ck">关闭</a>
			</div>
		</div>
	</div> -->
	<div id="msgNewOrderBox" class="fixPromptBox jdPrompt  " style="z-index: 99999;display: none;">
		<h2 class="pr-15 fixPrompt_header">
			<span class="f-l f-18 c-white" id="order_msgbox_title">接单提醒</span>
			<a class="f-r f-14 c-white" href="javascript:closeMsgBox();">关闭</a>
		</h2>
		<div class="pd-20 fixPrompt_main lh-26 f-14">
			<p id="order_msgbox_content">
				有<span class="va-t">新的400工单</span>，<span class="va-t">FW-54658685b</span>/<span class="va-t">空调安装</span> ,请及时安排接单！
			</p>
			<a class="btn_check radius">查看</a>
		</div>
	</div>


	<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${ctxPlugin}/lib/jqGrid_5.2/plugins/jquery.contextmenu.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/socket.io.js"></script> 
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/unipay/unipay.js"></script>
		
	<script type="text/javascript">
	var curOrderNums = 0;
	var userType = '${userType}';
	var ktVIP;
    var changingSkin = false;
	var id= $("#firstMenuId").val();
	var name = $("#firstMenuName").val();
	var count = $("#firstMenuCount").val();
	function cnnws(){
		var socket =  io.connect('${websocketUrl}' + "?userId="+userId);
		socket.on('connect', function(data) {
			var jsonObject = {userName: userId, message: "init"};
			socket.emit('initPM', jsonObject);
		});
		socket.on('newMessage', function(data) {
			var obj = eval('('+data.message+')');
			showOrderMsgBox(obj);
			curOrderNums = 4;
		});
	}
	
	function showOrderMsgBox(obj){
		console.log(obj);
		var msgType = obj.msgType;
		var orderNo = obj.orderNo;
		var empName = obj.empName;
		var serviceType = obj.serviceType;
		if(msgType == "10"){//接单
			$("#msgNewOrderBox").removeClass("wgPrompt");
			$("#msgNewOrderBox").addClass("jdPrompt");
			$("#order_msgbox_title").text("接单提醒");
			var html = '有<span class="va-t">新的400工单</span>，<span class="va-t">'+orderNo+'</span><span class="va-t">'+serviceType+'</span> ,请及时安排接单！';
			$("#order_msgbox_content").empty().html(html);
		}else if(msgType == "11"){
			$("#msgNewOrderBox").removeClass("jdPrompt");
			$("#msgNewOrderBox").addClass("wgPrompt");
			$("#order_msgbox_title").text("完工提醒");
			var html = '<p>工单：'+orderNo + '' +serviceType + '<span class="va-t c-f55025">已完成</span>，请及时安排回访！</p><p>服务工程师：<span class="va-t c-f55025">'+empName+'</span></p>';
			$("#order_msgbox_content").empty().html(html);
		}
		$("#msgNewOrderBox").show();
	}
	
	var userId = ('${userId}');
		$(function() {
			ktVIP='${site.dueTime}';
			$.post("${ctx}/goods/sitePlatformGoods/getSite",function(result){
				if(isBlank(result)){
					
				}else{
					ktVIP=result.columns.due_time;
				}
			}); 

			cnnws();
			//setTimeout(cnnws, 10000);
			
			init_left_menu(id,name,count);
			$("#orderMe").on('click', '.sf_menu_item', function(){
				$(".sf_menu_item").removeClass("current");
				$(this).addClass("current");
			});
			$("#sf_top_menu").on('click', '.sf_top_menu_item', function(){
				$(".sf_top_menu_item").removeClass("current");
				$(this).addClass("current");
			});
			getMessageCount();


			$("#jumpToYunying").click(function() {
				var parentFrame = $('#sf_top_menu',window.document);
				parentFrame.find('a').removeClass('current');
				parentFrame.find("a.sf_top_menu_item:contains('运营管理')").addClass('current');
				init_left_menu('cc3930152a2a4c51989adc4b8c160298','运营管理','v7', function () {
					var aSide = $('#Hui-aside', window.document);
					changeLocation('运营管理','公司资料');
					aSide.find("a[data-title='公司资料']").click();
					aSide.find("a[data-title='公司资料']").parent().addClass('current');
				});
			});
			
			$("#goToGoods").click(function(){
				var parentFrame = $('#sf_top_menu',window.document);
				parentFrame.find('a').removeClass('current');
				parentFrame.find("a.sf_top_menu_item:contains('商品管理')").addClass('current');
				init_left_menu('cb0c8c9b182843fc8690453e52e67f59','商品管理','v4', function () {
					var aSide = $('#Hui-aside', window.document);
					changeLocation('商品管理','平台商品');
					aSide.find("a[data-title='平台商品']").parent().addClass('current');
					$("iframe", window.top.document).attr("src", '${ctx}/goods/sitePlatformGoods/getSitePlatformAssistant');
				});
			});

            $("#skinbox_con span").click(function () {
                if (changingSkin) {
                    return;
                }

                var skin = $("input", $(this)).val();
                changingSkin = true;
                $.ajax({
                    url: '${ctx}/user_custom/skin',
                    data: {skin: skin},
                    type: 'post',
                    success: function () {
                        window.location.reload();
                    },
                    complete: function() {
                        changingSkin = false;
                    }
                });
            });
            
		});

		$(window).load(function() {
			//dom not only ready, but everything is loaded
			if (typeof('${xufeiRemind}') != "undefined") {
				//xfRemind();
			}
		});
		
		function getMessageCount(){
            $.post("${ctx}/commonAjax/getMessengerCount", {}, function (result) {
                $("#msgCount").text(result.msgCount + "条");
            });
		}
		
		function isBlank(val) {
			if (val == null || $.trim(val) == '' || val == undefined) {
				return true;
			}
			return false;
		}
		
		function init_left_menu(id,name,count,x){
			$.ajax({
				url: "${ctx}/sys/menu/tree",
				type: "POST",
				data: "parentId="+id,
				dataType: "json",
				success: function(data) {
					var obj=eval(data);
					var length = obj.cmlist.length;
					$("#orderMe").empty();
					var html = '';
					var firstName = "";
					
					var sitePermissions = '${permissions}';
					for(var i = 0; i < length; i++){
						if(userType != '3' || obj.isAdmin || (userType == '3' && checkSitePermission(sitePermissions, obj.cmlist[i].menuId))){
							var newHref = obj.cmlist[i].href;
							if(newHref && newHref.indexOf("?") != -1){
								newHref += "&curMenuId=" + obj.cmlist[i].menuId;  
							}else{
								newHref += "?curMenuId=" + obj.cmlist[i].menuId;
							}
							html += '<li class="sf_menu_item" onclick="changeLocation(\''+name+'\', \''+obj.cmlist[i].name+'\');"><a data-href="${ctx}'+newHref+'" data-title="'+obj.cmlist[i].name+'"';
							html += 'href="javascript:void(0)"><i class="aside-menu '+obj.cmlist[i].icon+'"></i>'+obj.cmlist[i].name+'</a></li>';
						}
					}

					$("#orderMe").append(html);

					show400Tip();

					if(typeof x === 'function') {
						x.call();
					} else {
						if($("#sf_top_menu").find("a[class~='current']").text() != "首页"){
							if($("#sf_top_menu").find("a[class~='current']").text() == "工单管理"){
								var it = $("#orderMe .sf_menu_item:contains('全部工单')");
								if (it.size() > 0) {
									it.eq(0).find('a').click();
								} else {
									$("#orderMe").find(".sf_menu_item").eq(0).find("a").click();
								}
							} else {
								$(".show_iframe").contents().find("body").empty();
								$("#orderMe").find(".sf_menu_item").eq(0).find("a").click();
							}
							//默认点击第一个菜单
						}
					}
				}, error: function(){//请求完成后最终执行参数
					location.reload();
				}
			});
		}
		
		function show400Tip(){
			var is400 = false;
			$("#orderMe .sf_menu_item").each(function(){
				if($(this).text().indexOf("400工单") != -1){
					is400 = true;
					$(this).find("a").append('<span class="mt-15 mr-5 f-r note">1</span>');
					return false;

				}
			});
		}

		function closeMsgBox(){
			$("#msgNewOrderBox").hide();
		}
		
		function changeLocation(module, subModule){
			$(".Hui-aside").show();
			$("#module_span").text(module);
			$("#sub_module_span").text(subModule);
		}
		
		function jumpToVIP(){
			layer.open({
				  type: 2,
				  content: '${ctx}/goods/sitePlatformGoods/jumpVIP',
				  //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://baidu.com', 'no']
				  title:false,
				  area: ['100%','100%'],
				  closeBtn:0,
				  shade:0
			});
		}
		function xfRemind() {
            layer.open({
                type: 2,
                content: '${ctx}/reminder/xufeiRemind',
                //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://baidu.com', 'no']
                title:false,
                area: ['100%','100%'],
                closeBtn:0,
                shade:0
            });
		}
		function saveLastRemind(callback) {
			$.ajax({
				url: '${ctx}/reminder/saveLastXuFeiRemind',
				type: 'post',
				complete: function() {
					callback.call();
				}
			});
		}
		function showXuFei() {
			layer.open({
				type: 2,
				content: '${ctx}/reminder/showXufei',
				//这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://baidu.com', 'no']
				title:false,
				area: ['100%','100%'],
				closeBtn:0,
				shade:0
			});
		}
	</script>
</body>
</html>
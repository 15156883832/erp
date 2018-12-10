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
							<i class="sficon sficon-role1"></i>
							<span class="username">${userName }</span>
							<i class="sficon sficon-arrowdown2"></i>
						</a>
						<ul class="dropDown-menu menu radius box-shadow" style="border-top: 1px solid #0e8ee7;">
							<li id="jumpToYunying"><a href="javascript:;"><i class="sficon sficon-role mr-5"></i>${usertype }</a></li>
							<li><a href="${ctx}/logout"><i class="sficon sficon-exit mr-5"></i>退出</a></li>
						</ul>
					</li>
				</ul>
			</nav>
						
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

	<div class="rbLayerbox msgbox" id="msgNewOrderBox" style="display: none;">
		<h2 class="layer-title">
			消息提示
			<a href="javascript:closeMsgBox();" class="sficon f-r closeW"></a>
		</h2>
		<div class="msgmain">
			<p class="txt">单号：<span id="msgBox_orderNo">WX20160704055525</span></p>
			<p class="txt">服务工程师<span id="msgBox_empName">张三</span><span id="msgBox_content">有新的反馈！</span></p>
			<div class="text-r">
				<a href="javascript:closeMsgBox();" class="btn-ck">关闭</a>
			</div>
		</div>
	</div>
	



	<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${ctxPlugin}/lib/jqGrid_5.2/plugins/jquery.contextmenu.js"></script>
<%-- <script type="text/javascript" src="${ctxPlugin}/lib/socket.io.js"></script>  --%>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/unipay/unipay.js"></script>
		
	<script type="text/javascript">
	var userType = '${userType}';
	var ktVIP;
	var changingSkin = false;
	var id= $("#firstMenuId").val();
	var name = $("#firstMenuName").val();
	var count = $("#firstMenuCount").val();
		$(function() {
			ktVIP='${site.dueTime}';
			$.post("${ctx}/goods/sitePlatformGoods/getSite",function(result){
				if(isBlank(result)){
					
				}else{
					ktVIP=result.columns.due_time;
				}
			}); 
			if(ktVIP==null || ktVIP==""){
				$("#ktVIP").text("开通VIP会员");
			}else{
				$("#ktVIP").text("续费VIP会员");
			}
			var userId = ('${userId}');
			/* var socket =  io.connect('${websocketUrl}');
			socket.on('connect', function(data) {
				var jsonObject = {userName: userId, message: "init"};
				socket.emit('initPM', jsonObject);
			});
			socket.on('disconnect', function() {});
			socket.on('newMessage', function(data) {
				var obj = eval('('+data.message+')');
				$("#msgBox_orderNo").text(obj.orderNoDetail);
				$("#msgBox_empName").text(obj.empName);
				$("#msgNewOrderBox").show();
			});  */
			
			init_left_menu(id,name,count);
			$("#orderMe").on('click', '.sf_menu_item', function(){
				$(".sf_menu_item").removeClass("current");
				$(this).addClass("current");
			});
			$("#sf_top_menu").on('click', '.sf_top_menu_item', function(){
				$(".sf_top_menu_item").removeClass("current");
				$(this).addClass("current");
			});
			/* $("#Hui-aside").show(); */
			getMessageCount();

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
					if(typeof x === 'function') {
						x.call();
					} else {
						if($("#sf_top_menu").find("a[class~='current']").text() != "首页"){
							$(".show_iframe").contents().find("body").empty();
							$("#orderMe").find(".sf_menu_item").eq(0).find("a").click();
							//默认点击第一个菜单
						}
					}
				}, error: function(){//请求完成后最终执行参数
					location.reload();
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
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
	<meta http-equiv="Cache-Control" content="no-siteapp" />
	<LINK rel="Bookmark" href="${ctxPlugin}/favicon.ico">
	<LINK rel="Shortcut Icon" href="${ctxPlugin}/favicon.ico"/>
	<!--[if lt IE 9]>
	<script type="text/javascript" src="${ctxPlugin}/lib/html5.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/respond.min.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/PIE_IE678.js"></script>
	<![endif]-->
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui/css/H-ui.min.css" />
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui/css/H-ui.reset.css"/>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/H-ui.admin.css" />
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/Hui-iconfont/1.0.7/iconfont.css" />
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/icheck/icheck.css" />
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/skin/default/skin.css" id="skin" />
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/style.css" />
	
	<script type='text/javascript' src='<%=request.getContextPath() %>/orderListener/dwr/engine.js'></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/orderListener/dwr/interface/ReverseMsgCenter.js"></script>
	<script type="text/javascript">
		ReverseMsgCenter.pageLoad('${userId}');
		function showMsg(data){
			var info = eval("("+data+")");
			if(info != null && info != undefined && info.userId != ""){
				if(info.type == 'ovt'){
					/* layer.tips('<div style="color:red;"><p><strong>工单超时提醒</strong></p><p>您有'+info.cnt+'条工单超过24小时未完成，请及时处理.</p></div>', '#tips-div', {
						  tips: [1, '#D6D608'],
						  time: 4000
						}); */
					if('${fns:getUserType()}' != "服务商"){
						layer.open({
							  title:'1小时未接工单提醒',
							  skin: 'layui-layer-lan', //样式类名
							  shift: 2,
							  offset:'rb',
							  shade: false,
							  move:false,
							  content: '<p class="txt">单号：<span>'+info.orderStr+'</span></p><p class="txt">超过1小时未接单,请及时处理!</p>',
							  btn:['查看'],
							  yes: function(index, layero){
								  var url = '${ctx}' + "/order/msgGotoOrderDetail?msgOrderNum="+info.orderNum;
								  $("#menu-order").find("ul").append('<li id="tmp_click"><a _href="'+url+'" data-title="未完工信息" href="javascript:;"></a></li>');
								  $("#tmp_click").find("a").click();
								  $("#tmp_click").remove();
								  layer.close(index);
							  }
						});
					}
				}else{
					var empStr = "";
					if(info.empStr != ""){
						empStr = ":" + info.empStr;
					}
					var html = '<p class="txt">单号：<span>'+info.orderStr+'</span></p><p class="txt">服务工程师<span>'+empStr+'</span>有新的反馈!</p>';
					layer.open({
						  title:'厂家工单提醒',
						  skin: 'layui-layer-lan', //样式类名
						  shift: 2,
						  offset:'rb',
						  shade: false,
						  move:false,
						  content: html,
						  btn:['查看'],
						  yes: function(index, layero){
							  var url = '${ctx}' + "/order/msgGotoOrderDetail?msgOrderNum="+info.orderNum;
							  $("#menu-order").find("ul").append('<li id="tmp_click"><a _href="'+url+'" data-title="厂家工单" href="javascript:;"></a></li>');
							  $("#tmp_click").find("a").click();
							  $("#tmp_click").remove();
							  layer.close(index);
						  }
					});
				}
			}
		}
	</script>
	
	<!--[if IE 6]>
	<script type="text/javascript" src="http://lib.h-ui.net/DD_belatedPNG_0.0.8a-min.js" ></script>
	<script>DD_belatedPNG.fix('*');</script>
	<![endif]-->
	<title>${fns:getConfig("productName")}</title>
	<meta name="keywords" content="">
	<meta name="description" content="">
</head>
<body onload="dwr.engine.setActiveReverseAjax(true);dwr.engine.setNotifyServerOnPageUnload(true,true);dwr.engine.setErrorHandler(function(){});">
<header class="navbar-wrapper">
	<div class="zhjnavbar pl-5 pr-5">
		<div class="container-fluid cl">
			<a class="logo f-l" href="#"></a>
			<nav class="nav navbar-nav zhj-navbar f-l ml-12 ">
				<ul class="cl" name="guide-nav-ul">
					<!--
                        <li><a href="#" class="inav1">信息管理</a></li>
                        <li class="active"><a href="#" class="inav2">工单管理</a></li>
                        <li><a href="#" class="inav3">厂家管理</a></li>
                        <li><a href="#" class="inav4">备件管理</a></li>
                        <li><a href="#" class="inav5">数据中心</a></li>
                        <li><a href="#" class="inav6">运营管理</a></li>
                        <li><a href="#" class="inav7">系统设置</a></li>
                    -->
					<c:set var="firstMenu" value="true"/>
					<c:forEach items="${fns:getMenuList()}" var="menu" varStatus="idxStatus">
						<c:if test="${menu.parent.id eq '1' && menu.isShow eq '1'}">
							<%-- <li><a href="javascript:;" onclick="article_add('${menu.id}','${menu.name }','${menu.sort%20}');" name="guidemenu" class="inav${menu.sort%20}" menuid="${menu.id}" >${menu.name}</a></li> --%>
							<li><a href="javascript:;" onclick="article_add('${menu.id}','${menu.name }','${fn:substring(menu.icon, 4, fn:length(menu.icon))}');" name="guidemenu" class="${menu.icon }" menuid="${menu.id}" >${menu.name}</a></li>
							<c:if test="${firstMenu}">
								<c:set var="firstMenuId" value="${menu.id}"/>
								<c:set var="firstMenuName" value="${menu.name}"/>
								<c:set var="firstMenuCount" value="${fn:substring(menu.icon, 4, fn:length(menu.icon))}"/>
							</c:if>
							<c:set var="firstMenu" value="false"/>
						</c:if>
					</c:forEach>
				</ul>
			</nav>
			<nav id="Hui-userbar" class="navbar-userbar zhj-userbar">
				<ul class="cl">
					<li class="dropDown dropDown_hover f-l">
						<a href="javascript:;" class="dropDown_A"><c:if test="${userType eq '2'}"><i class="role role_${site.level}"></i></c:if>${fns:getUserName()}<i class="Hui-iconfont arrow_down">&#xe6d5;</i></a>
						<ul class="dropDown-menu menu radius box-shadow">
		          			<li><a href="javascript:;"><i class="icon_userbar icon1"></i></a></li>
		          			<c:if test="${userType eq '2'}">
			          			<li><a href="javascript:;"><i class="icon_userbar icon_${site.level}"></i>
			          				<c:if test="${site.level eq '0' }">普通会员</c:if>
			          				<c:if test="${site.level eq '1' }">银牌会员</c:if>
			          				<c:if test="${site.level eq '2' }">金牌会员</c:if>
			          				<c:if test="${site.level eq '3' }">钻石会员</c:if>
			          				</a>
			          			</li>
		          			</c:if>
		          			<li><a href="javascript:;"><i class="icon_userbar icon2"></i>${fns:getUserName()}</a></li>
		          			<c:if test="${userType eq '2'}">
		          				<li><a href="javascript:;"><i class="icon_userbar icon4"></i>短信剩余数（<span class="c-fd6522">${site.smsAvailableAmount }条</span>）</a></li>
		          			</c:if>
		          			<li><a href="${ctx}/redirect/logout"><i class="icon_userbar icon3"></i>退出</a></li>
		          			<%-- <li><a href="${ctx}/common/download?fileName=excel/peijian_import_template.xlsx" target="_blank"><i class="icon_userbar icon3"></i>下载</a></li> --%>
	              		</ul>
					</li>
				</ul>
			</nav>
		</div>
	</div>
</header>


<aside class="Hui-aside">
	<input type="hidden" id="firstMenuId" value="${firstMenuId }">
	<input type="hidden" id="firstMenuName" value="${firstMenuName }">
	<input type="hidden" id="firstMenuCount" value="${firstMenuCount }">
	<input runat="server" id="divScrollValue" type="hidden" value="">
	<div class="menu_dropdown bk_2" id="orderMe" >
		
	</div>
</aside>

<div class="dislpayArrow hidden-xs"><a id="pngfix-nav-btn" class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a></div>
<section class="Hui-article-box">
	<div id="Hui-tabNav" class="Hui-tabNav">
		<div class="Hui-tabNav-wp">
			<ul id="min_title_list" class="acrossTab cl">
				<li class="active"><span title="快捷桌面" data-href="">快捷桌面</span><em></em></li>
			</ul>
		</div>
		<div class="Hui-tabNav-more btn-group"><a id="js-tabNav-prev" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d4;</i></a><a id="js-tabNav-next" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d7;</i></a></div>
	</div>
	<div id="iframe_box" class="Hui-article">
		<div class="show_iframe">
			<div style="display:none" class="loading"></div>
			<iframe scrolling="yes" frameborder="0" src="${ctx}/shortcut/index"></iframe>
		</div>
	</div>
	<div id="tips-div" style="position: fixed;right: 0;bottom: 0;">&nbsp;</div>
</section>


<script type="text/javascript" src="${ctxPlugin}/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/layer/2.1/layer.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui/js/H-ui.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/H-ui.admin.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		var id= $("#firstMenuId").val();
		var name = $("#firstMenuName").val();
		var count = $("#firstMenuCount").val();
		article_add(id,name,count);
	});

	function article_add(id,name,count){
		$.ajax({
			url: "${ctx}/sys/menu/tree",
			type: "POST",
			data: "parentId="+id,
			dataType: "json",
			success: function(data) {
				var obj=eval(data);
				var length = obj.cmlist.length;
				$("#orderMe").empty();
				var html ='<dl id="menu-order" class="zhj-menu zhj-menu'+count+'"><dt class="selected"><i></i>'+name+'</dt>';
				if(count == "8"){
					html += '<dd class="zhj-menu-cjgd"><ul>';
				}else{
					html += '<dd><ul>';
				}
				for(var i=0;i<length;i++){
					html += '<li><a _href="${ctx}'+obj.cmlist[i].href+'" data-title="'+obj.cmlist[i].name+'" href="javascript:void(0)"><i class="'+obj.cmlist[i].icon+'"></i>'+obj.cmlist[i].name+'</a></li>';//menu_ordericon'+(i+1)+'
				}
				html += '</ul></dd></dl>';
				$("#orderMe").append(html);
				$("#orderMe").val('');
			}, error: function(){//请求完成后最终执行参数
				location.reload();
			}
		});
	}
</script>
<script type="text/javascript">
	function createFakeMenuItem(href, title) {
		var html = '<li><a _href="'+href+'" data-title="'+ title+'" href="javascript:void(0)"></a></li>';
		$('#fakerNavi').html(html);
		Hui_admin_tab($('#fakerNavi').find('a'));
	}
	$(function() {
		<c:if test="${false eq detailInfoDone}">
			createFakeMenuItem("${ctx}" + "/operate/site/form", "完善资料");
			$('.active').children('i').remove();
			  $(document).unbind("dblclick");
		</c:if>
		
		$(".zhj-navbar li").on("click", function(){
			$(".zhj-navbar li").removeClass("active");
			$(this).addClass("active");
		});
		
		var a = $.parseJSON('${commonSetting}');
		if(a.set_value== "1"){
		}else{
		}
	});
</script>
<ul style="display: block;" id="fakerNavi"></ul>
</body>
</html>

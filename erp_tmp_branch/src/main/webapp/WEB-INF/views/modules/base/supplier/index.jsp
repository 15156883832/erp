﻿<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE HTML>
<html>
<head>
<title>思方科技</title>
<meta charset="utf-8">
<meta name="keywords" content="思方海尔,Haier,思方">
<meta name="description" content="思方海尔">
<meta name="decorator" content="base">
<style type="text/css">
	body{
		background:#e4e6eb; 
		min-width: 1366px;
		/*min-height: 720px;*/
		position: absolute;
	    left: 0;
	    right: 0;
	    bottom: 0;
	    top: 0;
	}
</style>
</head>
<body class="">
	<header class="navbar-wrapper navbarHeader">
		<div class="navbar navbar-sflogo">
			<div class="nav-logo nav-logo-new">
				<a class="logo navbar-logo" href="#"></a>
			</div>
			<nav class="breadcrumb f-l c-222">
				<i class="Hui-iconfont f-18">&#xe671;</i>
				<span>当前位置：</span>
				<a href="javascript:;" class=""><span id="module_span">商品管理</span></a>
				<a href="javascript:;" class=""><span class="en">&gt;</span><span id="sub_module_span">我的商品管理</span></a>
			</nav>
			<nav id="Hui-userbar" class="navbar-userbar userbar-sf f-r mr-15">
				<ul class="cl">
					<li class="">
						<a class="helpLink btn-help" href="${ctx}/helpindex/indexHelp?a=gdztsm" target="_blank" >
							<i class="sficon sficon-help"></i>帮助中心
							<i class="jicon_update"></i>
						</a>
					</li>
					<li class="dropDown dropDown_hover right"> 
						<a class="helpLink btn-help" href="#">
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
						<a href="#" class="dropDown_A ">
							<span class="username va-t">${userName}</span>
							<i class="sficon sficon-arrowdown2"></i>
						</a>
						<ul class="dropDown-menu menu radius box-shadow w-200" style="border-top: 1px solid #0e8ee7;">
							<li id="jumpToYunying"><a href="javascript:;"><i class="sficon sficon-role mr-5"></i>${usertype }</a></li>
							<li><a href="${ctx}/logout"><i class="sficon sficon-exit mr-5"></i>退出</a></li>
						</ul>
					</li>
				</ul>
			</nav>
		</div>
		
	</header>
<aside class="Hui-aside hide1" id="Hui-aside">
	<div class="menu_dropdown bk_2">
	<c:set var="firstMenu" value="true"/>
		<c:forEach items="${fns:getMenuListL2()}" var="menu" varStatus="idxStatus">
			<dl >
				<dt class="menu-l1"><i class="sfnav ${menu.menu.icon}"></i>${menu.menu.name}<i class="menu_dropdown-arrow"></i></dt>
				<dd>
					<ul>
						<c:forEach items="${menu.children}" var="child" varStatus="idx">
						<%-- <c:if test="${idx.first}">
						
						
				         </c:if>  --%>
				         <c:if test="${firstMenu}">
							<c:set var="firstdataHref" value="${child.href}"/>
							<c:set var="firstMenuName" value="${child.name}"/>
						</c:if>
				         <c:set var="firstMenu" value="false"/>
							<li onclick="changeLocation('${menu.menu.name}', '${child.name}')"><a class="menu-l2" data-href="${ctx}${child.href}" data-title="${child.name}" data-group="${menu.menu.name}" href="javascript:void(0)">${child.name}</a></li>
						</c:forEach>
					</ul>
				</dd>
			</dl>
		</c:forEach>
	</div>
</aside>

<div class="dislpayArrow" id="dislpayArrow"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar2(this)"> <i class="Hui-iconfont Hui-iconfont-arrow2-left c-white"></i> </a></div>
<section class="Hui-article-box" id="Hui-article-box">
	<div id="Hui-tabNav" class="Hui-tabNav">
		<div class="Hui-tabNav-wp">
			<ul id="min_title_list" class="acrossTab cl">
				<li class="active"><span data-href="${ctx}${firstdataHref}">${firstMenuName }</span><em></em></li>
			</ul>
		</div>
		<div class="Hui-tabNav-more btn-group">
			<a id="js-tabNav-prev" class="js-tabNav" href="javascript:;"></a>
			<a id="js-tabNav-next" class="js-tabNav" href="javascript:;"></a>
		</div>
	</div>
	<div id="iframe_box" class="Hui-article">
		<div class="show_iframe">
			<div style="display:none" class="loading"></div>
			<iframe scrolling="yes" frameborder="0" src="${ctx}${firstdataHref}" allowtransparency="yes"></iframe>
		</div>
	</div>
</section>

<!--请在下方写此页面业务相关的脚本-->
	<script type="text/javascript">
        var changingSkin = false;
        $(function () {
            $("#skinbox_con").find("span").click(function () {
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
                    complete: function () {
                        changingSkin = false;
                    }
                });
            });

            selectModule("商品管理", "我的商品管理");
        });

        function displaynavbar2(obj) {
            if ($(obj).hasClass("open")) {
                $(obj).removeClass("open");
                $(obj).find('.Hui-iconfont').removeClass('Hui-iconfont-arrow2-right').addClass('Hui-iconfont-arrow2-left');
                $('.Hui-aside').css({'left': '0px'});
                $('.Hui-article-box').css({'left': '150px'});
                $('.dislpayArrow').css({'left': '150px'});
            } else {
                $(obj).addClass("open");
                $(obj).find('.Hui-iconfont').removeClass('Hui-iconfont-arrow2-left').addClass('Hui-iconfont-arrow2-right');
                $('.Hui-aside').css({'left': '-150px'});
                $('.Hui-article-box').css({'left': '0px'});
                $('.dislpayArrow').css({'left': '0px'});
            }
        }

        function changeLocation(module, subModule) {
            $("#module_span").text(module);
            $("#sub_module_span").text(subModule);
        }
	</script>
</body>
</html>
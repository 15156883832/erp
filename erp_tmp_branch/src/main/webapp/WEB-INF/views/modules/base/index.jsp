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
	<script type="text/javascript" src="${ctxPlugin}/lib/socket.io.js"></script>
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
	.logoBtmWhite{
		 overflow: visible;
	}
</style>
</head>
<body class="">
	<header class="navbar-wrapper navbarHeader"  style="z-index: 99999">
		<div class="navbar navbar-sflogo">
			<div class="nav-logo nav-logo-new">
				<a class="logo navbar-logo" href="#"></a>
			</div>
			<nav class="breadcrumb f-l c-222">
				<i class="Hui-iconfont f-18">&#xe671;</i>
				<span>当前位置：</span>
				<a href="javascript:;" class=""><span id="module_span">工单管理</span></a>
				<a href="javascript:;" class=""><span class="en">&gt;</span><span id="sub_module_span">首页</span></a>
			</nav>
			<div class="f-l w-160 priceWrap" style="margin-top:17px;">
				<input class="input-text" id ="orderNUmber" placeholder="请输入联系方式" onkeydown="if(event.keyCode==13){btnSearch(1);}"/>
				<span class="unit"><a class="sficon sficon-search-gray btn_search" id="btnS1"></a></span>
			</div>
			<div class="f-l w-160 ml-15 priceWrap" style="margin-top:17px;">
				<input class="input-text" id ="orderNUmber2" placeholder="请输入工单编号" onkeydown="if(event.keyCode==13){btnSearch(2);}"/>
				<span class="unit"><a class="sficon sficon-search-gray btn_search" id="btnS2"></a></span>
			</div>
			<nav id="Hui-userbar" class="navbar-userbar userbar-sf f-r mr-15">
				<ul class="cl">
					<li class="">
						<c:if test="${dict eq 1 }">
							<c:if test="${not empty site.id }">
								<%--
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
								--%>
								<c:if test="${mark == 'wkt' }">
									<a class="openVipR" href="javascript:;" onclick="showXuFei();">
										<i class="sficon sficon-role0"></i>开通VIP会员
									</a>
								</c:if>
								<c:if test="${mark == 'gq' }">
									<a class="openVipR" href="javascript:;" onclick="showXuFei();">
										<i class="sficon sficon-role0"></i>续费VIP会员
									</a>
								</c:if>
								<c:if test="${mark == 'ok' }">
									<a class="openVipR"  href="javascript:;" onclick="showXuFei();">
										<i class="sficon sficon-renew"></i>续费VIP会员
									</a>
								</c:if>
							</c:if>
						</c:if>
					</li>
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
							<i class="sficon sficon-role${level.count}"></i>
							<span class="username va-t">${userName}</span>
							<i class="sficon sficon-arrowdown2"></i>
						</a>
						<ul class="dropDown-menu menu radius box-shadow w-200" style="border-top: 1px solid #0e8ee7;">
						<c:if test="${userType eq 2 }">
							<li id="jumpToYunying"><a href="javascript:;" class="text-overflow"><i class="sficon sficon-role mr-5"></i>${usertype }（${level.name}）</a></li>
						</c:if>
						<c:if test="${userType ne 2 }">
							<li ><a href="javascript:;" class="text-overflow"><i class="sficon sficon-role mr-5"></i>${usertype }</a></li>
						</c:if>
							<li id="goToGoods"><a href="javascript:;"><i class="sficon sficon-mgs mr-5"></i>可使用短信（<span class="c-f55025 f-13" id="msgCount">0条</span>）</a></li>
							<li><a href="javascript:fenxiang();"><i class="sffejl mr-5"></i>会员分享奖励</a></li>
							<li><a href="${ctx}/logout"><i class="sficon sficon-exit mr-5"></i>退出</a></li>
						</ul>
					</li>
				</ul>
			</nav>
			<c:if test="${giftCount gt 0}">
				<img src="${ctxPlugin}/static/h-ui.admin/images/A.gif" class="mr-10 f-r mt-5" style="height: 40px;" id="jumpToGift"/>
			</c:if>
			<c:if test="${xufeiInfo.remindIcon == 1 and xufeiRemindDock}">
				<a class="f-r mr-10 btndis btndis${xufeiInfo.discount}" onclick="xfRemind();"></a>
			</c:if>
		</div>
		
	</header>
<aside class="Hui-aside hide1" id="Hui-aside">
	<div class="menu_dropdown bk_2">
		<dl class="">
			<dt class="menu_home current"><a id="menu_home" href="javascript:void(0)" data-href="${ctx}/main/redirect/welcome" data-title="首页"><i class="sfnav sfnav1 "></i>首页</a></dt>
		</dl>
		<c:forEach items="${fns:getMenuListL2()}" var="menu" varStatus="idxStatus">
			<dl >
				<dt class="menu-l1"><i class="sfnav ${menu.menu.icon}"></i>${menu.menu.name}<i class="menu_dropdown-arrow"></i></dt>
				<dd>
					<ul>
						<c:forEach items="${menu.children}" var="child" varStatus="idx">
							<li onclick="changeLocation('${menu.menu.name}', '${child.name}')">
								<%--fns:ensureTabPathByL2Menu(child.id, child.href)--%>
								<%--${child.href}--%>
								<a class="menu-l2" data-href="${ctx}${fns:ensureTabPathByL2Menu(child.id, child.href)}" data-title="${child.name}" data-group="${menu.menu.name}" href="javascript:void(0)">${child.name}</a>
							</li>
						</c:forEach>
					</ul>
				</dd>
			</dl>
		</c:forEach>
	</div>

</aside>
<div>
	<div class="nav-logo-new nav-logo nav-logo2">
<c:if test="${bangshou eq 'yes' }">
		<a class="logo navbar-logo logo2"  href="${ctx}/goods/employeOwn/alipayforward" target="_blank">
		</a>
</c:if>
	</div>

	<%--<div class="bing hide">
		<a href="javascript:jumpToMenuItem('商品管理','平台商品');"><img style="width: 100%;" src="${ctxPlugin}/static/h-ui.admin/images/bing.png" alt=""/></a>
		<div class="sheng">
			<div class="bingNone">&times;</div>
			<div>剩余 <span class="setIn">9</span>秒</div>
		</div>
	</div>--%>
	<%--<div class="logoBtmContent">--%>
	    <%--<div class="logoBtmWhite">--%>
	        <%--<div class="logoBtm1"></div>--%>
	        <%--<div class="logoBtm2"></div>--%>
	        <%--<a href="${ctx}/goods/employeOwn/alipayforward" target="_blank"class="logoBtmBtn"></a>--%>
	        <%--<span class="cha-del">&times;</span>--%>
	    <%--</div>--%>
	<%--</div>--%>
<%-- 	<div class="logoBtm" >
	    <div class="logoBtm1"></div>
	    <div class="logoBtm2"></div>
	    <a class="logoBtmBtn"  href="${ctx}/goods/employeOwn/alipayforward" target="_blank"></a>
	    <span class="cha">&times;</span>
	</div> --%>
	</div>
<div class="dislpayArrow" id="dislpayArrow"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar2(this)"> <i class="Hui-iconfont Hui-iconfont-arrow2-left c-white"></i> </a></div>
<section class="Hui-article-box" id="Hui-article-box">
	<div id="Hui-tabNav" class="Hui-tabNav">
		<div class="Hui-tabNav-wp">
			<ul id="min_title_list" class="acrossTab cl">
				<li class="active"><span data-href="${ctx}/main/redirect/welcome">首页</span><em></em></li>
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
			<iframe scrolling="yes" frameborder="0" src="${ctx}/main/redirect/welcome" allowtransparency="yes"></iframe>
		</div>
	</div>
</section>

<div class="fixPromptBox sysPrompt" id="msgNewOrderBox" style="z-index: 99999;display: none;">
	<h2 class="pr-15 fixPrompt_header">
		<span class="f-l f-18 c-white">系统提醒</span>
		<a class="f-r f-14 c-white" href="javascript:closeMsgBox();">关闭</a>
	</h2>
	<div class="fixPrompt_main lh-20 f-14"></div>
</div>
	<!--请在下方写此页面业务相关的脚本-->
	<script type="text/javascript">
        var changingSkin = false;
        var curOrderNums = 0;
        var userId = ('${userId}');

        /*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-弹出美的冰箱推广页面-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*/
       /* function openpopup(){
            setInterval(function(){
                var num=$('.setIn').html();
                if(num>0){
                    num--;
                    $('.setIn').html(num);
                    if(num==0){
                        a()
                    }
                }
            },1000);
        }
        function get_cookie(Name) {
            var search = Name + "=";
            var returnvalue = "";
            if (document.cookie.length > 0) {
                offset = document.cookie.indexOf(search);
                if (offset != -1) {
                    // if cookie exists
                    offset += search.length;
                    // set index of beginning of value
                    end = document.cookie.indexOf(";", offset);
                    // set index of end of cookie value
                    if (end == -1)
                        end = document.cookie.length;
                    returnvalue=unescape(document.cookie.substring(offset, end))
                }
            }
            return returnvalue;
        }
        function loadpopup(){
            if (get_cookie("popped")==""){
                $('.bing').show();
                openpopup()
                document.cookie="popped=yes"
            }else{
                a();
			}
        }

        function a() {
            $('.bing').fadeOut()
        }

        $('.bing').click(function () {
            a()
        });*/

		/*-----------------------------------------------------------------------------*/

        $(function () {
            if ("${areaCode}" === "8720") {
                openAolai();
            }
            <c:if test="${not fns:isDev()}">
            cnnws();
			</c:if>
            //loadpopup();

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

            getMessageCount();
            onClickDuanxinHandler();

            $('#btnS1').on('click', function () {
                btnSearch(1);
            });

            $('#btnS2').on('click', function () {
                btnSearch(2);
            });

            $("#jumpToYunying").click(function() {
            	 creatIframe('${ctx}/operate/getSiteMsg/site', '公司资料设置');
            });
            $("#jumpToGift").click(function() {
               // jumpToMenuItem("运营管理", "分享会员奖励");
               fenxiang();
            });
//        setTimeout(function () {
//            $('.logoBtmWhite').slideDown()
//            $('.nav-logo2').slideUp()
//        },2000);
//        $('.cha-del').click(function () {
//            $(this).parents().prev().eq(0).slideDown()
//            $(this).parents().find('.logoBtmWhite').slideUp();
//
//        });
        });

        function clickPushJT(number){
            $("#orderNUmber2").val(number);
            btnSearch(2);
		}

		function goToPeijianPage(){
            jumpToMenuItem("备件管理", "备件申请管理");
		}
        

        function btnSearch(type) {
            var bStop = false;
            var bStopIndex = 1;
            var show_navLi = $('#min_title_list li');
            var num='';
			if(type === 1) {
                num = $("#orderNUmber").val();
            } else {
			    num = $("#orderNUmber2").val();
			}

            if (num == null || num == '' || num == undefined) {
                layer.msg("请输入查询信息！");
                return
            }
            show_navLi.each(function () {
                $(this).removeClass('active');
                if ($(this).find('span').text() == '快速查询') {
                    bStopIndex = show_navLi.index($(this));
                    bStop = true;
                }
            });
            if (!bStop) {
                creatIframe('${ctx}/order/orderQuick?comp=' + num+"&type="+type, '快速查询');
            } else {
                show_navLi.eq(bStopIndex).addClass('active');
                $('#iframe_box .show_iframe').hide().eq(bStopIndex).show().find('iframe').attr({'src': '${ctx}/order/orderQuick?comp=' + num+"&type="+type});

            }
        }

        <c:if test="${'2' eq userType}">
        $(window).load(function () {
            //dom not only ready, but everything is loaded
            if (${xufeiRemind}) {
                xfRemind();
            }
        });
        </c:if>
        
        function fenxiang(){
        	  creatIframe('${ctx}/sys/gift', '分享会员奖励');
        }

        function cnnws(){
        	var isFirefox = navigator.userAgent.toUpperCase().indexOf("Firefox") ? true:false; 
        	var isChrome = window.navigator.userAgent.indexOf("Chrome") !== -1;
        	if(isFirefox || isChrome){
        		var socket =  io.connect('${websocketUrl}' + "?userId="+userId);
                socket.on('connect', function(data) {
                    var jsonObject = {userName: userId, message: "init"};
                    socket.emit('initPM', jsonObject);
                });
                socket.on('newMessage', function(data) {
                    var obj = eval('('+data.message+')');
                    curOrderNums = obj.count;
                    refreshPushMsgBox(obj);
                });
        	}
        }

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

        function getMessageCount(){
            $.post("${ctx}/commonAjax/getMessengerCount", {}, function (result) {
                $("#msgCount").text(result.msgCount + "条");
            });
        }

        function closeMsgBox() {
            $("#msgNewOrderBox").hide();
            $("#msgNewOrderBox .fixPrompt_main").empty();
        }

        function changeLocation(module, subModule) {
            $("#module_span").text(module);
            $("#sub_module_span").text(subModule);
        }

        function jumpToVIP() {
            layer.open({
                type: 2,
                content: '${ctx}/goods/sitePlatformGoods/jumpVIP',
                //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://baidu.com', 'no']
                title: false,
                area: ['100%', '100%'],
                closeBtn: 0,
                shade: 0
            });
        }

        function xfRemind() {
            layer.open({
                type: 2,
                content: '${ctx}/reminder/xufeiRemind',
                //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://baidu.com', 'no']
                title: false,
                area: ['100%', '100%'],
                closeBtn: 0,
                shade: 0
            });
        }

        function saveLastRemind(callback) {
            $.ajax({
                url: '${ctx}/reminder/saveLastXuFeiRemind',
                type: 'post',
                complete: function () {
                    callback.call();
                }
            });
        }

        function showXuFei() {
            layer.open({
                type: 2,
                content: '${ctx}/reminder/showXufei',
                //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://baidu.com', 'no']
                title: false,
                area: ['100%', '100%'],
                closeBtn: 0,
                shade: 0
            });
        }

        function openAolai() {
            layer.open({
                type: 2,
                content: '${ctx}/main/redirect/showAolai',
                title: false,
                area: ['100%', '100%'],
                closeBtn: 0,
                shade: 0
            });
        }

        function onClickDuanxinHandler() {
            $("#goToGoods").on('click', function () {
                jumpToMenuItem("商品管理", "平台商品");
            });
        }

        function jumpToMenuItem(module, subModule) {
            var dropdownMenu = $(".menu_dropdown");
            dropdownMenu.find(".menu-l1").each(function () {
                if (module === $(this).text()) {
                    if (!$(this).hasClass("selected")) {
                        $(this).click();
                    }
                    $(this).parent().find(".menu-l2").each(function () {
                        if (subModule === $.trim($(this).text())) {
                            $(this).click();
                            return false;
                        }
                    });
                    return false;
                }
            });
		}
	</script>
</body>
</html>
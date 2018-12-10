<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
<!--<meta charset="utf-8">-->
<meta name="decorator" content="default"/>
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<meta http-equiv="Cache-Control" content="no-siteapp" />

<title>${fns:getConfig("productName")}</title>
<meta name="keywords" content="">
<meta name="description" content="">
</head>
<body>
<%--  	<header class="nav-wrapper">
		<div class="zhjcontent">
			<a href="${ctx}" class="logo f-l"></a>
		</div>
	</header>  --%>

<%-- 	<section class="zhjbox loginpagebox">
		<div class="zhjcontent clearfix">
			<div class="leftbox f-l">
				<h1 class="title"></h1>
				<div class="txt">
					<p>操作简单，管理便捷，服务高效</p>
					<p>我们从始至终就是如何为您带来最优的服务，告诉我们您需要什么样的功能需求，我们就给您提供这样的功能。</p>
				</div>
				<div class="clearfix">
					<div class="codeimgbox">
						<img src="${commonStaticImgPath}/qrcode/code_jlr.png">
						<p class="imgtxt">服务商版APP下载</p>
					</div>
					<div class="codeimgbox">
						<img src="${commonStaticImgPath}/qrcode/code_fwgcs.png">
						<p class="imgtxt">服务工程师APP下载</p>
					</div>
				</div>
			</div>
			<div class="rightbox f-l">
				<div class="loginmodule">
					<h2 class="title">
						<span class="title-lb f-l">欢迎登录</span>
						<a class="link-reg f-r" href="${ctx}/main/redirect/crmRegist">免费注册&nbsp;&gt;</a>
					</h2>
					<div class="form">
						<form action="${ctx}/login" method="post">
							<p class="erromsg" <c:if test="${errormessage eq 'error'}">style="visibility:visible;"</c:if>>您输入的密码和账户名不匹配，请重新输入！</p>
							<p class="textbox radius name">
								<input type="text" name="username" class="text" placeholder="手机号/邮箱/登录名" />
							</p>
							<p class="textbox radius pwd">
								<input type="password" name="password" class="text" placeholder="密码"  />
							</p>
							<p class="btn-pwd mb-10">
								<label class="btn-remember f-l pos-r" for="rememberpwd" >
									<input type="checkbox" id="rememberpwd" name="online" class="pos-a left bottom" />记住密码
								</label>
								<a class="btn-forget f-r" href="${ctx}/main/redirect/forgetPwd">忘记密码?</a>
							</p>
							<a class="btn-log radius btn-block">登录</a>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section> --%>
	
	<div class="loginSfbg"></div>
	<div class="loginSfpage">
		<div class="loginbox">
			<div class="sflogo"></div>
					<form action="${ctx}/login" method="post">
				<div class="sfloginForm">
					<div class="input-wrap">
						<input type="text" name="username" class="input-login username"  placeholder="手机号/邮箱/登录名" />
					</div>
					<div class="input-wrap">
						<input type="password" name="password" class="input-login userpwd" placeholder="密码"  />
					</div>
					<div class="pwdbox cl">
						<label class="remberpwd pos-r" for="rememberpwd">
							<input type="checkbox" id="rememberpwd"  name="online"/>记住密码
						</label>
						<a href="${ctx}/main/redirect/forgetPwd" class="f-r forgetpwd">忘记密码</a>
					</div>
					<a href="javascript:;" class="btn-login">登录</a>
				    <c:if test="${errormessage eq 'error'}">
				    <p class="txt" >您输入的密码和账户名不匹配，请重新输入！</p>
				    </c:if>
						
				</div>
			</form>	
			<p class="cright">Copyright © 2014-2016 安徽思方网络科技有限公司 皖ICP备17000071号</p>
		</div>		
				
				
		<div class="extra-wrap">
			<div class="qqmain">
				<a href="javascript:;" class="extra-btn radius btn-qq">
					<span>QQ在线</span>
				</a>
				<div class="qqnumberbox radius">
					<p class="qqtxt">387808217</p>
					<p class="qqtxt">2997231847</p>
				</div>
			</div>
			<div class="codemain mt-5">
				<a href="javascript:;" class="extra-btn radius btn-app">
					<span>APP下载</span>
				</a>				
				<div class="downloadCode radius">
					<div class="codebox">
						<div class="code-img">
							
							<img src="${commonStaticImgPath}/qrcode/code_fwgcs.png">
						</div>
						<p class="txt">服务工程师APP下载</p>
					</div>
					<div class="codebox">
						<div class="code-img">
							<img src="${commonStaticImgPath}/qrcode/code_jlr.png">
						</div>
						<p class="txt">服务商App下载</p>
					</div>
				</div>
			</div>
			<div class="weixinmain mt-5" >
				<a href="javascript:;" class="extra-btn radius btn-weixin">
					<span>微信公众号</span>
				</a>
				<div class="weixinbox radius">
					<img src="${commonStaticImgPath}/qrcode/code-weixin.png" class="img-wx" />
					<p>扫一扫关注</p>
				</div>
			</div>
		</div>
	</div>
	
	<!-- <footer class="text-c pt-20">
		Copyright ©2014-2016 xx有限公司 皖ICP备17000071号
	</footer> -->
<script type="text/javascript" src="${ctxPlugin}/lib/aes.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.cookie.js"></script>
<script type="text/javascript">
	var t=function(){var a="${ctx}/main/redirect",b="${ctx}/login",c=function(c,d){$.cookie(c,d,{expires:2555,path:a}),$.cookie(c,d,{expires:2555,path:b})},d=function(c){$.removeCookie(c,{path:a}),$.removeCookie(c,{path:b})};return{tg:function(){function a(a){a=a||32;for(var b="ABCDEFGHJKMNPQRSTWXYZabcdefhijkmnprstwxyz2345678",c=b.length,d="",e=0;e<a;e++)d+=b.charAt(Math.floor(Math.random()*c));return d}var g,b=$("#rememberpwd"),e=$('input[name="username"]'),f=$('input[name="password"]');b.attr("checked")?(g=a(6),c("u",CryptoJS.AES.encrypt(e.val(),g).toString(),g),c("p",CryptoJS.AES.encrypt(f.val(),g).toString(),g),c("c","true"),c("v",g)):(d("u"),d("p"),d("c"),d("v"))},r:function(){"true"==$.cookie("c")&&($('input[name="username"]').val(CryptoJS.AES.decrypt($.cookie("u"),$.cookie("v")).toString(CryptoJS.enc.Utf8)),$('input[name="password"]').val(CryptoJS.AES.decrypt($.cookie("p"),$.cookie("v")).toString(CryptoJS.enc.Utf8)),$("#rememberpwd").attr("checked",!0),$("#rememberpwd").parent("label").addClass("remberpwd-yes"))}}}();

	
	function setMt(){
		var winH = $(window).height();
		var oDiv = $('.loginbox');
		var oDivh = oDiv.height();
		var mt = parseInt((winH-oDivh)/2)>0 ?parseInt((winH-oDivh)/2) :0;
		oDiv.css({'margin-top': mt});
	}
	
	$(function(){
		
		$('.loginSfbg').css({
			'filter':'progid:DXImageTransform.Microsoft.AlphaImageLoader(src="http://120.210.205.24/orderstres/commonfiles/bg_sflogin.jpg"'})
		
	/* 	$('.btn-app').hover(function(){
			$(this).css({'background-position':' 24px -210px'});
			$(this).children('span').css({'color':'#0d87cb'});
			$('.downloadCode').show();
		},function(){
			$(this).css({'background-position':' 24px -140px'});
			$(this).children('span').css({'color':'#2a2a2a'});
			$('.downloadCode').hide();
		}); */
			
		$('.codemain').hover(function(){
			$('.btn-app').css({'background-position':' 24px -210px'});
			$('.btn-app').children('span').css({'color':'#0d87cb'});
			$('.downloadCode').show();
		},function(){
			$('.btn-app').css({'background-position':' 24px -140px'});
			$('.btn-app').children('span').css({'color':'#2a2a2a'});
			$('.downloadCode').hide();
		});
		
		$('.qqmain').hover(function(){
			$('.btn-qq').css({'background-position':' 24px -70px'});
			$('.btn-qq').children('span').css({'color':'#0d87cb'});
			$('.qqnumberbox').show();
		},function(){
			$('.btn-qq').css({'background-position':' 24px -0px'});
			$('.btn-qq').children('span').css({'color':'#2a2a2a'});
			$('.qqnumberbox').hide();
		});
		$('.weixinmain').hover(function(){
			$('.btn-weixin').css({'background-position':' 24px -350px'});
			$('.btn-weixin').children('span').css({'color':'#0d87cb'});
			$('.weixinbox').show();
		},function(){
			$('.btn-weixin').css({'background-position':' 24px -280px'});
			$('.btn-weixin').children('span').css({'color':'#2a2a2a'});
			$('.weixinbox').hide();
		});
		
		//解决iframe下系统超时无法跳出iframe框架的问题
		if (window != top)
		top.location.href = location.href;
		
		setMt();
		$(window).resize(function(){
			setMt();
		});
		
		//  是否记住密码
	/* 	$('#rememberpwd').click(function(){
			if ( $(this).attr('checked')) {
				$(this).removeAttr('checked');
				$(this).parent('label').removeClass('active');
			}else{
				$(this).attr('checked',true);
				$(this).parent('label').addClass('active');
			}
		}); */
		$('#rememberpwd').on('click',function(){
			if ( $(this).attr('checked')) {
				 $(this).removeAttr('checked');
				$(this).parent('label').removeClass('remberpwd-yes');
			}else{
				 $(this).attr('checked',true);
				$(this).parent('label').addClass('remberpwd-yes');
			}
		});

		$('.btn-login').click(function () {
			t.tg();
			$('form').submit();
		});
		$(document).keypress(function(e) {
			if(e.which == 13) {
				$('.btn-login').trigger('click');
			}
		});
		t.r();

		var c = '${temporaryMsg}';
		<c:if test="${not empty temporaryMsg}">
		layer.msg('${temporaryMsg}');
		</c:if>
		$("body").addClass("loginpage")
	});
	
</script>
</body>
</html>
﻿<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
<meta name="decorator" content="base"/>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/sfskin_blue.css" />
	<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
	<style type="text/css">
		html,body{ position: relative; height: 100%;}
		.errorwran{
				display: none;
			}
		.guanIndex{
			width:1000px;
			margin:0px auto 0;
			padding-right:200px;
			padding-top:20px;
			position: relative;
			z-index: 999;
		}
	</style>
</head>
<body>
	<div class="loginbg"></div>
	<div class="loginWrap">
		<div class="loginWrapBg">
			<h2 class="webName pos-r">
				<a class="btn_return" href="http://www.sifangerp.cn/" target="_blank"><i class="sficon sficon-return1"></i> 返回官网</a>
			</h2>
			<div class="loginMain loginpage cl" style="padding-bottom:15px;">
				<div class="f-l leftWrap br pos-r" id="leftWrap">
					<div class="swicthWrap">
						<a href="javascript:;" class="switchCode current">经理人</a>
						<a href="javascript:;" class="switchCode sw2">工程师</a>
					</div>
					
					<div class="tabCon">
						<p class="title">经理人APP下载</p>
						<img src="${ctxPlugin}/static/h-ui.admin/images/ERP2.0_manager_download_page.png" />
					</div>
					<div class="tabCon">
						<p class="title">工程师APP下载</p>
						<img src="${ctxPlugin}/static/h-ui.admin/images/ERP2.0_employe_download_page.png" />
					</div>
				</div>
				<%-- <div class="f-l leftWrap br">
					<img src="${ctxPlugin}/static/h-ui.admin/images/code.png" />
					<div class="mt-15 lh-20">
						<p>扫描二维码下载官方</p><p>思方APP</p>
					</div>
				</div> --%>
				
				<div class="f-l rightWrap">
					<h3 class="f-20 lh-26 mb-20 text-c">欢迎登录</h3>
					<form action="${ctx}/login" method="post" id="loginForm">
						<div class="input-wrap username">
							<i class="iconUser"></i>
							<input type="text" class="input-text2 " placeholder="手机号/ 用户名" id="username" name="username"  value="${username }" datatype="*" errormsg="格式错误" nullmsg="请输入登录名"/>
							<!-- <p class=" errorwran errorwranu"></i></p> -->
							
						</div>
						<div class="input-wrap mt-20 userpwd">
							<i class="iconUser"></i>
							<input type="password" class="input-text2 " placeholder="密码" id="password" name="password"  datatype="*" errormsg="格式错误" nullmsg="请输入登录密码"/>
							<!-- <p class="errorwran errorwranp"></i></p> -->
						</div>
						<div class="mt-15 cl mb-15" id="box">
							<label class="label-cbox f-13">
								<input type="checkbox" name="rememberpwd"  id="rememberpwd"/>记住密码
							</label>
							<a class="btn-forgetpwd f-13 f-r" href="javascript:resertPwd();">忘记密码？</a>
						</div>
						<c:if test="${errormessage eq 'error' }">
						<p class="c-fe0101 f-12  lh-20 "><i class="sficon sficon-errorwran2"></i>您输入的密码和账户名不匹配，请重新输入！</p>
						</c:if>
						<c:if test="${msg  eq 'notfind' }">
						<p class="c-fe0101 f-12  lh-20 "><i class="sficon sficon-errorwran2"></i>您输入的手机号或用户名不存在，请重新输入！</p>
						</c:if>
						
						<a class="btn-login mt-5">登录</a>
						<div class="cl lh-20 mt-10">
							<a href="javascript:register();" class="btn_regLink f-l" >立即注册</a> 
						
							<span class="f-l c-888">获取激活码，免费使用系统！</span>
						</div>
						<%-- <c:if test="${errormessage eq 'error' }">
						<div style="height:30px"><p class=" c-fe0101 f-13 "><i class="oState state-invalid"></i>您输入的密码和账户名不匹配，请重新输入！</p></div>
						</c:if>
						<c:if test="${msg  eq 'notfind' }">
							<div style="height:30px"><p class=" c-fe0101 f-13 "><i class="oState state-invalid"></i>登陆账号不存在！</p></div>
							</c:if> --%>
							
					<!-- 	<div style="height:30px"><p class=" c-fe0101 f-13 hide"><i class="oState state-invalid"></i></p></div> -->
					</form>
				</div>
				
			</div>
		</div>
	</div>
	
	<div class="copyright">
		<p class="f-13" style="color: #2a2a2a;">
			为了您更好的系统使用体验，我们建议您使用下列浏览器：
			<a class="btn_browserFf mr-10" href="http://www.firefox.com.cn/download/#more" target="_blank">火狐浏览器</a>
			<a class="btn_browserGg" href="https://www.google.cn/chrome/" target="_blank">谷歌浏览器</a>
			（建议电脑分辨率调整至1440x900及以上）
		</p>
		<p>Copyright ©2014-2017 安徽思方网络科技有限公司 皖ICP备17000071号</p>	
	</div>
	<script type="text/javascript" src="${ctxPlugin}/lib/aes.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.cookie.js"></script>
<script type="text/javascript">
var _sftt = function() {
    var a = "${ctx}/main/redirect",
    b = "${ctx}/login",
    c = function(c, d) {
        $.cookie(c, d, {
            expires: 2555,
            path: a
        }),
        $.cookie(c, d, {
            expires: 2555,
            path: b
        })
    },
    d = function(c) {
        $.removeCookie(c, {
            path: a
        }),
        $.removeCookie(c, {
            path: b
        })
    };
    return {
        tg: function() {
            function a(a) {
                a = a || 32;
                for (var b = "ABCDEFGHJKMNPQRSTWXYZabcdefhijkmnprstwxyz2345678",
                c = b.length,
                d = "",
                e = 0; e < a; e++) d += b.charAt(Math.floor(Math.random() * c));
                return d
            }
            var g, b = $("#rememberpwd"),
            e = $('input[name="username"]'),
            f = $('input[name="password"]');
            b.attr("checked") ? (g = a(6), c("u", CryptoJS.AES.encrypt(e.val(), g).toString(), g), c("p", CryptoJS.AES.encrypt(f.val(), g).toString(), g), c("c", "true"), c("v", g)) : (d("u"), d("p"), d("c"), d("v"))
        },
        r: function() {
            "true" == $.cookie("c") && ($('input[name="username"]').val(CryptoJS.AES.decrypt($.cookie("u"), $.cookie("v")).toString(CryptoJS.enc.Utf8)), $('input[name="password"]').val(CryptoJS.AES.decrypt($.cookie("p"), $.cookie("v")).toString(CryptoJS.enc.Utf8)), $("#rememberpwd").attr("checked", !0), $("#rememberpwd").parent("label").addClass("label-cbox-selected"))
        }
    }
} ();


	$(function(){
		
		initCopyRight();
		
		$.Huitab("#leftWrap .swicthWrap .switchCode","#leftWrap .tabCon","current","click","0");
		$('.input-text2').focus(function(){
			$(this).css({'border':'1px solid #0e8ee7'});
		})
		$('.input-text2').blur(function(){
			$(this).css({'border':'1px solid #ccc'});
		})
		
 		$('input[name="rememberpwd"]').on('click',function(){
			
			if($(this).prop('checked')){
				$(this).parent().addClass('label-cbox-selected');
			}else{
				$(this).parent().removeClass('label-cbox-selected');
			}
		}); 
		$(".btn-login").on('click', function(){
			 $('#loginForm').Validform({
				 tiptype:function(msg, o, cssctl) {
					 var objtip;
					 objtip=o.obj.siblings(".errorwran");
					 if(o.type =="3"){
						cssctl(objtip,o.type);
						objtip.text(msg);
						objtip.show();
		  			}else{
			  	/* 	o.obj.removeClass('mustfill'); */
					$(".errorwran").hide();
		 	 		}
				},
				postonce : true,
				callback: function(form) {	
				}
			});
			 _sftt.tg();
			 $("#loginForm").submit();
		});
		$(document).keypress(function(e) {
			if(e.which == 13) {
				$('.btn-login').trigger('click');
			}
		});
		_sftt.r();
        //解决iframe下系统超时无法跳出iframe框架的问题
        if (window != top) top.location.href = location.href;
	});
	
	function register(){
		layer.open({
			type : 2,
			content:'${ctx}/main/redirect/sgUp',
			title:false,
			area: ['100%','100%'],
			closeBtn:0,
			shade:0,
			anim:-1 
		});
	}
	
	function resertPwd(){
		layer.open({
			type : 2,
			content:'${ctx}/main/redirect/toResertPwd',
			title:false,
			area: ['100%','100%'],
			closeBtn:0,
			shade:0,
			anim:-1 
		});
	}
	
	function initCopyRight(){
		var winWidth = window.screen.width;
		
		if( winWidth < 1440){
			$('.loginWrap').css({
				
			})
			$('.copyright').css({'bottom':'5px'})
		}
		
	}
</script>
	
</body>
</html>
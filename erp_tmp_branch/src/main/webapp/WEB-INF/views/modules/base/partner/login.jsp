﻿<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
	<%--<meta name="decorator" content="base"/>--%>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
	<meta http-equiv="Cache-Control" content="no-store" />

	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<meta http-equiv="Cache-Control" content="no-siteapp" />
	<script src="${ctxPlugin}/static/h-ui.admin/js/jquery-1.8.3.js" type="text/javascript" charset="utf-8"></script>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/layer/2.1/skin/layer.css" />
	<script type="text/javascript" src="${ctxPlugin}/lib/layer/2.1/layer.js"></script>
	<script src="${ctxPlugin}/static/h-ui.admin/js/sifang.js" type="text/javascript" charset="utf-8"></script>

	<!--[if lt IE 9]>
	<script type="text/javascript" src="${ctxPlugin}/lib/html5shiv.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/respond.min.js"></script>
	<![endif]-->


	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/order-st/partner/css/reset.css"/>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/order-st/partner/css/style.css"/>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/order-st/partner/css/ygcxlm.css"/>
	<!--[if IE 6]>
	<script type="text/javascript" src="${ctxPlugin}/lib/DD_belatedPNG_0.0.8a-min.js" ></script>
	<script>DD_belatedPNG.fix('*');</script>
	<![endif]-->

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
	<h2 class="webName mb-50 cl">

	</h2>
	<div class="cl pt-30">
		<div class="f-l " style="width: 540px; padding-top: 120px;">
			<p class="f-22 c-5f4852 lh-30 mb-10">
				<strong class="c-ff6900">指导：</strong>
				安徽省消费者权益保护委员会</p>
			<p class="f-22 c-5f4852 lh-30 mb-10">
				<strong class="c-ff6900">主办：</strong>
				安徽省电子电器行业维权办公室<br>
				<span style="padding-left: 73px">安徽省电子电器服务业协会</span>
			</p>
			<p class="f-22 c-5f4852 lh-30 mb-10"><strong class="c-ff6900">媒体： </strong>中国消费者报安徽记者站</p>

			<div class="login_con1"></div>
		</div>

		<div class="loginWrapBg f-r">

			<p class="cl mb-15">
				<a class="btn_return f-r" href="http://www.ahesa.org/" target="_blank">
					<i class="sficon sficon-return1"></i> 返回官网
				</a>
			</p>
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

				<div class="f-l rightWrap">
					<h3 class="f-20 lh-26 mb-20 text-c">欢迎登录</h3>
					<form action="${ctx}/login?origin=jdxh" method="post" id="loginForm">
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
							<a href="javascript:register();" class="btn_regLink f-l">立即注册</a>
							<span class="f-l c-888"> 协会官方统一激活码 </span>
							<span class="f-l c-ff6900">&nbsp;FWXH </span>
							<span class="f-l c-888">&nbsp;</span>
						</div>
					</form>
				</div>

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
	<p>Copyright ©2014-2018 安徽思方网络科技有限公司 皖ICP备17000071号</p>
</div>
<script type="text/javascript" src="${ctxPlugin}/lib/aes.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.cookie.js"></script>
<script src="${ctxPlugin}/static/order-st/partner/js/index.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
    var t = function() {
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
        /*$('.input-text2').focus(function(){
            $(this).css({'border':'1px solid #0e8ee7'});
        })
        $('.input-text2').blur(function(){
            $(this).css({'border':'1px solid #ccc'});
        })*/

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
            t.tg();
            $("#loginForm").submit();
        });
        $(document).keypress(function(e) {
            if(e.which == 13) {
                $('.btn-login').trigger('click');
            }
        });
        t.r();
        //解决iframe下系统超时无法跳出iframe框架的问题
        if (window != top) top.location.href = location.href;
    });

    function register(){
        layer.open({
            type : 2,
            content:'${ctx}/main/redirect/sgUp?origin=jdxh',
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
            content:'${ctx}/main/redirect/toResertPwd?origin=jdxh',
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            anim:-1
        });
    }

    // 底部版权信息位置
    function initCopyRight(){
        var pageHeight = $(window).height();

        if( pageHeight <= 768){
            $('body').height('768px');
            //		$('#copyright').css({ 'bottom':'5px' });
            //		$('#copyright').css({ 'position':'absolute'});
        }else{
            $('body').height('100%');
            //		$('#copyright').css({ 'bottom':'50px' });
            //		$('#copyright').css({ 'position':'fixed'});
        }
    }
</script>

</body>
</html>
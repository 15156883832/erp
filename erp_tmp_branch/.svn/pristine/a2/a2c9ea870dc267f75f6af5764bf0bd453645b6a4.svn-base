<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
<!--<meta charset="utf-8">-->
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<meta http-equiv="Cache-Control" content="no-siteapp" />

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
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/Validform/5.3.2/css/validformstyle.css" />
<!--[if IE 6]>
<script type="text/javascript" src="http://lib.h-ui.net/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<title>${fns:getConfig("productName")}</title>
<meta name="keywords" content="">
<meta name="description" content="">
<style type="text/css">
	.forgetpwdform .txt-note{
		display: none;
	}
	.forgetpwdform .Validform_wrong{
		display: block;
		background-position: 0 -111px;
		color: #f54b1d;
	}
	.forgetpwdform .Validform_right{
		display: block;
		background-position: 0 -147px;
	}
</style>
</head>
<body class="loginpage">
	<header class="nav-wrapper">
		<div class="zhjcontent">
			<a href="${ctx}" class="logo f-l"></a>
			<h1 class="pagetitle f-l">忘记密码</h1>
		</div>
	</header>

	<section class="zhjbox regpagebox">
		<div class="zhjcontent">
			<div class="pt-10 lh-26 reglog">
				<span class="f-r"><a class="btn-login" href="${ctx}/login">登录</a>|&nbsp;
				<%-- <a class="btn-login ml-5" href="${ctx}/main/redirect/crmRegist">注册</a> --%>
				</span>
			</div>
			<div class="regbgbox">
				<h2 class="pwdtest-title pt-10">
					<a class="pwdNav1">短信验证</a>
					<a class="pwdNav1">邮箱验证</a>
				</h2>
				<div class="forgetpwdform pwdTab1 smsTab">
					<form action="${ctx}/main/redirect/resetPwdBySms" method="post" accept-charset="utf-8" class="sms-rp">
						<div class="pos-r mb-15 reginputbox">
							<label class="txt-lb pos-a left bottom text-r"><em>*</em>手机号：</label>
							<input type="text" name="mobile" class="input-text radius" placeholder="请输入手机号，用于登录和找回密码" datatype="m" nullmsg="请输入手机号" errormsg="手机号格式不正确" ajaxurl="${ctx}/main/redirect/checkphone3?sucmsg=" maxlength="11"/>
							<span id="mobile_error" class="txt-note note pos-a right bottom"></span>
						</div>
						<div class="pos-r mb-15 reginputbox regcodebox">
							<label class="txt-lb pos-a left bottom text-r"><em>*</em>验证码：</label>
							<input type="text" name="code" class="input-text radius" datatype="*4-6" nullmsg="请输入验证码" errormsg="验证码不正确" ajaxurl="${ctx}/main/redirect/checkcode?sucmsg=" maxlength="6"/>
							<a id="code-i" class="btn-code radius f-r">获取短信验证码</a>
							<span class="txt-note note pos-a right bottom"></span>
						</div>
						<div class="pos-r mb-15 reginputbox">
							<label class="txt-lb pos-a left bottom text-r"><em>*</em>重置密码：</label>
							<input type="password" name="password" class="input-text radius" placeholder="请输入密码" datatype="*6-15" nullmsg="请输入密码" errormsg="密码范围在6~15位之间" maxlength="15"/>
							<span class="txt-note note pos-a right bottom"></span>
						</div>
						<div class="pos-r mb-15 reginputbox">
							<label class="txt-lb pos-a left bottom text-r"><em>*</em>确认密码：</label>
							<input type="password" name="passwordConfirmation" class="input-text radius" placeholder="请再次输入密码" datatype="*" recheck="password" nullmsg="请输入确认密码" errormsg="两次输入的密码不一致" maxlength="15"/>
							<span class="txt-note note pos-a right bottom"></span>
						</div>
						<div class="pos-r mb-15 reginputbox">
							<a id="btnSmsReset" class="btn-log radius btn-block">确定</a>
						</div>
					</form>
				</div>
				<div class="forgetpwdform pwdTab1 mailTab">
					<form action="${ctx}/main/redirect/resetPwdByMail" method="post" accept-charset="utf-8" class="mail-rp">
						<div class="pos-r mb-15 reginputbox">
							<label class="txt-lb pos-a left bottom text-r"><em>*</em>邮箱：</label>
							<input type="text" name="mail" class="input-text radius" placeholder="请输入您绑定的邮箱" datatype="e" nullmsg="请输入邮箱" errormsg="邮箱格式不正确" ajaxurl="${ctx}/main/redirect/checkmail3?sucmsg="/>
							<span class="txt-note note pos-a right bottom"></span>
						</div>
						<div class="pos-r mb-15 reginputbox regcodebox">
							<label class="txt-lb pos-a left bottom text-r"><em>*</em>验证码：</label>
							<input type="text" name="token" class="input-text radius" datatype="*4-6" nullmsg="请输入验证码" errormsg="验证码不正确" maxlength="6"/>
							<a id="token-i" class="btn-code radius f-r">获取邮箱验证码</a>
							<span class="txt-note note pos-a right bottom"></span>
						</div>
						<div class="pos-r mb-15 reginputbox">
							<label class="txt-lb pos-a left bottom text-r"><em>*</em>重置密码：</label>
							<input type="password" name="password" class="input-text radius" placeholder="请输入密码" datatype="*6-15" nullmsg="请输入密码" errormsg="密码范围在6~15位之间" maxlength="15"/>
							<span class="txt-note note pos-a right bottom"></span>
						</div>
						<div class="pos-r mb-15 reginputbox">
							<label class="txt-lb pos-a left bottom text-r"><em>*</em>确认密码：</label>
							<input type="password" name="passwordConfirmation" class="input-text radius" placeholder="请再次输入密码" datatype="*" recheck="password" nullmsg="请输入确认密码" errormsg="两次输入的密码不一致" maxlength="15"/>
							<span class="txt-note note pos-a right bottom"></span>
						</div>
						<div class="pos-r mb-15 reginputbox">
							<a id="btnMailReset" class="btn-log radius btn-block">确定</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/layer/2.1/layer.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui/js/H-ui.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/H-ui.admin.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/validation-utils.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/layer/2.1/layer.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript">
	var elMobile, elGetCode, elGetToken, elMail;

	$(function(){
		loginPageH();
		var aNav = $('.pwdNav1');
		var aTab = $('.pwdTab1');
		var iNow = 0;
		$(aNav[iNow]).addClass('active');
		$(aTab[iNow]).show();
		aNav.each(function(index){
			$(this).click(function(){
				aNav.removeClass('active');
				$(this).addClass('active');
				aTab.hide();
				$(aTab[index]).show();
			});
		});
	});
	
	function loginPageH(){
		var winH = $(document).height();
		var flagH ;
		if( winH < 809){
			flagH = 130;
		}else if( winH < 989){
			flagH = 200 ;
		}else{
			flagH = 250 ;
		}
		var divH = winH - $('.nav-wrapper').height() - flagH;
		$('.zhjbox').height(divH);
		$('.zhjbox').css({'padding-top': (divH- $('.zhjcontent').eq(1).height())/3 });
	}

	function getSmsCode() {
		var mobile = elMobile.val();
		if ($validator.isMobileValid(mobile)) {
			checkSendTime(60);
			$.ajax({
				type: "post",
				url: "${ctx}/main/redirect/mobileCode?mobile=" + mobile,
				dataType: "json",
				success: function () {
				}
			});
		} else {
			$('#mobile_error').removeClass('Validform_wrong').addClass('Validform_wrong').text("请检查手机号码");
		}
	}

    function validateMail() {
        $.ajax({
            type: "post",
            url: "${ctx}/main/redirect/checkmail3",
            data: {
                param: elMail.val()
            },
            dataType: "json",
            success: function (data) {
                if (data.status == 'y') {
                    checkSendTime2(60);
                    $.ajax({
                        type: "post",
                        url: "${ctx}/main/redirect/sendMailCode?mail=" + elMail.val(),
                        dataType: "json",
                        success: function () {
                            layer.msg("邮件已发送，请注意查收！");
                        }
                    });
                } else {
                    // 啥也不干？
                }
            }
        });
    }

    function getToken() {
        var mail = elMail.val();
        if ($validator.isEmailValid(mail)) {
            validateMail();
        }
    }

	function checkSendTime(time) {
		if (time <= 1) {
			elGetCode.text("获取短信验证码");
            elGetCode.on('click', getSmsCode);
		} else {
			time = time - 1;
            elGetCode.text(time + " 秒后重新获取");
            elGetCode.off('click');
			setTimeout(function () {
				checkSendTime(time);
			}, 1000);
		}
	}

	function checkSendTime2(time) {
		if (time <= 1) {
			elGetToken.text("获取邮箱验证码");
            elGetToken.on('click', getToken);
		} else {
			time = time - 1;
            elGetToken.text(time + " 秒后重新获取");
            elGetToken.off('click');
			setTimeout(function () {
                checkSendTime2(time);
			}, 1000);
		}
	}

	$(function () {
		$('.sms-rp').Validform({
			btnSubmit:"#btnSmsReset",
			tiptype: function(msg, o, cssctl) {
				if(!o.obj.is("form")){//验证表单元素时o.obj为该表单元素，全部验证通过提交表单时o.obj为该表单对象;
					var objtip=o.obj.siblings(".txt-note");
					cssctl(objtip,o.type);
					objtip.text(msg);
				}
			},
			callback: function (form) {
				layer.load(0, {time: 15 * 1000});
				return true;
			}
		});
		$('.mail-rp').Validform({
			btnSubmit:"#btnMailReset",
			tiptype: function(msg, o, cssctl) {
				if(!o.obj.is("form")){//验证表单元素时o.obj为该表单元素，全部验证通过提交表单时o.obj为该表单对象;
					var objtip=o.obj.siblings(".txt-note");
					cssctl(objtip,o.type);
					objtip.text(msg);
				}
			},
			callback: function (form) {
				layer.load(0, {time: 15 * 1000});
				return true;
			}
		});

		elMobile = $("input[name='mobile']");
		elMail = $("input[name='mail']");
		elGetCode = $("#code-i");
		elGetToken = $("#token-i");
		elGetCode.on('click', getSmsCode);
		elGetToken.on('click', getToken);

		$('input[name="mail"]').blur(function () {
			var url = "${ctx}/main/redirect/checktoken?sucmsg=";
			var elToken = $('input[name="token"]');
			if ($validator.isEmailValid($(this).val())) {
				url += '&mail=' + $(this).val();
				elToken.attr("ajaxurl", url);
			} else {
				elToken.removeAttr('ajaxurl');
			}
		});
	});
</script>
</body>
</html>

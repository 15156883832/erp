<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <!--<meta charset="utf-8">-->
    
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <LINK rel="Bookmark" href="${ctxPlugin}/favicon.ico">
    <LINK rel="Shortcut Icon" href="${ctxPlugin}/favicon.ico"/>
    <!--[if lt IE 9]>
    <script type="text/javascript" src="${ctxPlugin}/lib/html5.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/respond.min.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/PIE_IE678.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui/css/H-ui.min.css"/>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui/css/H-ui.reset.css"/>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/H-ui.admin.css"/>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/Hui-iconfont/1.0.7/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/icheck/icheck.css"/>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/skin/default/skin.css" id="skin"/>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/style.css"/>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/Validform/5.3.2/css/validformstyle.css" />

    <!--[if IE 6]>
    <script type="text/javascript" src="http://lib.h-ui.net/DD_belatedPNG_0.0.8a-min.js"></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
	<title>${fns:getConfig("productName")}</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <style type="text/css">
        .registerform .txt-note{
            display: none;
        }
        .registerform .Validform_wrong{
            display: block;
            background-position: 0 -111px;
            color: #f54b1d;
        }
        .registerform .Validform_right{
            display: block;
            background-position: 0 -147px;
        }
    </style>
</head>
<body class="loginpage">
<header class="nav-wrapper">
    <div class="zhjcontent">
        <a href="${ctx}" class="logo f-l"></a>
        <h1 class="pagetitle f-l">欢迎注册</h1>
    </div>
</header>

<section class="zhjbox regpagebox">
    <div class="zhjcontent">
        <div class="pt-10 lh-26 reglog">
            <span class="f-r">已注册？<a class="btn-login" href="${ctx}/login">登录</a></span>
        </div>
        <div class="regbgbox">
            <div class="registerform">
                <form action="${ctx}/main/redirect/register" method="post" accept-charset="utf-8" class="registForm">
                    <div class="pos-r mb-15 reginputbox">
                        <label class="txt-lb pos-a left bottom text-r"><em>*</em>手机号：</label>
                        <input type="text" name="mobile" class="input-text radius" placeholder="请输入手机号，用于登录和找回密码" datatype="m" nullmsg="请输入手机号" errormsg="手机号格式不正确" ajaxurl="${ctx}/main/redirect/checkphone2?sucmsg=" maxlength="11"/>
                        <span id="mobile_error" class="txt-note note pos-a right bottom"></span>
                        <!--<span class="note tel pos-a right bottom"></span>-->
                    </div>
                    <div class="pos-r mb-15 reginputbox regcodebox">
                        <label class="txt-lb pos-a left bottom text-r"><em>*</em>验证码：</label>
                        <input type="text" name="code" class="input-text radius" datatype="*4-6" nullmsg="请输入验证码" errormsg="验证码不正确" ajaxurl="${ctx}/main/redirect/checkcode?sucmsg=" maxlength="6"/>
                        <a id="code-i" class="btn-code radius f-r">获取短信验证码</a>
                        <span class="txt-note note pos-a right bottom"></span>
                    </div>
                    <div class="pos-r mb-15 reginputbox">
                        <label class="txt-lb pos-a left bottom text-r"><em>*</em>登录账号：</label>
                        <input type="text" name="loginName" class="input-text radius" placeholder="请输入长度为4-16位字母和数字组合的用户名" datatype="username" nullmsg="请输入登录账号" errormsg="账号应为4-16位字母和数字组合" ajaxurl="${ctx}/main/redirect/checkLoginName2?sucmsg=" maxlength="16"/>
                        <span class="txt-note note pos-a right bottom"></span>
                    </div>
                    <div class="pos-r mb-15 reginputbox">
                        <label class="txt-lb pos-a left bottom text-r"><em>*</em>密码：</label>
                        <input type="password" name="password" class="input-text radius" placeholder="请输入密码长度为6-15位数字、字母或组合" datatype="*6-15" nullmsg="请输入密码" errormsg="密码范围在6~15位之间" maxlength="15"/>
                        <span class="txt-note note pos-a right bottom"></span>
                    </div>
                    <div class="pos-r mb-15 reginputbox">
                        <label class="txt-lb pos-a left bottom text-r"><em>*</em>确认密码：</label>
                        <input type="password" name="passwordConfirmation" class="input-text radius" placeholder="请再次输入密码" datatype="*" recheck="password" nullmsg="请输入确认密码" errormsg="两次输入的密码不一致" maxlength="16"/>
                        <span class="txt-note note pos-a right bottom"></span>
                        <!--<span class="note pwd pos-a right bottom">密码不一致</span>-->
                    </div>
                    <div class="pos-r mb-15 reginputbox">
                        <label class="txt-lb pos-a left bottom text-r"><em>*</em>企业名称：</label>
                        <input type="text" name="siteName" class="input-text radius" placeholder="请输入企业名称长度为4-50汉字" datatype="z450" nullmsg="请输入企业名称" errormsg="企业名称应为4-50个汉字" maxlength="50"/>
                        <span class="txt-note note pos-a right bottom"></span>
                    </div>
                    <div class="pos-r mb-15 reginputbox">
                        <a id="btnRegist" class="btn-log radius btn-block">注册</a>
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
<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript">
    var elMobile, elGetCode, elLoginName;

    function getSmsCode() {
        if ($('input[name="mobile"]').hasClass("Validform_error")) {
            return;
        }
        var mobile = elMobile.val();
        if ($validator.isMobileValid(mobile)) {
            $.ajax({
                type: "GET",
                url: "${ctx}/main/redirect/checkphone2?sucmsg=&param=" + mobile,
                dataType: "json",
                success: function (data) {
                    if ('y' == data.status) {
                        checkSendTime(60);
                        $.ajax({
                            type: "post",
                            url: "${ctx}/main/redirect/mobileCode?mobile=" + mobile,
                            dataType: "json",
                            success: function () {
                            }
                        });
                    }
                }
            });
        } else {
            var error = $('#mobile_error');
            if (!error.hasClass('Validform_wrong')) {
                error.removeClass('Validform_wrong').addClass('Validform_wrong').text("请检查接收验证码手机号");
            }
        }
    }

    function checkSendTime(time) {
        if (time <= 1) {
            elGetCode.off('click').on('click', getSmsCode);
            elGetCode.text("获取短信验证码");
        } else {
            elGetCode.off('click');
            time = time - 1;
            elGetCode.text(time + " 秒后重新获取");
            setTimeout(function () {
                checkSendTime(time);
            }, 1000);
        }
    }
    
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
    
    $(function () {
    	loginPageH();
        $('.registForm').Validform({
            btnSubmit:"#btnRegist",
            tiptype: function(msg, o, cssctl) {
                if(!o.obj.is("form")){//验证表单元素时o.obj为该表单元素，全部验证通过提交表单时o.obj为该表单对象;
                    var objtip=o.obj.siblings(".txt-note");
                    cssctl(objtip,o.type);
                    objtip.text(msg);
                }
            },
            datatype: {
                "username": function (val) {
                    if (val && val.length >= 4) {
                        if (/^[0-9a-zA-Z]*[0-9][0-9a-zA-Z]*$/.test(val) && /^[0-9a-zA-Z]*[a-zA-Z][0-9a-zA-Z]*$/.test(val)) {
                            return true;
                        }
                    }
                    return false;
                },
                "z450": function(val) {
                    return /^[\u4e00-\u9fa5]{4,50}$/.test(val)
                }
            },
            callback: function (form) {
                var index = layer.load(0, {time: 15 * 1000});
                $.ajax({
                    url: "${ctx}/main/redirect/register",
                    //dataType: 'json',
                    type: "POST",
                    data: form.serialize(),
                    success: function (data) {
                        if (data.status && 'n' == data.status) {
                            if (data.login) {
                                elLoginName[0].validform_valid = "false";
                                var note = elLoginName.siblings(".txt-note");
                                note.removeClass("Validform_right").addClass("Validform_wrong");
                                note.text("用户名已被占用");
                            }
                            if (data.mobile) {
                                elMobile[0].validform_valid = "false";
                                var note1 = elMobile.siblings(".txt-note");
                                note1.removeClass("Validform_right").addClass("Validform_wrong");
                                note1.text("手机号已经被占用");
                            }
                        } else {
                            layer.msg("注册成功");
                            window.location = "${ctx}/login";
                        }
                    },
                    complete: function () {
                        layer.close(index);
                    }
                });
                return false;
            }
        });

        elMobile = $("input[name='mobile']");
        elGetCode = $("#code-i");
        elLoginName = $("input[name='loginName']");
        elGetCode.on("click", getSmsCode);
    });
</script>
</body>
</html>

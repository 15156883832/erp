<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
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
		html,body{ position: relative; height: 100%; }
		body{ overflow: auto;}
	</style>
</head>

<body>
	<div class="loginbg"></div>
	
	<div class="loginWrap">
		<div class="loginWrapBg registerpage">
			<h2 class="webName mb-40" style="margin-left: 50px;"></h2>
			<div class="loginMain resetMain">
				<h3 class="lh-26 resetTitle pb-10"> 
					重置密码
					<div class="loginlink">
						<span class="lh-20 va-t">已有账号</span>
						<a  class="btn-forgetpwd" onclick="retn()" href="${ctx}/main/redirect?origin=jdxh">马上登录</a>
					</div>
				</h3>
				<form action="#">
					<div class="cl mb-10">
						<label class="f-l text-r w-180"><em class="mark">*</em>手机号：</label>
						<input type="text" class="f-l w-280 input-text" placeholder="请输入注册的手机号" name="mobile" id="mobile"/>
					</div>
					<div class="cl mb-10">
						<label class="f-l text-r w-180"><em class="mark">*</em>验证码：</label>
						<input type="text" class="f-l w-170 input-text" placeholder="短信验证码" name="msgCheck" id="msgCheck" />
						<input type="button" id="sendMsg" value="获取验证码" class="f-l ml-10 w-100 btn-getCode btn"/>  
					</div>
					<div class="cl mb-10">
						<label class="f-l text-r w-180"><em class="mark">*</em>新密码：</label>
						<input type="text" class="f-l w-280 input-text" placeholder="6-8位的数字、字母或组合" id="password" name="password" />
					</div>
					<div class="cl mb-10">
						<label class="f-l text-r w-180"><em class="mark">*</em>确认密码：</label>
						<input type="text" class="f-l w-280 input-text" id="password1" name="password1"/>
					</div>
					<div class="ml-180 h-26 hide" id="checkMobile">
						<!-- <p class="c-fe0101 f-13 lh-20 "><i class="sficon sficon-errorwran2"></i>您输入的手机号错误，请重新输入！</p> -->
					</div>
					
					<div class="cl mb-10 mt-10">
						<label class="f-l w-180"></label>
						<a class="btn-login f-l w-280" onclick="submitPwd()">提交</a>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="copyright">Copyright ©2014-2018 安徽思方网络科技有限公司 皖ICP备17000071号</div>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="${ctxPlugin}/static/h-ui/js/H-ui.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/H-ui.admin.js"></script>
<script type="text/javascript">
var fsMsg="0";
	$(function(){
        window.onresize = function(){
            initCopyRight();
        };
	})
	
	function isBlank(val) {
		if (val == null || $.trim(val) == '' || val == undefined) {
			return true;
		}
		return false;
	}
	
	function CheckPassWord(password) {
		
	   var str = password;
	   if ((str.length < 6) || (str.length > 16) ) {
	        return false;
	    } 
	   /*  var reg1 = new RegExp(/^[a-zA-Z0-9]{6,16}$/);
	    if (!reg1.test(str)) {
	        return false;
	    } */
	} 
	
	function submitPwd(){
		$("#checkMobile").empty();
		var mobile = $("#mobile").val();
		var password = $("#password").val();
		var password1 = $("#password1").val();
		var msgCheck = $("#msgCheck").val();//验证码
		if(fsMsg=="1"){
			if(isBlank(msgCheck)){
				layer.msg("请输入您获取的短信验证码");
				$("#msgCheck").focus();
				return;
			}
		}else{
			layer.msg("请先点击发送短信验证码");
			$("#confirmCode").focus();
			return;
		}
		if(isBlank(password)){
			 $("#password").focus();
			 $("#checkMobile").append('<p class="c-fe0101 jdxhIcon jdxhIcon_errorWarn hide1"><i class="sficon sficon-errorwran2"></i>请输入6-16位字符的密码</p>');
			 $("#checkMobile").removeClass("hide");
			 return ;
		}
		if(CheckPassWord(password)==false){
			$("#password").focus();
			$("#checkMobile").append('<p class="c-fe0101 jdxhIcon jdxhIcon_errorWarn hide1"><i class="sficon sficon-errorwran2"></i>请输入6-16位字符的密码</p>');
			$("#checkMobile").removeClass("hide");
			return ;
		} 
		if(password != password1){
			$("#password1").focus();
			$("#checkMobile").append('<p class="c-fe0101 jdxhIcon jdxhIcon_errorWarn hide1"><i class="sficon sficon-errorwran2"></i>您输入的的密码前后不一致，请重新输入</p>');
			$("#checkMobile").removeClass("hide");
			return ;
		}
		
		$.ajax({
			type:"post",
			url:"${ctx}/main/redirect/resertPwd",
			data:{mobile:mobile,password:password,msgCheck:msgCheck},
			success:function(result){
				if(result=="errorMsg"){
					$("#msgCheck").focus();
					$("#checkMobile").append('<p class="c-fe0101 jdxhIcon jdxhIcon_errorWarn hide1"><i class="sficon sficon-errorwran2"></i>您的短信验证码输入错误，请重新输入</p>');
					$("#checkMobile").removeClass("hide");
					return ;
				}else if(result=="ok"){
					layer.msg("密码修改成功！");
					setTimeout(function() {  
						window.parent.location.reload(true);
						window.close();
		            },  
		            500)  
				}else{
					$("#checkMobile").append('<p class="c-fe0101 jdxhIcon jdxhIcon_errorWarn hide1"><i class="sficon sficon-errorwran2"></i>注册失败，请检查！</p>');
					$("#checkMobile").removeClass("hide");
				}
				
			}
		})
		
		
	}
	
	var wait=60; 
	function time(o) { 
		
			 if (wait == 0) { 
				 o.removeAttribute("disabled");            
	             o.value="获取验证码";  
	             wait = 60;
		        } else {  
		            o.setAttribute("disabled", true);  
		            o.value="重新发送(" + wait + ")";  
		            wait--;  
		            setTimeout(function() {  
		                time(o)  
		            },  
		            1000)  
		        }  
    }  
	document.getElementById("sendMsg").onclick=function(){
		var ff = this;
		$("#checkMobile").empty();
    	var mobile = $("#mobile").val();
    	if(mobile.length==11 && (/^1[3|4|5|7|8][0-9]\d{4,8}$/.test(mobile))){//点击发送短信验证码
    		fsMsg="1";
	    	$.ajax({
	    		type:"post",
	    		url:"${ctx}/main/redirect/sendMsg1",
	    		data:{mobile:mobile},
	    		success:function(result){
	    			if(result=="noExist"){
	    				$("#mobile").focus();
	    				$("#checkMobile").append('<p class="c-fe0101 jdxhIcon jdxhIcon_errorWarn hide1"><i class="sficon sficon-errorwran2"></i>该手机号未注册</p>');
	    				$("#checkMobile").removeClass("hide");
	    			}else if(result=="ok"){
	    				time(ff);
	    			}else{
	    				layer.msg("发送失败，请检查！");
	    				return ;
	    			}
	    		}
	    	})
    	}else{
    		 $("#mobile").focus();
			 $("#checkMobile").append('<p class="c-fe0101 jdxhIcon jdxhIcon_errorWarn hide1"><i class="sficon sficon-errorwran2"></i>请输入正确的手机号</p>');
			 $("#checkMobile").removeClass("hide");
    	}
	}
	
	function retn(){
		window.parent.location.reload(true);
		window.close();
	}

// 底部版权信息位置
function initCopyRight(){
    var pageHeight = $(window).height();

    if( pageHeight <= 768){
        $('body').height('768px');
    }else{
        $('body').height('100%');
    }
}
</script>

</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%String error = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<link rel="shortcut icon" href="${ctxStatic}/favicon.ico">
<title>${fns:getConfig('productName')} 登录</title>
<link href="${ctxStatic}/common/login.css" rel="stylesheet" type="text/css" />
<link href="${ctxStatic}/jquery-jbox/2.3/Skins2/Blue/jbox.css" rel="stylesheet" />
</head>

<body style="overflow: hidden;background-color:#1c77ac; background-image:url('${ctxStatic}/images/light.png'); background-repeat:no-repeat; background-position:center top;">
    <div id="mainBody">
      <div id="cloud1" class="cloud"></div>
      <div id="cloud2" class="cloud"></div>
    </div>  
    
	<div class="logintop">    
	    <span>欢迎登录${fns:getConfig('productName')}</span>    
	    <ul>
	    </ul>    
    </div>
	    
    <div class="loginbody">
	    <span class="systemlogo"></span> 
	    <div class="loginbox">
	    <form id="loginForm" class="login-form" action="${ctx}/login" method="post">
		    <ul>
			    <li><input id="username" name="username" type="text" datatype="*4-16" nullmsg="请输入用户名！" errormsg="用户名至少4个字符,最多18个字符！" class="loginuser" onclick="JavaScript:this.value=''"/></li>
			    <li><input id="password" name="password" type="password" datatype="*4-16" nullmsg="请输入密码！" errormsg="密码范围在4~16位之间！" class="loginpwd" onclick="JavaScript:this.value=''"/></li>
			    <li>
			    	<input type="submit" class="loginbtn" value="登录"/>
			    	<label><input id="rememberMe" name="rememberMe" type="checkbox" value="" checked="checked" />记住密码</label>
			    	<label><!-- <a href="#">忘记密码？</a> --></label>
			    </li>
		    </ul>
		</form>
	    </div>
    </div>
    <div class="loginbm">Copyright &copy; 2012-${fns:getConfig('copyrightYear')}   <a href="http://www.jojowo.net">jojowo.net</a>  ${fns:getConfig('productName')} </div>
	<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/common/cloud.js" type="text/javascript"></script>
	<script src="${ctxStatic}/common/Validform_v5.3.2_min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery-jbox/2.3/i18n/jquery.jBox-zh-CN.min.js" type="text/javascript"></script>
	<script language="javascript">
		$(function(){
			if('<%=error%>'!='null'){
				$.jBox.messager('<font color="red">用户或密码错误, 请重试.</font>','错误提示',{icon: 'error',showType: 'fade'})
			}
		    $.Tipmsg.r=null;
			$(".login-form").Validform({
				tiptype:function(msg){
					$.jBox.messager('<font color="red">'+msg+'</font>','错误提示',{icon: 'error',showType: 'fade'})
				},
				tipSweep:true,
				ajaxPost:false
			});
			
		    $('.loginbox').css({'position':'absolute','left':($(window).width()-692)/2});
		    $('.systemlogo').css({'margin-top':25});
			$(window).resize(function(){
		   		$('.loginbox').css({'position':'absolute','left':($(window).width()-692)/2});
			    $('.systemlogo').css({'margin-top':25 });
	    	});
	    
	    
	 	// 如果在框架中，则跳转刷新上级页面
		if(self.frameElement && self.frameElement.tagName=="IFRAME"){
			parent.location.reload()
		}
	});  
	</script> 

</body>
</html>

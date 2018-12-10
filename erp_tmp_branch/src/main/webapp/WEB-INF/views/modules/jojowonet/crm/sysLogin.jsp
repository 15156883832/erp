<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<title>xx网络科技有限公司</title>
<link href="${ctxStatic}/jojowonet/css/style.css" type="text/css" rel="stylesheet" />
</head>

<body>
<div id="loginCon">
<!--top-->
	<div id="top">
        <div class="topmain">
            <h1><a href="${ctx}/main/redirect"><img src="${ctxStatic}/jojowonet/images/logo.png" /></a></h1>
          <h2>欢迎登录</h2>
      <p class="ltop">
            	<a href="${ctx}/main/redirect">首页</a> <span>|</span>
    <a href="${ctx}/main/redirect/crmRegist">注册新账号</a>
            </p>
        </div>
	</div>
<!--main-->
<form id="loginForm"  class="form login-form" action="${ctx}/login" method="post">
	<div id="loginMain">
    	<div class="loMain">
        	<div class="lobox">
        		<c:if test="${errormessage eq 'error'}">
	        		<div class="tishi">
	                	您输入的密码和账户名不匹配，请重新输入！
	                </div>
                </c:if>
            	<div class="login">
                   <dl>
                        <dt>登录账号：</dt>
                        <dd>
                            <input type="text" class="name" id="username" name="username"/>
                        </dd>
                   </dl>
                   <dl>
                        <dt>密码：</dt>
                        <dd>
                            <input type="password" class="txt" id="password" name="password"/>
                        </dd>
                   </dl>
                </div>
                <div class="shuoming">
                    <input type="checkbox" id="rememberMe" name="rememberMe"/>记住密码
                    <span>没有账号？<a href="${ctx}/main/redirect/crmRegist">立即注册</a></span>
                    <span><a href="${ctx}/main/redirect/toChangePwd">忘记密码？</a></span>
                </div>
                <div class="logBtn">
                    <input type="submit" class="denglu" value="登录" />
                </div>
                <div class="other">
                    您还可以用QQ快速登陆：
                    <a href="#"><img src="${ctxStatic}/jojowonet/images/qq_img.png" /></a>
                </div>	
            </div>
        </div>
    </div>
</form>
<!--foot-->
<div id="lfoot">Copyright © 2010-2015xx网络科技有限公司 皖ICP备13013595号 </div>

</div>



</body>
</html>
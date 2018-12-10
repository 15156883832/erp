<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<link href="${ctxStatic}/jojowonet/css/style.css" type="text/css" rel="stylesheet" />
<title>登录</title>
</head>

<body>
<div id="loginCon">
<div class="head">
    	<h1><a href="${ctx}"><img src="${ctxStatic}/jojowonet/images/logo_login.png" /></a></h1>
        <h2>欢迎登录</h2>
    </div>
	<div class="loginCon">
    	<h3>如有账号，请登录</h3>
        <div class="login">
           <dl>
           		<dt>登录账号：</dt>
                <dd>
                	<input type="text" class="name"/>
                </dd>
           </dl>
           <dl>
           		<dt>密码：</dt>
                <dd>
                	<input type="password" class="txt"/>
                </dd>
           </dl>
        </div>
        <div class="shuoming">
        	<input type="checkbox" />记住密码
            <span>没有账号？<a href="#">立即注册</a></span>
            <span><a href="#">忘记密码？</a></span>
        </div>
        <div class="logBtn">
        	<a href="#">登录</a>
        </div>
        <div class="other">
        	您还可以用以下账号登陆：
            <a href="#"><img src="${ctxStatic}/jojowonet/images/weibo.png" /></a>
            <a href="#"><img src="${ctxStatic}/jojowonet/images/qq_img.png" /></a>
            <a href="#"><img src="${ctxStatic}/jojowonet/images/renren_img.png" /></a>
        </div>
    </div>
    <div class="shallow">
    	<img src="${ctxStatic}/jojowonet/images/shallow.png" />
    </div>
</div>

</body>
</html>

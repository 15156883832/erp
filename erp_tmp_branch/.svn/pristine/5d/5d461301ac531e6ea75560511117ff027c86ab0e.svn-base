<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<title>找回密码</title>
<link href="${ctxStatic}/jojowonet/css/style.css" type="text/css" rel="stylesheet" />
</head>

<body>
<div id="pwhead">
	<div class="pwhead">
		<h1><a href="${ctx}/main/redirect"><img src="${ctxStatic}/jojowonet/images/logo_login.png" /></a></h1>
        <h2>找回密码</h2>
        <p>
        	<a href="${ctx}/main/redirect/crmLogin">登录</a> |
            <a href="${ctx}/main/redirect/crmRegist">注册</a> |
            <a href="${ctx}/main/redirect">返回首页</a>
        </p>
    </div>
</div>
<div id="pwCon">
	<div class="step">
        <dl>
            <dt><img src="${ctxStatic}/jojowonet/images/mimaicon1.png" /></dt>
            <dd><span>邮箱确认</span><i></i>重置登录密码<i></i>找回成功</dd>
        </dl>
    </div>
	<div class="mailPro">
    	<h2>验证邮件已发送至联系邮箱${userVo.email}，请您按照邮件提示进行下一步操作。</h2>
    </div>
    <div class="pwbtn mailbtn">
    	<c:if test="${emailDomain eq 'qq.com' }">
    		<a href="https://mail.qq.com/cgi-bin/loginpage">进入邮箱</a>
    	</c:if>
    	<c:if test="${emailDomain eq '163.com' }">
    		<a href="http://mail.163.com">进入邮箱</a>
    	</c:if>
    	<c:if test="${emailDomain eq 'sina.com' }">
    		<a href="http://mail.sina.com.cn">进入邮箱</a>
    	</c:if> 
<!--     	<a href="${ctx}/main/redirect/changePwd?userid=${userVo.id}&username='admin'">进入邮箱  修改密码页面</a> -->
    </div>
</div>

</body>
</html>

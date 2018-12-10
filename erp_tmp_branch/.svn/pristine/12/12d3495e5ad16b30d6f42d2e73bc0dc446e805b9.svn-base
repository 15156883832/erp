<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<title>找回密码</title>
<link href="${ctxStatic}/jojowonet/css/style.css" type="text/css" rel="stylesheet" />
<script src="${ctxStatic}/jquery/jquery-1.11.1.min.js" type="text/javascript"></script>
<script type="text/javascript">

	function sendEmail(){
		$("#sendEmailForm").submit();
	}
</script>
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
	<div class="mail">
    	<h4>您正在找回密码的账号为：<span>${userVo.loginName}</span>，<a href="${ctx}/main/redirect/toChangePwd">换一个号</a></h4>
        <h2>请选择找回密码的方式：</h2>
        <p>选择登录邮箱：${userVo.email}<span>（申请表将发送至此邮箱）</span></p>
    </div>
    <form:form id="sendEmailForm" modelAttribute="userVo"
			action="${ctx}/main/redirect/toSendEmail" method="post">
			<form:input  path="id"  type="hidden" />
			<form:input  path="email"  type="hidden" />
			<form:input  path="loginName"  type="hidden" />
	</form:form>
    <div class="pwbtn">
    	<a href="javascript:sendEmail();">下一步</a>
    </div>
</div>



</body>
</html>

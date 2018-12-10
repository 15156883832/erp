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
<script src="${ctxStatic}/common/Validform_v5.3.2_min.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function(){
		$("#midfypwdForm").Validform({tiptype:'3'});
	});
	
	function modify(){
		$("#midfypwdForm").submit();
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
            <dt><img src="${ctxStatic}/jojowonet/images/mimaicon2.png" /></dt>
            <dd><span>邮箱确认</span><i></i><span>重置登录密码</span><i></i>找回成功</dd>
        </dl>
    </div>
    <form:form id="midfypwdForm" modelAttribute="userVo"
			action="${ctx}/main/redirect/updatePwdByUserId" method="post">
			 <form:input type="hidden" path="id" />
		<div class="mailReset">
	    	<dl>
	        	<dt>账户名：</dt>
	            <dd><span>${userVo.loginName}</span></dd>
	        </dl>
	        <dl>
	        	<dt>新的登录密码：</dt>
	            <dd>
	            	<form:input id="p" path="password" nullmsg="密码不能为空"  sucmsg="<img src='${ctxStatic}/product/images/accept.png' style='height:18px;width:18px;'/>"  placeholder="请输入密码长度为6-16位" datatype="*6-16" type="password" class="txt"/>
	            </dd>
	        </dl>
	        <dl>
	        	<dt>确认新的登录密码：</dt>
	            <dd>
	            	<form:input path="password1" type="password" ignore="ignore" datatype="*" recheck="password" sucmsg="<img src='${ctxStatic}/product/images/accept.png' style='height:18px;width:18px;'/>"  placeholder="两次密码输入需一致" errormsg="您两次输入的账号密码不一致！" class="txt"/>
	            </dd>
	        </dl>
	    </div>
    </form:form>
    <div class="pwbtn mailbtn">
    	<a href="javascript:modify();">确定</a>
    </div>
</div>

</body>
</html>

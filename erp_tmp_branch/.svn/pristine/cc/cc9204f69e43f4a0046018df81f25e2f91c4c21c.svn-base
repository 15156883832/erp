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
		$("#changePwdForm").Validform({tiptype:'3'});
		$("#validatecode").val("");
	}); 
	
	var validateCodeFlag = false;
	var validateNameFlag = false; 
	
	function checkLoginName(){
		var loginName = $("input[name='loginName']").val();
		if(loginName !=''){
			$.ajax({
				type: "post",
				url : "${ctx}/main/redirect/checkLoginName",
				data: "loginName="+loginName,
				success : function(data) {
					if(data=='false'){
						$("#loginNameTipe").text("");
						validateNameFlag = true; 
						
					}else{
						$("#loginNameTipe").text("此用户名不存在！");
						$("#loginnamed span:eq(1)").text('');
						validateNameFlag = false; 
					}
				},
				error: function() {
					alert("验证失败！！");
				}
			});
		}else{
			validateNameFlag = false; 
		}
	}
	
	function validateCode(){
		var validateCode = $("#validatecode").val();
		if(validateCode !=''){
			$.ajax({
					type: "GET",
					url : "${pageContext.request.contextPath}/servlet/validateCodeServlet",
					data: "validateCode="+validateCode,
					success : function(date) {
						if(date=='false'){
							$("#validateTip").text('验证码错误');
							$('.validateCode').attr('src','/jojowonet/servlet/validateCodeServlet?'+new Date().getTime());
							validateCodeFlag = false;
						}else{
							$("#validateTip").text('');
							$("#validateTip1").show();
							validateCodeFlag = true;
						}
					},
					error: function() {
						
					}					
				});
		  }else{
			  $("#validateTip").text('');
			  validateCodeFlag = false;
		  }
		}
	
	function next(){
		checkLoginName();
		validateCode();
		if(validateNameFlag&&validateCodeFlag){
			$("#changePwdForm").submit();
		}
	}
	
	function codefocud(){
		$("#validateTip1").hide();
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
    <h3>请输入您要找回登录密码的账号名</h3>
    <form:form id="changePwdForm" modelAttribute="userVo"
			action="${ctx}/main/redirect/toNextChangePwd" method="post">
	    <div class="pwWrap">
	        <dl>
	            <dt>您的账号：</dt>
	            <dd id="loginnamed">
	            <form:input  path="loginName" onblur="checkLoginName();" nullmsg="账号不能为空" sucmsg="<img src='${ctxStatic}/product/images/accept.png' style='height:18px;width:18px;'/>"  placeholder="请输入你的注册账号" datatype="*4-20" type="text" class="name"/>
                	<span id="loginNameTipe" style="color: red;"></span>
	            </dd>
	        </dl>
	        <dl>
	            <dt>验证码：</dt>
	            <dd>
		            <input type="text" id="validatecode" placeholder="请输入验证码" onfocus="codefocud();" onblur="validateCode();" maxlength="4" class="name" style="width:292px;"/>
					<tags:validateCode name="validateCode" inputCssStyle="width:292px;"/>
					<span id="validateTip" style="color: red;"></span>
					<span id="validateTip1" style="display: none;"><img src='${ctxStatic}/product/images/accept.png' style='height:18px;width:18px;'/></span>
	            </dd>
	        </dl>
	    </div>
	    <div class="pwbtn">
	    	<a href="javascript:next();">下一步</a>
	    </div>
     </form:form>
</div>

</body>
</html>

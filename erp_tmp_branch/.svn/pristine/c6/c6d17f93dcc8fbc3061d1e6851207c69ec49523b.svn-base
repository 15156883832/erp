<%@ page contentType="text/html;charset=UTF-8" %>
<%-- <%@ include file="/WEB-INF/views/include/taglib.jsp"%> --%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<title>xx网络科技有限公司</title>
<link href="${ctxStatic}/jojowonet/css/style.css" type="text/css" rel="stylesheet" />
<script src="${ctxStatic}/jquery/jquery-1.11.1.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/common/Validform_v5.3.2_min.js" type="text/javascript"></script>

	<script type="text/javascript">
		
		$(function(){
			$("#registForm").Validform({tiptype:'3'});
			loginPageH();
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
		
		function home(){
			$("#home").attr("class" ,"checked" );
			$("#service").attr("class" ,"unchecked" );
			$("#userType").val("jiating");
			$(".box").hide();
		}
		
		function service(){
			$("#home").attr("class" ,"unchecked" );
			$("#service").attr("class" ,"checked" );
			$("#userType").val("fuwushang");
			$(".box").show();
		}
		
		var validateCodeFlag = false;
		var validateNameFlag = false; 
		
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
								validateCodeFlag = true;
							}
						},
						error: function() {
							alert("验证码获取错误");
						}					
					});
			  }else{
				  $("#validateTip").text('');
				  validateCodeFlag = false;
			  }
			}
		
		function checkLoginName(){
			var loginName = $("input[name='loginName']").val();
			if(loginName !=''){
				$.ajax({
					type: "post",
					url : "${ctx}/main/redirect/checkLoginName",
					data: "loginName="+loginName,
					success : function(data) {
						if(data=='false'){
							$("#loginNameTipe").text("此用户名已被注册！");
							$("#loginnamed span:eq(1)").text('');
							validateNameFlag = false; 
						}else{
							$("#loginNameTipe").text("");
							validateNameFlag = true; 
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
		
		function regist(){
			
			validateCode();
			checkLoginName();
			
			if(validateNameFlag&&validateCodeFlag){
				$("#registForm").submit();
			}
			
		}
	</script>
</head>

<body>
<div class="loginCon registbg">
<!--top-->
	<div id="top">
        <div class="topmain">
            <h1><a href="${ctx}/main/redirect"><img src="${ctxStatic}/jojowonet/images/logo.png" /></a></h1>
          <h2>欢迎注册</h2>
      <p class="ltop">
            	<a href="${ctx}/main/redirect">首页</a> <span>|</span>
    <a href="${ctx}/main/redirect/crmLogin">登录</a>
            </p>
        </div>
	</div>
<!--main-->
	<div class="registCon">
	<form:form id="registForm" modelAttribute="userVo"
			action="${ctx}/main/redirect/save" method="post">
        <div class="regist">
        	 <dl>
           		<dt><span>*</span>用户类型：</dt>
                <dd>
                	<input type="hidden" id="userType" name="userType" value="jiating"/>
                	<a id="home" href="javascript:home();" class="checked">家庭用户</a>
                    <a id="service" href="javascript:service();" class="unchecked">售后服务商</a>
                </dd>
            </dl>
           <dl>
           		<dt><span>*</span>登录账号：</dt>
                <dd id="loginnamed">
                	<form:input  path="loginName" onblur="checkLoginName();" nullmsg="账号不能为空" sucmsg="<img src='${ctxStatic}/product/images/accept.png' style='height:18px;width:18px;'/>"  placeholder="请输入登陆账号长度为4-20位" datatype="*4-20" type="text" class="name"/>
                	<span id="loginNameTipe" style="color: red;"></span>
                </dd>
           </dl>
           <dl>
           		<dt><span>*</span>密码：</dt>
                <dd>
                	<form:input id="p" path="password" nullmsg="密码不能为空"  sucmsg="<img src='${ctxStatic}/product/images/accept.png' style='height:18px;width:18px;'/>"  placeholder="请输入密码长度为6-16位" datatype="*6-16" type="password" class="txt"/>
                </dd>
           </dl>
           <dl>
           		<dt><span>*</span>确认密码：</dt>
                <dd>
                	<form:input path="password1" type="password" ignore="ignore" datatype="*" recheck="password" sucmsg="<img src='${ctxStatic}/product/images/accept.png' style='height:18px;width:18px;'/>"  placeholder="两次密码输入需一致" errormsg="您两次输入的账号密码不一致！" class="txt"/>
                </dd>
           </dl>
           <dl>
           		<dt><span>*</span>邮箱：</dt>
                <dd>
                	<form:input  path="email" nullmsg="邮箱不能为空" sucmsg="<img src='${ctxStatic}/product/images/accept.png' style='height:18px;width:18px;'/>"  placeholder="请输入邮箱，用于找回密码" datatype="e" type="text" class="name"/>
                </dd>
           </dl>
        </div>
<!--售后服务商注册信息--> 
        <div class="box" style="display: none;">
            <div class="regist">
               <dl>
                    <dt><span>*</span>企业名称：</dt>
                    <dd>
                        <form:input path="siteName" nullmsg="企业名称不能为空"  sucmsg="<img src='${ctxStatic}/product/images/accept.png' style='height:18px;width:18px;'/>"  placeholder="请输入企业名称长度为4-50字" datatype="*4-50" type="text" class="name"/>
                    </dd>
               </dl>
               <dl>
                    <dt><span>*</span>营业执照号：</dt>
                    <dd>
                        <form:input path="licenseNumber" nullmsg="营业执照号不能为空"  sucmsg="<img src='${ctxStatic}/product/images/accept.png' style='height:18px;width:18px;'/>"  placeholder="请输入营业执照号码长度为13-15位" errormsg="请输入正确的营业执照号" datatype="n13-15" type="text" class="name"/>
                    </dd>
               </dl>
               <dl>
                    <dt><span>*</span>地址：</dt>
                    <dd>
                        <form:input path="address" nullmsg="地址不能为空"  sucmsg="<img src='${ctxStatic}/product/images/accept.png' style='height:18px;width:18px;'/>"  placeholder="请输入详细地址长度为6-50字" datatype="*6-50" type="text" class="name"/>
                    </dd>
               </dl>
               <dl>
                    <dt><span>*</span>法人代表：</dt>
                    <dd>
                        <form:input path="corporate" nullmsg="法人代表不能为空"  sucmsg="<img src='${ctxStatic}/product/images/accept.png' style='height:18px;width:18px;'/>"  placeholder="请输入法人代表长度为2-10字" datatype="*2-10" type="text" class="name"/>
                    </dd>
               </dl>
               <dl class="zhizhao">
                    <dt><span>*</span>营业执照副本：</dt>
                    <dd>
                        <div class="pic"></div>
                        <div class="picBot">
                            <p>请上传已<b>加盖公章</b>的营业执照</p>
                            <span><a href="#">立即上传</a></span>
                        </div>
                    </dd>
               </dl>
            </div>
        </div>
        <div class="regist">
            <dl class="yanzhma">
                <dt><span>*</span>验证码：</dt>
                <dd>
					<input type="text" id="validatecode" placeholder="请输入验证码" onblur="validateCode();" maxlength="4" class="name" style="width:292px;"/>
					<tags:validateCode name="validateCode" inputCssStyle="width:292px;"/>
					<span id="validateTip" style="color: red;"></span>
                </dd>
            </dl>
        </div>
        <div class="checkBox"><input type="checkbox" checked="checked" />我已阅读并同意<a href="#">《xx服务条款》</a></div>
        <div class="logBtn registBtn">
        	<input type="button" onclick="regist();" class="denglu" value="立即注册" />
        </div>
        </form:form>
    </div>
<!--foot-->
<div id="lfoot">Copyright © 2010-2015xx网络科技有限公司 皖ICP备13013595号 </div>

</div>

</body>
</html>

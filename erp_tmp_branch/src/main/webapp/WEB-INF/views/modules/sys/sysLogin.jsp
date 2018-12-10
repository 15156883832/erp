<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%String error = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);%>
<!DOCTYPE html>
<html>
<head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
        <title>财务系统登录</title>
        <link rel="stylesheet" href="${ctxStatic}/fmss1.2/assets/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${ctxStatic}/fmss1.2/assets/font-awesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="${ctxStatic}/fmss1.2/assets/css/form-elements.css">
        <link rel="stylesheet" href="${ctxStatic}/fmss1.2/assets/css/style.css">
        <link rel="shortcut icon" href="${ctxStatic}/fmss1.2/assets/ico/favicon.png">
		<style>
		@font-face {font-family: 'Audiowide';font-style: normal;font-weight: 400;}
		.orangeFont{color:#ff9900;}
		.orangeFont:hover{color:#FF9900;font-family:Audiowide;-webkit-animation: neon5 1.5s ease-in-out infinite alternate;
  		-moz-animation: neon5 1.5s ease-in-out infinite alternate;animation: neon5 1.5s ease-in-out infinite alternate;}
		
		@-webkit-keyframes neon5 {
	  from {
	    text-shadow: 0 0 10px #fff,0 0 20px  #fff,0 0 30px  #fff,0 0 40px  #FF9900,0 0 70px  #FF9900, 0 0 80px  #FF9900,
	               0 0 100px #FF9900,0 0 150px #FF9900;}
	  to {
	    text-shadow: 0 0 5px #fff,0 0 10px #fff, 0 0 15px #fff, 0 0 20px #FF9900, 0 0 35px #FF9900,
	               0 0 40px #FF9900, 0 0 50px #FF9900,  0 0 75px #FF9900;}
	}

	@keyframes neon5 {
  		from {text-shadow: 0 0 10px #fff, 0 0 20px  #fff, 0 0 30px  #fff,0 0 40px  #FF9900, 0 0 70px  #FF9900,
               0 0 80px  #FF9900,0 0 100px #FF9900,0 0 150px #FF9900;}
  		to {text-shadow: 0 0 5px #fff, 0 0 10px #fff, 0 0 15px #fff, 0 0 20px #FF9900,
               0 0 35px #FF9900,0 0 40px #FF9900,0 0 50px #FF9900,0 0 75px #FF9900; }
	}

</style>
</head>

 <body>

        <!-- Top content -->
        <div class="top-content">
        	
            <div class="inner-bg">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-8 col-sm-offset-2 text">
                            <h1><strong><span class="orangeFont">xx财务系统</span></strong></h1>
							
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6 col-sm-offset-3 form-box">
                        	<div class="form-top">
                        		<div class="form-top-left">
                        			<h3>登陆xxFMSS</h3>
                        		</div>
                        		<div class="form-top-right">
                        			<i class="fa fa-lock"></i>
                        		</div>
                            </div>
                            <div class="form-bottom">
			                    <form id="loginForm" class="login-form" action="${ctx}/login" method="post">
			                    	<div class="form-group">
			                    		<label class="sr-only" for="form-username">Username</label>
			                    		<input id="username" name="username" placeholder="登陆用户名" type="text" datatype="*4-16"
			                    			 nullmsg="请输入用户名！" errormsg="用户名至少4个字符,最多18个字符！" class="form-username form-control" onclick="JavaScript:this.value=''"/>
			                        	<!-- <input type="text" name="form-username" placeholder="登陆用户名" class="form-username form-control" id="form-username"> -->
			                        </div>
			                        <div class="form-group">
			                        	<label class="sr-only" for="form-password">Password</label>
			                        	<input id="password" name="password" type="password" placeholder="登陆密码" datatype="*4-16" nullmsg="请输入密码！" errormsg="密码范围在4~16位之间！" class="form-password form-control" onclick="JavaScript:this.value=''"/>
			                        	<!-- <input type="password" name="form-password" placeholder="登陆密码" class="form-password form-control" id="form-password"> -->
			                        </div>
			                        <button type="submit" class="btn">点击登陆</button>
			                    </form>
		                    </div>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>


        <!-- Javascript -->
        <script src="${ctxStatic}/fmss1.2/assets/js/jquery-1.11.1.min.js"></script>
        <script src="${ctxStatic}/fmss1.2/assets/bootstrap/js/bootstrap.min.js"></script>
        <script src="${ctxStatic}/fmss1.2/assets/js/jquery.backstretch.min.js"></script>
        <script src="${ctxStatic}/fmss1.2/assets/js/scripts.js"></script>
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
			/*
	        Fullscreen background
		    */
		    $.backstretch("${ctxStatic}/fmss1.2/assets/img/backgrounds/1.jpg");
		    
		    /*
		        Form validation
		    */
		    $('.login-form input[type="text"], .login-form input[type="password"], .login-form textarea').on('focus', function() {
		    	$(this).removeClass('input-error');
		    });
		    
		    $('.login-form').on('submit', function(e) {
		    	
		    	$(this).find('input[type="text"], input[type="password"], textarea').each(function(){
		    		if( $(this).val() == "" ) {
		    			e.preventDefault();
		    			$(this).addClass('input-error');
		    		}
		    		else {
		    			$(this).removeClass('input-error');
		    		}
		    	});
		    	
		    });
	});  
	</script> 
    </body>
</html>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<link rel="shortcut icon" href="${ctxStatic}/favicon.ico">
<title>${fns:getConfig('productName')}</title>
<link href="${ctxStatic}/common/index.css" rel="stylesheet" type="text/css" />
<link href="${ctxStatic}/jquery-jbox/2.3/Skins2/Blue/jbox.css" rel="stylesheet" />
<style type="text/css">
#left{width: 187px;}
#left,#right,#openClose {float:left;} #openClose {width:8px;margin:0 1px;cursor:pointer;}
#openClose,#openClose.close {background:#fdfdfd url("${ctxStatic}/images/openclose.png") no-repeat -29px center;}
#openClose.close {background-position:1px center;}
.wzsy a:link,.wzsy a:visited{margin-top:20px;padding-right:20px;width:70px; height:24px; line-height:24px; float:right; margin-left:12px; text-align:center; background:url("${ctxStatic}/images/btn_bg.png") no-repeat left top;}
.wzsy a:hover{background:url("${ctxStatic}/images/btn_bg.png") no-repeat left -24px;}
.wzsy a{color: white;}
</style>
<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery/jquery-migrate-1.1.1.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-jbox/2.3/i18n/jquery.jBox-zh-CN.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${root}/dwr/engine.js"></script>
<script type="text/javascript" src="${root}/dwr/util.js"></script>
<script type="text/javascript" src="${root}/dwr/interface/MessagePush.js"></script>
<script type="text/javascript"> 
	function onPageLoad(){
		var userId = '<shiro:principal property="id"/>';
		var userType = '<shiro:principal property="userType"/>';
		var siteId = '${siteId}';
		MessagePush.onPageLoad(userId,userType,siteId);
	}
	function showMessage(title,msg){
		$.jBox.messager(msg,title,{icon: 'tip',showType: 'fade'})
	}
	
	function flushInfo(infocn){
		$("infocn").text(infocn);
	}
	
	function flushJjb(jjb){
		$("jjb").text(jjb);
	}

	$(function(){	
		//$("#openClose").click();
		//顶部导航切换
		$(".nav li a").click(function(){
			$(".nav li a.selected").removeClass("selected")
			$(this).addClass("selected");
			if(!$("#openClose").hasClass("close")){
				$("#openClose").click();
			}
		})	
		
		$("a[name='hf']").each(function(){
			
			$(this).click(function(){
				$.jBox("iframe:"+$(this).attr('href'), {
				    title: "密码修改",
				    width: 700,
				    height: 350,
				    buttons: {}
				});
				return false;
			});
		});
		
		dwr.engine.setActiveReverseAjax(true);
		dwr.engine.setNotifyServerOnPageUnload(true);
		onPageLoad();
	});
	
</script>
</head>
<body style="min-width:1500px;">
	<div id="header" style="width:100%;height:88px;background:url(${ctxStatic}/images/topbg.png) repeat-x;">
		<div class="topleft">
	    	<a href="${ctx}/portal" target="rightFrame"><img src="${ctxStatic}/images/logo.png" title="系统首页" /></a>
	    </div>
	    
	    <ul class="nav">
		    <c:set var="firstMenu" value="true"/>
		    <c:forEach items="${fns:getMenuList()}" var="menu" varStatus="idxStatus">
		    <c:if test="${menu.parent.id eq '1' && menu.isShow eq '1'}">
			<li><a href="${ctx}/sys/menu/tree?parentId=${menu.id}" target="leftFrame"><img src="${ctxStatic}/images/icon0${menu.sort%10+1}.png" title="${menu.name}" /><h2>${menu.name}</h2></a></li>
			<c:if test="${firstMenu}">
				<c:set var="firstMenuId" value="${menu.id}"/>
			</c:if>
			<c:set var="firstMenu" value="false"/>
			</c:if>
			</c:forEach>
	    </ul>
	            
	    <div class="topright">    
		    <ul>
		    	<li><span><font color="#D8E8F3">您好&nbsp;[<shiro:principal property="name"/>]</font></span></li>
		    
			    <%-- <li><span><img src="${ctxStatic}/images/help.png" title="帮助"  class="helpimg"/></span><a href="#">帮助</a></li>
			    <li><a href="#">关于</a></li> --%>
		    	<%-- <shiro:hasPermission name="USER_TYPE:3">
		    	<li><span><font name="jjbFont" style="color: white;">智惠薪</font></span></li>
			    <li onclick="refreshJJB();" style="cursor: pointer;"><span><img src="${ctxStatic}/images/coins.png" title="JOJOWO币"  class="helpimg"/></span><a id="jjb" ><span name="jjwbAccount">${jjwb}</span></a> </li>
			    </shiro:hasPermission>
			    <shiro:hasPermission name="USER_TYPE:2">
			    <li><span><font name="jjbFont" style="color: white;">智惠薪</font></span></li>
			    <li onclick="refreshJJB();" style="cursor: pointer;"><span><img src="${ctxStatic}/images/coins.png" title="JOJOWO币"  class="helpimg"/></span><a id="jjb" ><span name="jjwbAccount">${jjwb}</span></a> </li>
			    </shiro:hasPermission> --%>
			    
			    <li><a name="hf" href="${ctx}/sys/user/modifyPwd">修改密码</a></li>
			    <li><a href="${ctx}/logout" target="_parent">退出</a></li>
		    </ul>
		   <%--  <div class="user">
			    <i><a href="${ctx}/crm/myinfo/list" style="color:#E9F2F7;font-size:13px;" target="rightFrame">消息  &nbsp;&nbsp;<c:if test="${noread ne null}"><b id="infocn">${noread}</b></c:if></a></i>
		    </div>  --%> 
		    <div class="wzsy">
	        	<a href="#">后台首页</a>
	            <a href="#">网站首页</a>
	        </div>  
	    </div>
	    
	</div>
	
	<div id="main">
		<div id="left">
			<iframe src="${ctx}/sys/menu/tree?parentId=${firstMenuId}" name="leftFrame" id="leftFrame" style="overflow:visible;" scrolling="no" frameborder="no" width="100%"></iframe>
		</div>
		<div id="openClose" class="close" onmouseover="this.style.cursor='pointer';">&nbsp;</div>
		<div id="right">
			<iframe src="${ctx}/portal" name="rightFrame" id="rightFrame" title="rightFrame" frameborder="no" marginheight="0" marginwidth="0" frameborder="0" scrolling="auto" width="100%"></iframe>
		</div>
	</div>
	<script type="text/javascript">
		var leftWidth = "187"; // 左侧窗口大小
		function wSize(){
			var w = $(document.body).width();//可见区域宽度
			var h = $(window).height();//可见区域高度
			
			leftFrame =$('#leftFrame');
			rightFrame =$('#rightFrame');
			
			topH = $("#header").height()+3;
			leftW = $("#left").width();
			
			$('#leftFrame').css('height',(h-topH)+'px');
			$('#rightFrame').css('height',(h-topH)+'px');
			$('#rightFrame').css('width',(w-$("#left").width()-$("#openClose").width()-5)+'px');
			$("#openClose").css('height',(h-topH-5)+'px');
			$("#right").width($("#main").width()-$("#left").width()-$("#openClose").width()-5);
		}
	</script>
	
	<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>
</body>
</html>

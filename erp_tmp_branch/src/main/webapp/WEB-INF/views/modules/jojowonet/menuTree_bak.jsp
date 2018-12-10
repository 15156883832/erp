<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<title></title>
<link href="${ctxStatic}/common/index.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="${ctxStatic}/jquery/jquery-1.9.1.min.js"></script>
<style type="text/css">
	.menuli{
		background-color: #8FD6D6;
	}
	.lefttop{
		background-image: url("${ctxStatic}/images/lefttop_1.png");
		width: 184px;
		height: 54;
	}
	.selDiv{
		background-image: url("${ctxStatic}/images/left_sel_panel.png");
	}
	.unselDiv{
		background-image: url("${ctxStatic}/images/left_unsel_panel.png");
	}
	.leftselsub{
		background-image: url("${ctxStatic}/images/left_sel_subpanel.png");
	}
	
</style>
<script type="text/javascript">
$(function(){	
	/* $("li[name='leftMenu']").each(function(){
		
	}); */
	$("div[class='title']").addClass("unselDiv");
	//导航切换
	$(".menuson li").click(function(){
		$(".menuson li.active").removeClass("active");
		$(".menuson li").removeClass("leftselsub");
		$(this).addClass("active");
		$(this).addClass("leftselsub");
	});
	
	$('.title').click(function(){
		var $ul = $(this).next('ul');
		$('dd').find('ul').slideUp();
		$("div[name='showDropDiv']").removeClass("shw");
		$("div[name='showDropDiv']").addClass("unshw");
		$(".title").each(function (){
			$(this).removeClass("selDiv");
			$(this).addClass("unselDiv");
		});
		
		$(this).removeClass("unselDiv");
		$(this).addClass("selDiv");
		if($ul.is(':visible')){
			$(this).next('ul').slideUp();
			$(this).find("div[name='showDropDiv']").addClass("shw");
		}else{
			$(this).next('ul').slideDown();
			$(this).find("div[name='showDropDiv']").addClass("shw");
		}
		
	});
	/* $('.lk').click(function(){
		parent.$("#openClose").click();
	}); */
	
})	

	function ov(id){
		//$("#"+id).addClass("menuli");
	}
	
	function ot(id){
		//$("#"+id).removeClass("menuli");
	}
</script>
</head>
<body>
	<div class="lefttop" style="margin-bottom: 1px;height: 54px;font-size: 17px;line-height: 47px;text-align: center;color: #767676;font-weight: 600;"><span></span>功&nbsp;能&nbsp;菜&nbsp;单&nbsp;</div>
    <dl class="leftmenu">
	    <c:set var="menuList" value="${fns:getMenuList()}"/><c:set var="firstMenu" value="true"/>
	    <c:set var="idx" value="1"/>
	    <c:forEach items="${menuList}" var="menu" varStatus="idxStatus"><c:if test="${menu.parent.id eq (not empty param.parentId?param.parentId:'1')&&menu.isShow eq '1'}">
	    <dd style="margin-bottom: 1px;">
		    <div class="title" style="height: 47px;">
		    	<span><img src="${ctxStatic}/images/leftico01.png" /></span>&nbsp;${menu.name}
				<c:if test="${idx == '1'}">
					<div name="showDropDiv" class="shw"></div>
				</c:if>
				<c:if test="${idx != '1'}">
					<div name="showDropDiv" class="unshw"></div>
				</c:if>
				<c:set var="idx" value="${idx+1}"/>
		    </div>
	    	<ul class="menuson">
			    <c:forEach items="${menuList}" var="menuChild">
				    <c:if test="${menuChild.parent.id eq menu.id&&menuChild.isShow eq '1'}">
				    	<li id="li_${menuChild.id}" style="height: 40px;" onmouseover="ov(this.id)" onmouseout="ot(this.id)"><cite></cite><a class="lk" href="${fn:indexOf(menuChild.href, '://') eq -1?ctx:''}${not empty menuChild.href?menuChild.href:'/404'}" target="rightFrame" >&nbsp;${menuChild.name}</a></li>
						<c:set var="firstMenu" value="false"/>
					</c:if>
				</c:forEach>
	        </ul>    
	        
	    </dd>
        </c:if>
        </c:forEach>
	      
    </dl>
    
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="decorator" content="base" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/bootstrap.pagination.css"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/easyui.css"/>

<!--[if IE 6]>
<script type="text/javascript" src="lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<title> </title>
</head>
<body>
<!-- 历史订单 -->
<div class="shadeBg" style="z-index:9999;"></div>
<div class=" dialogPage">
	
	<a class="btnClose sficon" onclick="closeAllDiv()"></a>
	<h3 class="text-c lh-22 f-16"><strong class="title">${rd.columns.title }</strong></h3>
            <p class="c-888 text-c lh-24 createTime"><fmt:formatDate value="${rd.columns.create_time }" pattern="yyyy-MM-dd HH-mm-ss"/></p>
	<div class="imgsCont ">
		<div class="imgsWrap">
			
			${rd.columns.content }
		</div>
	</div>
</div>
	
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript">
	
	$(function(){
		if('${mark}'!=2){
			parent.closeLoadBg();
		}
		$('#Hui-article-box',window.top.document).css({'z-index':'1999'});
		//maxHeight(); 
	})

	
	$('.btnClose').on('click', closeBox);
	
	function closeBox(){
		$('.shadeBg').hide();
		$('.dialogPage').hide();
		$('#Hui-article-box',window.top.document).css({'z-index':'9'});
	}
	
	window.onresize = function(){
		maxHeight();
	}
	
	function maxHeight(){
		var pageHeight = $(window).height();
		$('.dialogPage .imgsCont').css({'max-height':pageHeight - 100 + 'px'});
		$.setPos($('.dialogPage'));
	}
	
	/* $（document）.ready{function(){
		//编写代码
		
	}}  */
	
  	window.onload = function(){  
		maxHeight();
    }  
	
	function closeAllDiv(){
		if('${mark}'=='2'){
			parent.search();
		}
		$('#Hui-article-box',window.top.document).css({'z-index':'9'});
		$('#loadBg',window.parent.document).remove();
		parent.layer.closeAll();
		
	}

</script> 
</body>
</html>
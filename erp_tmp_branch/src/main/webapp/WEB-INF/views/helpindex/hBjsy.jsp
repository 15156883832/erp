﻿<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="Bookmark" href="${ctxPlugin}/favicon.ico" >
<link rel="Shortcut Icon" href="${ctxPlugin}/favicon.ico" />
<!--[if lt IE 9]>
<script type="text/javascript" src="${ctxPlugin}/lib/html5shiv.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui/css/H-ui.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/helpStyle.css" />
<!--[if IE 6]>
<script type="text/javascript" src="${ctxPlugin}/lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<title>思方ERP帮助中心——备件使用</title>
<meta name="keywords" content="思方海尔,Haier,思方">
<meta name="description" content="思方海尔">
<style type="text/css">
	body{
		background:#fff;
	}
</style>
</head>
<body >
	
	<h1 class="jpageTitle">备件使用</h1>
	<div class="partContainer">
		<div class="partNote mb-15">服务工程师领取备件后可以在APP端对备件进行相关使用，使用类型分为三种：返还、零售、工单使用。</div>
	</div>
	
	<h2 class="partTitle">备件的返还</h2>
	<div class="partContainer mb-20">
		<div class="partNote mb-5">工程师至少有一个备件的库存，主要针对工程师领取的备件没有使用完，需要返还到网点，常备备件可不计算在内。</div>
		<div class="cl">
			<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/27备件_返还01.png" class="f-l mr-10" />
			<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/27备件_返还02.png" class="f-l mr-10" />
			<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/27备件_返还03.png" class="f-l mr-10" />
			<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/27备件_返还04.png" class="f-l" />
		</div>
	</div>
	
	<h2 class="partTitle">备件的使用</h2>
	<div class="partContainer mb-20">
		<div class="partNote mb-5">在备件模块直接使用于工单</div>
		<div class="cl mb-20">
			<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/28备件_工单使用01.png" class="f-l mr-10" />
			<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/28备件_工单使用02.png" class="f-l mr-10" />
			<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/28备件_工单使用03.png" class="f-l mr-10" />
			<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/28备件_工单使用04.png" class="f-l" />
		</div>
		<div class="partNote mb-5">在工单模块下反馈封单时也可以直接添加使用备件</div>
		<div class="cl mb-20">
			<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/29备件_工单使用01.png" class="f-l mr-10" />
			<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/29备件_工单使用02.png" class="f-l mr-10" />
			<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/29备件_工单使用03.png" class="f-l mr-10" />
		</div>
		<p class="c-fe0101 f-16 mt-15">提示</p>
		<div class="partNote">
			服务工程师返还的备件需要在电脑端【备件库存管理】下的【待返还】下做入库操作<br>
			在备件模块下的工单使用只显示当前工程师的工单且工单状态为服务中、待回访、待结算<br>
			工单详情内使用备件在该备件未核销前，工单使用的备件信息可撤销使用<br> 
			工单详情内使用的备件在工单未结算前，可以进行撤销使用，也可进行添加备件的操作
		</div>
		
	</div>
	<h2 class="partTitle">备件的零售</h2>
	<div class="partContainer mb-20">
		<div class="partNote mb-5">在备件模块可以零售给用户</div>
		<div class="cl mb-20">
			<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/28备件_零售01.png" class="f-l mr-10" />
			<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/28备件_零售02.png" class="f-l mr-10" />
			<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/28备件_零售03.png" class="f-l mr-10" />
			<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/28备件_零售04.png" class="f-l" />
		</div>
		<div class="partNote mb-5">在工单模块直接零售</div>
		<div class="cl mb-20">
			<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/28备件_零售05.png" class="f-l mr-10" />
			<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/28备件_零售06.png" class="f-l mr-10" />
			<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/28备件_零售07.png" class="f-l mr-10" />
		</div>
		
		
	</div>


<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="${ctxPlugin}/lib/jquery/1.9.1/jquery.min.js"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/sifang.js" type="text/javascript" charset="utf-8"></script>
<!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript">
$(function(){

	$.setIframe();
});


</script> 

</body>
</html>
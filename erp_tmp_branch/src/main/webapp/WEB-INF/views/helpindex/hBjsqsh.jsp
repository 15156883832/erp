<%@ page contentType="text/html;charset=UTF-8"%>
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
<title>思方ERP帮助中心——备件的入库</title>
<meta name="keywords" content="思方海尔,Haier,思方">
<meta name="description" content="思方海尔">
<style type="text/css">
	body{
		background:#fff;
	}
</style>
</head>
<body >
	
	<h1 class="jpageTitle">备件申请提交和审核</h1>
	<div class="partContainer">
		<div class="partNote mb-15">点击【备件管理】-->【备件申请管理】-->【待审核、待出库、全部申请】查看备件申请记录及审核情况。</div>
		<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/23备件_申请管理.png" class="img" />
		
	</div>
	<div class="pl-20 pr-20 pb-20 f-14">备件的申请方式分为三种：APP端直接申请、APP端关联工单申请、电脑端的工程师申请。</div>
	<h2 class="partTitle">APP端直接申请</h2>
	<div class="partContainer mb-20">
		<div class="partNote mb-15">在服务工程师APP端的备件模块下申请备件</div>
		<div class="cl">
			<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/24备件_直接申请.png" class="f-l mr-10" />
			<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/24备件_直接申请02.png" class="f-l mr-10" />
			<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/24备件_直接申请03.png" class="f-l mr-10" />
			<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/24备件_直接申请04.png" class="f-l" />
		</div>
	</div>
	<h2 class="partTitle">APP端关联工单申请</h2>
	<div class="partContainer mb-20">
		<div class="partNote mb-15">在服务工程师APP端关联工单申请</div>
		<div class="cl pos-r">
			<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/25备件_关联工单申请05.png" class="f-l mr-10" />
			<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/24备件_直接申请02.png" class="f-l mr-10" />
			<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/24备件_直接申请03.png" class="f-l mr-10" />
			<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/24备件_直接申请04.png" class="f-l" />
		</div>
	</div>

	<h2 class="partTitle">电脑端的工程师申请</h2>
	<div class="partContainer mb-20">
		<div class="partNote mb-15">电脑端的“工程师申请”，直接登记到服务工程师的库存无需审核、出库流程</div>
		<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/26备件_工程师申请.png" class="img" />
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
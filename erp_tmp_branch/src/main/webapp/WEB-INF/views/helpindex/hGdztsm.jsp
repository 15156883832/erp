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
<!--<link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/H-ui.admin.css" />-->
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/Hui-iconfont/1.0.8/iconfont.css" />
<!--<link rel="stylesheet" type="text/css" href="static/h-ui.admin/skin/default/skin.css" id="skin" />-->
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/helpStyle.css" />
<!--[if IE 6]>
<script type="text/javascript" src="${ctxPlugin}/lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<title>思方ERP帮助中心——工单状态说明</title>
<meta name="keywords" content="思方海尔,Haier,思方">
<meta name="description" content="思方海尔">
<style type="text/css">
	body{
		background:#fff;
	}
</style>
</head>
<body>
	<h1 class="jpageTitle">工单状态说明</h1>
	
	<h2 class="partTitle">全部工单</h2>
	<div class="partContainer mb-20">
		<div class="partNote mb-15">点击【工单管理】-【全部工单】，打开服务商全部工单列表页面；</div>
		<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/01工单管理_工单状态_全部工单.png" class="img" />
		<div class="partNote">
			【待接收】指通过思方工单同步助手同步的厂家待接收工单；<br>
			【待派工】指待派工至服务工程师服务的工单；<br>
			【服务中】指已派工至服务工程师、未服务完工的工单；<br> 
			【待回访】指服务已完工、待信息员回访的工单；<br> 
			【待结算】指回访完成、待结算员结算的工单；<br> 
			【已完成】指工单已结算或直接封单的工单；<br> 
			【无效单】指标记无效的工单。
		</div>
	</div>
	
	<h2 class="partTitle">待派工工单</h2>
	<div class="partContainer mb-20">
		<div class="partNote mb-15">点击【工单管理】-【待派工工单】，打开待派工的工单列表页面；</div>
		<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/02工单管理_工单状态_待派工工单.png" class="img" />
		<div class="partNote">
			待派工工单中区分出“暂不派工”、“拒接工单”和“今日预约”等特殊状态的工单。<br>
			【暂不派工】标记暂不派工的工单；<br> 
			【拒接工单】服务工程师拒接的工单；<br>
			【今日预约】工单的预约时间为今日的工单。
		</div>
	</div>
	
	<h2 class="partTitle">服务中工单</h2>
	<div class="partContainer mb-20">
		<div class="partNote mb-15">点击【工单管理】-【服务中工单】，打开服务中的工单列表页面；</div>
		<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/03工单管理_工单状态_服务中工单.png" class="img" />
		<div class="partNote">
			服务中工单区分出“待接工单”、“预警工单”和“待件工单”等特殊状态的工单。<br>
			【待接工单】服务工程师待接收的工单；<br> 
			【预警工单】从工单报修时间开始超20小时服务未完工的工单；<br>
			【待件工单】正在发起备件申请且申请未审核的工单。
		</div>
	</div>
	
	<h2 class="partTitle">回访结算工单</h2>
	<div class="partContainer">
		<div class="partNote mb-15">点击【工单管理】-【回访结算工单】，打开待回访、结算的工单列表页面；</div>
		<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/04工单管理_工单状态_回访结算工单.png" class="img" />
		<div class="partNote">
			服务中工单区分出“待回访”和“待结算”的工单。<br>
			【待回访】服务已完工、待回访的工单；<br> 
			【待结算】已回访、待结算的工单。
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
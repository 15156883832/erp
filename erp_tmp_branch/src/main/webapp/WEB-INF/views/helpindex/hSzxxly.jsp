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
<title>思方ERP帮助中心——设置信息来源</title>
<meta name="keywords" content="思方海尔,Haier,思方">
<meta name="description" content="思方海尔">
<style type="text/css">
	body{
		background:#fff;
	}
</style>
</head>
<body >
	
	<h1 class="jpageTitle">设置信息来源</h1>
	
	<div class="partContainer">
		<div class="partNote textIndent">
			每家服务商都有固定的自接工单信息来源，需要在工单信息中记录；所以要提前添加信息来源。
		</div>
		<div class="partNote mb-15">1、点击【系统设置】-【设置面板】-【工单基础信息设置】-【信息来源】，进入信息来源设置页面；</div>
		<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/50系统设置_添加员工10.png" class="img" />
		<div class="partNote mb-15">2、点击【添加】，打开信息来源新建页面；</div>
		<!--<img src="static/h-ui.admin/images/help/sz_fwpl2.png" class="img" />-->
		<div class="partNote mb-15">
			3、点击<i class="sficon sficon-add2 mr-5 ml-5"></i>添加一行品类输入框、点击<i class="sficon sficon-reduce2 ml-5 mr-5"></i>删除品类输入框；
			输入品类名称、排序后点击【保存】，信息来源添加成功。	
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
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
<!--<link rel="stylesheet" type="text/css" href="lib/Hui-iconfont/1.0.8/iconfont.css" />-->
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/helpStyle.css" />
<!--[if IE 6]>
<script type="text/javascript" src="${ctxPlugin}/lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<title>思方ERP帮助中心——厂家工单信息同步</title>
<meta name="keywords" content="思方海尔,Haier,思方">
<meta name="description" content="思方海尔">
<style type="text/css">
	body{
		background:#fff;
	}
</style>
</head>
<body >
	
	<h1 class="jpageTitle">厂家工单信息同步</h1>
	
	<div class="partContainer">
		<div class="partNote">用于设置工单发送的短信中显示的联系电话和签名。</div>
		<div class="partNote mb-15">1、点击【系统设置】-【设置面板】-【工单信息】-【厂家资料设置】，进入厂家资料维护页面；</div>
		<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/50系统设置_添加员工11.png" class="img" />
		<div class="partNote mb-15">2、点击【添加】，打开厂家资料弹窗页面：</div>
		<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/50系统设置_添加员工12.png" class="img" />
		<div class="partNote mb-15">
			3、选择厂家名称、填写厂家系统的账号和密码
			点击【确定】，厂家资料添加成功。
		</div>
		<p class="c-fe0101 f-16 mt-15">提示</p>
		<div class="partNote">
			厂家系统的登录密码定期更换后，要及时修改厂家资料中的密码。
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
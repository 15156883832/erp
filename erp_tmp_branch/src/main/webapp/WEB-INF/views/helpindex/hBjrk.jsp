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
	<div id="subpage">
	<h1 class="jpageTitle">备件的入库</h1>

	<h2 class="partTitle">备件的新增入库</h2>
	<div class="partContainer">
		<div class="partNote mb-15">点击【备件管理】-->【备件库存管理】-->【新增】打开备件新增页面，编辑备件相关信息，点击“保存”后即可新增成功。</div>
		<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/20备件_新增入库.png" class="img" />
	</div>
	<h2 class="partTitle">备件的手动入库</h2>
	<div class="partContainer">
		<div class="partNote mb-15">
			点击【备件管理】-->【备件库存管理】-->【手动入库】打开手动入库的页面；<br>
			当库存量不足需要补库时，可选择手动入库，必须选中至少一个备件才可手动入库，可根据实际需要勾选备件进行手动入库。
		</div>
		<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/21备件_手动入库.png" class="img" />
	</div>
	<h2 class="partTitle">备件的批量导入</h2>
	<div class="partContainer">
		<div class="partNote mb-15">
			点击【备件管理】-->【备件库存管理】-->【批量导入】打开批量导入的页面；<br>
			点击“下载模板”下载思方的备件模板，按模板提供的表头选项在模板内编辑好网点的备件信息，编辑完成后点击“选择”按钮，选择模板后，校验、导入即可。
		</div>
		<img src="${ctxPlugin}/static/h-ui.admin/images/help_v2/22备件_批量入库.png" class="img" />
		<p class="c-fe0101 f-16 mt-15">提示</p>
		<div class="partNote">
			模板内的必填项不可为空<br>
			备件编号在系统内是具有唯一性的，所以备件编号不可重复（模板内）<br>
			部分的备件信息是有固定的输入内容，不可输入固定内容之外的信息<br> 
			模板内的备件编号若已存在系统内，则视为是无效的数据，不对系统原有的备件做任何操作
		</div>
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
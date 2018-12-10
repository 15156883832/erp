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
<script type="text/javascript" src="lib/html5shiv.js"></script>
<script type="text/javascript" src="lib/respond.min.js"></script>
<![endif]-->
<meta name="decorator" content="base" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui/css/H-ui.css" />
<!--<link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/H-ui.admin.css" />-->
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/Hui-iconfont/1.0.8/iconfont.css" />
<!--<link rel="stylesheet" type="text/css" href="static/h-ui.admin/skin/default/skin.css" id="skin" />-->
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/helpStyle.css" />
<!--[if IE 6]>
<script type="text/javascript" src="lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<title>思方ERP帮助中心</title>
<meta name="keywords" content="思方海尔,Haier,思方">
<meta name="description" content="思方海尔">
<style type="text/css">
	body{
		background:#eeeeee;
	}
</style>
</head>
<body>
<header class="headerWrap">
	<div class="jMain cl">
		<a href="javascript:;" class="jLogo"></a>
		<span class="pageTitle">帮助中心</span>
		<div class="f-r helpNavbar">
			<a href="${ctx}/helpindex/indexHelp?a=gdztsm"" class="helpbar current">
				操作指引<i class="jicon_update"></i>
			</a>
			<a href="${ctx}/docdownload/download" class="helpbar ">
				文档与视频<i class="jicon_update"></i>
			</a>
		</div>
	</div>
</header>

<div class="jpageWrap mb-20  joptguide">
	<div class="jpageWrapBg">
		<div class="jMain bk-gray cl">
			<aside class="jAside f-l" id="jAside">
				<div class="menu_dropdown ">
					<dl class="" id="orderMa">
						<dt> 
							<a href="javascript:;" class="moduleTitle currentModule">
								工单管理 
								<i class="Hui-iconfont Hui-iconfont-arrow2-bottom f-r c-666"></i>
							</a>
						</dt>
						<dd>
							<ul class="moduleList">
								<li class="">
									<a href="javascript:void(0);" class="moduleItemTitle  currentModuleItem" data-href="hGdztsm.html" id="gdztsm">
										<i class="Hui-iconfont Hui-iconfont-arrow2-right c-666"></i>工单状态说明
									</a>
								</li>
								<li>
									<a href="javascript:void(0);" class="moduleItemTitle"  id="xjgd" data-href="${ctx}/helpindex/help/hGdxj">
										<i class="Hui-iconfont Hui-iconfont-arrow2-right c-666"></i>新建工单
									</a>
								</li>
								<li>
									<a href="javascript:void(0);" class="moduleItemTitle"  id="gddr" data-href="${ctx}/helpindex/help/hGddr">
										<i class="Hui-iconfont Hui-iconfont-arrow2-right c-666"></i>工单导入
									</a>
								</li>
								<li>
									<a href="javascript:void(0);" class="moduleItemTitle"  id="gdpg" data-href="${ctx}/helpindex/help/hGdpg">
										<i class="Hui-iconfont Hui-iconfont-arrow2-right c-666"></i>工单派工
									</a>
								</li>
								<li>
									<a href="javascript:void(0);" class="moduleItemTitle"  id="gdfk" data-href="${ctx}/helpindex/help/hGdpdfk">
										<i class="Hui-iconfont Hui-iconfont-arrow2-right c-666"></i>APP工单处理
									</a>
								</li>
								<li>
									<a href="javascript:void(0);" class="moduleItemTitle"  id="gdhf" data-href="${ctx}/helpindex/help/hGdhf">
										<i class="Hui-iconfont Hui-iconfont-arrow2-right c-666"></i>工单回访
									</a>
								</li>
								<li>
									<a href="javascript:void(0);" class="moduleItemTitle"  id="gddy" data-href="${ctx}/helpindex/help/hGddy">
										<i class="Hui-iconfont Hui-iconfont-arrow2-right c-666"></i>工单打印
									</a>
								</li>
								
							</ul>
						</dd>
					</dl>
					<dl class="" id="bjMa">
						<dt class=""> 
							<a href="javascript:void(0);" class="moduleTitle ">
								备件管理<i class="Hui-iconfont Hui-iconfont-arrow2-bottom f-r c-666"></i>
							</a>
						</dt>
						<dd>
							<ul class="moduleList">
								<li class="">
									<a href="javascript:void(0);" class="moduleItemTitle"  id="bjrk" data-href="${ctx}/helpindex/help/hBjrk">
										<i class="Hui-iconfont Hui-iconfont-arrow2-right c-666"></i>备件入库
									</a>
								</li>    
								<li>
									<a href="javascript:void(0);" class="moduleItemTitle"  id="bjsqsh" data-href="${ctx}/helpindex/help/hBjsqsh">
										<i class="Hui-iconfont Hui-iconfont-arrow2-right c-666"></i>备件申请提交和审核
									</a>
								</li>
								<li>
									<a href="javascript:void(0);" class="moduleItemTitle"  id="bjsy" data-href="${ctx}/helpindex/help/hBjsy">
										<i class="Hui-iconfont Hui-iconfont-arrow2-right c-666"></i>备件使用
									</a>
								</li>
								<li>
									<a href="javascript:void(0);" class="moduleItemTitle"  id="bjhx" data-href="${ctx}/helpindex/help/hBjhx">
										<i class="Hui-iconfont Hui-iconfont-arrow2-right c-666"></i>备件核销
									</a>
								</li>
								<li>
									<a href="javascript:void(0);" class="moduleItemTitle"  id="bjdj" data-href="${ctx}/helpindex/help/hBjdj">
										<i class="Hui-iconfont Hui-iconfont-arrow2-right c-666"></i>旧件登记
									</a>
								</li>
							</ul>
						</dd>
					</dl>
					<dl class="" id="commodityMa">
						<dt> 
							<a href="javascript:void(0);" class="moduleTitle ">
								商品管理<i class="Hui-iconfont Hui-iconfont-arrow2-bottom f-r c-666"></i>
							</a>
						</dt>
						<dd>
							<ul class="moduleList">
								<!--<li class="">
									<a href="#" class="moduleItemTitle " data-href="hSplbsz.html" id="sp_szlb">
										<i class="Hui-iconfont Hui-iconfont-arrow2-right c-666"></i>设置商品类别
									</a>
								</li>    -->
								<li>    
									<a href="javascript:void(0);" class="moduleItemTitle"  id="sp_tjsp" data-href="${ctx}/helpindex/help/hSptj">
										<i class="Hui-iconfont Hui-iconfont-arrow2-right c-666"></i>添加商品
									</a>
								</li>
								<li>
									<a href="javascript:void(0);" class="moduleItemTitle"  id="sp_spxs" data-href="${ctx}/helpindex/help/hSpxs">
										<i class="Hui-iconfont Hui-iconfont-arrow2-right c-666"></i>商品销售
									</a>
								</li>
								<!--<li>
									<a href="#" class="moduleItemTitle" data-href="hSpddgl.html" id="sp_ddgl">
										<i class="Hui-iconfont Hui-iconfont-arrow2-right c-666"></i>订单管理
									</a>
								</li>-->
							</ul>
						</dd>
					</dl>
					<dl class="" id="operativeMa">
						<dt> 
							<a href="#" class="moduleTitle ">
								运营管理<i class="Hui-iconfont Hui-iconfont-arrow2-bottom f-r c-666"></i>
							</a>
						</dt>
						<dd>
							<ul class="moduleList">
								<li class="">
									<a href="javascript:void(0);" class="moduleItemTitle "  id="yy_tjyg" data-href="${ctx}/helpindex/help/hYytjyg">
										<i class="Hui-iconfont Hui-iconfont-arrow2-right c-666"></i>添加员工
									</a>
								</li>    
								<li>    
									<a href="javascript:void(0);" class="moduleItemTitle"  id="yy_fpqx" data-href="${ctx}/helpindex/help/hYyfpqx">
										<i class="Hui-iconfont Hui-iconfont-arrow2-right c-666"></i>分配权限
									</a>
								</li>
							</ul>
						</dd>
					</dl>
					<dl class="" id="systemMa">
						<dt> 
							<a href="javascript:void(0);" class="moduleTitle ">
								系统设置<i class="Hui-iconfont Hui-iconfont-arrow2-bottom f-r c-666"></i>
							</a>
						</dt>
						<dd>
							<ul class="moduleList">
								<li class="">
									<a href="javascript:void(0);" class="moduleItemTitle " id="sz_fwpl" data-href="${ctx}/helpindex/help/hSzfwpl?sz_fwpl">
										<i class="Hui-iconfont Hui-iconfont-arrow2-right c-666"></i>设置服务品类
									</a>
								</li>    
								<li>    
									<a href="javascript:void(0);" class="moduleItemTitle"   id="sz_fwpp" data-href="${ctx}/helpindex/help/hSzfwpp">
										<i class="Hui-iconfont Hui-iconfont-arrow2-right c-666"></i>设置服务品牌
									</a>
								</li>
								<li>    
									<a href="javascript:void(0);" class="moduleItemTitle"  id="sz_xxly" data-href="${ctx}/helpindex/help/hSzxxly">
										<i class="Hui-iconfont Hui-iconfont-arrow2-right c-666"></i>设置信息来源
									</a>
								</li>
								<li>    
									<a href="javascript:void(0);" class="moduleItemTitle"  id="sz_cjgdxxtb" data-href="${ctx}/helpindex/help/hSzxxtb">
										<i class="Hui-iconfont Hui-iconfont-arrow2-right c-666"></i>厂家资料维护
									</a>
								</li>
								<li>    
									<a href="javascript:void(0);" class="moduleItemTitle"  id="sz_dxsz" data-href="${ctx}/helpindex/help/hSzdx">
										<i class="Hui-iconfont Hui-iconfont-arrow2-right c-666"></i>短信设置
									</a>
								</li>
							</ul>
						</dd>
					</dl>
				</div>
			</aside>
			<section class="jSection f-r">
				<div class="iframeWrap" id="iframeWrap">
					<iframe id="jIframe" scrolling="yes" frameborder="0" src="${ctx}/helpindex/hGdztsm" allowtransparency="yes"></iframe>
				</div>
			</section>
		</div>
	</div>
</div>
<footer class="jFooterWrap">
	Copyright ©2014-2017 安徽思方网络科技有限公司 皖ICP备17000071号
</footer>

<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="${ctxPlugin}/lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="${ctxPlugin}/lib/layer/2.4/layer.js"></script>
<!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript">
$(function(){
//	var getInfo = window.location.search.slice(window.location.search.lastIndexOf("?")+1);
	
	switchPage('${para}');

});

$('#jAside ul a').on('click', function(){
	var id = $(this).closest('dl').attr('id'),
		href = $(this).attr('data-href'),
		id = $(this).attr('id');
	switchPage(id);
});

function switchPage(id){
	
	//  id主要是为了快速定位
	var asideWrap = $('#jAside'),
		iFrame = $('#jIframe');
	
	var target = $('#'+id);
	var href = $(target).attr('data-href');
	asideWrap.find('dt a').removeClass('currentModule');
	asideWrap.find('ul a').removeClass('currentModuleItem');
	
	$(target).closest('dl').find('dt a').addClass('currentModule');
	$(target).addClass('currentModuleItem');
	iFrame.attr({'src':href});
	
}

</script> 

</body>
</html>
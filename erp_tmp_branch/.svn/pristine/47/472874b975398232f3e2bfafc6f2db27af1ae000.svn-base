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
	
</style>
</head>
<body>
<header class="headerWrap">
	<div class="jMain cl">
		<a href="javascript:;" class="jLogo"></a>
		<span class="pageTitle">帮助中心</span>
		<div class="f-r helpNavbar">
			<a href="${ctx}/helpindex/indexHelp?a=gdztsm" class="helpbar">
				操作指引<i class="jicon_update"></i>
			</a>
			<a href="${ctx}/docdownload/download" class="helpbar current">
				文档与视频<i class="jicon_update"></i>
			</a>
		</div>
	</div>
</header>
<div class="jpageWrap jdocpage">
	<div class="jpageWrapBg">
		<div class="jMain bk-gray bg-fff cl">
			<dl class="">
				<dt class="jdoclistTitle">
					<span class="w-710">文件</span>
					<span class="w-160">更新时间</span>
					<span class="w-120">大小</span>
					<span class="w-170">操作</span>
				</dt>
				<dd>
					<ul class="jdoclist">
					<c:forEach items="${list }" var="doc">
					<li>
							<div class="f-l w-710 docWrap">
							<c:if test="${doc.columns.icon==1 }">
								<i class="sficon_format sficon_format_word"></i>
							</c:if>
									<c:if test="${doc.columns.icon==2 }">
								<i class="sficon_format sficon_format_excel"></i>
							</c:if>
									<c:if test="${doc.columns.icon==3 }">
								<i class="sficon_format sficon_format_ppt"></i>
							</c:if>
							
								<!-- <i class="jicon_update"></i> -->
								<h3>${doc.columns.name }.${doc.columns.doc_type }</h3>
								<p class="c-666 lh-24 w-560 text-overflow">${doc.columns.description }</p>
							</div>
							<c:if test="${not empty doc.columns.update_time }">
							<div class="f-l w-160 txt1"><fmt:formatDate value="${doc.columns.update_time }" pattern="yyyy-MM-dd hh:mm"/></div>
							</c:if>
							<c:if test="${empty doc.columns.update_time }">
							<div class="f-l w-160 txt1"><fmt:formatDate value="${doc.columns.create_time }" pattern="yyyy-MM-dd hh:mm"/></div>
							</c:if>
							
							<div class="f-l w-120 txt1">${doc.columns.doc_size }</div>
							<div class="f-l w-170 pt-20 pl-30">
								<a href="${commonStaticImgPath}${doc.columns.path }" class="c-1e66b1"><i class="jicon_download"></i> 下载</a>
								
							</div>
						</li>
					
					</c:forEach>
						<!-- <li>
							<div class="f-l w-710 docWrap">
								<i class="sficon_format sficon_format_word"></i>
								<i class="jicon_update"></i>
								<h3>帮助中心操作经验分享.doc</h3>
								<p class="c-666 lh-24 w-560 text-overflow">经验分享经验分享经验分享经验分享经验分享经验分享经验分享经验分享经验分享经验分享经验分享经验分享经验分享经验分享经验分享经验分享</p>
							</div>
							<div class="f-l w-160 txt1">2017-08-28 15:30</div>
							<div class="f-l w-120 txt1">36kb</div>
							<div class="f-l w-170 pt-20 pl-30">
								<a href="javascript:;" class="c-1e66b1"><i class="jicon_download"></i> 下载</a>
								
							</div>
						</li>
						<li>
							<div class="f-l w-710 docWrap">
								<i class="sficon_format sficon_format_excel"></i>
								<i class="jicon_update"></i>
								<h3>帮助中心操作经验分享.excel</h3>
								<p class="c-666 lh-24 w-560 text-overflow">经验分享经验分享经验分享经验分享经验分享经验分享经验分享经验分享经验分享经验分享经验分享经验分享经验分享经验分享经验分享经验分享</p>
							</div>
							<div class="f-l w-160 txt1">2017-08-28 15:30</div>
							<div class="f-l w-120 txt1">36kb</div>
							<div class="f-l w-170 pt-20 pl-30">
								<a href="javascript:;" class="c-1e66b1"><i class="jicon_download"></i> 下载</a>
							</div>
						</li>
						<li>
							<div class="f-l w-710 docWrap">
								<i class="sficon_format sficon_format_ppt"></i>
								<i class="jicon_update"></i>
								<h3>帮助中心操作经验分享.ppt</h3>
								<p class="c-666 lh-24 w-560 text-overflow">经验分享经验分享经验分享经验分享经验分享经验分享经验分享经验分享经验分享经验分享经验分享经验分享经验分享经验分享经验分享经验分享</p>
							</div>
							<div class="f-l w-160 txt1">2017-08-28 15:30</div>
							<div class="f-l w-120 txt1">36kb</div>
							<div class="f-l w-170 pt-20 pl-30">
								<a href="javascript:;" class="c-1e66b1"><i class="jicon_download"></i> 下载</a>
							</div>
						</li>-->
						<li>
							<div class="f-l w-710 docWrap">
								<i class="sficon_format sficon_format_avi"></i>
								
								<h3>1.3.服务品牌品类.avi</h3>
								<p class="c-666 lh-24 w-560 text-overflow">1.3.服务品牌品类</p>
							</div>
							<div class="f-l w-160 txt1">2017-09-19 15:30</div>
							<div class="f-l w-120 txt1">20Mb</div>
							<div class="f-l w-170 pt-20 pl-30">
			
								<a target="_blank"  href="http://v.youku.com/v_show/id_XMzAyNTY1OTU0NA==.html?spm=a2h3j.8428770.3416059.1" class="c-1e66b1"><i class="jicon_play"></i> 播放</a>
							</div>
						</li> 
						<li>
							<div class="f-l w-710 docWrap">
								<i class="sficon_format sficon_format_avi"></i>
								
								<h3>1-4商品，预警，考勤，短信设置.avi</h3>
								<p class="c-666 lh-24 w-560 text-overflow">1-4商品，预警，考勤，短信设置</p>
							</div>
							<div class="f-l w-160 txt1">2017-09-19 15:30</div>
							<div class="f-l w-120 txt1">20Mb</div>
							<div class="f-l w-170 pt-20 pl-30">
			
								<a target="_blank"   href="http://v.youku.com/v_show/id_XMzAyNTY2MDc4OA==.html?spm=a2h3j.8428770.3416059.1" class="c-1e66b1"><i class="jicon_play"></i> 播放</a>
							</div>
						</li> 
						<li>
							<div class="f-l w-710 docWrap">
								<i class="sficon_format sficon_format_avi"></i>
								
								<h3>1-5员工信息设置及考勤统计.avi</h3>
								<p class="c-666 lh-24 w-560 text-overflow">1-5员工信息设置及考勤统计</p>
							</div>
					<div class="f-l w-160 txt1">2017-09-19 15:30</div>
							<div class="f-l w-120 txt1">20Mb</div>
							<div class="f-l w-170 pt-20 pl-30">
			
								<a target="_blank"   href="http://v.youku.com/v_show/id_XMzAyNTY2Mjk2OA==.html?spm=a2h3j.8428770.3416059.1" class="c-1e66b1"><i class="jicon_play"></i> 播放</a>
							</div>
						</li> 
						<li>
							<div class="f-l w-710 docWrap">
								<i class="sficon_format sficon_format_avi"></i>
								
								<h3>1-6结算信息设置.avi</h3>
								<p class="c-666 lh-24 w-560 text-overflow">1-6结算信息设置</p>
							</div>
						<div class="f-l w-160 txt1">2017-09-19 15:30</div>
							<div class="f-l w-120 txt1">20Mb</div>
							<div class="f-l w-170 pt-20 pl-30">
			
								<a target="_blank"   href="http://v.youku.com/v_show/id_XMzAyNTY2NjU0NA==.html?spm=a2h3j.8428770.3416059.1" class="c-1e66b1"><i class="jicon_play"></i> 播放</a>
							</div>
						</li> 
						<li>
							<div class="f-l w-710 docWrap">
								<i class="sficon_format sficon_format_avi"></i>
								
								<h3>2-1工单接入方式.avi</h3>
								<p class="c-666 lh-24 w-560 text-overflow">2-1工单接入方式</p>
							</div>
							<div class="f-l w-160 txt1">2017-09-19 15:30</div>
							<div class="f-l w-120 txt1">20Mb</div>
							<div class="f-l w-170 pt-20 pl-30">
			
								<a target="_blank"   href="http://v.youku.com/v_show/id_XMzAyNTY3ODc0NA==.html?spm=a2h3j.8428770.3416059.1" class="c-1e66b1"><i class="jicon_play"></i> 播放</a>
							</div>
						</li> 
						<li>
							<div class="f-l w-710 docWrap">
								<i class="sficon_format sficon_format_avi"></i>
							
								<h3>2-2一个简单的保内工单闭环.avi</h3>
								<p class="c-666 lh-24 w-560 text-overflow">2-2一个简单的保内工单闭环</p>
							</div>
							<div class="f-l w-160 txt1">2017-09-19 15:30</div>
							<div class="f-l w-120 txt1">20Mb</div>
							<div class="f-l w-170 pt-20 pl-30">
			
								<a target="_blank"   href="http://v.youku.com/v_show/id_XMzAyNTY4Mjg0NA==.html?spm=a2h3j.8428770.3416059.1" class="c-1e66b1"><i class="jicon_play"></i> 播放</a>
							</div>
						</li> 
						<li>
							<div class="f-l w-710 docWrap">
								<i class="sficon_format sficon_format_avi"></i>
								
								<h3>2-3保外工单闭环.avi</h3>
								<p class="c-666 lh-24 w-560 text-overflow">2-3保外工单闭环</p>
							</div>
							<div class="f-l w-160 txt1">2017-09-19 15:30</div>
							<div class="f-l w-120 txt1">20Mb</div>
							<div class="f-l w-170 pt-20 pl-30">
			
								<a target="_blank"   href="http://v.youku.com/v_show/id_XMzAyNTY4ODQ4NA==.html?spm=a2h3j.8428770.3416059.1 " class="c-1e66b1"><i class="jicon_play"></i> 播放</a>
							</div>
						</li> 
						<li>
							<div class="f-l w-710 docWrap">
								<i class="sficon_format sficon_format_avi"></i>
								
								<h3>2-4配件批量导入及单个入库.avi</h3>
								<p class="c-666 lh-24 w-560 text-overflow">2-4配件批量导入及单个入库</p>
							</div>
							<div class="f-l w-160 txt1">2017-09-19 15:30</div>
							<div class="f-l w-120 txt1">20Mb</div>
							<div class="f-l w-170 pt-20 pl-30">
			
								<a target="_blank"   href="http://v.youku.com/v_show/id_XMzAyNTY5MTIwMA==.html?spm=a2h3j.8428770.3416059.1" class="c-1e66b1"><i class="jicon_play"></i> 播放</a>
							</div>
						</li> 
						
						<li>
							<div class="f-l w-710 docWrap">
								<i class="sficon_format sficon_format_avi"></i>
								
								<h3>2-5配件申请及审核.avi</h3>
								<p class="c-666 lh-24 w-560 text-overflow">2-5配件申请及审核</p>
							</div>
							<div class="f-l w-160 txt1">2017-09-19 15:30</div>
							<div class="f-l w-120 txt1">20Mb</div>
							<div class="f-l w-170 pt-20 pl-30">
			
								<a target="_blank"   href="http://v.youku.com/v_show/id_XMzAyNTY5NDcwOA==.html?spm=a2h3j.8428770.3416059.1" class="c-1e66b1"><i class="jicon_play"></i> 播放</a>
							</div>
						</li> 
						<li>
							<div class="f-l w-710 docWrap">
								<i class="sficon_format sficon_format_avi"></i>
								
								<h3>2-6保内配件工单闭环及配件核销.avi</h3>
								<p class="c-666 lh-24 w-560 text-overflow">2-6保内配件工单闭环及配件核销</p>
							</div>
							<div class="f-l w-160 txt1">2017-09-19 15:30</div>
							<div class="f-l w-120 txt1">20Mb</div>
							<div class="f-l w-170 pt-20 pl-30">
			
								<a target="_blank"   href="http://v.youku.com/v_show/id_XMzAyNTY5NjYzMg==.html?spm=a2h3j.8428770.3416059.1" class="c-1e66b1"><i class="jicon_play"></i> 播放</a>
							</div>
						</li> 
						<li>
							<div class="f-l w-710 docWrap">
								<i class="sficon_format sficon_format_avi"></i>
								
								<h3>3商品上架，销售流程及品台商品.avi</h3>
								<p class="c-666 lh-24 w-560 text-overflow">3商品上架，销售流程及品台商品</p>
							</div>
							<div class="f-l w-160 txt1">2017-09-19 15:30</div>
							<div class="f-l w-120 txt1">20Mb</div>
							<div class="f-l w-170 pt-20 pl-30">
			
								<a target="_blank"   href="http://v.youku.com/v_show/id_XMzAyNTY5ODE0NA==.html?spm=a2h3j.8428770.3416059.1" class="c-1e66b1"><i class="jicon_play"></i> 播放</a>
							</div>
						</li> 
						
					</ul>
					<div class="pr-15">
						<!-- 分页 -->
					</div>
				</dd>
			</dl>
			
		</div>
	</div>
</div>
<footer class="jFooterWrap">
	Copyright ©2014-2017 安徽思方网络科技有限公司 皖ICP备5863296号
</footer>

<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="lib/layer/2.4/layer.js"></script>
<!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript">
$(function(){
	
	$('.jdocpage .jMain').height($(document.body).outerHeight()-$('.headerWrap').outerHeight()-$('.jFooterWrap').height() );

});



</script> 

</body>
</html>
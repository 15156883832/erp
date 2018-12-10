<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="decorator" content="base"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/skin/default/skin.css" id="skin" />

<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/ui.jqgrid.css"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/jquery-ui-1.9.2.custom.css"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/bootstrap.pagination.css"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/easyui.css"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/style.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/sfskin_blue.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/styleGoods.css" />
<title>（公司商品）商品详情</title>
</head>
<body class="">
	<div class="sfpagebg bk-gray pt-25 pl-20 pr-20 pb-80">
		<div class="goodsDetail">
			<div class="cl mb-20">
				<div class="f-l w-480">
					<div class="f-l mr-15 commodityImgWrap" id="commodityImgWrap">
						<!-- <img  id="commodityImg" /> -->
					</div>
					<div class="commodityImgListWrap f-l" id="commodityImgListWrap">
						<a class="btn_com btn_comPrev" id="btn_comPrev"> </a>
						<a class="btn_com btn_comNext" id="btn_comNext"></a>
						<div class="commodityImgList">
							<ul id="adlist">
								<c:forEach items="${iconArr }" var="icArr">
									<li class="">
										<img src="${commonStaticImgPath}${icArr }" />
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
				<div class="f-l">
					<h3 class="goodsName">
						${siteSelf.columns.name }
					</h3>
					<div class="goodsPrice mb-15 cl">
						<c:if test="${siteSelf.columns.rebate_flag eq 1 }">
							<div class="f-l col-3-1">
							<span class="f-13">建议零售价：</span><del class="c-black f-16">￥${siteSelf.columns.customer_price }</del>
						</div>
							<div class="f-l col-3-1">
								<span class="f-13">折扣价：</span><span class="c-fd6e32 f-22">￥${siteSelf.columns.rebate_price }</span>
							</div>
						</c:if>
						<c:if test="${siteSelf.columns.rebate_flag ne 1 }">
							<div class="f-l col-3-1">
								<span class="f-13">建议零售价：</span><span class="c-fd6e32 f-22">￥${siteSelf.columns.customer_price }</span>
							</div>
						</c:if>
					</div>
					<div class="line-dashed mb-10"></div>
					<div class="mb-10 cl text-c f-14 lh-30">
						<div class="f-l col-2-1 br">
							商品状态：<span class="c-fd6e32">
										<c:if test="${siteSelf.columns.sell_flag eq 1 }">上架</c:if>
										<c:if test="${siteSelf.columns.sell_flag eq 2 }">下架</c:if>
									</span>
						</div>
						<div class="f-l col-2-1">
							公司商品库存：<span class="c-fd6e32">${siteSelf.columns.stocks }</span>${siteSelf.columns.unit }
						</div>
					</div>
					<div class="line-dashed mb-10"></div>
					<div class="pt-15">
						<c:if test="${siteSelf.columns.tmall_seller_link!='' && siteSelf.columns.tmall_seller_link!=null }">
							<a href="${siteSelf.columns.tmall_seller_link }" target="_blank"  class="underline c-0e8ee7 mr-20 icon_TM">天猫比价</a>
						</c:if>
						<c:if test="${siteSelf.columns.jd_seller_link!='' && siteSelf.columns.jd_seller_link!=null }">
							<a href="${siteSelf.columns.jd_seller_link }" target="_blank"  class="underline c-0e8ee7 mr-20 icon_JD">京东比价</a>
						</c:if>
					</div>
					
				</div>
			</div>
			
			<div class="producttitle mb-25">
				<span class="producttitle_1">
					<span class="f-16">商品介绍 </span>
					<span class="f-16 c-888">/</span>
					<span class="c-888">Product Introduction</span>
				</span>
			</div>
			<div class="" style="width: 1000px; margin: 0 auto 25px;" >
				<table class="table table-border table-bordered productParameters">
					<tr>
						<th>商品编号</th>
						<td>${siteSelf.columns.number }</td>
						<th>商品名称</th>
						<td>${siteSelf.columns.name }</td>
					</tr>
					<tr>
						<th>商品品牌</th>
						<td>${siteSelf.columns.brand }</td>
						<th>商品型号</th>
						<td>${siteSelf.columns.model }</td>
					</tr>
					<tr>
						<th>商品类别</th>
						<td>${siteSelf.columns.category }</td>
						<th>序号</th>
						<td>${siteSelf.columns.sort_num }</td>
					</tr>
					<c:if test="${siteSelf.columns.repair_term != '' && siteSelf.columns.repair_term != null}">
						<tr>
							<th>保修期限</th>
							<td colspan="3">${siteSelf.columns.repair_term }</td>
						</tr>
					</c:if>
				</table>
			</div>
			<div class="text-c goodsImgsMain">
				${siteSelf.columns.html }
			</div>
		</div>
	
		<div class="btnsWrapFixbBg bgOpacity"></div>
		<div class="btnsWrapFixb pt-15 text-c">
			<a class="btnBlue pt-10 pb-10 lh-26 f-16 w-180 c-white radius mr-20" onclick="bianji('${siteSelf.columns.id}')">编辑商品</a>
			<c:if test="${siteSelf.columns.sell_flag eq 1 }">
				<a class="btnOrange2 pt-10 pb-10 lh-26 f-16 w-180 c-white radius ml-15" onclick="xiajia('${siteSelf.columns.id}')">下架商品</a>
			</c:if>
			<c:if test="${siteSelf.columns.sell_flag eq 2 }">
				<a class="btnOrange2 pt-10 pb-10 lh-26 f-16 w-180 c-white radius ml-15" onclick="shangjia('${siteSelf.columns.id}')">上架商品</a>
			</c:if>
		</div>
		
	</div>
	

<script type="text/javascript" src="${ctxPlugin}/lib/datatables/1.10.0/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="${ctxPlugin}/lib/laypage/1.2/laypage.js"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/grid.locale-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/carousel.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
	
	$(function(){
		$('#commodityImgListWrap').carousel();
	})
	
	
	
	//编辑商品
	function bianji(id){
		window.location.href="${ctx}/goods/siteself/toEditSiteSelfGoods?id="+id+"&jp="+'${jp}';
	} 
	
	//下架
	function xiajia(id) {
		var content = "确认要下架？";
		$('body').popup({
			level:3,
			title:"商品下架",
			content:content,
			 fnConfirm :function() {
			$.ajax({
				type : "POST",
				url : "${ctx}/goods/siteself/doXJ",
				data : {
					"id" : id
				},
				success : function(data) {
					if (data == "ok") {
						layer.msg('下架成功!');
						 window.location.href="${ctx}/goods/siteself/showDetail?id="+'${siteSelf.columns.id}'+"&jp=o2";
					} else {
						layer.msg('下架失败!');
					}
				}
			});
			 },
			 fnCancel:function (){
					
				}
		});

	}
	//上架
	function shangjia(id) {
		var content = "确认要上架？";
		$('body').popup({
			level:3,
			title:"商品上架",
			content:content,
			 fnConfirm :function() {
			$.ajax({
				type : "POST",
				url : "${ctx}/goods/siteself/doSJ",
				data : {
					"id" : id
				},
				success : function(data) {
					if (data == "ok") {
						layer.msg('上架成功!');
						window.location.href="${ctx}/goods/siteself/showDetail?id="+'${siteSelf.columns.id}'+"&jp=o2";
					} else {
						layer.msg('上架失败!');
					}
					return;
				}
			});
			 },
			 fnCancel:function (){
					
				}
		});
	}
	
	function jumpHref(href,mark){
		var msg = "未设置天猫比价链接！";
		var ids = '.icon_TM';
		if(mark=='jd'){
			msg = "未设置京东比价链接！";
			ids = '.icon_JD';
		}
		layer.msg(msg);
		return ;
	}
	
	function isBlank(val) {
		if (val == null || $.trim(val) == '' || val == undefined) {
			return true;
		}
		return false;
	}

</script> 
</body>
</html>
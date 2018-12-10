<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>我的商品-编辑</title>
<meta name="decorator" content="base"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/lazyload/1.9.3/jquery.lazyload.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/ueditor/1.4.3/ueditor.config.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/ueditor/1.4.3/ueditor.all.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/ueditor/1.4.3/lang/zh-cn/zh-cn.js"></script>
<style type="text/css">
.webuploader-pick{
	background:none;
	color:#22a0e6;	
	padding:0;
	
}
.spimg1 .webuploader-pick{
	width:134px;
	height:134px;
}
.spimg2 .webuploader-pick{
	width:80px;
	height:80px;
}

.webuploader-pick img{
	width:100%;
	height:100%;
	position:absolute;
	left:0;
	top:0;
}
</style>
</head>
<body>
<!-- 新增商品 -->
<div class="popupBox newsp spAddsp">
	<h2 class="popupHead">
		商品详情
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<form action="${ctx}/goods/siteself/doBJ" method="post" id="tf">
	<div class="popupContainer pos-r">
		<div class="popupMain">
		<div class="pcontent pt-10">
			<div class="cl w-710">
				<div class="f-r mb-10 w-240">
					<label class="w-90 f-l"> 商品图片：</label>
					<div class="imgbox2 f-l pos-r spimg1" id="spimg1" >
						<img src="${commonStaticImgPath}${siteSelf.columns.icon}" id="img-view" />
						<c:if test="${siteSelf.columns.icon == '' || siteSelf.columns.icon == null }"> 
							<a href="javascript:;" class="btn-uploadimg oneImg" ></a>
						</c:if> 
						<input type="hidden" name="icon" value="${siteSelf.columns.icon}" id="img-input">
					</div>
				</div>
				<div class="f-l mb-10">
				<input type="hidden" name="yuanNumber" value="${siteSelf.columns.number }">
				<input type="hidden" name="id" value="${siteSelf.columns.id }"/>
					<label class="f-l w-90">商品编号：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly"  value="${siteSelf.columns.number }" id="number" name="number"/>
					<label class="f-l w-100">商品名称：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly"  value="${siteSelf.columns.name }" id="name" name="name"/>
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-90">商品品牌：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${siteSelf.columns.brand }" name="brand"/>
					<label class="f-l w-100">商品型号：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${siteSelf.columns.model }" name="model"/>
					<input type="hidden" name="source" value="${siteSelf.columns.source }"/>
				</div>
				<div class="f-l mb-10 feiteshu">
					<label class="f-l w-90">商品类别：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly"  value="${siteSelf.columns.category }" name="model"/>
					
					<label class="f-l w-100">库位：</label>
					<input type="text" class="input-text w-140 f-l readonly"  readonly="readonly" value="${siteSelf.columns.location }" name="location"/>
				</div>
				
				<div class="f-l mb-10 feiteshu" >
					<label class="f-l w-90"> 商品单位：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly"  value="${siteSelf.columns.unit}" name="model"/>
					<label class="f-l w-100"> 库存数量：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly"  name="gstocks" id="gstocks" value="${siteSelf.columns.stocks }"/>	
				</div>
				
			    <div class="f-l mb-10 feiteshu">
					<label class="f-l w-90">入库价格：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text readonly"  readonly="readonly" id="gsitePrice" name="gsitePrice" value="${siteSelf.columns.site_price }"/>
						<span class="unit">元</span>
					</div>
					<label class="f-l w-100">工程师价格：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text readonly" readonly="readonly"  name="gemployePrice" value="${siteSelf.columns.employe_price }"/>
						<span class="unit">元</span>
					</div>
				</div>
				<div class="f-l mb-10 feiteshu">
					<label class="f-l w-90"> 零售价格：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text readonly" readonly="readonly"  name="gcustomerPrice" id="gcustomerPrice" value="${siteSelf.columns.customer_price }"/>
						<span class="unit">元</span>
					</div>
					<c:if test="${siteSelf.columns.rebate_flag eq 0 }">
						<span class="f-l w-100 lh-26 text-r">
							<label ></label>
						</span>
						<div class=" w-140 f-l readonly" id="discount">
						</div>
					</c:if>
					
					<c:if test="${siteSelf.columns.rebate_flag ne 0 }">
						<span class="f-l w-100 lh-26 text-r">
							<label class="" >折扣价格：</label>
						</span>
						<div class="priceWrap w-140 f-l " id="discount">
							<input type="hidden" name="rebateFlag" value="1"/>
							<input type="text" class="input-text readonly"  readonly="readonly"  name="grebatePrice" value="${siteSelf.columns.rebate_price }"/>
							<span class="unit">元</span>
						</div>
					</c:if>
					
				</div>
				<div class="f-l mb-10 feiteshu">
					<label class="f-l w-90">工程师提成：</label>
					<c:if test='${siteSelf.columns.deduct_type eq 1 }'>
						<div class="priceWrap w-140 f-l">
							<input type="text" class="input-text readonly" readonly="readonly"  name="deductType" id="normal_tc" value="常规提成" />
						</div>
						<div class="f-l tcbox " style="margin-left: 40px;" id="normal_box">
							<label class="f-l">提成金额：</label>
							<div class="priceWrap f-l w-140">
								<input type="text" class="input-text readonly" readonly="readonly"  name="gnormalDeductAmount" value="${siteSelf.columns.normal_deduct_amount }"/>
								<span class="unit">元</span>
							</div>
						</div>
						<div class="f-l hide tcbox" style="margin-left: 40px;" id="ratio_box">
							<label class="f-l ">提成比例：</label>
							<div class="priceWrap f-l w-140">
								<input type="text" class="input-text readonly" readonly="readonly"  name="ratioDeductVal" value="${siteSelf.columns.ratio_deduct_val }"/>
								<span class="unit">%</span>
							</div>
						</div>
					</c:if>
					<c:if test='${siteSelf.columns.deduct_type eq 2 }'>
						<div class="priceWrap w-140 f-l">
							<input type="text" class="input-text readonly" readonly="readonly"  name="deductType" id="normal_tc" value="比例提成" />
						</div>
						<div class="f-l hide tcbox" style="margin-left: 40px;" id="normal_box">
							<label class="f-l">提成金额：</label>
							<div class="priceWrap f-l w-140">
								<input type="text" class="input-text readonly" readonly="readonly"  name="gnormalDeductAmount" value="${siteSelf.columns.normal_deduct_amount }"/>
								<span class="unit">元</span>
							</div>
						</div>
						<div class="f-l  tcbox" style="margin-left: 40px;" id="ratio_box">
							<label class="f-l">提成比例：</label>
							<div class="priceWrap f-l w-140">
								<input type="text" class="input-text readonly" readonly="readonly"  name="ratioDeductVal" value="${siteSelf.columns.ratio_deduct_val }"/>
								<span class="unit">%</span>
							</div>
						</div>
					</c:if>
					<c:if test='${siteSelf.columns.deduct_type ne 1 && siteSelf.columns.deduct_type ne 2 }'>
						<div class="priceWrap w-140 f-l">
							<input type="text" class="input-text readonly" readonly="readonly"  name="deductType" id="normal_tc" value="" />
						</div>
						<div class="f-l hide tcbox" style="margin-left: 40px;" id="normal_box">
							<label class="f-l">提成金额：</label>
							<div class="priceWrap f-l w-140">
								<input type="text" class="input-text readonly" readonly="readonly"  name="gnormalDeductAmount" value=""/>
								<span class="unit">元</span>
							</div>
						</div>
						<div class="f-l  tcbox" style="margin-left: 40px;" id="ratio_box">
							<label class="f-l">提成比例：</label>
							<div class="priceWrap f-l w-140">
								<input type="text" class="input-text readonly" readonly="readonly"  name="ratioDeductVal" value=""/>
								<span class="unit">%</span>
							</div>
						</div>
					</c:if>
					
				</div>
				<div class="f-l mb-10 feiteshu">
					<label class="f-l w-90"> 是否上架：</label>
					<c:if test="${siteSelf.columns.sell_flag==1 }">
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly"  name="sortNum" value="确认上架"/>
					</c:if>
					<c:if test="${siteSelf.columns.sell_flag==2 }">
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly"  name="sortNum" value="暂不上架"/>
					</c:if>
					<label class="f-l w-100">序号：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly"  name="sortNum" value="${siteSelf.columns.sort_num }"/>
				</div>
			</div>
		
			<div class="pl-15 pr-15" style="height:210px;width:710px;overflow-x: hidden;overflow-y: auto;">
				 <script id="container" name="content" type="text/plain">
       				 
   				 	</script>
				 <textarea class="textarea h-50 hide" value="" id="html" name="html"></textarea>
			 </div>
		</div>
		</div>
		<div class="text-c btbWrap">
			<a href="javascript:;" onclick="inStockDetail()" class="sfbtn sfbtn-opt w-100 mr-5">确认入库</a>
			<a href="javascript:closeDiv();" class="sfbtn sfbtn-opt w-70 mr-5">关闭</a>
		</div>
	</div>
	</form>
</div>

<script type="text/javascript">
	$(function(){
		//防止图片过宽
	  	fixImgWidth();
	  	ue = UE.getEditor('container',{ serverUrl:'${ctxPlugin}/lib/ueditor/1.4.3/jsp/controller.jsp',
			toolbars: [['bold', 'italic', 'underline', 'fontborder',  'forecolor', 'backcolor',
	                      'fontfamily', 'fontsize','justifyleft','justifycenter','justifyright','justifyjustify',  
	                      'simpleupload', 'insertimage', 'preview','fullscreen']],
                      elementPathEnabled : false,
                      autoFloatEnabled :false,
                      initialFrameHeight: 150});
		ue.ready(function(){
			ue.setContent('${siteSelf.columns.html }');
			ue.setDisabled();
			 // 阻止工具栏的点击向上冒泡
		    $(this.container).click(function(e){
		        e.stopPropagation();
		    });
		    // 解决悬浮问题
		    if (UE.browser.ie && UE.browser.version <= 7) {
	    		FixIe7Bug();
	    	}
		})
		
		$('.spAddsp').popup({fixedHeight:false});
	
		
	});
	
	function closeDiv(){
		 $.closeDiv($(".spAddsp"));
	}
	
	   $('#spimg1').imgShow();
	   $('#Imgprocess2').imgShow();//非弹出框时需要hasIframe:true
	   function fixImgWidth(){
		   	$('#activeEditor img').each(function(item,index){
		   			$(this).bind('load', function() {//针对谷歌浏览器解决图片不能缩小的bug
		   				if($(this).width()>600){
		   					$(this).width(600);
		   				}
		   				$(this).parent().width($(this).width());
		   			});
		   			if($(this).width()>600){
		   					$(this).width(600);
		   				}
		   				$(this).parent().width($(this).width());
		   		});
		   }
	   
	   var mark2 = false;
	   function inStockDetail(){
		   if(mark2==true){
			   return ;
		   }
		   var id='${returnGoods.columns.id}';
		   var name='${returnGoods.columns.good_name}';
		   var amount='${returnGoods.columns.used_num}';
		   var goodId='${returnGoods.columns.good_id}';
		   mark2 = true;
			$.ajax({
				type:"post",
				url:"${ctx}/goods/usedRecord/confirmInStocks",
				data:{id:id,amount:amount,goodId:goodId},
				success:function(result){
					if(result.code=="421"){
						layer.msg("该商品不存在！");
						return;
					}else if(result.code=="200"){
						layer.msg("入库成功！");
						setTimeout(function() {
							parent.search();
							$.closeDiv($(".spAddsp"));
						}, 250);
						/* window.close();
						window.parent.location.reload();
						$('#Hui-article-box',window.top.document).css({'z-index':'9'}); */
						return;
					}else if(result.code=="422"){
						layer.msg("入库信息有误，商品历史领取数量小于返还数量！");
						return;
					} if(result.code=="423"){
						layer.msg("返还数量要求大于0！");
						return;
					}else if(result.code=="424"){
						layer.msg("商品使用记录信息有误，此商品可能已返还！");
						return;
					}else{
						layer.msg("入库失败，出现未知错误，请联系管理员！");
						return;
					}
				},
				complete:function(){
					mark2 = false;
				}
			})
		}
		
</script> 
</body>
</html>
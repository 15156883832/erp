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
/* .webuploader-pick{
	background:#fff;
	padding:0;
	color: #0e8ee7;
} */
.webuploader-pick{
	background:none;
	color:#22a0e6;	
	padding:0;
	
}
/* .spimg1{ border:none;} */
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
				
				<!-- 特殊 -->
				<div class="f-l mb-10 teshu" >
					<label class="f-l w-90">商品类别：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly"  value="${siteSelf.columns.category }" name="model"/>
					<label class="f-l w-100"> 商品单位：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly"  value="${siteSelf.columns.unit}" name="model"/>
					<input type='hidden' name="gsitePriceYing"  value="${siteSelf.columns.site_price }"/><!-- 入库价格 -->
				</div>
				
				<!-- 特殊商品 -->
				<div class="f-l mb-10 teshu">
					<label class="f-l w-90">官方指导价：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text  f-l readonly" readonly="readonly"  value="${siteSelf.columns.customer_price }" name="gcustomerPrice"/>
						<span class="unit">元</span>
					</div>
					<label class="f-l w-100">建议零售价：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text f-l readonly" readonly="readonly"  value="${siteSelf.columns.rebate_price }"  name="grebatePrice"/>
						<span class="unit">元</span>
					</div>
					<input type='hidden' name="gsitePrice"  value="${siteSelf.columns.site_price }"/><!-- 入库价格 -->
				</div>
				
				<div class="f-l mb-10 teshu">
					<label class="f-l w-90">促销奖励：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text w-140 f-l readonly" readonly="readonly"  value="" name="orderPrice"/>
						<span class="unit">元</span>
					</div>
					<label class="f-l w-100">是否上架：</label>
					<select class="select w-140 f-l readonly" disabled="disabled" name="sellFlag">
						<option value="1">确认上架</option>
						<option value="2">暂不上架</option>
					</select>
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
							<!-- <input type="hidden" name="rebateFlag" value="0"/>
							<input type="text" class="input-text readonly" readonly="readonly" name="grebatePrice" value=""/>
							<span class="unit">元</span> -->
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
					
					
					<%-- <span class="f-l w-100 lh-26 text-r">
						<label class="label-cbox4" for="isDiscount"><input class="" type="checkbox" id="isDiscount"/> 折扣价格：</label>
					</span>
					<div class="priceWrap w-140 f-l readonly" id="discount">
						<input type="text" class="input-text readonly" readonly="readonly" name="grebatePrice" value="${siteSelf.columns.rebate_price }"/>
						<span class="unit">元</span>
					</div> --%>
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
					
					<%-- <c:if test="${siteSelf.columns.deduct_type eq 1 }">
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
					</c:if> --%>
					<%-- <c:if test="${siteSelf.columns.deduct_type eq 2 }">
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
					</c:if> --%>
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
			<%-- <div class="txtwrap mb-10 w-710">
				<label class="lb w-90">商品描述：</label>
				<textarea class="textarea h-50 readonly" readonly="readonly"  name="description">${siteSelf.columns.description }</textarea>
			</div>
			 <div class="txtwrap cl hm-80">
				<label class="lb w-90">其它图片：</label>
				<div class="cl">
					<div class="f-l mr-10" id="Imgprocess2">
						<c:forEach items="${images }" var="str" varStatus="da">
							<div class="f-l imgWrap1 mb-10" id="img${da.index}">
								<div class="imgWrap"> 
									<img src="${commonStaticImgPath}${str}" id="${commonStaticImgPath}${str}"></img>
									<img id="${commonStaticImgPath}${str}" class="lazy" data-original="${commonStaticImgPath}${str}" />
								</div>
								<input type="hidden" value="${str}" name="imgs" >
							</div>
						</c:forEach>
						<!-- <div class="imgWrap f-l w-110" id="btn-img2">
							<div id="filePicker-add">
								<a href="javascript:;" class="btn-upload"></a>
							</div>
							<span>最多可添加8张图片</span>
						</div> -->
						
					</div>
				</div>
			</div>  --%>
			<div class="pl-15 pr-15" style="height:210px;width:710px;overflow-x: hidden;overflow-y: auto;">
				 <script id="container" name="content" type="text/plain">
       				 
   				 	</script>
				 <textarea class="textarea h-50 hide" value="" id="html" name="html"></textarea>
			 </div>
		</div>
		</div>
		<div class="text-c btbWrap">
			<a href="javascript:closeDiv();" class="sfbtn sfbtn-opt w-70 mr-5">关闭</a>
		</div>
	</div>
	</form>
</div>

<script type="text/javascript">
	var count = parseInt('${count}');
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
		
		if(count==8){
			$("#btn-img2").addClass('hide');
		} 
		createUploader("#filePicker-add","#Imgprocess2","file_fake_addimg","file_fake_add","delimgs");
		$('.spAddsp').popup({fixedHeight:false});
		
		$("img.lazy").lazyload({
		 	threshold : 10
		});
		
		var name= '${siteSelf.columns.name }';
		if($.trim(name)=='浩泽家用反渗透直饮机'){
			$(".feiteshu").remove();
			
			var sitePrice=$("input[name='gsitePrice']").val();/* 入库价格 */
			var grebatePrice=$("input[name='grebatePrice']").val();/* 建议零售价格 */
			var prize=grebatePrice-sitePrice;
			$("input[name='orderPrice']").val(prize);//促销奖励
		}else{
			$(".teshu").remove();
			
		}
		
	});
	
	function closeDiv(){
		 $.closeDiv($(".spAddsp"));
	}
	
	$('#isDiscount').click(function(){
		if($(this).attr('checked')){
			$(this).parent('label').addClass('label-cbox4-selected');
			$('#discount').removeClass('readonly');
			$('#discount').children('input').removeClass('readonly').removeAttr('readonly');
			$("input[name='rebateFlag']").val("1");
		}else{
			$(this).parent('label').removeClass('label-cbox4-selected');
			$('#discount').addClass('readonly');
			$('#discount').children('input').addClass('readonly').attr({'readonly':'readonly'});
			$("input[name='rebateFlag']").val("0");
		}
	})
	
	$('input[name="deductType"]').each(function(){
		$(this).click(function(){
			var isChecked = $(this).attr('checked');
			if(isChecked){
				$('input[name="deductType"]').parent('label').removeClass('radiobox-selected');
				$(this).parent().addClass('radiobox-selected');
				$('.tcbox').hide();
				var boxId = $(this).attr('id').split('_')[0]+'_box';
				$('#'+boxId).show();
			}
		});
	})
	
	//判断编号是否存在
	$("input[name='number']").blur(function(){
		var number=$("input[name='number']").val();
		var yuanNumber=$("input[name='yuanNumber']").val();
		if(number!=yuanNumber){
			 $.ajax({
					type:"POST",
					url : "${ctx}/goods/siteself/isNull",
					data : {
						number:number
					},
					success : function(data) {
						 if(data=="fal"){
							 layer.msg('该编号已存在！！');
							 $.closeDiv($(".splydjbox"));
							 window.location.reload(true);
						 }
					}
			});
		}
	})
	var adpoting = false;
	function tijiao(){
		if(adpoting) {
		    return;
	    }
		var name=$("input[name='name']").val();
		var category=$("select[name='category']").val();
		var gstocks=$("input[name='gstocks']").val();
		var gsitePrice=$("input[name='gsitePrice']").val();
		var gcustomerPrice=$("input[name='gcustomerPrice']").val();
		var icon = $("input[name='icon']").val();
		var number = $("input[name='number']").val();
		var grebatePrice = $("input[name='grebatePrice']").val();//折扣价格
		var gnormalDeductAmount = $("input[name='gnormalDeductAmount']").val();//提成金额
		var gemployePrice = $("input[name='gemployePrice']").val();//工程师价格
		var sortNum = $("input[name='sortNum']").val();//序号
		if(isBlank(number)){
			layer.msg('商品编号不能为空！！！');
			document.getElementById("number").focus();
			return false;
		}
		if(isBlank(name)){
			layer.msg('商品名称不能为空！！！');
			document.getElementById("name").focus();
			return false;
		}
		if(isBlank(category)){
			layer.msg('商品类别不能为空！！！');
			document.getElementById("category").focus();
			return false;
		}
		if(isBlank(gstocks)){
			layer.msg('请输入新增数量！！！');
			document.getElementById("gstocks").focus();
			return false;
		}
		if(isBlank(gsitePrice)){      //入库价格
			layer.msg('请输入入库价格！！！');
			document.getElementById("gsitePrice").focus();
			return false;
		}else if(check(gsitePrice)==false){
			layer.msg('输入的入库价格格式有误！！！');
			return false;
		}
		if(isBlank(gcustomerPrice)){ //零售价格
			layer.msg('请输入零售价格！！！');
			return false;
		}else if(check(gcustomerPrice)==false){
			layer.msg('输入的零售价格格式有误！！！');
			return false;
		}
		if(isBlank(icon)){
			layer.msg('请上传商品图片！！！');
			return false;
		}
		if(check(grebatePrice)==false){
			layer.msg('输入的折扣价格格式有误！！！');
			return false;
		}
		if(check(gnormalDeductAmount)==false){
			layer.msg('输入的提成金额格式有误！！！');
			return false;
		}
		if(check(gemployePrice)==false){
			layer.msg('输入的工程师价格格式有误！！！');
			return false;
		}
		if(upZero(sortNum)==false){
			layer.msg('输入的序号格式有误！！！');
			return false;
		}
		adpoting = true;
		$.ajax({
			type:"post",
			traditional:true,
			url:"${ctx}/goods/siteself/doBJ",
			data:$("#tf").serializeJson(),
			success:function(result){
				if(result==true){
					layer.msg("修改成功！");
					setTimeout(function(){
						window.parent.location.reload(true);
						$.closeDiv($(".spAddsp"));
					},500);
				}else{
					layer.msg("修改失败，请检查！");
				}
			},
            complete: function() {
                adpoting = false;
            }
		})
		
	}
	
	function check(number) { 
	    var re = /^\d+(?=\.{0,1}\d+$|$)/ ;
	    if($.trim(number)!='' && number!=null && number!=undefined){
	        if (!re.test(number)) { 
	           return false;
	        } 
	    }
	    return true;
	}
	
	function upZero(num) { 
	    var re = /^\+?[1-9]\d*$/;
	    if($.trim(num)!='' && num!=null && num!=undefined){
	        if (!re.test(num)) { 
	           return false;
	        } 
	    }
	    return true;
	}
	
	
	function isBlank(val) {
			if (val == null || val == '' || val == undefined) {
				return true;
			}
			return false;
		}
	var thumbnailWidth = 130;   //缩略图高度和宽度 （单位是像素），当宽高度是0~1的时候，是按照百分比计算，具体可以看api文档  
	var thumbnailHeight = 130; 
	uploader = WebUploader.create({
	       // 选完文件后，是否自动上传。 
	       auto: true,  
	       swf: '${ctxPlugin}/lib/webuploader/0.1.5/Uploader.swf',  
	       server: '${ctx}/common/uploadFile',		       
	       duplicate:true,
	       fileSingleSizeLimit:1024*1024*5,
	       pick: '#img-picker',  
	       accept: {
	    	    title: 'Images',
	    	    extensions: 'gif,jpg,jpeg,bmp,png',
	    	    mimeTypes: 'image/gif,image/jpg,image/jpeg,image/bmp,image/png'
	       },  
	       method:'POST'
	   }); 
	   uploader.on("error",function (type){
	   		if (type=="Q_TYPE_DENIED"){ 
		   		layer.msg("请上传JPG、PNG格式文件");
		   }else if(type=="F_EXCEED_SIZE"){
			   layer.msg("文件大小不能超过5M"); 
			}
	   });
	   uploader.on('beforeFileQueued', function(file){
		   uploader.reset();
	   });
	   uploader.on( 'uploadSuccess', function( file, response ) {
		   $("#img-view").attr("src",'${commonStaticImgPath}'+response.path);
		   $("#img-input").val(response.path);
		 	$(".oneImg").remove();
		   
	   });
	  
	   uploader.on( 'fileQueued', function( file ) {
		   uploader.makeThumb( file, function( error, src ) {
			   if (error) {
				    layer.msg('不能预览');
			   }
		}, thumbnailWidth, thumbnailHeight );
	});
	   
	   function createUploader(picker,site, el,id,delimg) {
			var thumbnailWidth = 130;   //缩略图高度和宽度 （单位是像素），当宽高度是0~1的时候，是按照百分比计算，具体可以看api文档  
			var thumbnailHeight = 130; 
			uploader = WebUploader.create({
			       // 选完文件后，是否自动上传。 
			       auto: true,  
			       swf: '${ctxPlugin}/lib/webuploader/0.1.5/Uploader.swf',  
			       server: '${ctx}/common/uploadFile',
			       
			       duplicate:true,
			       fileNumLimit:8, 
			       fileSingleSizeLimit:1024*1024*5,
			       pick: {id:picker,
			    	   multiple:true},  
			       accept: {  
			    	    title: 'Images',
			    	    extensions: 'gif,jpg,jpeg,bmp,png',
			    	    mimeTypes: 'image/gif,image/jpg,image/jpeg,image/bmp,image/png'
			       },  
			       method:'POST'
			   }); 
			   uploader.on("error",function (type){
			   if (type=="Q_TYPE_DENIED"){ 
				   layer.msg("请上传JPG、PNG格式文件");
				   }else if(type=="F_EXCEED_SIZE"){
					   layer.msg("文件大小不能超过5M"); }
			   });
			   
			   uploader.on('beforeFileQueued', function(file){
				   uploader.reset();
			   });
			   uploader.on( 'uploadSuccess', function( file, response ) {
				
				//   $("#"+el).val(response.path);
				   if(count > 7){
						return false;
					}else{
						$('<input type="hidden"  name="imgs" id="imgs'+file.id+'" value="'+response.path+'">').insertBefore($("#btn-img2"));
						 count = count + 1;
					}
				   /* $(site).append('<input type="hidden"  name="imgs" id="imgs'+file.id+'" value="'+response.path+'">'); */
					//$(".form-add-messenger").find('input[name="licenseImg"]').val(response.path);  
			   
			   });
			   uploader.on( 'uploadError', function( file, reason ) {
					
			   }); 
			  
			   uploader.on( 'fileQueued', function( file ) {
				   if(count==7){
					   $("#btn-img2").addClass('hide');
				   }
				   if(count > 7){
					   layer.msg("上传图片数超过限制");
					   return false;
				   }
			   uploader.makeThumb( file, function( error, src ) {
				   if (error) {
					    alert('不能预览');
				   } else {
					   img(id,src,file,site);
				   }
			}, thumbnailWidth, thumbnailHeight );
			//   uploader.upload();  
			});   
			   
		}
	   
	   function dele(obj,fileId){
			$(obj).parent('.imgWrap1').remove();
			$("#file"+fileId+"").remove();
			$("#imgs"+fileId).remove();
			count=count-1;
			 if(count==7){
				   $("#btn-img2").removeClass('hide');
			   }
       		return ;
		}
	   
	   function img(id,src,file,site){
			var html =' <div class="f-l imgWrap1 mb-10" id="file'+file.id+'"><div class="imgWrap"> ';
			html +='<img src="'+src+'" id=""></img></div><a class="sficon btn-delimg" onclick="dele(this,\''+file.id+'\')"></a></div>';
			
			$(html).insertBefore($("#btn-img2"));
		}
	   
	   function deleteImg(ff){
		   $("#"+ff).remove();
		   count=count-1;
		   if(count==7){
			   $("#btn-img2").removeClass('hide');
		   }
		   if(uploader){
			   uploader = null;
		   }
		   createUploader("#filePicker-add","#Imgprocess2","file_fake_addimg","file_fake_add","delimgs");
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
		
</script> 
</body>
</html>
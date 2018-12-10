<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>平台商品-我要销售</title>
<meta name="decorator" content="base"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/ueditor/1.4.3/themes/default/ueditor.css"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/ueditor/1.4.3/themes/default/ueditor.min.css"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/ueditor/1.4.3/themes/iframe.css"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/ueditor/1.4.3/ueditor.config.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/ueditor/1.4.3/ueditor.all.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/ueditor/1.4.3/ueditor.all.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/ueditor/1.4.3/ueditor.parse.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/ueditor/1.4.3/ueditor.parse.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/ueditor/1.4.3/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/ueditor/1.4.3/lang/en/en.js"></script>
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
<div class="popupBox newsp ptAddsp">
	<h2 class="popupHead">
		 我要销售
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<form action=""  method="post" id="tf">
	<div class="popupContainer pos-r">
		<div class="popupMain">
		<div class="pcontent pt-10">
			<div class="cl w-710">
				<div class="f-r mb-10 w-240">
					<label class="w-90 f-l"><em class="mark">*</em>商品图片：</label>
					<div class="imgbox2 f-l pos-r spimg1" id="spimg1" >
						<img src="${commonStaticImgPath}${platform.columns.icon}" id="img-view" />
						<c:if test="${platform.columns.icon == '' || platform.columns.icon == null }"> 
							<a href="javascript:;" class="btn-uploadimg oneImg" ></a>
						</c:if> 
						<input type="hidden" name="icon" value="${platform.columns.icon}" id="img-input">
						<input type="hidden" name="platformGoodId" value="${platform.columns.id}" id="img-input">
					</div>
					<a href="javascript:;" class="btn-uploadimg  ml-90 w-140 text-c" id="img-picker">上传图片</a>
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-90"><em class="mark">*</em>商品编号：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${platform.columns.number }" name="number"/>
					<label class="f-l w-100"><em class="mark">*</em>商品名称：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly"  value="${platform.columns.name }" name="name"/>
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-90">商品品牌：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${platform.columns.brand }" name="brand"/>
					<label class="f-l w-100">商品型号：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${platform.columns.model }" name="model"/>
					<input type="text" class="input-text w-140 f-l readonly hide" readonly="readonly" value="${platform.columns.category }" name="oldCategory"/>
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-90"><em class="mark">*</em>商品类别：</label>
					<select class="select w-140 f-l" name="category">
						<option value="">请选择</option>
					<c:forEach var ="cg" items="${categoryList}">
						<option value="${cg.columns.name }" <c:if test="${cg.columns.name==platform.columns.category }">selected="selected"</c:if>  >${cg.columns.name }</option>
					</c:forEach>
					</select>
					<label class="f-l w-100" id="locationName">库位：</label>
					<input type="text" class="input-text w-140 f-l "  value="" name="location"/>
					
					<!-- 特殊商品 -->
					<label class="f-l w-100" id="unitName">商品单位：</label>
					<%--<input type="hidden" value="${platform.columns.unit }" name="unit" />--%>
					<input type="text" id="esunit" class="input-text w-140 f-l readonly" readonly="readonly"  value="${platform.columns.unit}" name="unit"/>
					<%-- <select class="select w-140 f-l readonly" disabled="disabled" id="esunit">
						<option value="">请选择</option>
						<c:forEach items="${units}" var="item">
							<option value="${item.name}" <c:if test="${item.name == platform.columns.unit }">selected="selected"</c:if>>${item.name}</option>
						</c:forEach>
					</select> --%>
				</div>
				<div class="f-l mb-10" id="nojingshuiPrice">
					<label class="f-l w-90"><em class="mark">*</em>新增数量：</label>
					<input type="text" class="input-text w-140 f-l mustfill "  value="" name="gstocks" id="gstocks"/>
					<label class="f-l w-100"><em class="mark">*</em>商品单位：</label>
					<select class="select w-140 f-l" name="unit">
						<option value="">请选择</option>
						<c:forEach items="${units}" var="item">
							<option value="${item.name}" <c:if test="${item.name == platform.columns.unit }">selected="selected"</c:if>>${item.name}</option>
						</c:forEach>
					</select>
				</div>
				
				<!-- 特殊商品 -->
				<div class="f-l mb-10" id="jingshuiPrice">
					<label class="f-l w-90">官方指导价：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text w-140 f-l readonly" readonly="readonly"  value="2979" name="gcustomerPrice"/>
						<span class="unit">元</span>
					</div>
					<label class="f-l w-100">建议零售价：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text w-140 f-l readonly" readonly="readonly"  value="2198"  name="grebatePrice"/>
						<span class="unit">元</span>
					</div>
				</div>
				
				<div class="f-l mb-10" id="jiangli">
					<label class="f-l w-90">促销奖励：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text w-140 f-l readonly" readonly="readonly"  value="" name="orderPrice"/>
						<span class="unit">元</span>
					</div>
					<label class="f-l w-100"><em class="mark">*</em>是否上架：</label>
					<select class="select w-140 f-l" name="sellFlag">
						<option value="1">确认上架</option>
						<option value="2">暂不上架</option>
					</select>
					<input type='hidden' name="gsitePrice"  value="${platform.columns.site_price }"/><!-- 入库价格 -->
				</div>
				
				
				
			    <div class="f-l mb-10 feiespecialy" >
					<label class="f-l w-90"><em class="mark">*</em>入库价格：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text readonly" readonly="readonly" name="gsitePrice" id="gsitePrice" value="${platform.columns.site_price }"/>
						<span class="unit">元</span>
					</div>
					<label class="f-l w-100">工程师价格：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text" name="gemployePrice" value=""/>
						<span class="unit">元</span>
					</div>
				</div>
				
				 <div class="f-l mb-10 feiespecialy" >
					<label class="f-l w-90"><em class="mark">*</em>零售价格：</label>
					<div class="priceWrap w-140 f-l">
						<c:if test="${platform.columns.good_sign eq 'DZ20180110'}">
							<input type="text" class="input-text mustfill" name="gcustomerPrice" id="gcustomerPrice" value="220.00"/>
						</c:if>
						<c:if test="${platform.columns.good_sign eq 'DZ20180111'}">
							<input type="text" class="input-text mustfill" name="gcustomerPrice" id="gcustomerPrice" value="180.00"/>
						</c:if>
						<c:if test="${platform.columns.good_sign eq 'DZ20180113'}">
							<input type="text" class="input-text mustfill" name="gcustomerPrice" id="gcustomerPrice" value="150.00"/>
						</c:if>
						<c:if test="${platform.columns.good_sign eq 'DZ20180114'}">
							<input type="text" class="input-text mustfill" name="gcustomerPrice" id="gcustomerPrice" value="360.00"/>
						</c:if>
						<c:if test="${platform.columns.good_sign eq 'DZ20180115'}">
							<input type="text" class="input-text mustfill" name="gcustomerPrice" id="gcustomerPrice" value="320.00"/>
						</c:if>
						<c:if test="${platform.columns.good_sign eq 'DZ20180116'}">
							<input type="text" class="input-text mustfill" name="gcustomerPrice" id="gcustomerPrice" value="220.00"/>
						</c:if>
						<c:if test="${platform.columns.good_sign eq 'LB20180105' || platform.columns.good_sign eq 'LB20180106' || platform.columns.good_sign eq 'BS20180107' || platform.columns.good_sign eq 'BS20180108'}">
							<input type="text" class="input-text mustfill" name="gcustomerPrice" id="gcustomerPrice" value="78.00"/>
						</c:if>
						<c:if test="${platform.columns.good_sign ne 'DZ20180110' && platform.columns.good_sign ne 'DZ20180111' && platform.columns.good_sign ne 'DZ20180113'
						&& platform.columns.good_sign ne 'DZ20180114' && platform.columns.good_sign ne 'DZ20180115' && platform.columns.good_sign ne 'DZ20180116'
						&& platform.columns.good_sign ne 'LB20180105' && platform.columns.good_sign ne 'LB20180106'} ">
							<input type="text" class="input-text mustfill" name="gcustomerPrice" id="gcustomerPrice" value=""/>
						</c:if>

						<span class="unit">元</span>
					</div>
					
					<span class="f-l w-100 lh-26 text-r">
						<label class="label-cbox4" for="isDiscount"><input type="checkbox" name="isDiscount" id="isDiscount"  value="1"/> 折扣价格：</label>
					</span>
					<div class="priceWrap w-140 f-l readonly" id="discount">
						<input type="text" class="input-text readonly" readonly="readonly" name="grebatePrice"/>
						<span class="unit">元</span>
					</div>
				</div>
				
				<div class="f-l mb-10" >
					<label class="f-l w-90">工程师提成：</label>
					<label class="f-l mt-3 mr-10 radiobox radiobox-selected" for="normal_tc">
						<input type="radio" name="deductType" id="normal_tc" value="1" checked="checked" />常规提成
					</label>
					<label class="f-l mt-3 mr-10 radiobox" for="ratio_tc">
						<input type="radio" name="deductType" id="ratio_tc"  value="2"/>比例提成
					</label>
					<div class="f-l tcbox" style="margin-left: 13px;" id="normal_box">
						<label class="f-l">提成金额：</label>
						<div class="priceWrap f-l w-140">
							<input type="text" class="input-text" name="gnormalDeductAmount"/>
							<span class="unit">元</span>
						</div>
					</div>
					<div class="f-l hide tcbox" style="margin-left: 13px;" id="ratio_box">
						<label class="f-l">提成比例：</label>
						<!-- <select class="select w-140 f-l" name="ratioDeductRadix">
							<option value="1">入库价格</option>
							<option value="2">工程师价格</option>
							<option value="3">零售价格</option>
							<option value="4">零售价格-工程师价格</option>
							<option value="5">零售价格-入库价格</option>
						</select> -->
						<div class="priceWrap f-l w-140">
						<!-- <span>提成比例系数</span> -->
							<span><input type="text" class="input-text" name="ratioDeductVal"/></span>
							<span class="unit">%</span>
						</div>
					</div>
				</div>
				<div class="f-l mb-10 feiespecialy" >
					<label class="f-l w-90"><em class="mark">*</em>是否上架：</label>
					<select class="select w-140 f-l" name="sellFlag">
						<option value="1">确认上架</option>
						<option value="2">暂不上架</option>
					</select>
				</div>
			</div>
			<%-- <div class="txtwrap mb-10 w-710">
				<label class="lb w-90">商品描述：</label>
				<textarea class="textarea h-50" name="description" id="textdescription"></textarea>
			</div>
			 <div class="txtwrap cl hm-80">
				<label class="lb w-90">其它图片：</label>
				<div class="cl">
					<div class="f-l mr-10" id="Imgprocess2">
						<c:forEach items="${images }" var="str" varStatus="da">
							<div class="f-l imgWrap1 mb-10" id="img${da.index}">
								<div class="imgWrap"> 
									<img src="${commonStaticImgPath}${str}" id="${commonStaticImgPath}${str}"></img>
								</div>
								<a class="sficon btn-delimg" onclick="deleteImg('img${da.index}')"></a>
								<input type="hidden" value="${str}" name="imgs" >
							</div>
						</c:forEach>
						<div class="imgWrap f-l w-110" id="btn-img2">
							<div id="filePicker-add">
								<a href="javascript:;" class="btn-upload"></a>
							</div>
							<span>最多可添加8张图片</span>
						</div>
					</div>
				</div>
			</div> --%>
			<div class="pl-15 pr-15" style="height:210px;width:710px;overflow-x: hidden;overflow-y: auto;">
				 <script id="container" name="content" type="text/plain">
   				 </script>
				<input id="html" name="html" type="hidden" value="${platform.columns.html }">
			 </div>
		</div>
		</div>
		<div class="text-c btbWrap">
			<input type="button" value="保存" class="sfbtn sfbtn-opt3 w-70 mr-5 singleSubmit" onclick="sellGoods()"/>
			<!-- <a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" id="Butfitting">保存</a> -->
			<a href="javascript:closeDiv();" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
		</div>
	</div>
	</form>
</div>

<script type="text/javascript">	
var count = parseInt('${count}');
var goodsname='${platform.columns.name}';
var goodSign='${platform.columns.good_sign}';
var sitePri='${platform.columns.site_price }';
	$(function(){
        $.post("${ctx}/goods/sitePlatformGoods/distinct",function(result){
            if(result=="showPopup"){
                if(goodSign=='LB20180105'){
                    $("input[name='gsitePrice']").val(${platform.columns.no_vip_price});
                }else if(goodSign=='LB20180106'){
                    $("input[name='gsitePrice']").val(${platform.columns.no_vip_price});
				}else if(goodSign=='CZ20180117'){
                    $("input[name='gsitePrice']").val(${platform.columns.no_vip_price});
				}else{
                    var price=parseFloat(sitePri)+parseFloat(5);
                    $("input[name='gsitePrice']").val(price);
				}
            }
        });

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
            ue.setContent('${platform.columns.html }');
			 // 阻止工具栏的点击向上冒泡
		    $(this.container).click(function(e){
		        e.stopPropagation();
		    });
		    // 解决悬浮问题
		    if (UE.browser.ie && UE.browser.version <= 7) {
	    		FixIe7Bug();
	    	}
		})
		
		//createUploader("#filePicker-add","#Imgprocess2","file_fake_addimg","file_fake_add","delimgs");
		$('.ptAddsp').popup({fixedHeight:false});
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
		   
		   var goodSn='${platform.columns.good_sign }';
		   if($.trim(goodSn)=='HZ20180104'){
			   $("#locationName").remove();
			   $("input[name='location']").remove();
			   $("#nojingshuiPrice").remove();
			   $(".feiespecialy").remove();
			   $("#textdescription").addClass("readonly");
			   $("#textdescription").prop("readonly",true);
			   $("#btn-img2").remove();
			   $("#img-picker").remove();
			   $(".btn-delimg").remove();
			   
			   var sitePrice=$("input[name='gsitePrice']").val();/* 入库价格 */
			   var grebatePrice=$("input[name='grebatePrice']").val();/* 建议零售价格 */
			   var prize=grebatePrice-sitePrice;
			   $("input[name='orderPrice']").val(prize);//促销奖励
		   }else{
			   $("#unitName").remove();
			   $("#esunit").remove();
			   $("#jingshuiPrice").remove();
			   $("#jiangli").remove();
		   }
		   
	});
	function closeDiv(){
		 $.closeDiv($(".ptAddsp"));
	}
	
	$('#isDiscount').click(function(){
		if($(this).attr('checked')){
			$(this).parent('label').addClass('label-cbox4-selected');
			$('#discount').removeClass('readonly');
			$('#discount').children('input').removeClass('readonly').removeAttr('readonly');
			$("#discount").val("1");
		}else{
			$(this).parent('label').removeClass('label-cbox4-selected');
			$('#discount').addClass('readonly');
			$('#discount').children('input').addClass('readonly').attr({'readonly':'readonly'});
			$("#discount").val("0");
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
	var adpoting = false;
	function sellGoods(){
		$("#html").val(ue.getContent());
		if(adpoting) {
		    return;
	    }
		var goodName=$("input[name='name']").val();
		var category=$("select[name='category']").val();
		if($.trim(goodSign)=='HZ20180104'){
			if(isBlank(category)){
				layer.msg("请选择商品类别！");
				return;
			}else{
				adpoting = true;
				$.ajax({
					type:"POST",
					traditional:true,
					url:"${ctx}/goods/sitePlatformGoods/doXS",
					data:$("#tf").serializeJson(), 
					dataType:'json',
					success:function(result){
						if(result==true){
							layer.msg("添加成功！");
							/* setTimeout(function(){
								window.parent.location.reload(true);
								$.closeDiv($(".ptAddsp"));
							},500); */
							//window.top.location.reload(true);
							//window.location.href='${ctx}/goods/sitePlatformGoods/getSitePlatformGoodslist';
							//window.location.href='${ctx}/goods/sitePlatformGoods/getSitePlatformGoodslist';
							$("iframe", window.top.document).attr("src", '${ctx}/goods/sitePlatformGoods/getSitePlatformGoodslist');
							$('#Hui-article-box',window.top.document).css({'z-index':'9'});
						}else{
							layer.msg("添加失败，请检查！");
						}
					},
		            complete: function() {
		                adpoting = false;
		            }
				}) 
			}
		}else if($.trim(goodSign)!='HZ20180104'){
			if(isBlank($('input[name="gstocks"]').val())){
				layer.msg("请输入新增数量！");
				$("#gstocks").focus();
				return;
			}else if(isBlank($('select[name="unit"]').val())){
				layer.msg("请选择商品单位！");
				return;
			}else if(isBlank($('input[name="gcustomerPrice"]').val())){
				layer.msg("请填写零售价格！");
				$("#gcustomerPrice").focus();
				return;
			}else if(isBlank($('input[name="icon"]').val())){
				layer.msg("请添加商品图片！");
				return;
			}else{
				adpoting = true;
				$.ajax({
					type:"POST",
					traditional:true,
					url:"${ctx}/goods/sitePlatformGoods/doXS",
					data:$("#tf").serializeJson(), 
					dataType:'json',
					success:function(result){
						if(result==true){
							layer.msg("添加成功！");
							/* setTimeout(function(){
								window.parent.location.reload(true);
								$.closeDiv($(".ptAddsp"));
							},500); */
							//window.top.location.reload(true);
							//window.location.href='${ctx}/goods/sitePlatformGoods/getSitePlatformGoodslist';
							//window.location.href='${ctx}/goods/sitePlatformGoods/getSitePlatformGoodslist';
							$("iframe", window.top.document).attr("src", '${ctx}/goods/sitePlatformGoods/getSitePlatformGoodslist');
							$('#Hui-article-box',window.top.document).css({'z-index':'9'});
						}else{
							layer.msg("添加失败，请检查！");
						}
					},
		            complete: function() {
		                adpoting = false;
		            }
				}) 
			}
		}
		
	}
	
	function isBlank(val) {
			if (val == null || val == '' || val == undefined) {
				return true;
			}
			return false;
		}
	
	   
	   function createUploader(picker,site, el,id,delimg) {
			var thumbnailWidth = 130;   //缩略图高度和宽度 （单位是像素），当宽高度是0~1的时候，是按照百分比计算，具体可以看api文档  
			var thumbnailHeight = 130; 
			uploader = WebUploader.create({
			       // 选完文件后，是否自动上传。 
			       auto: true,  
			       swf: '${ctxPlugin}/lib/webuploader/0.1.5/Uploader.swf',  
			       server: '${ctx}/common/uploadFile',
			       
			       duplicate:true,
			       
			       fileSingleSizeLimit:1024*1024*5,
			       pick:picker,
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
			var html =' <div class="f-l imgWrap1" id="file'+file.id+'"><div class="imgWrap"> ';
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
	   
	   function isBlank(val) {
			if (val == null || val == '' || val == undefined) {
				return true;
			}
			return false;
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
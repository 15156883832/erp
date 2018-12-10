<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>我的商品-新增</title>
<meta name="decorator" content="base"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
<script type="text/javascript" src="${ctxPlugin}/lib/ueditor/1.4.3/themes/iframe.css"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>

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
img{
	width:100px;
	height:100px;
}
	
</style>

</head>
<body>
<!-- 新增商品 -->
<div class="popupBox newsp spAddsp">
	<h2 class="popupHead">
		新增商品
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<form action="${ctx}/goods/siteself/doXZ" method="post" id="tf">
	<div class="popupContainer pos-r">
		<div class="popupMain">
		<div class="pcontent pt-10">
			<div class="cl w-710">
				<div class="f-r mb-10 w-240">
					<label class="w-90 f-l"><em class="mark">*</em>商品图片：</label>
					<div class="imgbox2 f-l pos-r spimg1" id="spimg1" >
						<img  id="img-view" />
						<a href="javascript:;" class="btn-uploadimg oneImg" ></a>
						<input type="hidden" name="icon"  id="img-input">
					</div>
					<a href="javascript:;" class="btn-uploadimg uploaderGG  ml-90 w-140 text-c" id="img-picker">上传图片</a>
					<p class="c-888 pl-80 w-240">建议上传图片大小：800*800</p>
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-90"><em class="mark">*</em>商品编号：</label>
					<input type="text" class="input-text w-140 f-l mustfill" value="${number }" id="number" name="number"/>
					<label class="f-l w-100"><em class="mark">*</em>商品名称：</label>
					<input type="text" class="input-text w-140 f-l mustfill"  value="" id="name" name="name"/>
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-90">商品品牌：</label>
					<input type="text" class="input-text w-140 f-l" value=""  name="brand"/>
					<label class="f-l w-100">商品型号：</label>
					<input type="text" class="input-text w-140 f-l" value="" name="model"/>
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-90"><em class="mark">*</em>商品类别：</label>
					<select class="select w-140 f-l" id="category" name="category">
						<option value="">--请选择--</option>
						<c:forEach var ="cg" items="${categoryList}">
						<option value="${cg.columns.name }">${cg.columns.name }</option>
						</c:forEach>
					</select>
					<label class="f-l w-100">库位：</label>
					<input type="text" class="input-text w-140 f-l"  value="" name="location"/>
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-90">商品单位：</label>
					<select id="punit" class="select w-140 f-l" name="unit" onfocus="showTip();">
						<%--<option value="件">件</option>--%>
						<%--<option value="米">米</option>--%>
						<%--<option value="升">升</option>--%>
						<option value="">请选择</option>
						<c:forEach items="${units}" var="item">
							<option value="${item.name}">${item.name}</option>
						</c:forEach>
					</select>
					<label class="f-l w-100"><em class="mark">*</em>新增数量：</label>
					<input type="text" class="input-text w-140 f-l mustfill" id="gstocks" name="gstocks"/>	
				</div>
			    <div class="f-l mb-10">
					<label class="f-l w-90"><em class="mark">*</em>入库价格：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text mustfill" id="gsitePrice" name="gsitePrice" datatype="*" errormsg="格式错误" nullmsg="入库价格"/>
						<span class="unit">元</span>
					</div>
					<label class="f-l w-100">工程师价格：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text" name="gemployePrice"/>
						<span class="unit">元</span>
					</div>
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-90"><em class="mark">*</em>零售价格：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text mustfill" id="gcustomerPrice" name="gcustomerPrice"/>
						<span class="unit">元</span>
					</div>
					
					<span class="f-l w-100 lh-26 text-r">
						<label class="label-cbox4" for="isDiscount"><input type="checkbox" name="isDiscount" id="isDiscount" /> 折扣价格：</label>
					</span>
					<div class="priceWrap w-140 f-l readonly" id="discount">
						<input type="hidden" name="rebateFlag" value="0"/>
						<input type="text" class="input-text readonly" readonly="readonly" name="grebatePrice"/>
						<span class="unit">元</span>
					</div>
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-90">工程师提成：</label>
					<label class="f-l mt-3 mr-10 radiobox radiobox-selected" for="normal_tc">
						<input type="radio" name="deductType" id="normal_tc" value="1" checked="checked" />固定金额
					</label>
					<label class="f-l mt-3 mr-10 radiobox" for="ratio_tc">
						<input type="radio" name="deductType" id="ratio_tc" value="2"/>利润比例
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
						<div class="priceWrap f-l w-140">
							<span><input type="text" class="input-text" name="ratioDeductVal"/></span>
							<span class="unit">%</span>
						</div>
						<span class="c-f55025" id="salesSetMark">（利润 = 实收金额  - 入库价格）</span>
					</div>
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-90">是否上架：</label>
					<select class="select w-140 f-l" name="sellFlag">
						<option value="1">确认上架</option>
						<option value="2">暂不上架</option>
					</select>
					<label class="f-l w-100">序号：</label>
					<input type="text" class="input-text w-140 f-l" name="sortNum" value ="1"/>
				</div>
			</div>
			<div class="f-l mb-10">
				<label class="f-l w-90">京东比价链接：</label>
				<input type="text" class="input-text w-380 f-l" value="${siteSelf.columns.jd_seller_link }" name="jdSellerLink"/>
			</div>
			<div class="f-l mb-10">
				<label class="f-l w-90">淘宝比价链接：</label>
				<input type="text" class="input-text w-380 f-l" value="${siteSelf.columns.tmall_seller_link }" name="tmallSellerLink"/>
			</div>
			<div class="pl-15 pr-15" style="height:210px;width:710px;overflow-x: hidden;overflow-y: auto;">
				 <script id="container" name="content" type="text/plain">
       				 
   				 	</script>
				 <textarea class="textarea h-50 hide" value="" id="html" name="html"></textarea>
			 </div>
		</div>
		</div>
		<div class="text-c btbWrap">
			<!-- <a type="text" value="保存" class="sfbtn sfbtn-opt3 w-70 mr-5" onclick="tijiao()"/> -->
			<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" onclick="tijiao()" >保存</a> 
			<a href="javascript:closeDiv();" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
		</div>
	</div>
	</form>
</div>

<script type="text/javascript">
	var showUnitTip = false;
	var unitOps;
	var count = 0 ;
	var ue;
	
	$(function(){
		
		//防止图片过宽
	  fixImgWidth();
		ue = UE.getEditor('container',{
			serverUrl:'${ctxPlugin}/lib/ueditor/1.4.3/jsp/controller.jsp',
			toolbars: [['bold', 'italic', 'underline', 'fontborder',  'forecolor', 'backcolor',
	                      'fontfamily', 'fontsize','justifyleft','justifycenter','justifyright','justifyjustify',  
	                      'simpleupload', 'insertimage', 'preview','fullscreen']],
	                      autoHeightEnabled: true,
	                      autoFloatEnabled: true,
                      elementPathEnabled : false,
                      initialFrameHeight: 150
		});
		ue.ready(function(){
			//ue.setContent('<p>顶顶顶顶</p><p style="text-align: center;"><img src="http://192.168.2.23:80/sfimggroup/M00/00/15/wKgCF1mT4pmAGyYbAAB_8JXQmeU610.jpg" alt="u=2677606714,1573372941&amp;fm=26&amp;gp=0.jpg" width="266" height="219" style="width: 266px; height: 219px;"/></p>');
			 // 阻止工具栏的点击向上冒泡
		    $(this.container).click(function(e){
		        e.stopPropagation();
		    });
		    // 解决悬浮问题
		    if (UE.browser.ie && UE.browser.version <= 7) {
	    		FixIe7Bug();
	    	}
		}) 
		
		
		createUploader1('.uploaderGG', '#spimg1', '', '', '');
		createUploader("#filePicker-add","#Imgprocess2","file_fake_addimg","file_fake_add","delimgs");
		//createUploader('#filePicker-mdd','#ImgprocessPJ','','','');
		$('.spAddsp').popup();
		unitOps = $('#punit').find("option").size();
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
	});
	
	$('input[name="deductType"]').each(function(){
		$(this).click(function(){
			if($(this).val()=='2'){//利润比例
				var nowThis = $(this);
				$.ajax({
					type:"post",
					url:"${ctx}/goods/siteself/ajaxGetSalesSet",
					success:function(data){
						var msg="（利润 = 实收金额 - 入库价格）";
						if(data!=null && data !=''){
							if(data.columns.set_value=="2"){
								msg="（利润 = 实收金额 - 工程师价格）";
							}
							if(data.columns.set_value=="3"){
								msg="（利润 = 实收金额 ）";
							}
						}
						$("#salesSetMark").text(msg);
						var isChecked = nowThis.attr('checked');
						if(isChecked){
							$('input[name="deductType"]').parent('label').removeClass('radiobox-selected');
							nowThis.parent().addClass('radiobox-selected');
							$('.tcbox').hide();
							var boxId = nowThis.attr('id').split('_')[0]+'_box';
							$('#'+boxId).show();
						}
					}
				})
			}else{
				var isChecked = $(this).attr('checked');
				if(isChecked){
					$('input[name="deductType"]').parent('label').removeClass('radiobox-selected');
					$(this).parent().addClass('radiobox-selected');
					$('.tcbox').hide();
					var boxId = $(this).attr('id').split('_')[0]+'_box';
					$('#'+boxId).show();
				}
			}
		});
	});
	
	//判断编号是否存在
	$("input[name='number']").blur(function(){
		var number=$("input[name='number']").val();
		if(isBlank(number)){
			layer.msg('商品编号不能为空！！！');
		}
	    $.ajax({
				type:"POST",
				url : "${ctx}/goods/siteself/isNull",
				data : {
					number:number
				},
				success : function(data) {
					 if(data=="fal"){
						 layer.msg('该编号已存在！！');
						 return;
					 }
				}
		});
	});
	
	function checkURL(URL){
		var str=URL;
		var Expression=/^http(s)?:\/\/([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?$/; 
		var objExp=new RegExp(Expression);
		if($.trim(URL)=='' || URL==null){
			return true;
		}
		if(objExp.test(str)==true){
		   return true;
		}else{
		   return false;
		}
	}
	
	var adpoting = false;
	function tijiao(){
	$("#html").val(ue.getContent());
		if(adpoting) {
		    return;
	    }
		var tmallSellerLink = $("input[name='tmallSellerLink']").val();
		var jdSellerLink = $("input[name='jdSellerLink']").val();
		var name=$("input[name='name']").val();
		var category=$("select[name='category']").val();
		var gstocks=$("input[name='gstocks']").val();
		var gsitePrice=$("input[name='gsitePrice']").val();
		var gcustomerPrice=$("input[name='gcustomerPrice']").val();
		var icon = $("input[name='icon']").val();
		var number = $("input[name='number']").val();
		var gemployePrice = $("input[name='gemployePrice']").val();
		var gnormalDeductAmount = $("input[name='gnormalDeductAmount']").val();
		var isDiscount = $("input[name='grebatePrice']").val();
		var sortNum = $("input[name='sortNum']").val();
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
		if(isBlank(gsitePrice)){
			layer.msg('请输入入库价格！！！');
			document.getElementById("gsitePrice").focus();
			return false;
		}else if(check(gsitePrice)==false){
			layer.msg('输入的入库价格的格式有误！！！');
			return false;
		}
		if(isBlank(gcustomerPrice)){
			layer.msg('请输入零售价格！！！');
			document.getElementById("gcustomerPrice").focus();
			return false;
		}else if(check(gcustomerPrice)==false){
			layer.msg('输入的零售价格格式有误！！！');
			return false;
		}
		if(isBlank(icon)){
			layer.msg('请上传商品图片！！！');
			return false;
		}
		if($.trim(gemployePrice)!="" && gemployePrice!=null && gemployePrice!=undefined){
			if(check(gemployePrice)==false){
				layer.msg('输入的工程师价格格式有误！！！');
				return false;
			}
		}
		
		if(isDiscount!=null && $.trim(isDiscount)!=""){
			if(check(isDiscount)==false){
				layer.msg('输入的折扣价格格式有误！！！');
				return false;
			}
		}
		if(gnormalDeductAmount!=null && $.trim(gnormalDeductAmount)!=""){
			if(check(gnormalDeductAmount)==false){
				layer.msg('输入的提成金额格式有误！！！');
				return false;
			}
		}
		if(sortNum!=null && $.trim(sortNum)!=""){
			if(upZero(sortNum)==false){
				layer.msg('输入的序号格式有误！！！');
				return false;
			}
		}
		if(!checkURL(jdSellerLink)){
			layer.msg("京东比价链接格式不正确，请重新输入！");
			$("input[name='jdSellerLink']").focus();
			return;
		}
		if(!checkURL(tmallSellerLink)){
			layer.msg("淘宝比价链接格式不正确，请重新输入！");
			$("input[name='tmallSellerLink']").focus();
			return;
		}
		adpoting = true;
		$.ajax({
			type:"post",
			traditional:true,
			url:"${ctx}/goods/siteself/doXZ",
			data:$("#tf").serializeJson(),
			success:function(result){
				if(result=="ok"){
					layer.msg("新增成功！");
					setTimeout(function(){
						window.parent.location.reload(true);
						$.closeDiv($(".spAddsp"));
					},500);
				}else if(result=="existNumber"){
					layer.msg("该编号已存在！！");
				}else if (result == "existPlatNumber") {
					layer.msg("该编号与平台合作商品的商品编号重复！");
					return;
				} else{
					layer.msg("新增失败，请检查！");
				}
			},
            complete: function() {
                adpoting = false;
            }
		})   
		
	}
	
	function check(number) { 
	    var re = /^\d+(?=\.{0,1}\d+$|$)/ 
        if (!re.test(number)) { 
           return false;
        } 
	    return true;
	} 
	
	function upZero(num){
		var reg = /^\+?[1-9]\d*$/;
		if(!reg.test(num)){
			return false;
		}
		return true;
	}
	
/* 	$("input[name='name']").blur(function(){
		var name=$("input[name='name']").val();
		if(isBlank(name)){
			layer.msg('商品名称不能为空！！！');
			return;
		}
	});
	
	 */

	function showTip() {
		if (!showUnitTip && unitOps == 0) {
			showUnitTip = true;
			$('body').popup({
				level: '3',
				type: 1,  // 提示操作成功
//			type:2,  // 提示是否进行某种操作
				content: '请在 “系统设置-计量单位” 中维护计量单位',
				fnConfirm: function () {
					showUnitTip = false;
					// 点击"确定"/“关闭”按钮进行的操纵
				},
				fnCancel: function () {
					// 点击"取消"按钮进行的操纵
					showUnitTip = false;
				}
			});
		}
	}
	
	function isBlank(val) {
			if (val == null || $.trim(val) == '' || val == undefined) {
				return true;
			}
			return false;
		}
	
	function createUploader1(picker, site, el, id, delimg){
	var thumbnailWidth = 130;   //缩略图高度和宽度 （单位是像素），当宽高度是0~1的时候，是按照百分比计算，具体可以看api文档  
	var thumbnailHeight = 130; 
	uploader = WebUploader.create({
	       // 选完文件后，是否自动上传。 
	       auto: true,  
	       swf: '${ctxPlugin}/lib/webuploader/0.1.5/Uploader.swf',  
	       server: '${ctx}/common/uploadFile',		       
	       duplicate:true,
	       fileSingleSizeLimit:1024*1024*5,
	       pick: picker,  
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
			       pick: picker,
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
				   }else if(type="Q_EXCEED_NUM_LIMIT "){
					   layer.msg("上传图片数超过限制");    
				   }
			   });
			   
			   uploader.on('beforeFileQueued', function(file){
				   uploader.reset();
			   });
			   uploader.on( 'uploadSuccess', function( file, response ) {
				
				//   $("#"+el).val(response.path);
				var reforeNode1 = document.getElementById("Imgprocess2");
			  // 	$("#Imgprocess1").insertBefore('<input type="hidden"  name="imgs" id="imgs'+file.id+'" value="'+response.path+'">',reforeNode1);
				if(count > 7){
					return false;
				}else{
					 $('<input type="hidden"  name="imgs" id="imgs'+file.id+'" value="'+response.path+'">').insertBefore($("#btn-img2"));
					 count = count + 1;
				}	
			  // $(site).append('<input type="hidden"  name="imgs" id="imgs'+file.id+'" value="'+response.path+'">');
					//$(".form-add-messenger").find('input[name="licenseImg"]').val(response.path);  
			  var ig = $("input [name='imgs']").val(); 
			   });
			   uploader.on( 'uploadError', function( file, reason ) {
					
			   }); 
			   
			   uploader.on( 'uploadProgress', function( file, percentage ) {
				});

			  
			   uploader.on( 'fileQueued', function( file ) {
				  
			   uploader.makeThumb( file, function( error, src ) {
				   if(count==7){
					   $("#btn-img2").addClass('hide');
				   }
				   if(count > 7){
					   layer.msg("上传图片数超过限制");
					   return false;
				   }
				 
				   if (error) {
					    layer.msg('不能预览');
				   } else {
					   img(id,src,file,site);
					   //dele(file);
					 //  $("#" + id).attr("src", src);
					//   $("#"+delimg).show();
					   //
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
			/* $(site).append(html); */
			/*  var reforeNode = document.getElementById("btn-img2");  */
			$(html).insertBefore($("#btn-img2"));
		}
	   
	   $('#spimg1').imgShow();
	   $('#Imgprocess2').imgShow();//非弹出框时需要hasIframe:true
		//防止图片过宽
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
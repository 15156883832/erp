<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>平台商品-新增</title>
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
.webuploader-pick{
	background:none;
	color:#22a0e6;	
	padding:0;
	
}
.spimg1{ border:none;}
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
<div class="popupBox newsp ptAddsp">
	<h2 class="popupHead">
		新增商品
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<form action="${ctx}/goods/platform/doXZ" method="post" id="tf">
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
					<a href="javascript:;" class="btn-uploadimg  ml-90 w-140 text-c" id="img-picker">上传图片</a>
					<p class="c-666 pl-80">建议上传图片大小：800*800</p>
					
					<!-- <div class="imgbox2 f-l pos-r">
						<img src="" alt="" id="img-view"/>
						<a href="javascript:;" class="btn-uploadimg uploanding1" ></a>
						<input class="ignoreSepcial" type="hidden" name="icon" id="img-input">
					</div>
					<div style="margin-left: 60%; margin-top: 40%; "  class="up" >
						<a href="javascript:;" class="btn-uploadimg" id="img-picker">上传图片</a>	
					</div>  -->
					<!-- <a class="btn-uploadimg uploanding1" id="img-picker">上传图片</a> -->
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-90"><em class="mark">*</em>商品编号：</label>
					<input type="text" class="input-text w-140 f-l" value="${number }" name="number"/>
					<label class="f-l w-100"><em class="mark">*</em>商品名称：</label>
					<input type="text" class="input-text w-140 f-l"  value="" name="name"/>
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-90">商品品牌：</label>
					<input type="text" maxlength="10" class="input-text w-140 f-l" value="" name="brand"/>
					<label class="f-l w-100">商品型号：</label>
					<input type="text" class="input-text w-140 f-l" value="" name="model"/>
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-90"><em class="mark">*</em>商品类别：</label>
					<select class="select w-140 f-l" name="category">
						<option value="">请选择</option>
					<c:forEach var ="cg" items="${categoryList}">
						<option value="${cg.columns.name }">${cg.columns.name }</option>
					</c:forEach>
					</select>
					<label class="f-l w-100">商品单位：</label>
					<input type="text" class="input-text w-140 f-l"  value="" name="unit"/>
				</div>
			    <div class="f-l mb-10">
					<label class="f-l w-90"><em class="mark">*</em>入库价格：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text" name="gplatformPrice"/>
						<span class="unit">元</span>
					</div>
					<label class="f-l w-100"><em class="mark">*</em>零售价格：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text" name="gsitePrice"/>
						<span class="unit">元</span>
					</div>
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-90"><em class="mark">*</em>分配方式：</label>
					<select class="select w-140 f-l" name="distributionType">
						<option value="">请选择</option>
						<option value="1">自动分配供应商</option>
						<option value="2" selected="selected">手动分配</option>
					</select>
					<label class="f-l w-100">排序：</label>
					<div class=" w-140 f-l">
						<input type="text" class="input-text" name="sortNum" value="1"/>
					</div>
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-90"><em class="mark">*</em>非会员价：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text" name="noVipPrice"/>
						<span class="unit">元</span>
					</div>
					<label class="f-l w-100">保修期限：</label>
					<input type="text" class="input-text w-140" maxlength="10" id="repairTerm" name="repairTerm"/>
				</div>
			</div>
			<div class="txtwrap mb-10 w-710">
				<label class="lb w-90">商品描述：</label>
				<textarea class="textarea h-50" name="description"></textarea>
			</div>
			<!-- <div class="mt-10 txtwrap">
               <label class="lb w-90">其它图片：</label>
               <div class="cl">

                   <div class="f-l mr-10 " id="Imgprocess2">
                       <div class="imgWrap f-l w-110" id="btn-img2">
                           <div id="filePicker-add">
                               <a href="javascript:;" class="btn-upload"></a>
                           </div>
                           <span>最多可添加8张图片</span>
                       </div>
                   </div>
               </div>
           </div> -->
			<div class="pl-15 pr-15" style="height:210px;width:710px;overflow-x: hidden;overflow-y: auto;">
				 <script id="container" name="content" type="text/plain">
       				 
   				 	</script>
				 <textarea class="textarea h-50 hide" value="" id="html" name="html"></textarea>
			 </div>
		</div>
		</div>
		<div class="text-c btbWrap">
			<input type="button" value="保存" class="sfbtn sfbtn-opt3 w-70 mr-5" onclick="tijiao()"/>
			<!-- <a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" id="Butfitting">保存</a> -->
			<a href="javascript:closeDiv();" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
		</div>
	</div>
	</form>
</div>

<script type="text/javascript">
	var count=0;
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
		createUploader("#filePicker-add","#Imgprocess2","file_fake_addimg","file_fake_add","delimgs");
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
		  
		   uploader.on( 'fileQueued', function( file ) {
			   uploader.makeThumb( file, function( error, src ) {
				   if (error) {
					    layer.msg('不能预览');
				   }
			}, thumbnailWidth, thumbnailHeight );
		});
	});
	function closeDiv(){
		 $.closeDiv($(".ptAddsp"));
	}
	 
	//判断编号是否存在
	$("input[name='number']").blur(function(){
		var number=$("input[name='number']").val();
		if(isBlank(number)){
			layer.msg('商品编号不能为空！！！');
		}
	    $.ajax({
				type:"POST",
				url : "${ctx}/goods/platform/isNull",
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
	})
	var adpoting = false;
 	function tijiao(){
 		$("#html").val(ue.getContent());
 		//$("#allHtml").val(ue.getAllHtml());
 		if(adpoting) {
		    return;
	    }
		var number=$("input[name='number']").val();
		var name=$("input[name='name']").val();
		var icon=$("input[name='icon']").val();
		var category=$("select[name='category']").val();
		var gsitePrice=$("input[name='gsitePrice']").val();//零售价格
		var gplatformPrice=$("input[name='gplatformPrice']").val();//入库价格  
		var noVipPrice=$("input[name='noVipPrice']").val();
		var distributionType = $("select[name='distributionType']");//分配方式
		var sortNum = $("input[name='sortNum']");//排序
		var repairTerm = $("input[name='repairTerm']").val();
		if(isBlank(number)){
			layer.msg('商品名称不能为空！！！');
			return false;
		}
		if(isBlank(name)){
			layer.msg('商品名称不能为空！！！');
			return false;
		}
		if(isBlank(icon)){
			layer.msg('商品图片不能为空！！！');
			return false;
		}
		if(isBlank(category)){
			layer.msg('商品类别不能为空！！！');
			return false;
		}
		if(isBlank(gsitePrice)){
			layer.msg('请输入零售价格！！！');
			return false;
		}else if(check(gsitePrice)){
			layer.msg('输入的零售价格格式有误！！！');
			return false;
		}
		if(isBlank(noVipPrice)){
			layer.msg('请输入非会员价！！！');
			return false;
		}else if(check(noVipPrice)){
			layer.msg('输入的非会员价格式有误！！！');
			return false;
		}
		if(isBlank(gplatformPrice)){
			layer.msg('请输入入库价格！！！');
			return false;
		}else if(check(gplatformPrice)){
			layer.msg('输入的入库价格格式有误！！！');
			return false;
		}
		if(isBlank(distributionType)){
			layer.msg('请选择分配方式！！！');
			return false;
		}
		if(sortNum!=null && $.trim(sortNum)!=""){
			if(upZero(sortNum)){
				layer.msg('输入的排序格格式有误！！！');
				return false;
			}
		}
		/* var reg = /^\+?[0-9]\d*$/;
		if(!isBlank(repairTerm)){
			if(!reg.test(repairTerm)){
				layer.msg("保修期限输入格式有误，请重新输入！");
				$("input[name='repairTerm']").focus();
				return;
			}
		} */
		adpoting = true;
		$.ajax({
			type:"post",
			traditional:true,
			url:"${ctx}/goods/platform/doXZ",
			data:$("#tf").serializeJson(),
			success:function(result){
				if(result==true){
					layer.msg("新增成功！");
					setTimeout(function(){
						window.parent.location.reload(true);
						$.closeDiv($(".ptAddsp"));
					},500);
				}else{
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
        if (re.test(number)) {
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
	
	$("input[name='name']").blur(function(){
		var name=$("input[name='name']").val();
		if(isBlank(name)){
			layer.msg('商品名称不能为空！！！');
		}
	})
	
	$("input[name='category']").blur(function(){
		var category=$("input[name='category']").val();
		if(isBlank(category)){
			layer.msg('商品类别不能为空！！！');
		}
	})
	 
	$("input[name='gsitePrice']").blur(function(){
		var gsitePrice=$("input[name='gsitePrice']").val();
		if(isBlank(gsitePrice)){
			layer.msg('请输入入库价格！！！');
		}
	})
	$("input[name='gplatformPrice']").blur(function(){
		var gcustomerPrice=$("input[name='gplatformPrice']").val();
		if(isBlank(gcustomerPrice)){
			layer.msg('请输入零售价格！！！');
		}
	})
	
	function isBlank(val) {
			if (val == null || $.trim(val) == '' || val == undefined) {
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
					   layer.msg("文件大小不能超过5M"); }
			   });
			   
			   uploader.on('beforeFileQueued', function(file){
				   uploader.reset();
			   });
			   
			   uploader.on( 'uploadSuccess', function( file, response ) {
					
					var reforeNode1 = document.getElementById("Imgprocess2");
						$('<input type="hidden"  name="imgs" id="imgs'+file.id+'" value="'+response.path+'">').insertBefore($("#btn-img2"));
						 count = count + 1;
				  var ig = $("input [name='imgs']").val(); 
				   });
			   
			   uploader.on( 'uploadError', function( file, reason ) {
					
			   }); 
			  
			   uploader.on( 'fileQueued', function( file ) {
				   
			   uploader.makeThumb( file, function( error, src ) {
				   if (error) {
					    alert('不能预览');
				   } else {
					   img(id,src,file,site);
					  
					   //dele(file);
				   }
			}, thumbnailWidth, thumbnailHeight );
			});   
			   
		}
	   
	   function dele(obj,fileId){
			$(obj).parent('.imgWrap1').remove();
			$("#file"+fileId+"").remove();
			$("#imgs"+fileId).remove();
			count=count-1;
      		return ;
		}
	   
	   function img(id,src,file,site){
				var html =' <div class="f-l imgWrap1 mb-10" id="file'+file.id+'"><div class="imgWrap"> ';
				html +='<img src="'+src+'" id=""></img></div><a class="sficon btn-delimg" onclick="dele(this,\''+file.id+'\')"></a></div>'; 
				$(html).insertBefore($("#btn-img2"));

		}
	   
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
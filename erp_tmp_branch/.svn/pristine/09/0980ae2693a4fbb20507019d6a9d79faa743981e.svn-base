
<!DOCTYPE HTML>
<html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<head>
<meta name="decorator" content="base"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>

<title>系统设置-家电品牌设置</title>
</head>

<body>

<!-- 添加 -->
<div class="popupBox jdBrand" style="z-index:101;">
	<h2 class="popupHead">
		添加
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<div class="popupMain">
			<div class="pcontent">
				<div class="cl">
					<div class="f-r mb-10 mr-40">
					
						<label class="w-100 f-l"> 图标：</label>
						<div>
						<div class="imgbox2 f-l pos-r"  id="ImgprocessPJ">
		
                              
						</div>
						
					</div>
	</div>
					
					<div class="f-l mb-10">
						<label class="f-l w-90"><em class="mark">*</em>品牌名称：</label>
						<input type="text" class="input-text w-140 f-l labelname" />
					</div>
					<div class="f-l mb-10">
						<label class="f-l w-90"><em class="mark">*</em>品牌厂商：</label>
						<input type="text" class="input-text w-140 f-l labelvendor" />
					</div>
					<div class="f-l mb-10">
						<label class="f-l w-90"><em class="mark">*</em>首字母：</label>
						<input type="text" class="input-text w-140 f-l labelletter" />
					</div>
					<div class="f-l mb-15">
						<label class="f-l w-90">排序：</label>
						<input type="text" class="input-text w-140 f-l labelsort" />
					</div>
				</div>
		<div style="margin-left: 70%">
		 		<p class="bg-reload"></p>
								<a href="javascript:;" class="btn-reload">选择图片上传</a>
		</div>
			
<!-- 			
				<div class="txtwrap pos-r "  id="brandsBox" >
					<label class="w-90 lb"><em class="mark">*</em>所属品类：</label>
					<div class="">
						<label class="f-l mr-15 mb-10 serveb-label" for="servebrand1">
							<input type="checkbox" name="servebrand" id="servebrand1" value="1"/>空调
						</label>
							<label class="f-l mr-15 mb-10 serveb-label" for="servebrand2">
							<input type="checkbox" name="servebrand" id="servebrand2" value="2" />冰箱
						</label>
							<label class="f-l mr-15 mb-10 serveb-label" for="servebrand3">
							<input type="checkbox" name="servebrand" id="servebrand3" value="3" />热水器
						</label>
							<label class="f-l mr-15 mb-10 serveb-label" for="servebrand4">
							<input type="checkbox" name="servebrand" id="servebrand4" value="5"/>油烟机
						</label>
							<label class="f-l mr-15 mb-10 serveb-label" for="servebrand5">
							<input type="checkbox" name="servebrand" id="servebrand5" value="6"/>洗衣机
						</label>
							<label class="f-l mr-15 mb-10 serveb-label" for="servebrand6">
							<input type="checkbox" name="servebrand" id="servebrand6" value="9"/>小家电
						</label>
							<label class="f-l mr-15 mb-10 serveb-label" for="servebrand7">
							<input type="checkbox" name="servebrand" id="servebrand7" value="10"/>吸尘器
						</label>
	
					</div>
				</div> -->
			</div>	
			<div class="text-c mt-20">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" id="btnSubmit">保存</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="closed()">取消</a>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
<script type="text/javascript">
	
	
	$(function(){
		$('.jdBrand').popup();
		selectServeBrand();
		$("#btnSubmit").click(function(){
			var img=$(".imgs").val();
		/* var categorylist =[]; */
		var letter=$(".labelletter").val();
		var names=$(".labelname").val();
		var vendor=$(".labelvendor").val();
		var sorts=$(".labelsort").val();

	
	/* 	$('input[name="servebrand"]:checked').each(function(){
			categorylist.push($(this).val());
		}); */
		 if(names.length==0){
			 layer.msg("请填写品牌名称");
			 return;
		 }
		if(letter.length==0){
			layer.msg("请填写首字母");
			return;
		}
	 	if((!letter.match(/[A-Z]/))||(letter.length!=1)){
			layer.msg("首字母请输入一个大写字母");
			return;
		} 
		if(vendor.length==0){
			layer.msg("请填写厂商");
			return;
		}
		

		
		if((sorts.length!=0)&&(sorts.match(/\D/)||sorts==0)){
			layer.msg("排序请输入0以外正整数");
			return;
		}

			$.ajax({
				type:'POST',
				url:'${ctx}/order/brandsettle/queryBrandById',//判断是否重名
				traditional: true,
				data:{"names":names},
				dataType:'json',
				async:false,
				success:function(result){
				if(result.flag){
					$.ajax({
						type:'POST',
						url:"${ctx}/order/brandsettle/addBrand",//添加
						traditional: true,
						data:{
							"names":names,
						    "sorts":sorts,
						    //"categorylist":categorylist,
						    "vendor":vendor,
						    "first_letter":letter,
						    "img":img
						   
						},
						success:function(data){
							layer.msg("添加成功");
							parent.location.reload(); 
							$.closeDiv($(".jdBrand"));
					   // window.location.href="${ctx}/order/brandsettle";
						//window.location.reload(true);
						}
					
					});
				}else{
			layer.msg("品牌已存在");
					return;
				} 
				return;
				}
			}); 

		});
		});
		function closed(){
			$.closeDiv($('.jdBrand'));
		}
		
	$(function(){//上传图片
	 		createUploader(".btn-reload","#ImgprocessPJ","file_fake_addimg","file_fake_add","delpickerImg"); 
			/* createUploader('.btn-reload','#ImgprocessPJ','','',''); */
		}); 
		function createUploader(picker,site, el,id,delimg) {
			var thumbnailWidth = 130;   //缩略图高度和宽度 （单位是像素），当宽高度是0~1的时候，是按照百分比计算，具体可以看api文档
			var thumbnailHeight = 130; 
			uploader = WebUploader.create({
			       // 选完文件后，是否自动上传。 
			       auto: true,  
			       swf: '${ctxPlugin}/lib/webuploader/0.1.5/Uploader.swf',  
			       server: '${ctx}/crm/common/uploadFile',
			       
			       duplicate:true,
			       
			       fileSingleSizeLimit:1024*1024*5,
			       pick: picker,  
			       accept: {  
			    	    title: 'Images',
			    	    extensions: 'gif,jpg,jpeg,bmp,png',
			    	    mimeTypes: 'image/*'
			       },  
			       method:'POST'
			   }); 
			   uploader.on("error",function (type){
			   if (type=="Q_TYPE_DENIED"){ 
				   layer.alert("请上传JPG、PNG格式文件");
				   }else if(type=="F_EXCEED_SIZE"){
					   layer.alert("文件大小不能超过5M"); }
			   });
			   
			   uploader.on('beforeFileQueued', function(file){
				   uploader.reset();
			   });
			   uploader.on( 'uploadSuccess', function( file, response ) {
				//   $("#"+el).val(response.path);
				   $(site).append('<input type="hidden" class="imgs"  name="pickerImg" id="pickerImg'+file.id+'" value="'+response.path+'">');
					//$(".form-add-messenger").find('input[name="licenseImg"]').val(response.path);  
			   });
			   uploader.on( 'uploadError', function( file, reason ) {
					
			   }); 
			  
			   uploader.on( 'fileQueued', function( file ) {
			   uploader.makeThumb( file, function( error, src ) {
				   if (error) {
					    alert('不能预览');
				   } else {
					    img(id,src,file,site); 
					   dele(file);
					 //  $("#" + id).attr("src", src);
					//   $("#"+delimg).show();
					   //
				   }
			}, thumbnailWidth, thumbnailHeight );
			//   uploader.upload();  
			});   
			   
		}
		function dele(file){ 
			 $(".btn-delimg").on("click",  function() {
				$(this).parent('.imgWrap1').remove();
				 uploader.removeFile( file ,true);
				 $("#pickerImg"+file.id).remove();
	         return ;
			   })
		}

		
	 	function img(id,src,file,site){
			var html =' <div class="f-l imgWrap1" id="file'+file.id+'"><div class="imgWrap"> ';
			html +='<img src="'+src+'" id=""></img></div><a class="sficon btn-delimg"></a></div>'; 
			$(site).html(html);

		} 
		
 
		function delOrigin(obj){
			var oParent = $('#originbox');
			$(obj).parent('div').remove();
			var childLenth = oParent.children().size();
			oParent.children().eq(childLenth-1).find('a.sficon-add2').show();
			
			if( childLenth == 1){
				oParent.children().eq(0).find('a.sficon-reduce2').hide();
			}
			$.setPos($('.addOrigin'));	
		}
	
		
	function selectServeBrand(){
		var brands = $('#brandsBox input[name="servebrand"]');
		brands.each(function(){
			$(this).bind('click',function(){
				if($(this).is(':checked')){
					$(this).parent('label').addClass('serveb-labelSel');
				}else{
					$(this).parent('label').removeClass('serveb-labelSel');
				}
			});
		});
	}


</script> 
</body>
</html>
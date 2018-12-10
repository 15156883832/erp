<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8" />
<meta name="decorator" content="base"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/skin/default/skin.css" id="skin" />


<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/sfskin_blue.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/styleGoods.css" />
<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script> 
<script type="text/javascript" src="${ctxPlugin}/lib/laypage/1.2/laypage.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>

<script type="text/javascript" src="${ctxPlugin}/lib/ueditor/1.4.3/ueditor.config.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/ueditor/1.4.3/ueditor.all.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/ueditor/1.4.3/lang/zh-cn/zh-cn.js"></script>
<title>新增商品</title>
</head>
<body >
	<div class="sfpagebg bk-gray pt-25 pl-25 pr-25 pb-80">
	<form id="tf" action="${ctx}/goods/platform/doXZ" method="post">
		<div class="">
			<div class="cl mb-15">
				<label class="lb w-100 text-r f-l"><em class="mark">*</em>商品名称：</label>
				<input type="text " class="input-text f-l w-460 mustfill" value="" id="name" name="name" />
			</div>
			<div class="cl mb-15 ">
				<label class="lb w-100 text-r f-l"><em class="mark">*</em>商品图片：</label>
				<div class="f-l">
					<div class="imgWrap1 f-l  mr-15" id="Imgprocess">
						<div class="imgWrap " id="imgsAdd">
							<a class="btn-upload bk_dashed"></a>
						</div>
					</div>
					
				</div>
				<input type="hidden" name="icon" value=""/>
				<span class="c-888 f-12 ml-10 mt-50 pt-10">建议主图上传图片大小：800*800px，最多5张</span>
			</div>
		
			<div class="bg-e8f2fa mb-15"><strong class="w-100 text-r lh-30 f-13">基本信息：</strong></div>
			<div class="cl mb-10">
				<label class="w-180 f-l"><em class="mark">*</em> 商品编号：</label>
				<input type="text" class="f-l input-text w-300 mustfill" placeholder="自动生成支持手动输入" value="${number }" maxlength="20" id="number" name="number" />
				<label class="w-120 f-l">商品品牌：</label>
				<input type="text" class="f-l input-text w-300" maxlength="10" name="brand" />
			</div>
			<div class="cl mb-10">
				<label class="w-180 f-l"><em class="mark">*</em>商品类别：</label>
				<select class="select f-l w-300" id="category" name="category">
					<option value="">--请选择--</option>
					<c:forEach var ="cg" items="${categoryList}">
						<option value="${cg.columns.name }">${cg.columns.name }</option>
					</c:forEach>
				</select>
				<label class="w-120 f-l">商品型号：</label>
				<input type="text" class="f-l input-text w-300" maxlength="100" name="model" />
			</div>
			<div class="cl mb-10">
				<label class="w-180 f-l">保修期限：</label>
				<input type="text" class="f-l input-text w-300"  id="repairTerm" maxlength="10" name="repairTerm" />

				<label class="f-l w-120"><em class="mark">*</em>分配方式：</label>
				<select class="select w-300 f-l" name="distributionType">
					<option value="">请选择</option>
					<option value="1">自动分配供应商</option>
					<option value="2" selected="selected">手动分配</option>
				</select>
			</div>
			<div class="cl mb-10">
				<label class="w-180 f-l">商品单位：</label>
				<input type="text" class="input-text w-300 f-l"  value="" name="unit"/>
				<label class="w-120 f-l">排序：</label>
				<input type="text" class="f-l input-text w-300" name="sortNum" value ="1"  />
			</div>
			<div class="cl mb-10">
				<label class="w-180 f-l">商品描述：</label>
				<textarea class="textarea f-l" style="width: 720px" name="description"></textarea>
			</div>
			
			<div class="bg-e8f2fa mb-15"><strong class="w-100 text-r lh-30 f-13">价格信息：</strong></div>
			<div class="cl mb-15">
				<label class="w-180 f-l"><em class="mark">*</em>入库价格：</label>
				<div class="priceWrap f-l w-300 mustfill">
					<input type="text" class="input-text"  id="gsitePrice" name="gplatformPrice" datatype="*" errormsg="格式错误" nullmsg="入库价格" />
					<span class="unit">元</span>
				</div>
				<label class="w-120 f-l"><em class="mark">*</em>VIP会员价：</label>
				<div class="priceWrap f-l w-300 mustfill">
					<input type="text" class="input-text" value=""  name="gsitePrice"/>
					<span class="unit">元</span>
				</div>
			</div>
			<div class="cl mb-15">
				<label class="w-180 f-l"><em class="mark">*</em>非会员价：</label>
				<div class="priceWrap f-l w-300 mustfill">
					<input type="text" class="input-text" value=""  name="noVipPrice"/>
					<span class="unit">元</span>
				</div>
				<label class="w-120 f-l"><em class="mark">*</em>零售价：</label>
				<div class="priceWrap f-l w-300 mustfill">
					<input type="text" class="input-text" value=""  name="advicePrice"/>
					<span class="unit">元</span>
				</div>
			</div>
			<div class="cl mb-10">
				<label class="w-180 f-l">京东比较链接：</label>
				<input type="text" class="f-l input-text w-300" value="${siteSelf.columns.jd_seller_link }" name="jdSellerLink" />
				<label class="w-120 f-l">淘宝比较链接：</label>
				<input type="text" class="f-l input-text w-300" value="${siteSelf.columns.tmall_seller_link }" name="tmallSellerLink" />
			</div>
			
			<div class="bg-e8f2fa mb-15"><strong class="w-100 text-r lh-30 f-13">商品介绍：</strong></div>
			<div class="" style="margin: 0 auto; width: 1000px;">
				<div class="">
					<!-- 编辑器 -->
					<script id="container" name="content" type="text/plain">
       				 
   					</script>
					<textarea class="textarea h-50 hide" value="" id="html" name="html"></textarea>
				</div>
			</div>
		</div>
	</form>
	<div class="btnsWrapFixbBg bgOpacity"></div>
	<div class="btnsWrapFixb pt-15 text-c">
		<a class="btnBlue pt-10 pb-10 lh-26 f-16 w-180 c-white radius mr-10" onclick="tijiao()" >保存</a>
		<a class="bg-eee pt-10 pb-10 lh-26 f-16 w-180 radius " onclick="closeDiv()" >取消</a>
	</div>
</div>	

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${ctxPlugin}/lib/datatables/1.10.0/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="${ctxPlugin}/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript">
var feedImgsCount = 0;

	$(function(){
		
		//防止图片过宽
		  fixImgWidth();
			ue = UE.getEditor('container',{
				serverUrl:'${ctxPlugin}/lib/ueditor/1.4.3/jsp/controller.jsp',
				toolbars: [['bold', 'italic', 'underline', 'fontborder',  'forecolor', 'backcolor',
		                      'fontfamily', 'fontsize','justifyleft','justifycenter','justifyright','justifyjustify',  
		                      'simpleupload', 'insertimage', 'preview','fullscreen']],
		                      autoHeightEnabled: true,
		                      autoFloatEnabled: false,
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
			
			createUploader("#imgsAdd","#Imgprocess","file_fake_addimg","file_fake_add","delimgs");
		
		$('#btn_discount').on('click', function(){
			var isOn = $(this).hasClass('label-cbox4-selected');
			if( !isOn ){
				$(this).addClass('label-cbox4-selected');
				$(this).find('input').val('1');
				$('#discountWrap').removeClass('readonly');
				$('#discountWrap').find('input').removeClass('readonly').removeAttr('readonly');
			}else{
				$(this).removeClass('label-cbox4-selected');
				$(this).find('input').val('0');
				$("input[name='grebatePrice']").val('');
				$('#discountWrap').addClass('readonly');
				$('#discountWrap').find('input').addClass('readonly').attr({'readonly':'readonly'});
			}
		})
		
		$('.radiobox').on('click', function(){
			var isOn = $(this).hasClass('radiobox-selected');
			var nowThis = $(this).find("input").val();
			if( !isOn ){
				$(this).closest('div').find('.radiobox').removeClass('radiobox-selected');
				$(this).closest('div').find('input[type="radio"]').prop({'checked':'false'});
				$('#tcWrap').find('.tcbox').hide();
				$(this).addClass('radiobox-selected');
				$(this).find('input[type="radio"]').prop({'checked':'true'});
				if(nowThis=='2'){
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
						}
					});
				}
				$('#tcWrap').find('.tcbox').eq($(this).index()).show();
			}
		})
		
	})

var adpoting = false;
function tijiao(){
    $("#html").val(ue.getContent());
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
    var distributionType = $("select[name='distributionType']").val();//分配方式
    var sortNum = $("input[name='sortNum']").val();//排序
    var repairTerm = $("input[name='repairTerm']").val();
    if(isBlank(number)){
        layer.msg('商品名称不能为空！！！');
    }else if(isBlank(name)){
        layer.msg('商品名称不能为空！！！');
    }else if(isBlank(icon)){
        layer.msg('商品图片不能为空！！！');
    }else if(isBlank(category)){
        layer.msg('商品类别不能为空！！！');
    }else if(isBlank(gsitePrice)){
        layer.msg('请输入零售价格！！！');
    }else if(check(gsitePrice)){
        layer.msg('输入的零售价格格式有误！！！');
    }else if(isBlank(noVipPrice)){
        layer.msg('请输入非会员价！！！');
    }else if(check(noVipPrice)){
        layer.msg('输入的非会员价格式有误！！！');
    }else if(isBlank(gplatformPrice)){
        layer.msg('请输入入库价格！！！');
    }else if(check(gplatformPrice)){
        layer.msg('输入的入库价格格式有误！！！');
    }else if(isBlank(distributionType)){
        layer.msg('请选择分配方式！！！');
    }else if(sortNum!=null && $.trim(sortNum)!="" && !upZero(sortNum)){
		layer.msg('输入的排序格式有误！！！');
    }else{
        adpoting = true;
        $.ajax({
            type:"post",
            traditional:true,
            url:"${ctx}/goods/platform/doXZ",
            data:$("#tf").serializeJson(),
            success:function(result){
                if(result==true){
                    parent.layer.msg("新增成功！");
                    var href="${ctx}/goods/platform/WholePlatHeader";
                    var navHref = "${ctx}/goods/platform/showXZ"
                    var navIndex = $(window.top.document).find('#min_title_list li').find('span[data-href="'+ navHref +'"]').index();
                    var iframeIndex = $(window.top.document).find('#min_title_list li').find('span[data-href="'+ href +'"]').index();

                    $(window.top.document).find('#min_title_list li.active').remove();
                    $(window.top.document).find('#iframe_box .show_iframe').eq(navIndex).remove();
                    $(window.top.document).find('#iframe_box .show_iframe').eq(iframeIndex).find('iframe').attr({'src':href}).show();
                }else{
                    layer.msg("新增失败，请检查！");
                }
            },
            complete: function() {
                adpoting = false;
            }
        })
    }
}

function closeDiv(){
    $.closeDiv($(".ptAddsp"));
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
	
	function isBlank(val) {
		if (val == null || $.trim(val) == '' || val == undefined) {
			return true;
		}
		return false;
	}
	
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
		   });
		   uploader.on( 'uploadSuccess', function( file, response ) {
		       $("input[name='markAble']").each(function(index,items){
					if(items.value==file.id){
						$(site).append('<input type="hidden"  name="pickerImg" id="pickerImg'+file.id+'" value="'+response.path+'">');
					}
				})
		   });
		   uploader.on( 'uploadError', function( file, reason ) {
				
		   }); 
		   uploader.on( 'uploadFinished', function() {
			   var path="";
		       var icons=$("input[name='pickerImg']")
               for(var i=0;i<icons.length;i++) {
                   path += $(icons[i]).val() + ",";
               }
			   $("input[name='icon']").val(path);
				if(uploader){
					uploader.reset();
				}
		   });
		  
		   uploader.on( 'fileQueued', function( file ) {
			  if(feedImgsCount==7){
				  $("#imgsAdd").hide();
			   }
			   if(parseInt(feedImgsCount) > 7 ){
				   layer.msg("最多可上传5张图片！");
				   return false;
			   } 
		   uploader.makeThumb( file, function( error, src ) {
			   if (error) {
				    layer.msg('不能预览');
			   } else {
				   img(id,src,file,site);
			   }
		}, thumbnailWidth, thumbnailHeight );
		});   
		   
	}
	
	function delx(obj,fileId) {
		$("#file"+fileId+"").remove();
		$(obj).parent('.imgWrap1').remove();
		$("#pickerImg"+fileId).remove();
		feedImgsCount = parseInt(feedImgsCount)-1;
		if(feedImgsCount<=4){
			$("#imgsAdd").show();
		} 
    	return ;
	} 

	
	function img(id,src,file,site){
		if(feedImgsCount > 4){
			$("#imgsAdd").hide();
			layer.msg("最多可上传5张图片！");
			return false;
		}
		feedImgsCount=parseInt(feedImgsCount)+1;  
		var html =' <div class="f-l imgWrap1 mr-15" id="file'+file.id+'"><div class="imgWrap"> ';
		html +='<img src="'+src+'" id="" class="img"></div><a class="sficon btn-delimg" onclick="delx(this, \''+file.id+'\')"></a></div>'+
				'<input name="markAble" id="mark'+file.id+'" hidden="hidden" value="'+file.id+'" />';
		$(site).append(html);
		if(feedImgsCount>=5){
			$("#imgsAdd").hide();
		}
	}
	
	function deleteImg(ff) {
		$("#" + ff).remove();
		feedImgsCount = feedImgsCount - 1;
		if (feedImgsCount == 4) {
			$("#imgsAdd").removeClass('hide');
		} 
		if (uploader) {
			uploader = null;
		}
		createUploader("#imgsAdd", "#Imgprocess", "file_fake_addimg","file_fake_add", "delimgs");
	}
	
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
	
	   function updateOrCreate(name,href){

		     var bStop = false;
		     var bStopIndex = 1;
		     var show_navLi = $('#min_title_list li',window.top.document);
		     show_navLi.each(function () {
		         $(this).removeClass('active');
		         if ($(this).find('span').text() ==$.trim(name)) {
		             bStopIndex = show_navLi.index($(this));
		             bStop = true;
		         }
		     });
		     if (!bStop) {
		         creatIframe(href, name);
		     } else {
		         show_navLi.eq(bStopIndex).addClass('active');
		         $('#iframe_box .show_iframe',window.top.document).hide().eq(bStopIndex).find('iframe').remove()

				 $('#iframe_box .show_iframe',window.top.document).eq(bStopIndex).append('<iframe scrolling="yes" frameborder="0" src="'+ href +'" title="'+ name+'" allowtransparency="yes"></iframe>').show();
		     }
		 }
	   
	   function quxiao(){
		   removeIframe();
	   }
</script> 
</body>
</html>
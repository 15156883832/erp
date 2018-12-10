<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="decorator" content="base" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select2.min.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select2.full.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/lodop/LodopFuncs.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/lodop/base64.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/lodop/printdesign.js"></script>

<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
<style type="text/css">
.webuploader-pick{
	background:none;
	width:640px;
	height:40px;
	color:#fff;
	overflow:visible;
}
#ImgprocessPJ1{
	width:640px;
	height:246px;
	text-align:center;
	line-height:246px;
}
#ImgprocessPJ1 img{
	max-width:640px;
	max-height:246px;
}
</style>

<!--[if IE 6]>
<script type="text/javascript" src="lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<title>运营管理-公司资料</title>
</head>
<body>
	<div class="sfpagebg bk-gray">
		<div class="sfpage printModule">
		<div class="page-orderWait">
			<div class="tabBar cl mb-20">
			 	<sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_SERVICECATE_TAB" html='<a class="btn-tabBar " href="${ctx}/order/category/headerList">服务品类</a> '></sfTags:pagePermission>
		<sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_SERVICEBRAND_TAB" html='<a class="btn-tabBar" href="${ctx}/order/category/siteBrandRelList">服务品牌</a> '></sfTags:pagePermission>
		<sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_MSGORIGIN_TAB" html='<a class="btn-tabBar" href="${ctx}/order/orderOrigin">信息来源</a> '></sfTags:pagePermission>
	<%-- 	<sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_MALTIONTYPE_TAB" html='<a class="btn-tabBar" href="${ctx}/order/malfunction">故障类型</a>'></sfTags:pagePermission>  --%>
			<a class="btn-tabBar current" href="${ctx}/order/printdesign">工单打印模板</a>
			<a class="btn-tabBar" href="${ctx}/order/orderMustFill/getMustFillInfo">工单必填项</a>
			<a class="btn-tabBar " href="${ctx}/order/township">乡镇设置</a>
			<sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_MSGMALL_TAB" html='<a class="btn-tabBar " href="${ctx}/order/orderMall">购机商场</a>'></sfTags:pagePermission>
			 <%-- <a class="btn-tabBar " href="${ctx}/order/siteSuperviseSetting">监督内容</a> --%>
			<a class="btn-tabBar " href="${ctx}/order/serviceType">服务类型</a>
			<a class="btn-tabBar " href="${ctx}/order/serviceMode">服务方式</a> 
			<a class="btn-tabBar " href="${ctx}/order/customerType">用户类型</a>
			</div>
				<h3 class="modelHead mb-10 ml-10">选择打印模板</h3>
			<div class="ml-10">
				<p class="mb-10"></p>
				<div class="mb-20" id="radioWrap">
				<c:choose>
				<c:when test="${rds.columns.state eq '1' }">
				<span class="radiobox"><input id="psize" type="radio" value="0" name="state" >使用系统自带</span>
				<span class="radiobox ml-20  radiobox-selected"><input id="psize" type="radio" value="1" name="state" >使用自定义</span>
				</c:when>
				<c:otherwise>
				<span class="radiobox radiobox-selected"><input id="psize" type="radio" value="0" name="state" >使用系统自带</span>
				<span class="radiobox ml-20"><input id="psize" type="radio" value="1" name="state" >使用自定义</span>
				</c:otherwise>
				</c:choose>
			</div>
			<h3 class="modelHead ml-10 mb-10">上传模板图片</h3>	
			<div class="ml-10 mb-30 modulePicWrap pos-r" >
				<div id="ImgprocessPJ1">
					<img alt="" src="${commonStaticImgPath}${rds.columns.imgurl }" id="imgpic">
				</div>
				<!-- <a class="btn_upModule"></a> -->
				<p class="modulePicWrap_lb" >上传图片模板</p>
			</div>
			<input type="hidden" name="imgurl" value="${rds.columns.imgurl }" id="img-input">
			<input type="hidden" name="id" value="${rds.columns.id }" id="prin_id">
			<h3 class="modelHead mb-10 ml-10">设置模板</h3>
			<div class="ml-10">
			
				<p class="mb-10">关联数据及预览模板  &nbsp;&nbsp;(<font color='#e92617'>如果本地未安装，点击这里<a href='http://www.lodop.net/download/Lodop6.224_Clodop3.056.zip' target='_self' class="c-0383dc underline">执行安装</a>,安装后请刷新页面。</font>)</p>
				<a class="sfbtn sfbtn-opt" onclick="templateSetting()">点击设置模板</a>						  
				<p class="mb-10" id="msg"></p>
				<p class="moduleCodeData mt-20">
						<textarea rows="12" id="content" readonly="readonly" cols="107" >${rds.columns.content }</textarea>
				</p>
			</div>
			
			
			<div class="text-c mt-25">
				<a class="sfbtn sfbtn-opt3 w-100" id="btn-save">保存</a>
			</div>
		
		</div>
		
		</div>
	</div>


<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>  
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/unipay/unipay.js"></script>
<script type="text/javascript">
  var state = "${rds.columns.state }";
// 纸张类型
var psize = 0;
if(!isBlank(state)){
	psize = state;
}

function isBlank(val) {
			if (val == null || val == '' || val == undefined) {
				return true;
			}
			return false;
		}


	function delimg() {
		if ($("#img-input1").val()=== "") {
		} else {

			$(".delzfb").css('display', 'block');
		}
	}
	function nodelimg() {
		$(".delzfb").css('display', 'none');
	}


	$(function() {
		$('#radioWrap').on('click','.radiobox', function(){
			$('#radioWrap .radiobox').removeClass('radiobox-selected');
			$(this).addClass('radiobox-selected');
			psize = $(this).children("input:first-child").val();
		});

		createUploader('.modulePicWrap_lb', '#ImgprocessPJ1', '', '', '');
		$('#ImgprocessPJ1').imgShow({hasIframe:true});

	});
	


	//点击保存修改
	$("#btn-save").bind(
					'click',function() {
						//获取页面元素信息
						var id = $("#prin_id").val();
						var content = $("#content").val();
						var img = $("#img-input").val();
				if(isBlank(content)){
					layer.msg("请设置模板！");
					return 
				}
				if(isBlank(img)){
					layer.msg("请设置打印模版图片");
					return 
				}
						
						$.ajax({
							type : 'POST',
							url : "${ctx}/order/printdesign/save",//修改
							traditional : true,
							data : {
								prinId:id,
								content : content,
								state : psize,
								imgurl : img
							},
							success : function(data) {
							
								window.location.reload(true);
							}

						});
					});
	//设置模板加载字段数据
	function templateSetting(){
	var img = $("#img-input").val();
		 if(isBlank(img)){
			layer.msg("请设置打印模版图片");
			return ;
		}  
		$.ajax({
			type : 'POST',
			url : "${ctx}/order/printdesign/getKeyName",
			data : {},
			datatype:"JSON",
			success : function(data) {
			if(isBlank(data.content)){
				url = "${commonStaticImgPath}"+img;
			}else{
				url = "${commonStaticImgPath}"+data.imgurl;
			}
				// 初始化设置打印
				prn_design(data,psize,url);
				//console.log(data);
			}

		});
	}

	function createUploader(picker, site, el, id, delimg) {

		uploader = WebUploader.create({
			// 选完文件后，是否自动上传。 
			auto : true,
			swf : '${ctxPlugin}/lib/webuploader/0.1.5/Uploader.swf',
			server : '${ctx}/common/uploadFilePrint',
			duplicate : true,
			fileSingleSizeLimit : 1024 * 1024 * 5,
			pick : picker,
			accept : {
				title : 'Images',
				extensions : 'gif,jpg,jpeg,bmp,png',
				mimeTypes : 'image/gif,image/jpg,image/jpeg,image/bmp,image/png'
			},
			method : 'POST'
		});
		uploader.on("error", function(type) {
			if (type == "Q_TYPE_DENIED") {
				layer.alert("请上传JPG、PNG格式文件");
			} else if (type == "F_EXCEED_SIZE") {
				layer.alert("文件大小不能超过5M");
			}
		});

		uploader.on('beforeFileQueued', function(file) {
			uploader.reset();
		});
		uploader.on('uploadSuccess', function(file, response) {
			$("#imgpic").attr("src", "${commonStaticImgPath}" + response.path);
			$("#img-input").val(response.path);
			img(id, ("${commonStaticImgPath}" + response.path), file, site);
			$('#ImgprocessPJ1').imgShow({hasIframe:true});
			
		});
		uploader.on('uploadError', function(file, reason) {

		});

		uploader.on('fileQueued', function(file) {
		});

	}


	function img(id, src, file, site) {
		var html = ' <div class="" id="file'+file.id+'">';
		html += '<img src="'+src+'" id=""></img></div>';
		$(site).html(html);
	}


</script> 
</body>
</html>
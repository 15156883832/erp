<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>备件库存管理-修改备件</title>
<meta name="decorator" content="base"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>

	<style type="text/css">
		.errorwran{
			display: none;
		}
		.Validform_wrong{
			display: block;
		}
		.Validform_right{
			display: none;
		}
	</style>

<style type="text/css">
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
<!-- 修改备件 -->
<div class="popupBox addbjbox" style="width: 545px;">
	<h2 class="popupHead">
		新增备件
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<form id="tf" action="" method="post">
	<input type="hidden" name="id" value="">
	<div class="popupContainer pos-r">
		<div class="popupMain">
			<div class="cl mb-10">
				<label class="f-l w-100"><em class="mark">*</em> 备件条码：</label>
				<input type="text" name="code" datatype="/^[a-zA-Z0-9-]+$/"  nullmsg="请输入备件条码" errormsg="备件条码必须为字母或数字或字母数字的组合" class="input-text w-140 f-l mustfill" value="" maxlength="20"/>
				<label class="f-l w-100"><em class="mark">*</em> 备件名称：</label>
				<input type="text" name="name" class="input-text w-140 f-l mustfill" value="" datatype="*" nullmsg="请输入备件名称"/>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-100"><em class="mark">*</em>备件型号：</label>
				<input type="text" class="input-text w-140 f-l mustfill " datatype="*" nullmsg="请输入备件型号" name="version"  value="" />
				<label class="f-l w-100"><em class="mark">*</em> 适用品类：</label>
				<select class="f-l select w-140  mustfill" name="suitCategory" datatype="*" nullmsg="请选择适用品类">
					<option value="">请选择</option>
					<c:forEach var="cate" items="${categoryList}">
						<option value="${cate.columns.name}" >${cate.columns.name}</option>
					</c:forEach>
				</select>
			</div>

			<div class="cl mb-10">
				<label class="f-l w-100"> <em class="mark">*</em>入库数量：</label>
				<input type="text" name="warning" datatype="price" nullmsg="请输入入库数量" errormsg="入库数量输入格式错误" class="input-text w-140 f-l mustfill"  value="" />
				<label class="f-l w-100"><em class="mark">*</em>单位：</label>
				<select class="f-l select w-140 mustfill" datatype="*" nullmsg="请选择单位"  name="unit" id="unit">
					<option value="">请选择</option>
					<c:forEach var="unit" items="${UnitList }">
					<option value="${unit.name }" >${unit.name }</option>
					</c:forEach>
				</select>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-100"><em class="mark">*</em>网点价格：</label>
				<div class="priceWrap w-140 f-l mustfill">
					<input type="text" class="input-text" value="" name="sitePrice" datatype="price" errormsg="网点价格输入格式错误" nullmsg="请输入入库价格"/>
					<span class="unit">元</span>
				</div>
				<!-- <label class="f-l w-100">零售价格：</label>
				<div class="priceWrap w-140 f-l ">
					<input type="text" class="input-text" name="stockPrice" id="stockPrice" value=""  errormsg="零售价格输入格式错误" datatype="price1" />
					<span class="unit">元</span>
				</div> -->
			</div>
			<div class="cl mb-10">
				<label class="f-l w-100">图片：</label>
				<div id="Imgprocess" class="f-l" >
				</div>
				<div class="f-l mr-10">
					<c:if test="${empty images}">
						<div class="imgWrap jiahao" id="jiahao" >
							<div id="filePicker-add">
								<a href="javascript:;" class="btn-upload"></a>
							</div>
							<p class="lh-20">最多可上传4张照片</p>
						</div>
					</c:if>
				</div>
				<div class="f-l mr-10 hide" id="jiahao">
					<div class="imgWrap jiahao"  >
						<div id="filePicker-add">
							<a href="javascript:;" class="btn-upload"></a>
						</div>
						<p class="lh-20">最多可上传4张照片</p>
					</div>
				</div>
				<input type="hidden" name="img" value="" id="fittingImage">
			</div>
			<div class="text-c mt-15">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" id="Butfitting">保存</a>
				<a href="javascript:close('.addbjbox');" class="sfbtn sfbtn-opt w-70 mr-5" onclick="closeTan()">取消</a>
			</div>
		</div>
	</div>
	</form>
</div>
<script type="text/javascript">
    var feedImgsCount = 4;
	//点击取消，关闭弹窗
	function close(selector) {
		$.closeDiv($(selector));
	}
	
	var subMark = false;
	$(function () {
		/* var ts = /^\d+(\.\d+)?$/;
		var tss = /^(\d+(\.\d+)?)?$/;
		alert(ts.test(""));
		alert(tss.test("")); */
	    if(!isBlank('${imagesSize}')){
            feedImgsCount = parseInt(4)+parseInt('${imagesSize}');
		}
		$(".addbjbox").popup();
        createUploader("#filePicker-add","#Imgprocess","file_fake_addimg","file_fake_add","delimgs");
		var fittingId = $("input[name='id']").val();
		var action = isBlank(fittingId) ? "addFitting" : "modifyFitting";
		$('#tf').Validform({
			btnSubmit: "#Butfitting",
			tiptype: function (msg, o, cssctl) {
				if (!isBlank(msg)) {
					layer.msg(msg);
				}
			},
			postonce: false,
			datatype: {
				"price": /^\d+(\.\d+)?$/,
				"price1": /^(\d+(\.\d+)?)?$/
			},
			callback: function (form) {
				if(subMark){
					return false;
				}
				subMark = true;
				$.ajax({
					url: "${ctx}/factoryfitting/stocks/factoryFittingDoAddOrEdit",
					type: "POST",
					data: form.serialize(),
					success: function (data) {
						if ("422" == data) {
							layer.msg('配件条码已存在');
						} else if("200" == data) {
							window.top.layer.msg('保存成功');
							parent.search();
							$.closeDiv($(".addbjbox"));
						}else{
							layer.msg('保存失败，请检查！');
						}
					},
					complete:function(){
						subMark = false;
					},error:function(){
						subMark = false;
					}
				}); 
				return false;
			}
		});

        $(".yuanImages .imgWrap").imgShow();
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
            var images="";
            var array=$("input[name='pickerImg']");//单引号 的name替换为相应的name
            for(var i=0;i<array.length;i++) {
                images += $(array[i]).val() + ",";
            }
            $("#fittingImage").val(images);
            if(uploader){
                uploader.reset();
            }
        });

        uploader.on( 'fileQueued', function( file ) {
            if(feedImgsCount==7){
                $("#jiahao").addClass('hide');
            }
            if(parseInt(feedImgsCount) > 7 ){
                layer.msg("最多可上传4张图片！");
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

    function img(id,src,file,site){
        if(feedImgsCount > 7){
            $("#jiahao").addClass('hide');
            layer.msg("最多可上传4张图片！");
            return false;
        }
        feedImgsCount=parseInt(feedImgsCount)+1;
        var html =' <div class="f-l imgWrap1 mb-10 appendImage" id="file'+file.id+'"><div class="imgWrap"> ';
        html +='<img src="'+src+'" id=""></div><a class="sficon btn-delimg" onclick="deletePicture(this, \''+file.id+'\')"></a></div>'+
            '<input name="markAble" id="mark'+file.id+'" hidden="hidden" value="'+file.id+'" />';
        $(site).append(html);
        if(feedImgsCount>=8){
            $("#jiahao").addClass('hide');
        }
        $(".appendImage .imgWrap").imgShow();
    }

    function deleteImg(ff) {
        $("#" + ff).remove();
        feedImgsCount = feedImgsCount - 1;
        if (feedImgsCount == 7) {
            $("#jiahao").removeClass('hide');
        }
        if (uploader) {
            uploader = null;
        }
        createUploader("#filePicker-add", "#Imgprocess", "file_fake_addimg","file_fake_add", "delimgs");
        getImages();
    }

    function deletePicture(obj,fileId) {
        $("#file"+fileId+"").remove();
        $("#mark"+fileId+"").remove();
        $(obj).parent('.imgWrap1').remove();
        $("#pickerImg"+fileId).remove();
        feedImgsCount = feedImgsCount-1;
        if(feedImgsCount<=7){
            $("#jiahao").removeClass('hide');
        }
        getImages();
        return ;
    }

    function getImages(){
        var images="";
        var array=$("input[name='pickerImg']");//单引号 的name替换为相应的name
        for(var i=0;i<array.length;i++) {
            images += $(array[i]).val() + ",";
        }
        $("#fittingImage").val(images);
	}

	function isBlank(val) {
		return (val == null || $.trim(val) == '' || val == undefined);
	}

	$('#spimg1').imgShow();
</script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<title>重新提交</title>
 <meta name="decorator" content="base"/>
 <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
</head>
<body>
<!-- 重新提交 -->
<div class="popupBox resubmitBox">
	<h2 class="popupHead">
		重新提交
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer ">
		<div class="popupMain pt-25 pb-20 pl-30 pr-30" >
			<p class="f-14 mb-10"><span class="c-fe0101">未通过原因</span>：${rds.columns.remarks}</p>
			<div class=" mb-20">
				<table class="table table-bg table-border table-bordered table-sdrk text-c" style="table-layout: auto;">
					<thead>
					<tr>
						<th class="w-420">商品信息</th>
						<th class="w-120">购买价格（元）</th>
						<th class="w-120">购买时间</th>
						<th class="w-120">支付码</th>
						<th class="w-120">凭证</th>
					</tr>
					</thead>
					<tr>
						<td class="text-l ">
							<div class="pd-10">
								<div class="imgWrap pos-r pl-90 mb-15 lh-22 pt-5" style="min-height: 80px;">
									<img src="${prototypeStaticImgPath}${imgs}" class="pos" />
									<p class="f-14"><strong>${rds.columns.poname }</strong> </p>
									<p>商品类别：${item.columns.category}         </p>
									<p>商品编号：${item.columns.number}</p>
								</div>
								<div class="mb-10 line-dashed"></div>
								<div class="">
									<span class="pr-30">用户姓名：${rds.columns.purchaser_name }</span>
									<span>联系方式：${rds.columns.purchaser_mobile }</span>
								</div>
								<div class="">详细地址：${rds.columns.address }</div>
							</div>
						</td>
						<td>${rds.columns.purchase_amount }</td>
						<td>${rds.columns.create_times }</td>
						<td>
							<span class="imgbox4 mb-20">
								<c:if test="${rds.columns.payment_type eq 0 }">
									<img id="payTy" src="${ctxPlugin }/static/h-ui.admin/images/prototype_wx.png" class="img" />
								</c:if>
								<c:if test="${rds.columns.payment_type eq 1 }">
									<img id="payTy" src="${ctxPlugin }/static/h-ui.admin/images/prototype_zfb.png" class="img" />
								</c:if>
								<%--<img src="static/h-ui.admin/images/code.jpg" class="img" />--%>
							</span>
						</td>
						<td>

							<a class="">
								<span class="imgbox4" id="spimg1"><img src="${prototypeStaticImgPath}${rds.columns.icon}" id="img-view" class="img"/> </span>
								<span class="w-90 text-c c-0e8ee7 lh-20" id="img-picker">上传凭证</span>
							</a>
						</td>
					</tr>
				</table>
			</div>
			<div class="text-c pt-30">
				<input type="hidden" name="id" value="${rds.columns.id }">
				<input type="hidden" id="img-input"  name="icon" value="">
				<a href="javascript:conmitOrder('${rds.columns.id }');" class="sfbtn sfbtn-opt3 w-70 mr-5">提交</a>
				<a href="javascript:cancel();" class="sfbtn sfbtn-opt w-70 ">取消</a>
			</div>
		</div>
	</div>
</div>


<!--_footer 作为公共模版分离出去-->
<script src="${ctxPlugin}/static/h-ui.admin/js/jquery-1.8.3.js" type="text/javascript" charset="utf-8"></script>

<script type="text/javascript" src="${ctxPlugin}/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui/js/H-ui.min.js"></script> 
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/H-ui.admin.js"></script>
<!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${ctxPlugin}/lib/My97DatePicker/4.8/WdatePicker.js"></script> 
<script type="text/javascript" src="${ctxPlugin}/lib/datatables/1.10.0/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="${ctxPlugin}/lib/laypage/1.2/laypage.js"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/grid.locale-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/jquery.jqGrid.src.revised.js" type="text/javascript" charset="utf-8"></script>
<!--<script src="static/h-ui.admin/js/easyui-revised.js" type="text/javascript" charset="utf-8"></script>-->
<script src="${ctxPlugin}/static/h-ui.admin/js/sifang.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/popUp.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
<script type="text/javascript">
	$(function(){

		$('.resubmitBox').popup();		
		var thumbnailWidth = 130;   //缩略图高度和宽度 （单位是像素），当宽高度是0~1的时候，是按照百分比计算，具体可以看api文档  
		var thumbnailHeight = 130; 
		uploader = WebUploader.create({
		       // 选完文件后，是否自动上传。 
		       auto: true,  
		       swf: '${ctxPlugin}/lib/webuploader/0.1.5/Uploader.swf',  
		       //server: '${ctx}/common/uploadFile',
		       server: '${prototypeUploadPath}/a/common/uploadFile',
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
			   $("#img-view").attr("src",'${prototypeStaticImgPath}'+response.path);
			   $("#img-input").val(response.path);
			   //$(".oneImg").remove();
			   
		   });
	})

	function isBlank(val) {
			if (val == null || val == '' || val == undefined) {
				return true;
			}
			return false;
	}
	
	function cancel(){
		$('#Hui-article-box',window.top.document).css({'z-index':'9'});	
		$.closeDiv($(".resubmitBox"))
	}
	
	$(".closePopup").on("click",function(){
		$('#Hui-article-box',window.top.document).css({'z-index':'9'});		
	})



	var repeatSub=false;
	function conmitOrder(){
	    if(repeatSub){
	        return;
		}
		var id=$("input[name='id']").val();
		var icon = $("#img-input").val();
		if(isBlank(id)){
			layer.msg("数据有误去，请稍后再试...");
		}else if(isBlank(icon)){
			layer.msg("请重新上传凭证");
		}else{
		    repeatSub=true;
			$.ajax({
				type : "POST",
				url : "${ctx}/goods/siteself/resubmitIcon",
				data : {
					"id" : id,
					icon:icon
				},
				success : function(data) {
					if(data == "yes"){
					layer.msg("提交成功！");
					window.location.href='${ctx}/goods/siteself/getMyorder';
					$('#Hui-article-box',window.top.document).css({'z-index':'9'});
					}else if(data == "no2"){
					layer.msg("该商品已被购买，请联系客服...");
					}else{
					layer.msg("提交失败，请稍后再试...");
					}
				},
				complete:function(){
                    repeatSub=false;
				}
			});
		}
	}
	
	$('#spimg1').imgShow();
	
</script> 
</body>
</html>
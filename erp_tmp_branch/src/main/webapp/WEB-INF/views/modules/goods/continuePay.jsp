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
<div class="popupBox w-520 resubmitBox">
	<h2 class="popupHead">
		重新提交
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<div class="popupMain pd-15">
			<div class="cl mb-10">
				<label class="f-l text-r w-80">订单编号：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${orderDetail.number }"/>
				<label class="f-l text-r w-100">商品名称：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${orderDetail.goodName }"/>
				<input type="hidden" name="id" value="${orderDetail.id }">
				<input type="hidden" id="img-input"  name="icon" value="">
			</div>
			<div class="cl mb-10">
				<label class="f-l text-r w-80">购买数量：</label>
				<input type="text" name="num" class="input-text w-140 f-l" value="${orderDetail.purchaseNum }"/>
				<label class="f-l text-r w-100">购买价格：</label>
				<div class="priceWrap w-140 f-l readonly">
					<input type="text" class="input-text readonly" readonly="readonly" value="${orderDetail.goodAmount }"/>
					<span class="unit">元</span>
				</div>
			</div>
			<div class="cl mb-10">
				<label class="f-l text-r w-80">收件人：</label>
				<input type="text" class="input-text w-140 f-l " name="customerName" value="${orderDetail.customerName }"/>
				<label class="f-l text-r w-100">联系方式：</label>
				<input type="text" class="input-text w-140 f-l " name="customerMobile"  value="${orderDetail.customerContact }"/>
			</div>
			<div class="line-dashed mb-10"></div>
			<div class="cl mb-10">
				<label class="f-l text-r w-80">收件地址：</label>
				<input type="text" class="input-text w-380 f-l " name="address"  value="${orderDetail.customerAddress }"/>
			</div>
			<div class="cl mb-10 pr-20">
				<div class="f-l w-180">
					<label class="f-l w-80 text-r">支付码：</label>
					<div class="imgbox f-l">
						<c:if test="${orderDetail.paymentType eq 0 }">
							<img id="payTy" src="${ctxPlugin }/static/h-ui.admin/images/weipay.png" class="w-140" />
						</c:if>
						<c:if test="${orderDetail.paymentType eq 1 }">
							<img id="payTy" src="${ctxPlugin }/static/h-ui.admin/images/alipay.png" class="w-140" />
						</c:if>
					</div>
					<a class="w-100 f-l ml-80 text-c lh-22 " >
						<c:if test="${orderDetail.paymentType eq 0 }">
							微信
						</c:if>
						<c:if test="${orderDetail.paymentType eq 1 }">
							支付宝
						</c:if>
					</a>
				</div>
				<div class="f-r w-180">
					<label class="f-l w-80 text-r">支付凭证：</label>
					<div class="imgbox f-l">
						<div class="f-l imgbox" id="spimg1" >
							<!-- <a href="javascript:;" class="btn-uploadimg oneImg" ></a> -->
							<img src="${commonStaticImgPath}${orderDetail.payConfirm}" id="img-view" />
						</div>
					</div>
					<a class="w-100 f-l ml-80 text-c lh-22 c-0383dc" id="img-picker">重新上传</a>
				</div>
			</div>
			<div class="cl mb-10">
				<label class="f-l text-r w-80">未通过原因：</label>
				<textarea class="textarea h-50 w-380 f-l readonly" readonly="readonly">${orderDetail.noPassSource}</textarea>
			</div>
			
			<div class="text-c mt-15">
				<a href="javascript:conmitOrder();" class="sfbtn sfbtn-opt3 w-70 mr-5">提交</a>
				<a href="javascript:cancel();" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
			</div>
		</div>
	</div>
</div>


<div class="popupBox w-520 chukuBox">
	<h2 class="popupHead">
		详情
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<div class="popupMain pd-15">
			<div class="cl mb-10">
				<label class="f-l text-r w-80">订单编号：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${orderDetail.number }"/>
				<label class="f-l text-r w-100">商品名称：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${orderDetail.goodName }"/>
			</div>
			<div class="cl mb-10">
				<label class="f-l text-r w-80">购买数量：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${orderDetail.purchaseNum }"/>
				<label class="f-l text-r w-100">购买价格：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${orderDetail.goodAmount }"/>
			</div>
			<div class="cl mb-10">
				<label class="f-l text-r w-80">收件人：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${orderDetail.customerName }"/>
				<label class="f-l text-r w-100">联系方式：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${orderDetail.customerContact }"/>
			</div>

			<div class="cl mb-10">
				<label class="f-l text-r w-80">收件地址：</label>
				<input type="text" class="input-text w-380 f-l readonly" readonly="readonly" value="${orderDetail.customerAddress }"/>
			</div>
			<div class="line-dashed mb-10"></div>
			<div class="cl mb-10">
				<label class="f-l text-r w-80">物流名称：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${orderDetail.logisticsName }"/>
				<label class="f-l text-r w-100">物流单号：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${orderDetail.logisticsNo }"/>
			</div>
			
			<div class="text-c mt-25">
				<a href="javascript:closeDiv();" class="sfbtn sfbtn-opt3 w-70 mr-5">关闭</a>
			</div>
		</div>
	</div>
</div>

<div class="popupBox spOprocess logistics">
	<h2 class="popupHead">
		物流信息
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r pb-60">
		<div class="popupMain">
			<div class="pcontent">
			<c:forEach items="${mapss }" var="map">
				<div class="llbox bk-gray">
					<h3 class="lltitle cl">物流信息 
					<span class="f-r mr-10">单号：${map.key}</span>
					<span class="f-r mr-20">名称：${orderDetail.logisticsName}</span>
					</h3>
					<div class="nologistics hide">商品尚未发货</div>
					<ul class="logisticslist pt-5 pb-5" style="min-height: 200px;max-height: 400px;overflow: auto">
						<c:forEach items="${map.value }" var="log" varStatus="idx">
						
						<c:choose>
						<c:when test="${idx.first}">
						<li>
							<div class="lltime">${log.key}</div>
							<div class="lladdress lladdr currentSeq"><i class="icon_seq"></i> ${log.value }</div>
						</li>
						</c:when>
						<c:otherwise>
						<li>
							<div class="lltime">${log.key}</div>
							<div class="lladdress lladdr "><i class="icon_seq"></i> ${log.value }</div>
						</li>
						</c:otherwise>
						</c:choose>
						</c:forEach>
						
						<c:choose>
						<c:when test="${orderDetail.sendgoodTime eq ''}"></c:when>
						<c:when test="${orderDetail.sendgoodTime eq null }"></c:when>
						<c:otherwise>
						<li>
							<div class="lltime">${orderDetail.sendgoodTime}</div>
							<div class="lladdress lladdr"><i class="icon_seq"></i> 已发货</div>
						</li>
						</c:otherwise>
						</c:choose>
						
					</ul>
				</div>
				</c:forEach>
			</div>
		</div>
		
		<div class="text-c btbWrap">
			<a href="javascript:close();" class="sfbtn sfbtn-opt3 w-70">关闭</a>
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
		var type = '${type}';
		if(type==1){
			$('.resubmitBox').popup();
		}else if(type == 2){
			$('.chukuBox').popup();	
		}else{
			$('.logistics').popup({fixedHeight:false});
		}
		
		//createUploader("#filePicker-add","#Imgprocess2","file_fake_addimg","file_fake_add","delimgs");
		
		///不需要的話刪了	
		 /// firstAddr currentSeq
		//$('#sty').popup({fixedHeight:false}); 
		
		
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
	});

	function conmitOrder(){
		var moliereg=/^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$|(^(1[0-9])\d{9}$)/;
		var numtes=/^[0-9]+([.]{1}[0-9]+){0,1}$/;
		var id=$("input[name='id']").val();
		var num=$("input[name='num']").val();
		var customerName=$("input[name='customerName']").val();
		var customerMobile=$("input[name='customerMobile']").val();
		var address=$("input[name='address']").val();
		var icon=$("input[name='icon']").val();//支付凭证
		if(!isBlank(customerMobile)){
			if(!moliereg.test(customerMobile)){
				layer.msg("联系方式格式不正确");
				return;
			}
		}
		if(!isBlank(num)){
			if(!numtes.test(num)){
				layer.msg("购买数量格式不正确");
				return;
			}
		}
		if(isBlank(num)){
			layer.msg("请输入购买数量");
		}else if(isBlank(customerName)){
			layer.msg("请输入用户名");
		}else if(isBlank(customerMobile)){
			layer.msg("请输入用户联系方式");
		}else if(isBlank(address)){
			layer.msg("请输入用户地址");
		}else{
			$.ajax({
				type : "POST",
				url : "${ctx}/goods/nanDao/repeatConmit",
				data : {
					"id" : id,
					num:num,
					customerName:customerName,
					customerMobile:customerMobile,
					address:address,
					icon:icon
				},
				success : function(data) {
					layer.msg("提交成功！");
					window.location.href='${ctx}/goods/nanDao/list';
					//parent.closeBatchForm();
					//parent.search();
					$('#Hui-article-box',window.top.document).css({'z-index':'9'});
				}
			});
		}
	}
	

	$('#spimg1').imgShow();
	
	function closeDiv(){
		$('#Hui-article-box',window.top.document).css({'z-index':'9'});
		$.closeDiv($(".chukuBox"));
	}
	function close(){
		$('#Hui-article-box',window.top.document).css({'z-index':'9'});
		$.closeDiv($(".logistics"));
	}
</script> 
</body>
</html>
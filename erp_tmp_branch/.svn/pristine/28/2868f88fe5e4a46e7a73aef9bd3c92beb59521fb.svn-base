<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>平台商品-详情</title>
<meta name="decorator" content="base"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
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
</style>
</head>
<body>
<div class="popupBox newsp ptAddsp">
	<h2 class="popupHead">
		 商品详情
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<form  method="post" id="tf">
	<div class="popupContainer pos-r">
		<div class="popupMain">
		<div class="pcontent pt-10">
			<div class="cl w-710">
				<div class="f-r mb-10">
					<label class="w-100 f-l">商品图片：</label>
					<div class="imgbox2 f-l pos-r readonly">
						<img src="${commonStaticImgPath}${platform.columns.icon}" id="img-view" />
						<input type="hidden" name="icon" value="${platform.columns.icon}" id="img-input">
					</div>
				</div>
				<div class="f-l mb-10">
					<input type="hidden"  name="id" value="${platform.columns.id }"/>
					<label class="f-l w-90">商品编号：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${platform.columns.number }" name="number"/>
					<label class="f-l w-100">商品名称：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly"  value="${platform.columns.name }" name="name"/>
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-90">商品品牌：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${platform.columns.brand }" name="brand"/>
					<label class="f-l w-100">商品型号：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${platform.columns.model }" name="model"/>
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-90">商品类别：</label>
					<select class="select w-140 f-l readonly" disabled="disabled" name="category">
						<option value="">请选择</option>
					<c:forEach var ="cg" items="${categoryList}">
						<option value="${cg.columns.name }" <c:if test="${cg.columns.name==platform.columns.category }">selected="selected"</c:if>  >${cg.columns.name }</option>
					</c:forEach>
					</select>
					<label class="f-l w-100">商品单位：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly"  value="${platform.columns.unit }" name="unit"/>
				</div>
				 
			    <div class="f-l mb-10" id="pputong">
					<label class="f-l w-90">商品价格：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text readonly" readonly="readonly" name="gsitePrice" value="${platform.columns.site_price }"/>
						<span class="unit">元</span>
					</div>
				</div>
				<!-- 特殊商品 -->
				<div class="f-l "  id="jingshuiPrice">
					<label class="f-l w-90">官方指导价：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text  f-l readonly" readonly="readonly"  value="2979" name="gcustomerPrice"/>
						<span class="unit">元</span>
					</div>
					<label class="f-l w-100">建议零售价：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text f-l readonly" readonly="readonly"  value="2198"  name="grebatePrice"/>
						<span class="unit">元</span>
					</div>
					<input type='hidden' name="gsitePrice"  value="${platform.columns.site_price }"/><!-- 入库价格 -->
				</div>
				
				<div class="f-l mb-10 mt-10" id="jingshuiPricecu">
					<label class="f-l w-90">促销奖励：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text f-l readonly" readonly="readonly"  value="" name="orderPrice"/>
						<span class="unit">元</span>
					</div>
				</div>
			</div>
			<%-- <div class="txtwrap mb-10 w-710">
				<label class="lb w-90">商品描述：</label>
				<textarea class="textarea h-50 readonly" readonly="readonly" name="description"></textarea>
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
					</div>
				</div>
			</div> --%>
			<div class="pl-15 pr-15" style="width:710px;overflow-x: hidden;">
				 <script id="container" name="content" type="text/plain">
       				 
   				 </script>
				 <textarea class="textarea h-50 hide" value="" id="html" name="html"></textarea>
			 </div>
		</div>
		<div class="text-c btbWrap">
		<c:if test="${siteId eq null || siteId eq '' }">
			<a href="javascript:;" class="sfbtn sfbtn-opt3 w-90 mr-5" onclick="showPTSPXQ('${platform.columns.id}','${platform.columns.type}')">我要销售</a>
		</c:if>
			<a href="javascript:closeDiv();" class="sfbtn sfbtn-opt w-70 mr-5">关闭</a>
		</div>
	</div>
	</form>
</div>

<script type="text/javascript">	
var count = parseInt('${count}');
	$(function(){
        $.post("${ctx}/goods/sitePlatformGoods/distinct",function(result){
            if(result=="showPopup"){
                $("input[name='gsitePrice']").val("20.50");
            }
        });

		//防止图片过宽
	  	ue = UE.getEditor('container',{ serverUrl:'${ctxPlugin}/lib/ueditor/1.4.3/jsp/controller.jsp',
			toolbars: [['bold', 'italic', 'underline', 'fontborder',  'forecolor', 'backcolor',
	                      'fontfamily', 'fontsize','justifyleft','justifycenter','justifyright','justifyjustify',  
	                      'simpleupload', 'insertimage', 'preview','fullscreen']],
                      elementPathEnabled : false,
                      autoFloatEnabled :false,
                      initialFrameHeight: 150});
		ue.ready(function(){
			ue.setContent('${platform.columns.html }');
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
		/* createUploader("#filePicker-add","#Imgprocess2","file_fake_addimg","file_fake_add","delimgs"); */
		$('.ptAddsp').popup();
		
		
		var name= '${platform.columns.name }';
		if($.trim(name)=='浩泽家用反渗透直饮机'){
			$("#pputong").remove();
			var sitePrice=$("input[name='gsitePrice']").val();/* 入库价格 */
			var grebatePrice=$("input[name='grebatePrice']").val();/* 建议零售价格 */
			var prize=grebatePrice-sitePrice;
			$("input[name='orderPrice']").val(prize);//促销奖励
		}else{
			$("#jingshuiPrice").remove();
			$("#jingshuiPricecu").remove();
		}
	});
	function closeDiv(){
		 $.closeDiv($(".ptAddsp"));
	}
	
	/* function sellGoods(){
			$.ajax({
				type:"POST",
				traditional:true,
				url:"${ctx}/goods/sitePlatformGoods/doXS",
				data:$("#tf").serializeJson(), 
				dataType:'json',
				success:function(result){
					if(result==true){
						layer.msg("添加成功！");
						setTimeout(function(){
							window.parent.location.reload(true);
							$.closeDiv($(".ptAddsp"));
						},500);
					}else{
						layer.msg("添加失败，请检查！");
					}
				}
			}) 
	} */
	 
	function isBlank(val) {
			if (val == null || val == '' || val == undefined) {
				return true;
			}
			return false;
		}
	
	
	//商品销售弹窗
	function showPTSPXQ(id,type){
		layer.open({
			 type : 2,
			 content:'${ctx}/goods/sitePlatformGoods/showPTSPXQ?id='+id,
			 title:false,
			 area: ['100%','100%'],
			 closeBtn:0,
			 shade:0,
			 fadeIn:0,
			 anim:-1 
			 });
		
	}

	   $('#spimg1').imgShow();
	   $('#Imgprocess2').imgShow();//非弹出框时需要hasIframe:true
</script> 
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>平台商品-编辑</title>
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
<!-- 编辑商品-->
<div class="popupBox newsp ptAddsp">
	<h2 class="popupHead">
		编辑商品
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<form action="${ctx}/goods/platform/doBJ" method="post" id="tf">
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
					</div>
					<a href="javascript:;" class="btn-uploadimg  ml-90 w-140 text-c" id="img-picker"></a>
			
				</div>
			
				<div class="f-l mb-10">
					<input type="hidden"  name="id" value="${platform.columns.id }"/>
					<label class="f-l w-90"><em class="mark">*</em>商品编号：</label>
					<input type="text" class="input-text w-140 f-l readony" value="${platform.columns.number }" name="number"/>
					<label class="f-l w-100"><em class="mark">*</em>商品名称：</label>
					<input type="text" class="input-text w-140 f-l"  value="${platform.columns.name }" name="name"/>
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-90">商品品牌：</label>
					<input type="text" class="input-text w-140 f-l" value="${platform.columns.brand }" name="brand"/>
					<label class="f-l w-100">商品型号：</label>
					<input type="text" class="input-text w-140 f-l" value="${platform.columns.model }" name="model"/>
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-90"><em class="mark">*</em>商品类别：</label>
					<select class="select w-140 f-l" name="category">
						<option value="">请选择</option>
					<c:forEach var ="cg" items="${categoryList}">
						<option value="${cg.columns.name }" <c:if test="${cg.columns.name==platform.columns.category }">selected="selected"</c:if>  >${cg.columns.name }</option>
					</c:forEach>
					</select>
					<label class="f-l w-100">商品单位：</label>
					<input type="text" class="input-text w-140 f-l"  value="${platform.columns.unit }" name="unit"/>
				</div>
			    <div class="f-l mb-10">
					<label class="f-l w-90"><em class="mark">*</em>入库价格：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text" name="gplatformPrice" value="${platform.columns.platform_price }"/>
						<span class="unit">元</span>
					</div>
					<label class="f-l w-100"><em class="mark">*</em>零售价格：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text" name="gsitePrice" value="${platform.columns.site_price }"/>
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
					<label class="f-l w-100"><em class="mark">*</em>排序：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text" name="sortNum" value="${platform.columns.sort_num }"/>
						<span class="unit">元</span>
					</div>
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-90"><em class="mark">*</em>是否上架：</label>
					<select class="select w-140 f-l" name="sellFlag">
						<option value="">请选择</option>
						<option value="1" <c:if test="${platform.columns.sell_flag==1 }">selected="selected"</c:if> >确认上架</option>
						<option value="2" <c:if test="${platform.columns.sell_flag==2 }">selected="selected"</c:if> >暂不上架</option>
					</select>
					<label class="f-l w-90"></label>
					<input type="hidden" value=""/>
				</div>
			</div>
			<%-- <div class="txtwrap mb-10 w-710">
				<label class="lb w-90">商品描述：</label>
				<textarea class="textarea h-50" name="description"></textarea>
			</div>
			 <div class="txtwrap cl hm-80">
				<label class="lb w-90">其它图片：</label>
				<div class="cl">
					<!-- <div id="Imgprocess" class="f-l" >
								 
					</div> -->
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
							<div class="imgWrap f-l w-110 " id="btn-img2">
						</div>
						
					</div>
				</div>
			</div>  --%>
			<div class="pl-15 pr-15" style="height:210px;width:710px;overflow-x: hidden;overflow-y: auto;">
				 <script id="container" name="content" type="text/plain">
       				 
   				 	</script>
				 <textarea class="textarea h-50 hide" value="" id="html" name="html"></textarea>
			 </div>
		</div>
		</div>
		<div class="text-c btbWrap">
			<a href="javascript:closeDiv();" class="sfbtn sfbtn-opt w-70 mr-5">关闭</a>
		</div>
	</div>
	</form>
</div>

<script type="text/javascript">
var count = parseInt('${count}');
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
			ue.setContent('${siteSelf.columns.html }');
			 // 阻止工具栏的点击向上冒泡
		    $(this.container).click(function(e){
		        e.stopPropagation();
		    });
		    // 解决悬浮问题
		    if (UE.browser.ie && UE.browser.version <= 7) {
	    		FixIe7Bug();
	    	}
		})
		$('.ptAddsp').popup();
	});
	function closeDiv(){
		 $.closeDiv($(".ptAddsp"));
	}
	 
	$("input[name='name']").blur(function(){
		var name=$("input[name='name']").val();
		if(isBlank(name)){
			layer.msg('商品名称不能为空！！！');
		}
	})
   $('#spimg1').imgShow();
   $('#Imgprocess2').imgShow();//非弹出框时需要hasIframe:true
</script> 
</body>
</html>
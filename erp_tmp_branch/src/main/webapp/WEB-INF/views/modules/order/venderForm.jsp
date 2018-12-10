<!DOCTYPE HTML>
<html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<head>
<meta name="decorator" content="base"/>

<!--[if IE 6]>
<script type="text/javascript" src="lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<title>系统设置-厂家设置——新增厂家</title>
</head>
<body>
<!-- 添加 -->
<div class="popupBox gysxzsp"  style=" z-index:101; width:400px;">
	<h2 class="popupHead">
		新增
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer ">
		<div class="popupMain pd-20">
			<div class="cl mb-10">
					<label class="f-l w-80">厂家名称：</label>
					<input type="text" class="input-text w-240 f-l vendername" />
				</div>
				<div class="cl mb-10">
					<label class="f-l w-80">厂家链接：</label>
					<input type="text" class="input-text w-240 f-l venderurl" />
				</div>
			<div class="text-c mt-20">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5"  id="btnSubmit">保存</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5"  onclick="closed()">取消</a>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">

	$(function(){
		$('.gysxzsp').popup();
		$("#btnSubmit").click(function(){
			var name=$('.vendername').val();
			var url=$('.venderurl').val();
			var nameArr = [];
			<c:forEach items="${nameList}" var="item">
			nameArr.push("${item}");
			
			</c:forEach>
				if($.inArray(name, nameArr)!=-1){
					layer.msg("厂家名称有重复")
					return;
				}
				if (url == null || !/^(http:\/\/|https:\/\/)?\w+(\.\w+)+/i.test(url)) {
					layer.msg("链接格式不正确");
					return;
				}
			
			$.ajax({
				type:'POST',
				url:"${ctx}/order/VendorSet/saveVender",
				traditional: true,
				data:{
					"name":name,
					"url":url
				},
				success:function(flag){
					if(flag){
						layer.msg("保存成功");
						parent.location.reload(); 
						$.closeDiv($(".gysxzsp"));
				
					}else{
						layer.msg("保存失败");
						return;
					}
				},
				error:function(){
					layer.msg("系统错误，请稍后重试")
					return;
				}
			})

		});
	});
	

	
	function closed(){
		$.closeDiv($('.gysxzsp'));
	}
		
</script> 
</body>
</html>
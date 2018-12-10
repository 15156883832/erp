
 <!DOCTYPE HTML>
<html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<head>
<meta name="decorator" content="base"/>
<title>系统设置-司机姓名</title>
</head>
<body>
<!-- 新增司机姓名-->
<div class="popupBox  addOrigin" style="z-index: 199;width: 300px;'">
	<h2 class="popupHead">
		新增
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<div class="popupMain">
			<div class="pcontent" id="originbox" >
				<div class="cl mb-10">
					<label class="f-l w-70"><em class="mark">*</em>司机姓名：</label>
					<input type="text" class="input-text w-140 f-l  labelname" />
				</div>
				<div class="cl mb-10">
					<label class="f-l w-70"><em class="mark">*</em>联系方式：</label>
					<input type="text" class="input-text w-140 f-l  labelmobile" />
				</div>
				
			</div>	
		</div>
		<div class="text-c btnWrap">
			<a class="sfbtn sfbtn-opt3 w-70 mr-5" id="btnSubmit">保存</a>
			<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5"  onclick="closed()">取消</a>
		</div>
	</div>
</div>


<script type="text/javascript">
var tel = /(^1\d{10}$)|(^(\d{3,4}\-)?\d{5,9}$)/;
	$(function(){
		//新增信息来源
	$('.addOrigin').popup({fixedHeight:false});

	$("#btnSubmit").click(function(){

		var names = $(".labelname").val();
		var mobile = $(".labelmobile").val();
	
			if(isBlank(names)){
				layer.msg("请输入司机姓名");
				return 
			}		 
			if(isBlank(mobile)){
				layer.msg("请输入联系电话");
				return 
			}		 
			if(!tel.test($.trim(mobile))){
				layer.msg("请输入有效联系方式");
				return
			}
		$.ajax({
			type:'POST',
			url:'${ctx}/operate/siteDriver/siteDriverCheck',
			traditional: true,
			data:{"names":names}, 
			dataType:'json',
			async:false,
			success:function(result){

			if(!result.flag){
				$.ajax({
					type:'POST',
					url:"${ctx}/operate/siteDriver/saveSiteDriver",
					traditional: true,
					data:{
						"names":names,
					    "mobile":mobile		
					},
					success:function(data){
						layer.msg("添加成功");
						parent.location.reload(); 
						$.closeDiv($(".addOrigin"));
				    //window.location.href="${ctx}/order/serviceMode";
					}
				});
			}else{
				layer.msg("司机姓名已存在!");
				return;
			} 
			return;
			}
		}); 
	});
	});
	
	function isBlank(val) {
		if (val == null || $.trim(val) == '' || val == undefined) {
			return true;
		}
		return false;
	}
	
	function closed(){
		$.closeDiv($('.addOrigin'));
	}


</script> 
</body>
</html> 

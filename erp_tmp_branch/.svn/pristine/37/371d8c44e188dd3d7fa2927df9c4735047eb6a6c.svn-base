<!DOCTYPE HTML>
<html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<head>
<meta name="decorator" content="base"/>
<title>系统设置-服务方式</title>
</head>
<body>
<!-- 修改信息来源 -->

<div class="popupBox porigin editOrigin" style="z-index: 199;">
	<h2 class="popupHead">
		修改
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<div class="popupMain">
			<div class="pcontent" id="originbox" >
			<input type="hidden"  value="${serviceMode.columns.id }"  id="ids"/>
				<div class="cl mb-10">
				<label class="f-l w-70"><em class="mark">*</em>服务方式：</label>
				<input type="text" class="input-text w-140 f-l labelname"  value="${serviceMode.columns.name }"/>
				<label class="f-l w-90">排序：</label>
				<input type="text" class="input-text w-80 f-l labelsort" value="${serviceMode.columns.sort }"/>
				 <span class="f-l mr-20  mb-40_ orderMustItem ${serviceType.columns.is_default eq '1'?'orderMustChk':''}">默认选项<i class="oItemChk"></i></span>
				</div>
				<%-- <div class="cl mb-10">
					<label class="f-l w-70">是否默认：</label>
					<label class='w-50 mr-10'><input type="radio" name='isDefault' value="1" style='margin-right:10px' ${serviceMode.columns.is_default eq '1' ? 'checked=\'checked\'' : ''}/>是</label>
					<label class='w-50'><input type="radio" name='isDefault' value="0" style='margin-right:10px' ${serviceMode.columns.is_default eq '0' ? 'checked=\'checked\'' : ''}/>否</label>
				</div> --%>
			</div>
			<div class="text-c mt-25 pt-20">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" id="btnSubmit">保存</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="closed()">取消</a>
			</div>
		</div>
	</div>
</div>
<input type="hidden" id="siteId" value="${siteId }"/>
<script type="text/javascript">
	$(function(){
	$('.editOrigin').popup(); 
	
	 $('.orderMustItem').on('click' ,function(){
         if($(this).hasClass('orderMustChk')){
             $(this).removeClass('orderMustChk');
         }else{
             $(this).addClass('orderMustChk');
         }
 })
	
	$("#btnSubmit").click(function(){
	var ids=document.getElementById("ids").value;

		var names = $(".labelname").val();
		var sorts = $(".labelsort").val();
		var siteId = $("#siteId").val();
		var isDefault ="0";
		if($('.orderMustItem').hasClass('orderMustChk')){
			isDefault = "1";
		}
		if(	$.trim(names)==""|| $.trim(names)==null){
			layer.msg("“方式名称”不能为空！");
			return;
		}
		if((sorts.length!=0)&&(sorts.match(/\D/)||sorts==0)){
			layer.msg("排序请输入除0以外数字");
			return;
		}

		$.ajax({
			type:'POST',
			url:'${ctx}/order/serviceMode/siteUpdaqueryNums',
			traditional: true,
			data:{"names":names,
				     "id":ids,
				     "siteId":siteId}, 
			dataType:'json',
			async:false,
			success:function(result){
			if(!result.flag){
				$.ajax({
					type:'POST',
					url:"${ctx}/order/serviceMode/siteupdate",
					traditional: true,
					data:{
						"names":names,
					    "sorts":sorts,
					    "id":ids,
					    "isDef" :isDefault
					},
					success:function(data){
						console.log(data)
						if(data =="ok"){
						layer.msg("修改成功");
						parent.location.reload(); 
						$.closeDiv($(".editOrigin"));
						}else{
						layer.msg("修改失败");
							
						}
					}
				
				});
			}else{
		layer.msg("方式已存在");
				return;
			} 
			return;
			}
		}); 

	});
	});
	function closed(){
		$.closeDiv($('.editOrigin'));
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


</script> 
</body>
</html> 
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta name="decorator" content="base"/>
<title>系统设置-信息来源</title>
</head>
<body>
<!-- 修改信息来源 -->

<div class="popupBox porigin editOrigin" >
	<h2 class="popupHead">
		修改
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<div class="popupMain">
			<div class="pcontent" id="originbox" >
			<input type="hidden"  value="${township.id }"  id="ids"/>
				<div class="cl mb-10">
				<label class="f-l w-70"><em class="mark">*</em>名称：</label>
				<input type="text" class="input-text w-140 f-l labelname"  value="${township.name }"/>
				<label class="f-l w-90">排序：</label>
				<input type="text" class="input-text w-140 f-l labelsort" value="${township.sort }"/>
			</div>
			</div>
			<div class="text-c mt-25 pt-20">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" id="btnSubmit">保存</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="fanhui()">取消</a>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(function(){
	$('.editOrigin').popup(); 
	$("#btnSubmit").click(function(){
	var ids=document.getElementById("ids").value;

		var names = $(".labelname").val();
		var sorts = $(".labelsort").val();
		if(names==null||names==""){
			layer.msg("请输入名称");
			$(".labelname").focus();
			return;
		}
		if((sorts.length!=0)&&(sorts.match(/\D/)||sorts==0)){
			layer.msg("排序请输入除0以外数字");
			return;
		}

		$.ajax({
			type:'POST',
			url:'${ctx}/order/township/getCheckName',
			traditional: true,
			data:{"name":names,
				     "id":ids}, 
			dataType:'json',
			async:false,
			success:function(result){
		
			if(!result){
				$.ajax({
					type:'POST',
					url:"${ctx}/order/township/update",
					traditional: true,
					data:{
						"name":names,
					    "sort":sorts,
					    "id":ids
					},
					success:function(data){
						layer.msg("修改成功");
						parent.location.reload(); 
						$.closeDiv($(".editOrigin"));
				   // window.location.href="${ctx}/order/orderOrigin";
					}
				});
			}else{
				layer.msg("名字已被使用");
				return;
			} 
			return;
			}
		}); 

	});
	});

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
	function fanhui(){
		$.closeDiv($('.editOrigin'));
	}

</script> 
</body>
</html> 



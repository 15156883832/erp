
 <!DOCTYPE HTML>
<html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<head>
<meta name="decorator" content="base"/>
<title>系统设置-用户类型</title>
</head>
<body>
<!-- 新增信息来源 -->
<div class="popupBox porigin addOrigin" style="z-index: 199;width: 379px;">
	<h2 class="popupHead">
		新增
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<div class="popupMain">
			<div class="pcontent" id="originbox" >
				<div class="cl mb-10">
					<label class="f-l w-90"><em class="mark">*</em>用户类型：</label>
					<input type="text" class="input-text w-140 f-l  labelname" />
					<a href="javascript:;" class="sficon sficon-reduce2 f-l mt-3 ml-5" onclick="delOrigin(this)"  style="display: none;" ></a>
					<a href="javascript:;" class="sficon sficon-add2 f-l mt-3 ml-5 " onclick="addOrigin(this)"></a>
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

	$(function(){
		//新增信息来源
	$('.addOrigin').popup({fixedHeight:false});

		var check = true;
	$("#btnSubmit").click(function(){
	     if(!check){
	         return;
          }	
	     check = false;
		var nameArr = [];
		var names = $(".labelname");
		var nameflag=false;
		var repeatname=false;
		names.each(function(indx,el) {
			nameArr[indx] =$(el).val();
			if(nameArr[indx].length==0){
				nameflag=true;
				check = true;
				layer.msg("请输入用户类型");
			}		
		 
		});	
	     if(nameflag){
	         return;
          }	
		var s = nameArr.join(",")+",";
		for(var i=0;i<nameArr.length;i++) {
			if(s.replace(nameArr[i]+",","").indexOf(nameArr[i]+",")>-1) {
	     		 repeatname=true;
	     		check = true;
	     		 layer.msg("用户类型有重复");
					break;
			}
		}	
    if(repeatname){
    	return;
    }

	$.ajax({
		type:'POST',
		url:'${ctx}/order/customerType/sitequeryNum',
		traditional: true,
		data:{"nameArr":nameArr}, 
		dataType:'json',
		async:false,
		success:function(result){

		if(!result.flag){
				$.ajax({
					type:'POST',
					url:"${ctx}/order/customerType/save",
					traditional: true,
					data:{
						"nameArr":nameArr,
					},
					success:function(data){
						check = true;
						layer.msg("保存成功");
						parent.location.reload(); 
						$.closeDiv($(".addOrigin"));
					}
				});
		}else{
			check = true;
			layer.msg("用户类型已存在!");
			return;
		} 
		}
	});
	});
	});
	
	function closed(){
		$.closeDiv($('.addOrigin'));
	}

	function addOrigin(obj){
		var oParent = $('#originbox');
		var html = '<div class="cl mb-10">'+
						'<label class="f-l w-90"><em class="mark">*</em>用户类型：</label>'+
						'<input type="text" class="input-text w-140 f-l labelname" />'+
						'<a href="javascript:;" class="sficon sficon-reduce2 f-l mt-3 ml-5" onclick="delOrigin(this)" ></a>'+
						'<a href="javascript:;" class="sficon sficon-add2 f-l mt-3 ml-5 " onclick="addOrigin(this)"></a>'+
					'</div>';
		oParent.append(html); 
		$(obj).hide();
		$(obj).prev('a.sficon-reduce2').show();
		$.setPos($('.addOrigin'));	
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
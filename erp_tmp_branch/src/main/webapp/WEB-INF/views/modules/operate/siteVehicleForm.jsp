
 <!DOCTYPE HTML>
<html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<head>
<meta name="decorator" content="base"/>
<title>系统设置-服务方式</title>
</head>
<body>
<!-- 新增信息来源 -->
<div class="popupBox  addOrigin" style="z-index: 199;width: 320px;">
	<h2 class="popupHead">
		新增
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<div class="popupMain">
			<div class="pcontent" id="originbox" >
				<div class="cl mb-10">
					<label class="f-l w-70"><em class="mark">*</em>车辆号码：</label>
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

	$("#btnSubmit").click(function(){
	
		var nameArr = [];
		var names = $(".labelname");

		var nameflag=false;
		var repeatname=false;
		names.each(function(indx,el) {
			nameArr[indx] =$(el).val();
	
			if(nameArr[indx].length==0){
				nameflag=true
				layer.msg("请输入车辆号码");
			}		 
			
		});	
        if(nameflag){
	         return;
         }	
		var s = nameArr.join(",")+",";
		for(var i=0;i<nameArr.length;i++) {
		if(s.replace(nameArr[i]+",","").indexOf(nameArr[i]+",")>-1) {
		      repeatname=true;
		      layer.msg("车辆号码有重复");
		break;
		}
	}
		if(repeatname){
			return;
		}
 

		$.ajax({
			type:'POST',
			url:'${ctx}/operate/siteVehicle/sitequeryNum',
			traditional: true,
			data:{"nameArr":nameArr}, 
			dataType:'json',
			async:false,
			success:function(result){

			if(!result.flag){
				$.ajax({
					type:'POST',
					url:"${ctx}/operate/siteVehicle/save",
					traditional: true,
					data:{
						"number":nameArr	
					},
					success:function(data){
						layer.msg("添加成功");
						parent.location.reload(); 
						$.closeDiv($(".addOrigin"));
					}
				});
			}else{
				layer.msg("车辆号码已存在!");
				return;
			} 
			return;
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
						'<label class="f-l w-70"><em class="mark">*</em>车辆号码：</label>'+
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
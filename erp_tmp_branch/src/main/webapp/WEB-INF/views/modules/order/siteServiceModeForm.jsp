
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
<div class="popupBox porigin addOrigin" style="z-index: 199;">
	<h2 class="popupHead">
		新增
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<div class="popupMain">
			<div class="pcontent" id="originbox" >
				<div class="cl mb-10">
					<label class="f-l w-70"><em class="mark">*</em>服务方式：</label>
					<input type="text" class="input-text w-140 f-l  labelname" />
					<label class="f-l w-60">排序：</label>
					<input type="text" class="input-text w-80 f-l  labelsort" />
					<span class="f-l mr-20  orderMustItem " onclick="oItemChk(this)"><input type="hidden" value="0" class="isDefault">默认选项<i class="oItemChk"></i></span>
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

<input type="hidden" id="siteId" value="${siteId }"/>
<script type="text/javascript">

	function oItemChk(obj){
            if($(obj).hasClass('orderMustChk')){
            	$(obj).removeClass('orderMustChk');
            	$(obj).find('.isDefault').val(0);
             }else{
            	$('.isDefault').val(0);
            	$(".orderMustItem").removeClass('orderMustChk');
            	 
            	$(obj).find('.isDefault').val(1);
            	 $(obj).addClass('orderMustChk');
             } 
	}

	$(function(){
		
		//新增信息来源
	$('.addOrigin').popup({fixedHeight:false});

	$("#btnSubmit").click(function(){
	
		var nameArr = [];
		var sortsArr = [];	
		var isDefaultArr = [];	
		var names = $(".labelname");
		var sorts = $(".labelsort");
		var isdef = $(".isDefault");
		var siteId = $("#siteId").val();
		var numberflag = false;
		var nameflag=false;
		var repeatname=false;
		names.each(function(indx,el) {
			nameArr[indx] =$(el).val();
			sortsArr[indx] = sorts.eq(indx).val();
			isDefaultArr[indx] = isdef.eq(indx).val();
	
			if(nameArr[indx].length==0){
				nameflag=true;
				layer.msg("请输入服务方式名");
			}		 
			if((sortsArr[indx].length!=0)&&(sortsArr[indx].match(/\D/)||sortsArr[indx]==0)){
				numberflag = true;
				layer.msg("排序请输入除0以外数字");
			}
		});	
        if(numberflag||nameflag){
	         return;
         }	
		var s = nameArr.join(",")+",";
		for(var i=0;i<nameArr.length;i++) {
		if(s.replace(nameArr[i]+",","").indexOf(nameArr[i]+",")>-1) {
      repeatname=true;
      layer.msg("服务方式名有重复");
		break;
		}
	}
		if(repeatname){
			return;
		}
 

		$.ajax({
			type:'POST',
			url:'${ctx}/order/serviceMode/sitequeryNum',
			traditional: true,
			data:{"nameArr":nameArr,
				"siteId":siteId}, 
			dataType:'json',
			async:false,
			success:function(result){

			if(!result.flag){
				$.ajax({
					type:'POST',
					url:"${ctx}/order/serviceMode/saveServiceMode",
					traditional: true,
					data:{
						"nameArr":nameArr,
					    "sortsArr":sortsArr,
					    "isDefaultArr":isDefaultArr
					},
					success:function(data){
						if(data == "ok"){
						layer.msg("添加成功");
						parent.location.reload(); 
						$.closeDiv($(".addOrigin"));
							
						}else{
							layer.msg("添加失败");
						}
				    //window.location.href="${ctx}/order/serviceMode";
					}
				});
			}else{
				layer.msg("服务方式已存在!");
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
						'<label class="f-l w-70"><em class="mark">*</em>服务方式：</label>'+
						'<input type="text" class="input-text w-140 f-l labelname" />'+
						'<label class="f-l w-60">排序：</label>'+
						'<input type="text" class="input-text w-80 f-l labelsort" />'+
						'<span class="f-l mr-20  orderMustItem " onclick="oItemChk(this)"><input type="hidden" value="0" class="isDefault">默认选项<i class="oItemChk"></i></span>'+
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

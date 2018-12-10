<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta name="decorator" content="base"/>

<!--[if IE 6]>
<script type="text/javascript" src="lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<title>系统设置-供应商设置——新增商品</title>
</head>
<body>
<!-- 添加 -->
<div class="popupBox gysxzsp"  style="z-index:101;">
	<h2 class="popupHead">
		新增
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<div class="popupMain">
			<div class="pcontent">
				<div class="cl mb-10">
					<label class="f-l w-90"><em class="mark">*</em>供应商名称：</label>
					<input type="text" class="input-text w-140 f-l gyname" />
					<label class="f-l w-110"><em class="mark">*</em>登录账号：</label>
					<input type="text" class="input-text w-140 f-l gylgname" />
				</div>
				<div class="cl mb-10">
					<label class="f-l w-90"><em class="mark">*</em>登录密码：</label>
					<input type="password" class="input-text w-140 f-l gypassword" />
					<label class="f-l w-110">联系人：</label>
					<input type="text" class="input-text w-140 f-l gycontactor"  />
				</div>
				<div class="cl mb-10">
					<label class="f-l w-90"><em class="mark">*</em>手机号：</label>
					<input type="text" class="input-text w-140 f-l gyphone" />
				</div>
				<div class="pl-90 pos-r mb-10" >
					<label class="w-90 lb">备注：</label>
					<textarea class="textarea h-50 gyremark"></textarea>
				</div>
				<div class="pl-90 pos-r " >
					<label class="w-90 lb"><em class="mark">*</em>关联商品：</label>
					<div class="cl" id="relatedSp">
					<c:forEach items="${goodslist }"  var="goods">
					
					<label class="f-l mr-15 mb-10 text-overflow serveb-label" for="${goods.columns.id }">
							<input type="checkbox" name="goods"   id="${goods.columns.id }" value="${goods.columns.id }" />${goods.columns.name  }
						</label>
					
					</c:forEach>
					
					
						<!-- <label class="f-l mr-15 mb-10 text-overflow serveb-label" for="com1">
							<input type="checkbox" name="commodity" checked="checked" id="com1" />格力格力格力格力格力
						</label> -->
					</div>
				</div>
			</div>	
			<div class="text-c mt-20">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5"  id="btnSubmit">保存</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5"  onclick="closed()">取消</a>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">

function getJson(){
	var goodslist =[];
	$('input[name="goods"]:checked').each(function(){
		goodslist.push($(this).val());
	});

	var json = {
	  "name":$(".gyname").val(),
	  "loginName":$(".gylgname").val(),
	  "password":$(".gypassword").val(),
	  "contactor":$(".gycontactor").val(),
	  "mobile":$(".gyphone").val(),
	  "remarks":$(".gyremark").val(),
	  "goodslist":goodslist
	    };
	    return json;
}
	
	$(function(){
		$('.gysxzsp').popup();
		selectCommodity();
		$("#btnSubmit").click(function(){
			var goodslist =[];
			$('input[name="goods"]:checked').each(function(){
				goodslist.push($(this).val());
				
			});
			
			var name=$(".gyname").val();
			var loginName=$(".gylgname").val();
			var password=$(".gypassword").val();
			var contactor=$(".gycontactor").val();
			var mobile=$(".gyphone").val();
			var remarks=$(".gyremark").val();
	
		var moliereg=/^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$|(^(1[0-9])\d{9}$)/;
		if(name==null||name==""){
			layer.msg("供应商名称为必填项");
			return;
		}
		if(loginName==null||loginName==""){
			layer.msg("供应商登录名为必填项");
			return;
		}
		if(password==null||password==""){
			layer.msg("供应商登陆密码为必填项");
			return;
		}
		if(mobile.length>0){
			if(!moliereg.test(mobile)){
				layer.msg("联系方式格式不正确");
				return;
			}
		}else{
			layer.msg("请输入联系方式");
			return;
		}
		if(goodslist.length==0){
			layer.msg("供应商关联商品必选");
			return;
		}
		


			$.ajax({
				type:'POST',
				url:'${ctx}/order/supplier/querysupplierById',//判断是否重名同时也要判断登录名是否重名
				traditional: true,
				data:{"name":name,
					     "loginName":loginName
					    }, 
				dataType:'json',
				async:false,
				success:function(result){
				if(result.flag){
					$.ajax({
						type:'POST',
						contentType: "application/json; charset=utf-8",
						url:"${ctx}/order/supplier/addsupplier",//添加
						traditional: true,
						data: JSON.stringify(getJson()),
				
						success:function(data){
							if(data=="ok"){
								layer.msg("添加成功");
								parent.location.reload(); 
								$.closeDiv($(".gysxzsp"));
							}else{
								layer.msg(data);
							}
						
					    //window.location.href="${ctx}/order/supplier";
						//window.location.reload(true);
						}
					
					});
				}else{
			layer.msg("供应商或登录名已存在");
					return;
				} 
				return;
				}
			}); 

		});
	});
	
	function selectCommodity(){
		var goods = $('#relatedSp input[name="goods"]');
		goods.each(function(){
			$(this).bind('click',function(){
				if($(this).is(':checked')){
					$(this).parent('label').addClass('serveb-labelSel');	
				}else{
					$(this).parent('label').removeClass('serveb-labelSel');
				}
			});
		});
	}
	
	function closed(){
		$.closeDiv($('.gysxzsp'));
	}
		
</script> 
</body>
</html>
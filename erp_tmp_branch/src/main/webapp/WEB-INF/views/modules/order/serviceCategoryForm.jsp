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
<title>系统设置——新增系统服务品类</title>
</head>
<body>
<!-- 添加 -->
<div class="popupBox gysxzsp"  >
	<h2 class="popupHead">
		系统服务品类
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<div class="popupMain">
			<div class="pcontent">

				<div class="pl-90 pos-r " >
					<label class="w-90 lb"><em class="mark">*</em>系统品类：</label>
					<div class="cl" id="relatedSp">
					<c:forEach items="${syscateList }"  var="cate">
					<c:choose>
					<c:when test="${fn:contains(categorylist,cate.columns.name)}">
					<label class="f-l mr-15 mb-10 text-overflow serveb-label serveb-labelSel" for="${cate.columns.id }">
							<input type="checkbox" name="goods"   id="${cate.columns.id }" value="${cate.columns.name }" />${cate.columns.name  }
						</label>
						</c:when>
							<c:otherwise>
					<label class="f-l mr-15 mb-10 text-overflow serveb-label" for="${cate.columns.id }">
							<input type="checkbox" name="goods"   id="${cate.columns.id }" value="${cate.columns.name }" />${cate.columns.name  }
						</label>
					</c:otherwise>
					</c:choose>
				
					
					
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

	
	$(function(){
		selectCommodity();
		var max='${max}';
		$('.gysxzsp').popup();
		
		$("#btnSubmit").click(function(){
			var catelist =[];
			$('input[name="goods"]:checked').each(function(){
				catelist.push($(this).val());
				
			});
			


			$.ajax({
				type:'POST',
				url:'${ctx}/order/category/querycateByname',//判断是否重名同时也要判断登录名是否重名
				traditional: true,
				data:{"catelist":catelist
					    }, 
				//dataType:'json',
				//async:false,
				success:function(result){
				if(result==null||result.length==0){
					$.ajax({
						type:'POST',
						//contentType: "application/json; charset=utf-8",
						url:"${ctx}/order/category/addMoresys",//添加
						traditional: true,
						data: {
							"catelist":catelist,
							"max":max
						},
				
						success:function(data){
							layer.msg("添加成功");
							parent.location.reload(); 
							$.closeDiv($(".gysxzsp"));
						}
				
					});
				}else{
			layer.msg(result+"已存在");
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
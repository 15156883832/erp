<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>
    <meta name="decorator" content="base"/>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/>
    <script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
<title>绑定区域人员</title>
</head>
<body>
<!-- 修改信息来源 -->

<div class="popupBox sysNotice editeNotice" style="width:400px">
	<h2 class="popupHead">
		绑定区域人员
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
				<div class="popupMain pt-25 pr-25 pb-15">
				<input type="hidden" id="siteIds" value="${ids }" name="siteIds">
			<div class="cl mb-10 pl-10">
				<label class="w-100 text-r f-l">区域人员：</label>
					<select class="select" multiline="false"  id="paraS" placeholder="请选择" name="serviceName" style="width:200px;height:25px" panelMaxHeight="200px">
                          <option value="">请选择</option>
                          <c:forEach var="service" items="${supplist}">
                              <option value="${service.columns.id}">${service.columns.name}</option>
                          </c:forEach>
					</select>
							
			</div>
			<div class="text-c mt-20">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" id="btn-publish" onclick="fabu()">确认</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70" onclick="closeds()">取消</a>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(function(){
	 $('#paraS').select2();
	$('.editeNotice').popup();
	   $(".selection").css("width","200px");
	});
	
	function closeds(){
		$.closeDiv($('.editeNotice'));
	}


	function fabu(){
		var siteid=$("#siteIds").val();
		var areaid=$("#paraS").val();
		 if (isBlank(areaid)) {
				layer.msg("请选择区域人员");
				return
		 }
		$.ajax({
			type:'POST',
			url:"${ctx}/order/areaManager/binding",
			traditional: true,
			data:{
				"siteids":siteid,
				"areaid":areaid
			},
			success:function(result){
				if(result=="ok"){
					parent.layer.msg("绑定成功！");
					parent.location.reload(); 
					$.closeDiv($(".editeNotice"));
				}else if(result!=""){
					layer.msg(result);
					return;
				}else{
					layer.msg("绑定失败");
					return;
				}
			},
			error:function(){
				layer.msg("系统繁忙请稍后重试")
				return;
			}
		})
	}

	function isBlank(val) {
		if(val==null || val=='' || val == undefined) {
			return true;
		}
		return false;
	}

</script> 
</body>
</html> 
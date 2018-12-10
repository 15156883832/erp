<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
  <head>
    
     <meta name="decorator" content="base"/> 
 <script type="text/javascript" src="${ctxPlugin}/lib/bootstrap-Switch/bootstrapSwitch.js" ></script> 

<style type="text/css">
.ui-jqgrid label {
width: 50px;
height: 30px;
background: white;

}
</style><!--改变开关的样式  -->
  </head>
  <body>
	<div class="sfpagebg bk-gray"><div class="sfpage">
		<div class="page-orderCaution">
			<div class="HuiTab">
				<div class="tabBar cl mb-10">
					<%--<sfTags:pagePermission authFlag="SMSMGM_SIGN_SET_TAB" html='<a class="btn-tabBar " href="${ctx}/order/smstempletSet/headlist">短信签名设置</a>'/>--%>
					<sfTags:pagePermission authFlag="SMSMGM_SIGN_CREATETEMP_TAB" html=' <a class="btn-tabBar  " href="${ctx}/order/smstempletSet/headlist">短信模板设置</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="SMSMGM_SIGN_SEND_TAB" html='<a class="btn-tabBar current" href="${ctx}/order/commonsetting/getShortmessage">短信发送设置</a>'/>
				</div>
				<div class="pt-10 pl-20" id="radioWrap">
					<span class="lh-20">工单派工后提示发送短信：</span>
					
					<c:choose>
					<c:when test="${rds.columns.set_value eq '1'}">
					<span class="radiobox "><input type="radio" name="setvalue" value="0" >不提示</span>
					<span class="radiobox ml-20 radiobox-selected"><input type="radio" name="setvalue" value="1" >提示</span>
					</c:when>
					<c:otherwise>
					<span class="radiobox radiobox-selected"><input type="radio" name="setvalue" value="0" >不提示</span>
					<span class="radiobox ml-20"><input type="radio" name="setvalue" value="1" >提示</span>
					</c:otherwise>
					</c:choose>
				</div>
				
				<input type="hidden" name="id" id="setvalueid" value="${rds.columns.id }">
			
				
				<div class="pt-15 pl-20"><a href="javascript:updateOper();"  class="sfbtn sfbtn-opt3 w-80">保存</a></div>
			</div>
		</div>
	</div></div>
	
<script type="text/javascript">

$(function(){
	$('#radioWrap').on('click','.radiobox', function(){
		$('#radioWrap .radiobox').removeClass('radiobox-selected');
		$(this).addClass('radiobox-selected');
	});
})

function updateOper(){
	var id = $("#setvalueid").val();
	var setvalue = $(".radiobox-selected input").val();
	 $.ajax({
		type:"POST",
		url:"${ctx}/order/commonsetting/setSMSsettings",
		data:{
			id:id,
			setvalue:setvalue
			}, 
		success:function(result){
			if(result == "ok"){
				layer.msg("保存成功！");
			}else{
				layer.msg("保存失败！");
			}
		}
	}); 
}

</script>

</body>
  </body>
</html>
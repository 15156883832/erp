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
					<sfTags:pagePermission authFlag="SYSSETTLE_SETTLEMENTTEMP_SETTLEMENT_TAB" html='<a class="btn-tabBar " href="${ctx}/order/settlementTemplate/list">结算方案设置</a>'></sfTags:pagePermission>
					<%--<a class="btn-tabBar current" href="${ctx}/order/commonsetting/settingvalue">结算显示设置</a>--%>
					<sfTags:pagePermission authFlag="SYSSETTLE_SETTLEMENTTEMP_SETTLEMENT_CONDITIONS_TAB" html='<a class="btn-tabBar " href="${ctx}/order/commonsetting/conditionsSet">结算条件设置</a>'></sfTags:pagePermission>
				</div>
				<div class="pl-120 pos-r ml-20" id="radioWrap1">
					<span class="lh-20">结算明细是否显示：</span>
					<c:if test="${rds1 eq null }">
						<input type="hidden" name="id1" id="setvalueid1" value="">
						<span class="radiobox radiobox-selected"><input type="radio" name="showFlag" value="1" >显示</span>
						<span class="radiobox ml-20 "><input type="radio" name="showFlag" value="0" >不显示</span>
					</c:if>
					
					<c:if test="${rds1 ne null }">
						<input type="hidden" name="id1" id="setvalueid1" value="${rds1.columns.id}">
						<c:choose>
						<c:when test="${rds1.columns.set_value eq '1'}"> 
						<span class="radiobox radiobox-selected"><input type="radio" name="showFlag" value="1" >显示</span>
						<span class="radiobox ml-20 "><input type="radio" name="showFlag" value="0" >不显示</span>
						 </c:when>
						<c:otherwise>
						<span class="radiobox "><input type="radio" name="showFlag" value="1" >显示</span>
						<span class="radiobox ml-20 radiobox-selected"><input type="radio" name="showFlag" value="0" >不显示</span>
						</c:otherwise>
						</c:choose>
					</c:if>
				</div></br>
				
				<div class="pl-120 pos-r ml-20" id="radioWrap">
				<input type="hidden" name="id" id="setvalueid" value="${rds.columns.id }">
					<span class="w-120 lh-20 pos_aT ">工程师APP结算费：</span>
					<div class="cl pt-15">
					<c:choose>
					<c:when test="${rds.columns.set_value eq '2'}">
						<div class="col-3-1 f-l ">
							<img src="${ctxPlugin}/static/h-ui.admin/images/img_js1.png" class="mb-15" /><br>
							<span class="radiobox ml-10"><input type="radio" name="setvalue" value="3" >按结算归属日期显示（默认）</span>
						</div>
						<div class="col-3-1 f-l ">
							<img src="${ctxPlugin}/static/h-ui.admin/images/img_js2.png" class="mb-15"  /><br>
							<span class="radiobox radiobox-selected ml-30"><input type="radio" name="setvalue" value="2" >按工单完成时间显示</span>
						</div>
						<div class="col-3-1 f-l ">
							<img src="${ctxPlugin}/static/h-ui.admin/images/img_js3.png" class="mb-15"  /><br>
							<span class="radiobox ml-30 "><input type="radio" name="setvalue" value="1" >按工单报修时间显示</span>
						</div>
				
					</c:when>
					<c:when test="${rds.columns.set_value eq '1'}">
					<div class="col-3-1 f-l ">
							<img src="${ctxPlugin}/static/h-ui.admin/images/img_js1.png" class="mb-15" /><br>
							<span class="radiobox ml-10"><input type="radio" name="setvalue" value="3" >按结算归属日期显示（默认）</span>
						</div>
						<div class="col-3-1 f-l ">
							<img src="${ctxPlugin}/static/h-ui.admin/images/img_js2.png" class="mb-15"  /><br>
							<span class="radiobox ml-30"><input type="radio" name="setvalue" value="2" >按工单完成时间显示</span>
						</div>
						<div class="col-3-1 f-l ">
							<img src="${ctxPlugin}/static/h-ui.admin/images/img_js3.png" class="mb-15"  /><br>
							<span class="radiobox radiobox-selected ml-30 "><input type="radio" name="setvalue" value="1" >按工单报修时间显示</span>
						</div>
					</c:when>
					<c:otherwise>
					<div class="col-3-1 f-l ">
							<img src="${ctxPlugin}/static/h-ui.admin/images/img_js1.png" class="mb-15" /><br>
							<span class="radiobox radiobox-selected ml-10"><input type="radio" name="setvalue" value="3" >按结算归属日期显示（默认）</span>
						</div>
						<div class="col-3-1 f-l ">
							<img src="${ctxPlugin}/static/h-ui.admin/images/img_js2.png" class="mb-15"  /><br>
							<span class="radiobox ml-30"><input type="radio" name="setvalue" value="2" >按工单完成时间显示</span>
						</div>
						<div class="col-3-1 f-l ">
							<img src="${ctxPlugin}/static/h-ui.admin/images/img_js3.png" class="mb-15"  /><br>
							<span class="radiobox ml-30 "><input type="radio" name="setvalue" value="1" >按工单报修时间显示</span>
						</div>
					</c:otherwise>
					</c:choose>
						
						
					</div>
				</div>
				<div class="ml-20 mt-20">
					<p class="lh-22"><span class="iconDec"></span>注释：默认是按照工单结算归属时间显示，也可以修改为按照工单完工时间或工单报修时间显示;</p>
					<p class="pl-60">在设置完成之后，可在思傅帮APP>>首页>>工单结算、思傅帮APP>>我的>>工单结算页面查看修改结果。</p>
				</div>
				<div class="text-c mt-30"><a href="javascript:updateOper();"  class="sfbtn sfbtn-opt3 w-80">保存</a></div>
			</div>
		</div>
	</div></div>
	
<script type="text/javascript">

$(function(){
	$('#radioWrap').on('click','.radiobox', function(){
		$('#radioWrap .radiobox').removeClass('radiobox-selected');
		$(this).addClass('radiobox-selected');
	});
	
	$('#radioWrap1').on('click','.radiobox', function(){
		$('#radioWrap1 .radiobox').removeClass('radiobox-selected');
		$(this).addClass('radiobox-selected');
	});
})

function updateOper(){
	var id = $("#setvalueid").val();
	var id1 = $("#setvalueid1").val();
	var setvalue = $(".radiobox-selected input[name='setvalue']").val();
	var showFlag = $(".radiobox-selected input[name='showFlag']").val();
	 $.ajax({
		type:"POST",
		url:"${ctx}/order/commonsetting/setSaveCommen",
		data:{
			id:id,
			id1:id1,
			setvalue:setvalue,
			showFlag:showFlag
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
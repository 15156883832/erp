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
.hfjs,.hfjs1{
	width: 110px;
}
</style><!--改变开关的样式  -->
  </head>
  
  <body>
	
	<div class="sfpagebg bk-gray"><div class="sfpage">
		<div class="page-orderCaution">
			<div class="HuiTab">
				<div class="tabBar cl mb-10">
					<sfTags:pagePermission authFlag="SYSSETTLE_SETTLEMENTTEMP_SETTLEMENT_TAB" html='<a class="btn-tabBar " href="${ctx}/order/settlementTemplate/list">结算方案设置</a>'></sfTags:pagePermission>
					<%--<a class="btn-tabBar " href="${ctx}/order/commonsetting/settingvalue">结算显示设置</a>--%>
					<sfTags:pagePermission authFlag="SYSSETTLE_SETTLEMENTTEMP_SETTLEMENT_CONDITIONS_TAB" html='<a class="btn-tabBar current " href="${ctx}/order/commonsetting/conditionsSet">结算条件设置</a>'></sfTags:pagePermission>
				</div>
				<div class="pl-120 pos-r ml-20 mt-30" id="chkWrap1">
					<label class="lh-20 pos w-120">结算明细是否显示：</label>
					<c:if test="${rds1 eq null }">
						<input type="hidden" name="id1" id="setvalueid1" value="">
						<span class="label-cbox   hfjs"><input type="radio" name="showFlag" value="1" >先回访再结算</span>
						<span class="label-cbox  ml-20 isequal"><input type="radio" name="showFlag" value="0" >交款总额 = 实收总额</span>
					</c:if>
					
					<c:if test="${rds1 ne null }">
						<input type="hidden" name="id1" id="setvalueid1" value="${rds1.columns.id}">
						<c:if test="${rds1.columns.set_value eq '0'}">
							<span class="label-cbox label-cbox-selected hfjs"><input type="radio" name="showFlag" value="0" >先回访再结算</span>
							<span class="label-cbox ml-20 isequal"><input type="radio" name="showFlag" value="1" >交款总额 = 实收总额</span>
						</c:if>
						<c:if test="${rds1.columns.set_value eq '1'}">
							<span class="label-cbox  hfjs"><input type="radio" name="showFlag" value="0" >先回访再结算</span>
							<span class="label-cbox label-cbox-selected ml-20 isequal"><input type="radio" name="showFlag" value="1" >交款总额 = 实收总额</span>
						</c:if>
						<c:if test="${rds1.columns.set_value eq '2'}">
							<span class="label-cbox label-cbox-selected  hfjs"><input type="radio" name="showFlag" value="0" >先回访再结算</span>
							<span class="label-cbox label-cbox-selected ml-20 isequal"><input type="radio" name="showFlag" value="1" >交款总额 = 实收总额</span>
						</c:if>
						<c:if test="${rds1.columns.set_value eq '3'}">
							<span class="label-cbox   hfjs"><input type="radio" name="showFlag" value="0" >先回访再结算</span>
							<span class="label-cbox  ml-20 isequal"><input type="radio" name="showFlag" value="1" >交款总额 = 实收总额</span>
						</c:if>
					</c:if>
				</div>
				<div class="pl-120 pos-r ml-20 mt-30" id="chkWrap2">
					<label class="lh-20 pos w-120">结算归属时间设置：</label>
					<span class="label-cbox hfjs1 ${gss eq '1' ? "label-cbox-selected" : ''}"><input type="radio" name="gstime" value="1" >默认为完工时间</span>
					<span class="label-cbox ml-20 ${gss eq '2' ? "label-cbox-selected" : ''}"><input type="radio" name="gstime" value="2" >默认为结算时间</span>
				</div>
				<!-- <div class="ml-20 mt-20">
					<p class="lh-22"><span class="iconDec"></span>注释：默认是按照工单结算归属时间显示，也可以修改为按照工单完工时间或工单报修时间显示;</p>
					<p class="pl-60">在设置完成之后，可在思傅帮APP>>首页>>工单结算、思傅帮APP>>我的>>工单结算页面查看修改结果。</p>
				</div> -->
				<div class="pl-120 mt-30 ml-20"><a href="javascript:updateOper();"  class="sfbtn sfbtn-opt3 w-80">保存</a></div>
			</div>
		</div>
	</div></div>
	
<script type="text/javascript">


	$(function() {
		$('#chkWrap1').on('click', '.label-cbox', function() {
			if ($(this).hasClass('label-cbox-selected')) {
				$(this).removeClass('label-cbox-selected');
			} else {
				$(this).addClass('label-cbox-selected');
			}
		});
        $('#chkWrap2').on('click', '.label-cbox', function() {
            if ($(this).hasClass('label-cbox-selected')) {
//                $(this).removeClass('label-cbox-selected');
            } else {
                $(".label-cbox", $('#chkWrap2')).removeClass("label-cbox-selected");
                $(this).addClass('label-cbox-selected');
            }
        });
	});

	var updating = false;
	function updateOper() {
        if (updating) {
            return;
        }

		var showFlag;
		if ($(".hfjs").hasClass('label-cbox-selected')) {//先回访在结算
			if ($(".isequal").hasClass('label-cbox-selected')) {
				showFlag = "2";
			} else {
				showFlag = "0";
			}
		} else {
			if ($(".isequal").hasClass('label-cbox-selected')) {
				showFlag = "1";
			} else {
				showFlag = "3";
			}
		}
		var id1 = $("#setvalueid1").val();

		updating = true;
		$.ajax({
			type : "POST",
			url : "${ctx}/order/commonsetting/setSaveCommenConditons",
			data : {
				id1 : id1,
				showFlag : showFlag,
				gsTime: ($('.label-cbox-selected', $('#chkWrap2')).find('input').val() || '1')
			},
			success : function(result) {
				if (result === "ok") {
					layer.msg("保存成功！");
				} else {
					layer.msg("保存失败！");
				}
			},
			complete: function() {
			    updating = false;
			}
		});
	}
</script>

</body>
</html>
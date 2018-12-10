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
					<sfTags:pagePermission authFlag="SYSSETTLE_GOODSMSGSET_GOODSCATESET_TAB" html='<a class="btn-tabBar  " href="${ctx}/order/goodscategory">商品类别设置</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="SYSSETTLE_GOODSMSGSET_GOODSLIRUNSET_TAB" html='<a class="btn-tabBar  current" href="${ctx}/order/goodscategory/goodsSalesSet">商品利润设置</a>'></sfTags:pagePermission>
				</div>
				<div class="pl-120 pos-r ml-20 mt-30" id="chkWrap1">
					<input hidden="hidden" id="salesId" value="${salesSet.columns.id }" />
					<c:if test="${salesSet ne null }">
						<label class="lh-20 pos w-120">商品利润计算公式：</label>
						<span class="radiobox <c:if test="${salesSet.columns.set_value eq 1 }">radiobox-selected</c:if>" ><input type="radio" name="showFlag" value="1" >成交价-入库价格</span>
						<span class="radiobox ml-20 <c:if test="${salesSet.columns.set_value eq 2 }">radiobox-selected</c:if>"><input type="radio" name="showFlag" value="2" >成交价-工程师价格</span>
						<span class="radiobox ml-20 <c:if test="${salesSet.columns.set_value eq 3 }">radiobox-selected</c:if>"><input type="radio" name="showFlag" value="3" >成交价</span>
					</c:if>
					<c:if test="${salesSet eq null }">
						<label class="lh-20 pos w-120">商品利润计算公式：</label>
						<span class="radiobox radiobox-selected" ><input type="radio" name="showFlag" value="1" >成交价-入库价格</span>
						<span class="radiobox ml-20 "><input type="radio" name="showFlag" value="2" >成交价-工程师价格</span>
						<span class="radiobox ml-20 "><input type="radio" name="showFlag" value="3" >成交价</span>
					</c:if>
				</div>
				<div class="pl-120 mt-30 ml-20"><a href="javascript:updateOper();"  class="sfbtn sfbtn-opt3 w-80">确定</a></div>
			</div>
		</div>
	</div></div>

	<script type="text/javascript">
		$(function() {
			$('#chkWrap1').on('click','.radiobox', function(){
				$('#chkWrap1 .radiobox').removeClass('radiobox-selected');
				$(this).addClass('radiobox-selected');
			});
		})
		
		var marks=false;
		function updateOper() {
			if(marks){
				return;
			}
			var salesSet = $(".radiobox-selected input[name='showFlag']").val();
			var id = $("#salesId").val();
			marks=true;
			$.ajax({
				type : "POST",
				url : "${ctx}/order/goodscategory/setSaveSalesSave",
				data : {
					id : id,
					salesSet : salesSet
				},
				success : function(result) {
					if (result == "ok") {
						layer.msg("保存成功！");
						window.location.reload();
					} else {
						layer.msg("保存失败！");
						
					}
					marks=false;
					return;
				}
			});
		}
	</script>

</body>
  </body>
</html>
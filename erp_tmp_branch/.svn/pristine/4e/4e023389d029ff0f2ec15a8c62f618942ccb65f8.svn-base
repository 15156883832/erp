<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html> 	
  <head>
    <title>My JSP 'proLimitList.jsp' starting page</title>
    <meta name="decorator" content="base"/>
    <script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>

  </head>
  
  <body>
 <div class="sfpagebg bk-gray">
 	<div class="sfpage">
	 	<div class="page-orderCaution">
 			<div class="cl mt-30">
				<div class="f-l mr-40">
					<label class=" w-90 text-r f-l">联系电话：</label>
					<input type="text" class="input-text w-200 f-l" id="smsPhone" maxlength="20"  value="${site.columns.repair_phone }"/>
					
				</div>
				<div class=" f-l ml-30" id="imgShows"> 
					<label class="f-l">示例：</label>
					<img alt="" src="${ctxPlugin}/static/h-ui.admin/images/img_lxfs.png" class="f-l" />
				</div>
			</div>
			<div class="mt-20 pl-90">
				<a href="javascript:baocun();" class="sfbtn sfbtn-opt3 w-70">保存</a>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
function baocun(){
	var smsPhone=$("#smsPhone").val();
	/* var pattern = /^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$|(^(1[0-9])\d{9}$)/; 
	if(!smsPhone.match(pattern)){
		layer.msg("联系方式格式不正确");
		$("#smsPhone").focus();
		return;
	} */
	if($.trim(smsPhone)=='' || smsPhone==null){
		layer.msg("请输入联系方式！");
		$("#smsPhone").focus();
		return;
	}
	$.ajax({
		type:'POST',
		url:'${ctx}/order/siteSet/updateRrepairPhone',
		dataType:'json',
		data:{"smsPhone":smsPhone}, 
		success:function(result){
			if(result.code=="200"){
				layer.msg("保存成功！")
				setTimeout(function(){
					window.location.reload(true);
				},100);
				return;
			}else{
				layer.msg("保存失败,请稍后重试！");
				return;
			}
		},
		error:function(){
			layer.msg("系统错误,请稍后重试");
			return;
		}
	}) 
}
$("#imgShows").imgShow();
</script>
  </body>
</html>
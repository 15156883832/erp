<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
  <head>
    
    <meta name="decorator" content="base"/>

   <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script> 
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/>
	<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">style="width: 110px;"
	-->
	<style type="text/css">
		.textbox{
			width: 110px;
		}
	</style>
  </head>
  
  <body>
   <div class="popupBox fwsxq" >
	<h2 class="popupHead">
		服务商详情
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<form  id="statisticsForm">
	<div class="popupContainer">
		<div class="popupMain pd-15">
			<div class="cl mb-10">
				<label class="f-l w-100">服务商名称：</label>
				<input type="text" class="input-text w-380 f-l readonly" readonly="readonly"  value="${rds.columns.name }" />
				<label class="f-l w-100">当前版本：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly"  value="${rds.columns.version }" />
				<label class="f-l w-100">注册日期：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly"  value="${rds.columns.create_time }" />
			</div>
			<div class="cl mb-10">
				<label class="f-l w-100">最新购买日期：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly"  value="${rds.columns.purchase_time }" />
				<label class="f-l w-100">到期日期：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly"  value="${rds.columns.due_time }" />
			</div>

			<div class="cl mb-10 pl-100 pos-r">
				<label class="w-100 pos">服务品类：</label>
				<textarea class="textarea readonly"  readonly="readonly"  style="50px;height: 70px;">${category }
				</textarea>
			</div>
			<div class="line-dashed mb-10"></div>
			
			<div class="cl mb-10">
				<label class="f-l w-100"><em class="mark">*</em>联系结果：</label>
				<select class="select w-120 f-l" name="contactResults" id="contact_results">
					<option value="" >--请选择--</option>
						<c:choose>
						<c:when test="${rds.columns.contact_results eq '已续费'}">
						 <option value="已续费" selected="selected">已续费</option>
				         <option value="不续费">不续费</option>
				         <option value="不确定">不确定</option>
				         <option value="未联系上">未联系上</option>
				         <option value="可续费">可续费</option>
						 <option value="漏保跟踪">漏保跟踪</option>
				         <option value="要跟进">要跟进</option>
				         <option value="不会用">不会用</option>
				         <option value="无需联系">无需联系</option>
						</c:when>
						<c:when test="${rds.columns.contact_results eq '不续费'}">
						 <option value="已续费" >已续费</option>
				         <option value="不续费" selected="selected">不续费</option>
				         <option value="不确定">不确定</option>
				         <option value="未联系上">未联系上</option>
				         <option value="可续费">可续费</option>
						 <option value="漏保跟踪">漏保跟踪</option>
				         <option value="要跟进">要跟进</option>
				         <option value="不会用">不会用</option>
				         <option value="无需联系">无需联系</option>
						</c:when>
						<c:when test="${rds.columns.contact_results eq '不确定'}">
						 <option value="已续费" >已续费</option>
				         <option value="不续费">不续费</option>
				         <option value="不确定" selected="selected">不确定</option>
				         <option value="未联系上">未联系上</option>
				         <option value="可续费">可续费</option>
						 <option value="漏保跟踪">漏保跟踪</option>
				         <option value="要跟进">要跟进</option>
				         <option value="不会用">不会用</option>
				         <option value="无需联系">无需联系</option>
						</c:when>
						<c:when test="${rds.columns.contact_results eq '未联系上'}">
						 <option value="已续费" >已续费</option>
				         <option value="不续费">不续费</option>
				         <option value="不确定">不确定</option>
				         <option value="未联系上" selected="selected">未联系上</option>
				         <option value="可续费">可续费</option>
						 <option value="漏保跟踪">漏保跟踪</option>
				         <option value="要跟进">要跟进</option>
				         <option value="不会用">不会用</option>
				         <option value="无需联系">无需联系</option>
						</c:when>
						<c:when test="${rds.columns.contact_results eq '可续费'}">
						 <option value="已续费" >已续费</option>
				         <option value="不续费">不续费</option>
				         <option value="不确定">不确定</option>
				         <option value="未联系上">未联系上</option>
				         <option value="可续费" selected="selected">可续费</option>
						 <option value="漏保跟踪">漏保跟踪</option>
				         <option value="要跟进">要跟进</option>
				         <option value="不会用">不会用</option>
				         <option value="无需联系">无需联系</option>
						</c:when>
						<c:when test="${rds.columns.contact_results eq '要跟进'}">
						 <option value="已续费" >已续费</option>
				         <option value="不续费">不续费</option>
				         <option value="不确定">不确定</option>
				         <option value="未联系上">未联系上</option>
				         <option value="可续费">可续费</option>
						<option value="要跟进" selected="selected">要跟进</option>
						 <option value="漏保跟踪">漏保跟踪</option>
				         <option value="不会用">不会用</option>
				         <option value="无需联系">无需联系</option>
						</c:when>
						<c:when test="${rds.columns.contact_results eq '漏保跟踪'}">
						 <option value="已续费" >已续费</option>
				         <option value="不续费">不续费</option>
				         <option value="不确定">不确定</option>
				         <option value="未联系上">未联系上</option>
				         <option value="可续费">可续费</option>
						<option value="要跟进" >要跟进</option>
						 <option value="漏保跟踪" selected="selected">漏保跟踪</option>
				         <option value="不会用">不会用</option>
				         <option value="无需联系">无需联系</option>
						</c:when>
						<c:when test="${rds.columns.contact_results eq '不会用'}">
						 <option value="已续费" >已续费</option>
				         <option value="不续费">不续费</option>
				         <option value="不确定">不确定</option>
				         <option value="未联系上">未联系上</option>
				         <option value="可续费">可续费</option>
						<option value="要跟进">要跟进</option>
						 <option value="漏保跟踪">漏保跟踪</option>
				         <option value="不会用" selected="selected">不会用</option>
				         <option value="无需联系">无需联系</option>
						</c:when>
						<c:when test="${rds.columns.contact_results eq '无需联系'}">
						 <option value="已续费" >已续费</option>
				         <option value="不续费">不续费</option>
				         <option value="不确定">不确定</option>
				         <option value="未联系上">未联系上</option>
				         <option value="可续费">可续费</option>
						<option value="要跟进">要跟进</option>
						 <option value="漏保跟踪">漏保跟踪</option>
				         <option value="不会用" >不会用</option>
				         <option value="无需联系" selected="selected">无需联系</option>
						</c:when>
						<c:otherwise>
						 <option value="已续费" >已续费</option>
				         <option value="不续费">不续费</option>
				         <option value="不确定">不确定</option>
				         <option value="未联系上">未联系上</option>
				         <option value="可续费">可续费</option>
						 <option value="漏保跟踪">漏保跟踪</option>
				         <option value="要跟进">要跟进</option>
				         <option value="不会用">不会用</option>
				         <option value="无需联系">无需联系</option>
						</c:otherwise>
						</c:choose>	       
			        
				</select>
				<label class="f-l w-80"><em class="mark">*</em>使用情况：</label>
				<!-- <select class="select w-120 f-l" name="usage" id="usage"> -->
				<input type="hidden" name="usage" id="usage"  >
				<span class="w-130 f-l">
				<select class="select  easyui-combobox"  id="statusFlag" multiple="true" multiline="false"  panelMaxHeight="320px">
					 <%--<option value="" class="hide">--请选择--</option>--%>
				
					 <option value="全部都用">全部都用</option>
		        	 <option value="只用工单">只用工单</option>
		        	 <option value="只用助手">只用助手</option>
		        	 <option value="之前有用">之前有用</option>
		        	 <option value="学习使用">学习使用</option>
		        	 <option value="一直未用">一直未用</option>
		        	 <option value="标记跟进">标记跟进</option>
		        	 <option value="使用结算">使用结算</option>
		        	 <option value="使用备件">使用备件</option>
		        	 <option value="只维护备件">只维护备件</option>
		        	 <option value="使用商品">使用商品</option>
		        	 <option value="只维护商品">只维护商品</option>
		        	 <option value="无现金收款">无现金收款</option>
		        	 <option value="人员维护">人员维护</option>
					 <%-- 	</c:otherwise>
					 </c:choose> --%>
		        	 
				</select>
			</span>
				<label class="f-l w-80">跟进方式：</label>
				<select class="select w-120 f-l" name="followUpMethod">
				<option value="">请选择</option>
				<c:choose>
				<c:when test="${rds.columns.follow_up_method eq 'QQ'}">
					<option value="QQ" selected="selected">QQ</option>
					<option value="电话">电话</option>
			        <option value="微信">微信</option>
			        <option value="短信">短信</option>
				</c:when>
				<c:when test="${rds.columns.follow_up_method eq '电话'}">
					<option value="QQ">QQ</option>
					<option value="电话" selected="selected">电话</option>
			        <option value="微信">微信</option>
			        <option value="短信">短信</option>
				</c:when>
				<c:when test="${rds.columns.follow_up_method eq '微信'}">
					<option value="QQ">QQ</option>
					<option value="电话">电话</option>
			        <option value="微信" selected="selected">微信</option>
			        <option value="短信">短信</option>
				</c:when>
				<c:when test="${rds.columns.follow_up_method eq '短信'}">
					<option value="QQ">QQ</option>
					<option value="电话">电话</option>
			        <option value="微信">微信</option>
			        <option value="短信" selected="selected">短信</option>
				</c:when>
				<c:otherwise>
				<option value="QQ">QQ</option>
					<option value="电话">电话</option>
			        <option value="微信">微信</option>
			        <option value="短信">短信</option>
				</c:otherwise>
				</c:choose>
				</select>
				<label class="f-l w-80">预约时间：</label>
				<input type="text" onfocus="WdatePicker({minDate:'%y-%M-%d'})" name="promiseTime" value="${rds.columns.promise_time }" class="input-text Wdate w-120 f-l">
				<label class="f-l w-80">分享服务商：</label>
				<input type="text" class="input-text w-120 f-l " value="${rds.columns.share_site }" name="shareSite" />
			</div>
			<!-- <div class="cl mb-10">
				</div> -->
			<div class="cl mb-10 pl-100 pos-r">
				<label class="w-100 pos"><em class="mark">*</em>跟进明细：</label>
				<textarea class="textarea " name="followUpDetailed" id="follow_up_detailed" style="50px">${detailed }</textarea>
			</div>
			<div class="cl mb-10 pl-100 pos-r">
				<label class="w-100 pos">跟进记录：</label>
				<div class="bk-gray pd-10" style="height: 200px;overflow: auto;">
					<c:forEach items="${list }" var="pro">
					 <p >
						 ${pro.columns.login_name }  &nbsp;:
						<span><fmt:formatDate value="${pro.columns.create_time }" pattern="yyyy-MM-dd HH:mm"/></span>：
						联系结果：${pro.columns.contact_results }；
						使用情况：${pro.columns.usages }；
						${pro.columns.follow_up_detailed }     
					</p>
						</c:forEach>
					
				</div>
			</div>
			<input type="hidden" name="id" value="${rds.columns.id }">
			<input type="hidden" name="siteId" value="${rds.columns.site_id }">
			<div class="text-c mt-20">
				<a href="javascript:save();" class="sfbtn sfbtn-opt3 w-70 mr-5">保存</a>
				<a href="javascript:closeDiv();" class="sfbtn sfbtn-opt w-70">关闭</a>
			</div>
		</div>
	</div>
	</form>
</div>
   
<script type="text/javascript">

$(function(){
	$('.fwsxq').popup();
	var usan = "${rds.columns.usage}";
	var indx = usan.split(",");
	$('#statusFlag').combobox('setValue',indx);

})

function closeDiv(){
	$.closeDiv($(".fwsxq"));
}

function isBlank(val) {
	if(val==null || val=='' || val == undefined) {
		return true;
	}
	return false;
}

var adpoting = false;	
function save(){
	if(adpoting) {
	    return;
    }
	if(isBlank($("#contact_results").val())){
		layer.msg("请选择联系结果");
		 return;
	}
	var statusFlag =  $('#statusFlag').combobox('getValues');
 	if(isBlank(statusFlag)){
		layer.msg("请选择使用情况");
		 return;
	}else{
		$("#usage").val(statusFlag);
	} 
	if(isBlank($("#follow_up_detailed").val())){
		layer.msg("请输入跟进明细");
		 return;
	}
	adpoting = true;
	
 	$.ajax({
		type : "POST",
		url : "${ctx}/order/statistics/addStatistics",
		data :$("#statisticsForm").serialize(),
		success : function(data) {	
			if(data){
				parent.layer.msg('保存成功!');
				$.closeDiv($(".fwsxq"));
				parent.location.reload(); 
    		
			}else{
				layer.msg('保存失败!');
			}
		},
        complete: function() {
            adpoting = false;
        }
	});    
}
</script>
  </body>
</html>
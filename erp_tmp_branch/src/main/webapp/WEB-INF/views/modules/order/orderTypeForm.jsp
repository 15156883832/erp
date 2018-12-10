<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'orderTypeForm.jsp' starting page</title>
     <meta name="decorator" content="base"/>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
	<script type="text/javascript">
		$(function(){
			$("#btnSubmit").click(function(){
			var url = "${ctx}/order/orderType/queryNum";
			var rname = $("#rname").val();
			if($.trim(rname)==""||$.trim(rname)==null){
			layer.msg("输入格式错误");
			return;
			}
			$.ajax({
				url:url,
				data:{"rname":rname}, 
				dataType:'json',
				async:false,
				success:function(result){
				if(result.flag){
					$("#inputForm").submit();
				}else{
					alert("名字已被使用!");
					return;
				} 
				return;
				}
			});
			
			});
		});
	
	</script>

  </head>
  
  <body>
   <div class="sfpagebg">
<div class="sfpage bk-gray table-header-settable">
	<ul class="nav nav-tabs">
		<%-- <li><a href="${ctx}/order/orderOrigin/">来源列表</a></li>
		<li class="active"><a href="${ctx}/order/orderOrigin/form?id=${orderOrigin.id}">来源<shiro:hasPermission name="order:orderOrigin:edit">${not empty orderOrigin.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="order:orderOrigin:edit">查看</shiro:lacksPermission></a></li> --%>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="orderType" action="${ctx}/order/orderType/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<div class="control-group">
			<label class="control-label">名称:</label>
			<div class="controls">
				<form:input id="rname" path="name" htmlEscape="false" maxlength="200" class="required"/>
			</div>
		</div>
		<div class="form-actions">
			<%-- <shiro:hasPermission name="order:orderOrigin:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/> --%>
			<input id="btnSubmit" class="btn btn-primary" type="button" value="保 存"/>
			&nbsp;<%-- </shiro:hasPermission> --%>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</div></div>
  </body>
</html>

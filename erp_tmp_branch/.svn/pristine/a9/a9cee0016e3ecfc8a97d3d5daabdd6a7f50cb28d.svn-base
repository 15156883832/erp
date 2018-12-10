<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<link href="${ctxStatic}/infosysterm/css/infosys.css" type="text/css" rel="stylesheet"/>
	<script type="text/javascript" src="${ctxStatic}/infosysterm/js/infosys.js"></script>
	<title>信息系统用户类型收发关系设置</title>
	<meta name="decorator" content="default"/>
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
	
	<script type="text/javascript">
	function selectSendUserType()
	{
		$.ajax({
			type:"GET",
			url:"${ctx}/sys/messageRelation/set"
		});
	}
	</script>
</head>
<body>
<!-- 	<div style="height: 50px;"><ul class="breadcrumb" style="position:fixed;top: 0px;width: 100%;">
	  <li><a href="#">信息系统用户关系管理</a> <span class="divider">></span></li>
	  <li class="active">关系设置</li>
	</ul></div> -->
	
	 <div class="place">
 		当前位置：
	  	<a href="#">信息系统用户关系管理</a> 
	  		>
	  	<a href="#" >关系设置</a>
	</div>
	
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/sys/messageRelation/list">关系列表</a></li>
		<li class="active"><a href="${ctx}/sys/messageRelation/set">设置</a></li>
	</ul>
	
 	<form:form id="inputForm" modelAttribute="messageRelationEntity" action="${ctx}/sys/messageRelation/set" method="post" class="form-horizontal">
		<div class="control-group">
			<label class="control-label">发送方用户类型:</label>&nbsp;&nbsp;
			<form:select path="sendUserType">
				<%-- <form:option value="" label="请选择"/> --%>
				<form:options items="${usertypes}"/>
			</form:select>
		</div>
		
 		<div class="control-group">
			<label class="control-label">站内信接收方用户角色:</label>&nbsp;&nbsp;
			<form:checkboxes path="mailUserTypes" items="${usertypes}"/>
		</div>
		
		<div class="control-group">
			<label class="control-label">推送消息接收方用户角色:</label>&nbsp;&nbsp;
			<form:checkboxes path="pushUserTypes" items="${usertypes}"/>
		</div> 
		
		<div class="form-actions">
			<%-- <shiro:hasPermission name="sys:user:edit"> --%>
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			<%-- </shiro:hasPermission> --%>
			<!-- <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/> -->
		</div>
	</form:form>
</body>
</html>
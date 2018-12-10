<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>字典管理</title>
	<meta name="decorator" content="default"/>
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
</head>
<body>
	<div style="height: 50px;"><ul class="breadcrumb" style="position:fixed;top: 0px;width: 100%;">
	  <li><a href="#">系统设置</a> <span class="divider">></span></li>
	  <li><a href="#">系统设置</a> <span class="divider">></span></li>
	  <li class="active">数据字典</li>
	</ul></div>
	  
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/sys/dict/">字典列表</a></li>
		<li class="active"><a href="${ctx}/sys/dict/form?id=${dict.id}">字典<shiro:hasPermission name="sys:dict:edit">${not empty dict.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:dict:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="dict" action="${ctx}/sys/dict/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label"><b class="need">*</b>键值:</label>
			<div class="controls">
				<form:input path="value" htmlEscape="false" maxlength="50" datatype="s1-18" errormsg="键值至少1个字符,最多18个字符！" nullmsg="请填写键值！"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><b class="need">*</b>标签:</label>
			<div class="controls">
				<form:input path="label" htmlEscape="false" maxlength="50" datatype="s1-18" errormsg="标签至少1个字符,最多18个字符！" nullmsg="请填写标签！"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><b class="need">*</b>类型:</label>
			<div class="controls">
				<form:input path="type" htmlEscape="false" maxlength="50" datatype="s" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><b class="need">*</b>描述:</label>
			<div class="controls">
				<form:input path="description" htmlEscape="false" maxlength="50" datatype="s1-18"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><b class="need">*</b>系统固定:</label>
			<div class="controls">
				<form:radiobuttons path="sys" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">排序:</label>
			<div class="controls">
				<form:input path="sort" htmlEscape="false" maxlength="11" datatype="n1-3" ignore="ignore" errormsg="排序为 1~3 位数字！"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="sys:dict:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	
	<script type="text/javascript">
		$(document).ready(function() {
			$("#value").focus();
			$("#inputForm").Validform({tiptype:'3'});
		});
	</script>
</body>
</html>
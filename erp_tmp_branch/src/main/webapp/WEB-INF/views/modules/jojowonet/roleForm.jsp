<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>角色管理</title>
	<meta name="decorator" content="default"/>
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
	<%@include file="/WEB-INF/views/include/treeview.jsp" %>
	<link href="${ctxPlugin}/static/treeTable/bootstrap.min.css" type="text/css" rel="stylesheet" />	
	<script src="${ctxPlugin}/lib/jquery.validation/1.14.0/jquery.validate.min.js" type="text/javascript"></script>
	<script type="text/javascript">
	var ztreeNode;
		$(document).ready(function(){
			$("#name").focus();
			$("#inputForm").validate({
				rules: {
					name: {remote: "${ctx}/sys/role/checkName?oldName=" + encodeURIComponent("${role.name}")}
				},
				messages: {
					name: {remote: "角色名已存在"}
				},
				submitHandler: function(form){
					var ids = [], nodes = ztreeNode.getCheckedNodes(true);
					for(var i=0; i<nodes.length; i++) {
						ids.push(nodes[i].id);
					}
					$("#menuIds").val(ids);
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});

			/* var setting = {check:{enable:true,nocheckInherit:true},view:{selectedMulti:false},
					data:{simpleData:{enable:true}},callback:{beforeClick:function(id, node){
						tree.checkNode(node, !node.checked, true, true);
						return false;
					}}}; */
			var setting = {
					check: {
				        enable: true,
				        chkboxType : { "Y" : "ps", "N" : "ps" }
				    },
					data: {
						simpleData: {
							enable: true,
							idKey: "id",
							pIdKey: "pid",
							rootPId: 0
						}
					},
					callback: {
						//onCheck: zTreeOnCheck
					}
				};
			
			
			ztreeNode = $.fn.zTree.init($("#menuTree"), setting, eval('${nodes}'));
			//ztreeNode.expandAll(true);
					
			// 用户-菜单
			/* var zNodes=[
					<c:forEach items="${menuList}" var="menu">
						{id:'${menu.id}', pId:'${not empty menu.parent.id ? menu.parent.id : 0}', name:"${not empty menu.parent.id ? menu.name : '权限列表'}"},
		            </c:forEach>
					]; */
			//var zNodes = '${nodes}';
			// 初始化树结构
			//var tree = $.fn.zTree.init($("#menuTree"), setting, zNodes);
			// 默认选择节点
			/* var ids = "${role.menuIds}".split(",");
			for(var i=0; i<ids.length; i++) {
				var node = tree.getNodeByParam("id", ids[i]);
				try{tree.checkNode(node, true, false);}catch(e){}
			} */
			// 默认展开全部节点
			//tree.expandAll(true);
		});
		
	</script>
</head>
<body>
<div class="sfpagebg bk-gray"><div class="sfpage">
<%-- 	
	<div style="height: 50px;"><ul class="breadcrumb" style="position:fixed;top: 0px;width: 100%;">
	  <li><a href="#">系统设置</a> <span class="divider">></span></li>
	  <li><a href="#">系统设置</a> <span class="divider">></span></li>
	  <li class="active">角色管理</li>
	</ul></div>

	<ul class="nav nav-tabs">
		<li><a href="${ctx}/sys/role/">角色列表</a></li>
		<li class="active"><a href="${ctx}/sys/role/form?id=${role.id}">角色<shiro:hasPermission name="sys:role:edit">${not empty role.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:role:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/> --%>
	<form:form id="inputForm" modelAttribute="role" action="${ctx}/sys/role/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<tags:message content="${message}"/>
		
		<div class="control-group">
			<label class="control-label">角色名称:</label>
			<div class="controls">
				<input id="oldName" name="oldName" type="hidden" value="${role.name}">
				<form:input path="name" htmlEscape="false" maxlength="50" class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">角色授权:</label>
			<div class="controls">
				<div id="menuTree" class="ztree" style="margin-top:3px;float:left;"></div>
				<form:hidden path="menuIds"/>
			</div>
		</div>
		<div class="form-actions">
			<%-- <shiro:hasPermission name="sys:role:edit"> --%><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;<%-- </shiro:hasPermission> --%>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</div></div>
</body>
</html>
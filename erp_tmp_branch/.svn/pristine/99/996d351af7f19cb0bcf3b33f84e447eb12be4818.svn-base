<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单管理</title>
	<meta name="decorator" content="default"/>
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
<link href="${ctxPlugin}/static/treeTable/bootstrap.min.css" type="text/css" rel="stylesheet" />	
<link href="${ctxPlugin}/static/order-st/common/butten.css" type="text/css" rel="stylesheet" />	
<link href="${ctxPlugin}/static/order-st/common/css/style.css" type="text/css" rel="stylesheet" />	
<link href="${ctxPlugin}/static/order-st/infosysterm/css/infosys.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="${ctxPlugin}/lib/layer/2.1/layer.js"></script>
	<style type="text/css">.table td i{margin:0 2px;}</style>
		<style type="text/css">
		td {
			padding-left: 15px;
			padding-right: 15px;
		}
		thead tr td{
			background-color: #C4C4C4;
		}
		.messk {
			border:1px solid #888;
			font-weight: 500;
		}
		.btn .btn-blue{
			background-color: #22a0e6;
			color:#22a0e6;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#treeTable").treeTable({expandLevel : 2});
		});
    	function updateSort() {
			loading('正在提交，请稍等...');
	    	$("#listForm").attr("action", "${ctx}/sys/menu/updateSort");
	    	$("#listForm").submit();
    	}
    	function dele(id){
    	    if(confirm('确认要删除菜单吗？')){  
    	    	location.href='${ctx}'+ "/sys/menu/delete?id=" + id;
    	    }
    	}
	</script>
</head>
<body>
    <div class="sfpagebg bk-gray"><div class="sfpage">
    
    <div class="btn-fwscxbox">
		<a class="btn-fwscx" href="${ctx}/sys/menu/form"><i class="cxicon"></i>添加${requestScope.curMenuId}1</a>
	</div>
    <br>
	<tags:message content="${message}"/>
	<form id="listForm" method="post">
		<table id="treeTable" class="table table-striped table-bordered table-condensed">
			<tr><th>名称</th><th>链接</th><th>类型</th><th style="text-align:center;">排序</th><th>可见</th><th>权限标识</th><shiro:hasPermission name="sys:menu:edit"><th>操作</th></shiro:hasPermission></tr>
			<c:forEach items="${list}" var="menu">
				<tr id="${menu.id}" pId="${menu.parent.id ne '1' ? menu.parent.id : '0'}">
					<td><i class="icon-${not empty menu.icon?menu.icon:' hide'}"></i><a href="${ctx}/sys/menu/form?id=${menu.id}">${menu.name}</a></td>
					<td>${menu.href}</td>
					<td>
						<c:if test="${menu.target eq '' }">
							系统菜单
						</c:if>
						<c:if test="${menu.target eq '1' }">
							TAB页面
						</c:if>
						<c:if test="${menu.target eq '2' }">
							页面按钮
						</c:if>
					</td>
					<td style="text-align:center;">
						<shiro:hasPermission name="sys:menu:edit">
							<input type="hidden" name="ids" value="${menu.id}"/>
							<input name="sorts" type="text" value="${menu.sort}" style="width:50px;margin:0;padding:0;text-align:center;">
						</shiro:hasPermission><shiro:lacksPermission name="sys:menu:edit">
							${menu.sort}
						</shiro:lacksPermission>
					</td>
					<td>${menu.isShow eq '1'?'显示':'隐藏'}</td>
					<td>${menu.permission}</td>
					<%-- <shiro:hasPermission name="sys:menu:edit"> --%><td>
						<a href="${ctx}/sys/menu/form?id=${menu.id}">修改</a>
						<a href="javascript:;" onclick="dele('${menu.id}')">删除</a>
						<a href="${ctx}/sys/menu/form?parent.id=${menu.id}">添加下级菜单</a>
						<a href="javascript:editPageAuth('${menu.id}');">编辑页面权限</a>  
					</td><%-- </shiro:hasPermission> --%>
				</tr>
			</c:forEach>
		</table>
		<%-- <shiro:hasPermission name="sys:menu:edit"><div class="form-actions pagination-left">
			<input id="btnSubmit" class="btn btn-primary" type="button" value="保存排序" onclick="updateSort();"/>
		</div></shiro:hasPermission> --%>
	 </form>
</div></div>
<script type="text/javascript">
	function editPageAuth(menuId){
		layer.open({
			type : 2,
			content:'${ctx}/main/redirect/goTest?menuId='+menuId,
			area: ['60%','60%']
		});
	}
</script>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>派工管理</title>
	<meta name="decorator" content="default"/>
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
	<script type="text/javascript" src="${ctxPlugin}/lib/formatStatus.js"></script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/order/orderDispatch/">派工列表</a></li>
		<shiro:hasPermission name="order:orderDispatch:edit"><li><a href="${ctx}/order/orderDispatch/form">派工添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="orderDispatch" action="${ctx}/order/orderDispatch/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<label>名称 ：</label><form:input path="name" htmlEscape="false" maxlength="50" class="input-small"/>
		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
	</form:form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>名称</th><th>备注</th><shiro:hasPermission name="order:orderDispatch:edit"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="orderDispatch">
			<tr>
				<td><a href="${ctx}/order/orderDispatch/form?id=${orderDispatch.id}">${orderDispatch.name}</a></td>
				<td>${orderDispatch.remarks}</td>
				<shiro:hasPermission name="order:orderDispatch:edit"><td>
    				<a href="${ctx}/order/orderDispatch/form?id=${orderDispatch.id}">修改</a>
					<a href="${ctx}/order/orderDispatch/delete?id=${orderDispatch.id}" onclick="return confirmx('确认要删除该派工吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>

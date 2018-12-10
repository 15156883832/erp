<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>来源管理</title>
	<meta name="decorator" content="default"/>
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
	<script type="text/javascript">
	
		function delOrigin(id){
			var url="${ctx}/order/orderOrigin/delete";
			var boflag = confirm("确定删除吗?");
			if(boflag){
					location.href="${ctx}/order/orderOrigin/delete?id="+id;
			}
			
			return;
		
		}
/* 		$(document).ready(function() {
			$(".timeChange").each(function(){
			
				$(this).html($(this).html().split(".")[0]);
			});
			
			
		}); */
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
	
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/order/orderOrigin/">来源列表</a></li>
		<%-- <shiro:hasPermission name="order:orderOrigin:edit"><li><a href="${ctx}/order/orderOrigin/form">来源添加</a></li></shiro:hasPermission> --%>
		<li><a href="${ctx}/order/orderOrigin/form">来源添加</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="orderOrigin" action="${ctx}/order/orderOrigin/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<label>名称 ：</label><form:input path="name" htmlEscape="false" maxlength="50" class="input-small"/>
		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
	</form:form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>名称</th><th>备注</th><shiro:hasPermission name="order:orderOrigin:edit"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="orderOrigin">
			<tr>
				<td><a href="${ctx}/order/orderOrigin/form?id=${orderOrigin.id}">${orderOrigin.name}</a></td>
				<%-- <td class="timeChange">${orderOrigin.createTime}</td> --%>
				<td><fmt:formatDate value="${orderOrigin.createTime }" pattern="yyyy-MM-dd HH:mm"/></td>
				<%-- <shiro:hasPermission name="order:orderOrigin:edit"> --%>
				<td>
    				<a href="${ctx}/order/orderOrigin/form?id=${orderOrigin.id}">修改</a>
					<a href="javascript:delOrigin('${orderOrigin.id}')">删除</a>
				</td>
				<%-- </shiro:hasPermission> --%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>

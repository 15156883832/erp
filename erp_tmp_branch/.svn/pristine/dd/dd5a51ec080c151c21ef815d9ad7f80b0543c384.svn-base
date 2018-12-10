<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="decorator" content="default"/>
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
</head>

<body>
	<div class="zhjpage gdtjpage">
		<div class="container-fluid">
			<form id="searchForm" action="${ctx}/session/onlines" method="post">
				<input type="hidden" id="pageNo" name="pageNo" value="${page.pageNo }">
				<input type="hidden" id="pageSize" name="pageSize" value="${page.pageSize }">
				<div class="mb-10">
					<label>服务商名称：</label>
					<input type="text" name="siteName" class="input-text radius w-160" value="${siteName}">
					<span class="zhjsearch1 ml-15">
						<a href="javascript:search();" class="btn btn-success radius"><i class="zhj-icon zhj-icon-cx"></i>查询</a>
					</span>
				</div>
			</form>

			<div class="table-wrap table-count mt-10">
				<table class="table" style ="table-layout:fixed;">
					<thead>
						<tr>
							<th style="width: 25%;">登录账号 </th>
							<th style="width: 45%;">服务商名称</th>
							<th style="width: 30%;">是否在线</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${page.list}" var="item">
						<tr>
							<td class="c-0d93db">${item.columns.login_name}</td>
							<td>${item.columns.siteName}</td>
							<td>
								<c:if test="${item.columns.is_online == '1' }">
									<%-- <c:if test="${item.columns.lgTime <= stl }">
										<i class="icon-online on-yes"></i>
									</c:if>
									<c:if test="${item.columns.lgTime > stl }">
										<i class="icon-online on-no"></i>
									</c:if> --%>
									<i class="icon-online on-yes"></i>
								</c:if>
								<c:if test="${item.columns.is_online != '1' }">
									<i class="icon-online on-no"></i>
								</c:if>
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="pagination">${page}</div>
			
		</div>
	</div>
<script type="text/javascript">
function page(n, s) {
	$("#pageNo").val(n);
	$("#pageSize").val(s);
	$("#searchForm").submit();
}
function search() {
	$("#searchForm").submit();
}
</script>

</body>
</html>
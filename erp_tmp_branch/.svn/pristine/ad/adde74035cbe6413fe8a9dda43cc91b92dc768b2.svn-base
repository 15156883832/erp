<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>字典管理</title>
<meta name="decorator" content="default" />
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<script type="text/javascript">
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
	}

	/**
	 * 加法运算，避免数据相加小数点后产生多位数和计算精度损失。
	 *
	 * @param num1加数1 | num2加数2
	 */
	function numAdd(num1, num2) {
		var baseNum, baseNum1, baseNum2;
		try {
			baseNum1 = num1.toString().split(".")[1].length;
		} catch (e) {
			baseNum1 = 0;
		}
		try {
			baseNum2 = num2.toString().split(".")[1].length;
		} catch (e) {
			baseNum2 = 0;
		}
		baseNum = Math.pow(10, Math.max(baseNum1, baseNum2));
		return (num1 * baseNum + num2 * baseNum) / baseNum;
	};
</script>
</head>
<body>

	<!-- <div style="height: 50px;"><ul class="breadcrumb" style="position:fixed;top: 0px;width: 100%;">
	  <li><a href="#">系统设置</a> <span class="divider">></span></li>
	  <li><a href="#">系统设置</a> <span class="divider">></span></li>
	  <li class="active">数据字典</li>
	</ul></div> -->

	<div class="place">
		系统设置：<a href="#">系统设置</a> > 数据字典
	</div>

	<%-- <ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sys/dict/">字典列表</a></li>
		<shiro:hasPermission name="sys:dict:edit"><li><a href="${ctx}/sys/dict/form?sort=10">字典添加</a></li></shiro:hasPermission>
	</ul> --%>
	<form:form id="searchForm" modelAttribute="dict"
		action="${ctx}/sys/dict/" method="post" class="searchWrap">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
		<%-- <label>类型：</label><form:select id="type" path="type" class="input-small"><form:option value="" label=""/><form:options items="${typeList}" htmlEscape="false"/></form:select>
		&nbsp;&nbsp;<label>描述 ：</label><form:input path="description" htmlEscape="false" maxlength="50" class="input-small"/>
		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
		 --%>
		<dl>
			<dt>类型：</dt>
			<dd>
				<form:select id="type" path="type" class="input-small">
					<form:option value="" label="" />
					<form:options items="${typeList}" htmlEscape="false" />
				</form:select>
			</dd>
		</dl>
		<dl>
			<dt>描述：</dt>
			<dd>
				<form:input path="description" htmlEscape="false" maxlength="50"
					class="input-small" />
			</dd>
		</dl>
		<p class="cxBtn">
			<input id="btnSubmit" type="submit" value="查询" />
		</p>
	</form:form>

	<div class="btnWrap">
		<ul>
			<li><a href="${ctx}/sys/dict/form?sort=10" class="btnBg1">添加</a></li>
		</ul>
	</div>
	<tags:message content="${message}" />
	<table id="contentTable" cellpadding="0" cellspacing="0" class="messkt"
		width="100%">
		<thead>
			<tr class="header">
				<td>键值</td>
				<td>标签</td>
				<td>类型</td>
				<td>描述</td>
				<td>排序</td>
				<shiro:hasPermission name="sys:dict:edit">
					<td>操作</td>
				</shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="dict">
				<tr>
					<td>${dict.value}</td>
					<td><a href="${ctx}/sys/dict/form?id=${dict.id}">${dict.label}</a></td>
					<td><a href="javascript:"
						onclick="$('#type').val('${dict.type}');$('#searchForm').submit();return false;">${dict.type}</a></td>
					<td>${dict.description}</td>
					<td>${dict.sort}</td>
					<shiro:hasPermission name="sys:dict:edit">
						<td><a href="${ctx}/sys/dict/form?id=${dict.id}">修改</a> <c:if
								test="${dict.sys eq '0' }">
								<a href="${ctx}/sys/dict/delete?id=${dict.id}"
									onclick="return confirmx('确认要删除该字典吗？', this.href)">删除</a>
							</c:if> <a
							href="<c:url value='${fns:getAdminPath()}/sys/dict/form?type=${dict.type}&sort=${dict.sort+10}'><c:param name='description' value='${dict.description}'/></c:url>">添加键值</a>
						</td>
					</shiro:hasPermission>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
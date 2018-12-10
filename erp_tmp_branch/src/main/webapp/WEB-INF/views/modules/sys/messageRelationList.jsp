<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<%@ include file="/WEB-INF/views/include/head.jsp"%>
	<script type="text/javascript" src="${ctxStatic}/infosysterm/js/infosys.js"></script>
	<title>信息系统用户类型收发关系列表</title>
	<meta name="decorator" content="default"/>
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
</head>
<body>
 	<div class="place">
 		当前位置：
	  	<a href="#">信息系统用户关系管理</a> 
	  		>
	  	<a href="#" >关系列表</a>
	</div>
	
<!-- 	<div class="place">
		当前位置：<a href="#">信息系统用户关系管理</a> > 关系列表
	</div> -->
<%-- 	<div class="messageCon">
		<div class="messTitle">
			<ul class="messmenu">
				<li>
					<a class="ys" href="${ctx}/sys/messageRelation/list">关系列表</a>
				</li>
				<li>
					<a class="" href="${ctx}/sys/messageRelation/set">设置</a>
				</li>
			</ul>
		</div>
	</div> --%>
  	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sys/messageRelation/list">关系列表</a></li>
		<li><a href="${ctx}/sys/messageRelation/set">设置</a></li>
	</ul>
	
	<table id="contentTable" class="table table-bordered table-condensed">
		<thead>
			<tr>
				<th>发件人用户类型</th>
				<th>站内信收件人用户类型</th>
				<th>推送消息收件人用户类型</th>
				<th>编辑</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${realtionList}" var="messageRelationListEntity">
			<tr>
				<td>${messageRelationListEntity.sendUserTypeName}</td>
				<td>${messageRelationListEntity.mailReceiveUserTypeName}</td>
				<td>${messageRelationListEntity.pushReceiveUserTypeName}</td>
				<td><a href="${ctx}/sys/messageRelation/set?sendusertype=${messageRelationListEntity.sendUserType}">修改</a></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>
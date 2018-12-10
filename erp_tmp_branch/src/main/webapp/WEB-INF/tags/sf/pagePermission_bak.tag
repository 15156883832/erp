<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="type" type="java.lang.String" required="true" description="标签类型:1.TAB页面标签,2.页面按钮"%>
<%@ attribute name="className" type="java.lang.String" required="false" description="权限按钮列表"%>
<%@ attribute name="href" type="java.lang.String" required="false" description="权限按钮列表"%>
<%@ attribute name="text" type="java.lang.String" required="false" description="权限按钮列表"%>
<%@ attribute name="tagId" type="java.lang.String" required="false" description="标签ID"%>
<%@ attribute name="tagName" type="java.lang.String" required="false" description="标签Name"%>
<%@ attribute name="label" type="java.lang.String" required="false" description="按钮label"%>
<%@ attribute name="buttons" type="java.util.List" required="false" description="按钮源"%>
<c:if test="${fns:checkPagePermission(pageContext.request, href)}">
	<c:if test="${type eq '1'}">
		<a class="${className }" href="${href}"
			<c:if test="${ !empty tagId }">id="${tagId}"</c:if>
			<c:if test="${ !empty tagName }">name="${tagName}"</c:if>
		>${text}</a>
	</c:if>
</c:if>
<c:if test="${type eq '2'}">
	<c:forEach var="btn" items="${pageBtns}">
		<c:if test="${btn.href eq label }">
			<a class="${className }" 
				<c:if test="${ !empty href }">href="${href}"</c:if>
				<c:if test="${ !empty tagId }">id="${tagId}"</c:if>
				<c:if test="${ !empty tagName }">name="${tagName}"</c:if>
			>${text}</a>
		</c:if>
	</c:forEach>
</c:if>

<%-- <c:forEach items="${perBtns}" var="btn">
	<c:if test="${btn.type eq 'a'}">
		<a href="${btn.url}" class="${btn.css}">${btn.name}</a>
	</c:if>
</c:forEach> --%>
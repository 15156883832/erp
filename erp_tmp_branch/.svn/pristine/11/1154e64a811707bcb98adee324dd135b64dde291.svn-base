<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="authFlag" type="java.lang.String" required="true" description="验证标签"%>
<%@ attribute name="html" type="java.lang.String" required="true" description="html内容"%>
<c:if test="${fns:checkPagePermission(pageContext.request, authFlag)}">
	<c:out value="${html}" escapeXml="false"/>
</c:if>
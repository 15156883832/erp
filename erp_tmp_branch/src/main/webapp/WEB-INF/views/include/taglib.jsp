<%@ taglib prefix="shiro" uri="/WEB-INF/tlds/shiros.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fns" uri="/WEB-INF/tlds/fns.tld" %>
<%@ taglib prefix="fnm" uri="/WEB-INF/tlds/fnm.tld" %>
<%@ taglib prefix="sf" uri="/WEB-INF/tlds/sf.tld" %>
<%@ taglib prefix="sfTags" tagdir="/WEB-INF/tags/sf" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<c:set var="ctx" value="${pageContext.request.contextPath}${fns:getAdminPath()}"/>
<c:set var="ctxPlugin" value="${pageContext.request.contextPath}/plug-in"/>
<c:set var="ctxImg" value="${pageContext.request.contextPath}"/> 

<!-- 公共图片路径 -->
<%-- <c:set var="commonStaticImgPath" value="http://120.210.205.24/orderstres"/> --%>
<c:set var="commonStaticImgPath" value="http://192.168.2.23:80/sfimggroup/"/>
<c:set var="prototypeStaticImgPath" value="http://192.168.2.23:80/sfimggroup/"/>
<c:set var="commonFileHead" value="http://192.168.2.23"/>
<%-- <c:set var="websocketUrl" value="http://120.55.17.200:7392"/> --%>
<c:set var="websocketUrl" value="http://192.168.2.23:9092"/>
<%-- <c:set var="ctxImg" value="http://120.210.205.42"/>--%>
<c:set var="prototypeUploadPath" value="http://192.168.2.25:8080/prototype"/>

<c:set var="printServerHost" value="http://192.168.2.164:8280/printer"/>